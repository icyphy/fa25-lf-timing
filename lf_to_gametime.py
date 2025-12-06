#!/usr/bin/env python3
"""
LF to GameTime Converter v2
Converts Lingua Franca generated C files to GameTime-compatible C files.
Generates separate analysis projects for each reactor and a driver function.

Usage:
    python lf_to_gametime.py <src-gen-dir> [output-dir]
    
Examples:
    python lf_to_gametime.py src-gen/HelloWorld
    (outputs to: lf-gametime-HelloWorld/)
    
    python lf_to_gametime.py src-gen/HelloWorld custom-output/
    (outputs to: custom-output/)
"""

import os
import re
import sys
from pathlib import Path
from typing import Dict, List, Tuple, Optional

## TODO: lf_sleep() transformation to fp_delay_for() not fully fixed. Add wrapper function to properly handle timing in GameTime analysis."

#TODO: Network latency

class LFToGameTimeConverter:
    """Converts LF-generated C files to GameTime-compatible format with per-reactor analysis."""
    
    def __init__(self, src_gen_dir: str, output_dir: str = None):
        self.src_gen_dir = Path(src_gen_dir)
        
        # Extract program name from the path
        self.program_name = self.src_gen_dir.name
        
        # Set default output directory based on program name if not provided
        if output_dir is None:
            output_dir = f"lf-gametime-{self.program_name}"
        
        self.output_dir = Path(output_dir)
        self.output_dir.mkdir(exist_ok=True)
        
        # Find the include directory - it should be at the same level as src-gen
        # Search recursively up the directory tree to find src-gen, then look for include/
        current = self.src_gen_dir
        while current.name != 'src-gen' and current.parent != current:
            current = current.parent
        
        # Now current should be the src-gen directory, go to its parent to find include/
        if current.name == 'src-gen':
            project_root = current.parent
            self.include_dir = project_root / "include"
        else:
            raise FileNotFoundError("Could not find 'src-gen' directory in the path hierarchy.")
        
        # Storage for extracted information
        self.reactions = []  # List of (function_name, code, reactor_name, trigger_info)
        self.reactor_reactions = {}  # {reactor_name: [(func_name, code, trigger_info)]}
        self.state_vars = {}  # {reactor_name: {var_name: var_type}}
        self.input_ports = {}  # {reactor_name: [(port_name, port_type)]}
        self.output_ports = {}  # {reactor_name: [(port_name, port_type)]}
        self.preamble = ""  # Global preamble code from LF file
    
    def find_lf_source_file(self) -> Optional[Path]:
        """Find the original .lf source file."""
        # Try common locations
        possible_locations = [
            Path(f"{self.program_name}.lf"),  # Current directory
            Path.cwd() / f"{self.program_name}.lf",
            self.src_gen_dir.parent / f"{self.program_name}.lf",
        ]
        
        for path in possible_locations:
            if path.exists():
                return path
        
        # Search recursively in parent directories
        current = Path.cwd()
        for _ in range(5):  # Search up to 5 levels
            lf_file = current / f"{self.program_name}.lf"
            if lf_file.exists():
                return lf_file
            current = current.parent
        
        return None
    
    def extract_preamble(self) -> str:
        """Extract preamble code from .lf file."""
        lf_file = self.find_lf_source_file()
        
        if not lf_file:
            print(f"   ⚠️  Warning: Could not find {self.program_name}.lf source file")
            return ""
        
        print(f"   ✓ Found LF source: {lf_file}")
        
        with open(lf_file, 'r') as f:
            content = f.read()
        
        # Extract preamble block: preamble {= ... =}
        preamble_pattern = r'preamble\s*\{=\s*(.+?)\s*=\}'
        matches = re.findall(preamble_pattern, content, re.DOTALL)
        
        if matches:
            preamble_code = '\n'.join(matches)
            print(f"   ✓ Extracted preamble ({len(matches)} block(s))")
            return preamble_code
        
        return ""
        self.preamble = ""  # Global preamble code from LF file
        
    def extract_ports_from_header(self, h_file_path: Path, reactor_name: str):
        """Extract input and output port information from _*.h file."""
        with open(h_file_path, 'r') as f:
            content = f.read()
        
        inputs = []
        outputs = []
        
        # Find port type definitions: _<reactor>_<port>_t
        # Input ports: typedef struct { ... int value; ... } _counter_in_t;
        # Output ports: typedef struct { ... int value; ... } _counter_out_t;
        
        port_pattern = r'typedef\s+struct\s*\{[^}]*?int\s+value;[^}]*?\}\s*_' + reactor_name + r'_(\w+)_t;'
        for match in re.finditer(port_pattern, content):
            port_name = match.group(1)
            if port_name.startswith('in'):
                inputs.append((port_name, 'int'))
            elif port_name.startswith('out'):
                outputs.append((port_name, 'int'))
        
        return inputs, outputs
    
    def extract_all_reactions(self, c_file_path: Path) -> List[Tuple[str, str, str, str]]:
        """Extract ALL reaction functions from _*.c file.
        Returns: List of (func_name, reaction_body, reactor_name, trigger_info)
        """
        with open(c_file_path, 'r') as f:
            content = f.read()
        
        reactions = []
        
        # Find all reaction functions
        pattern = r'void\s+(_\w+reaction_function_(\d+))\s*\(void\*\s+instance_args\)\s*\{'
        
        for match in re.finditer(pattern, content):
            func_name = match.group(1)
            reaction_num = match.group(2)
            reactor_match = re.match(r'_(\w+)reaction_function_\d+', func_name)
            reactor_name = reactor_match.group(1) if reactor_match else 'unknown'
            
            # Extract function body
            func_start = match.end()
            brace_count = 1
            i = func_start
            # Extract function body
            func_start = match.end()
            brace_count = 1
            i = func_start
            while i < len(content) and brace_count > 0:
                if content[i] == '{':
                    brace_count += 1
                elif content[i] == '}':
                    brace_count -= 1
                i += 1
            
            full_body = content[func_start:i-1].strip()
            
            # Find code between #line markers from .lf file (user code only)
            line_pattern = r'#line\s+\d+\s+"[^"]+\.lf"(.+?)(?:#line\s+\d+\s+"[^"]+"|$)'
            line_match = re.search(line_pattern, full_body, re.DOTALL)
            
            if line_match:
                reaction_body = line_match.group(1).strip()
            else:
                reaction_body = full_body
            
            # Determine trigger type by analyzing the initialization code
            # Look for _lf__startup_reactions, _lf__observe_reactions, etc.
            trigger_info = self.determine_trigger_type(c_file_path, reaction_num)
            
            reactions.append((func_name, reaction_body, reactor_name, trigger_info))
        
        return reactions
    
    def determine_trigger_type(self, c_file_path: Path, reaction_num: str) -> str:
        """Determine what triggers a reaction by analyzing the initialization code."""
        with open(c_file_path, 'r') as f:
            content = f.read()
        
        # Look for patterns like: self->_lf__startup_reactions[0] = &self->_lf__reaction_0;
        triggers = []
        
        # Check for startup trigger
        if re.search(rf'_lf__startup_reactions\[\d+\]\s*=\s*&self->_lf__reaction_{reaction_num};', content):
            triggers.append('startup')
        
        # Check for input port triggers (e.g., _lf__observe_reactions)
        input_pattern = rf'_lf__(\w+)_reactions\[\d+\]\s*=\s*&self->_lf__reaction_{reaction_num};'
        for match in re.finditer(input_pattern, content):
            port_name = match.group(1)
            if port_name != 'startup' and not port_name.startswith('_'):
                triggers.append(f'input:{port_name}')
        
        # Check for timer/action triggers (e.g., _lf__repeat)
        action_pattern = rf'self->_lf__(\w+)\.reactions\s*=\s*&self->_lf__\w+_reactions\[0\];\s*.*?self->_lf__\w+\.number_of_reactions\s*=\s*\d+;'
        # Simpler: look for action assignments
        action_pattern2 = rf'_lf__(\w+)_reactions\[\d+\]\s*=\s*&self->_lf__reaction_{reaction_num};'
        for match in re.finditer(action_pattern2, content):
            action_name = match.group(1)
            if action_name not in ['startup'] and action_name not in [t.split(':')[1] if ':' in t else t for t in triggers]:
                triggers.append(f'action:{action_name}')
        
        return ','.join(triggers) if triggers else 'unknown'
    
    def extract_reaction_body(self, c_file_path: Path) -> Optional[Tuple[str, str, str]]:
        """DEPRECATED: Extract first reaction only. Use extract_all_reactions instead."""
        reactions = self.extract_all_reactions(c_file_path)
        if reactions:
            func_name, body, reactor_name, _ = reactions[0]
            return (func_name, body, reactor_name)
        return None
    
    def extract_state_variables(self, h_file_path: Path) -> Dict[str, str]:
        """Extract user-defined state variables from _*.h file."""
        with open(h_file_path, 'r') as f:
            content = f.read()
        
        state_vars = {}
        
        # Find the self_t struct
        struct_pattern = r'typedef\s+struct\s*\{(.+?)\}\s*_\w+_self_t;'
        struct_match = re.search(struct_pattern, content, re.DOTALL)
        
        if not struct_match:
            return state_vars
            
        struct_body = struct_match.group(1)
        lines = struct_body.split('\n')
        i = 0
        while i < len(lines):
            line = lines[i].strip()
            
            # Check for #line directive pointing to .lf file
            if line.startswith('#line') and '.lf"' in line:
                if i + 1 < len(lines):
                    next_line = lines[i + 1].strip()
                    var_match = re.match(r'(\w+)\s+(\w+)\s*;', next_line)
                    if var_match:
                        var_type = var_match.group(1)
                        var_name = var_match.group(2)
                        if not var_name.startswith('_lf'):
                            state_vars[var_name] = var_type
                i += 2
            else:
                i += 1
                
        return state_vars
    
    def extract_from_include_header(self, reactor_name: str) -> Tuple[Dict[str, str], List[Tuple[str, str]], List[Tuple[str, str]]]:
        """Extract state variables and ports from include/*.h file (cleaner approach)."""
        # Capitalize first letter for header file name
        header_name = reactor_name.capitalize()
        header_path = self.include_dir / self.program_name / f"{header_name}.h"
        
        state_vars = {}
        input_ports = []
        output_ports = []
        
        if not header_path.exists():
            print(f"⚠️  Warning: Include header not found: {header_path}")
            return state_vars, input_ports, output_ports
        
        with open(header_path, 'r') as f:
            content = f.read()
        
        # Extract state variables from *_self_t struct
        self_pattern = rf'typedef\s+struct\s+{reactor_name}_self_t\s*\{{([^}}]+)\}}\s*{reactor_name}_self_t;'
        self_match = re.search(self_pattern, content, re.DOTALL)
        
        if self_match:
            struct_body = self_match.group(1)
            for line in struct_body.split('\n'):
                line = line.strip()
                # Skip base, end, comments
                if line.startswith('//') or 'base' in line or 'end[' in line or not line:
                    continue
                # Match: type name;
                var_match = re.match(r'(\w+)\s+(\w+)\s*;', line)
                if var_match:
                    var_type = var_match.group(1)
                    var_name = var_match.group(2)
                    if not var_name.startswith('_'):
                        state_vars[var_name] = var_type
        
        # Extract input ports from *_<portname>_t structs
        # Look for all port type structs and classify them
        port_pattern = rf'typedef\s+struct\s*\{{[^}}]*?(\w+)\s+value;[^}}]*?\}}\s*{reactor_name}_(\w+)_t;'
        declared_ports = {}  # {port_name: value_type}
        
        for match in re.finditer(port_pattern, content, re.DOTALL):
            value_type = match.group(1)
            port_name = match.group(2)
            # Skip action types (they have different structure)
            if port_name not in ['repeat', 'action']:
                declared_ports[port_name] = value_type
        
        # Now read the LF file to determine which ports are inputs vs outputs
        lf_file = self.find_lf_source_file()
        if lf_file:
            with open(lf_file, 'r') as f:
                lf_content = f.read()
            
            # Find reactor definition
            reactor_pattern = rf'reactor\s+{reactor_name.capitalize()}\s*\([^)]*\)\s*\{{([^}}]*?input[^}}]*?output[^}}]*?)\}}'
            reactor_match = re.search(reactor_pattern, lf_content, re.DOTALL | re.IGNORECASE)
            
            if reactor_match:
                reactor_body = reactor_match.group(1)
                # Extract input declarations
                for port_name, value_type in declared_ports.items():
                    if re.search(rf'input\s+{port_name}\s*:', reactor_body):
                        input_ports.append((port_name, value_type))
                    elif re.search(rf'output\s+{port_name}\s*:', reactor_body):
                        output_ports.append((port_name, value_type))
        
        # Fallback: use naming convention if LF parsing fails
        if not input_ports and not output_ports and declared_ports:
            for port_name, value_type in declared_ports.items():
                if 'in' in port_name.lower() or port_name in ['observe', 'receive', 'request']:
                    input_ports.append((port_name, value_type))
                elif 'out' in port_name.lower() or port_name in ['reveal', 'send', 'response']:
                    output_ports.append((port_name, value_type))
        
        return state_vars, input_ports, output_ports
    
    def transform_reaction_code(self, reaction_body: str, reactor_name: str, 
                                input_ports: List[Tuple[str, str]],
                                output_ports: List[Tuple[str, str]],
                                state_vars: Dict[str, str] = None) -> str:
        """Transform LF reaction code to GameTime-compatible C code, passing state as parameters."""
        code = reaction_body

        # Remove #line directives
        code = re.sub(r'^\s*#line\s+\d+\s+"[^"]+"\s*$', '', code, flags=re.MULTILINE)

        # Remove SUPPRESS_UNUSED_WARNING
        code = re.sub(r'SUPPRESS_UNUSED_WARNING\([^)]+\)\s*;', '', code)

        # Remove LF internal variable declarations
        code = re.sub(r'_\w+_self_t\*\s+self\s*=\s*\([^)]+\)[^;]+;\s*', '', code)
        code = re.sub(r'_\w+_\w+_t\*\s+\w+\s*=\s*[^;]+;\s*', '', code)
        code = re.sub(r'int\s+\w+_width\s*=\s*[^;]+;\s*', '', code)

        # Track output variables from lf_set calls
        output_vars = []

        def replace_lf_set(match):
            port = match.group(1)
            value = match.group(2)
            output_vars.append(port)
            return f'__output_{port} = {value};'

        # Replace lf_set(port, value)
        code = re.sub(r'lf_set\s*\(\s*(\w+)\s*,\s*(.+?)\s*\)', replace_lf_set, code)

        # Replace LF API calls
        code = code.replace('lf_print(', 'printf(')
        code = re.sub(r'lf_time_logical\s*\(\s*\)', '0LL', code)

        # Replace lf_schedule with scheduling flag/counter to preserve execution path cost
        def replace_schedule(match):
            return 'schedule_count++;  // lf_schedule overhead for WCET'

        code = re.sub(r'lf_schedule\s*\([^)]+\)\s*;', replace_schedule, code)

        # Replace self->field with field (now a parameter)
        code = re.sub(r'self->(\w+)', r'\1', code)

        # Replace input port->value with port parameter
        for port_name, port_type in input_ports:
            code = re.sub(rf'{port_name}->value', port_name, code)

        # Remove printf calls that cause KLEE symbolic execution issues
        # COMMENTED OUT FOR TESTING - let KLEE handle printf naturally
        # code = self.remove_printf_calls(code)

        # Clean up extra whitespace
        code = re.sub(r'\n\s*\n\s*\n', '\n\n', code)
        code = code.strip()

        return code, output_vars
    
    def remove_printf_calls(self, code: str) -> str:
        """Keep printf calls with non-pointer arguments, replace others for KLEE compatibility.
        
        KLEE can handle printf with direct parameters (e.g., printf("%d", param)) but not
        with pointer dereferences (e.g., printf("%d", *ptr)). We selectively replace only
        the problematic cases while preserving accurate timing for all printf calls.
        """
        # Pattern to detect printf with pointer dereferences
        # Look for *variable inside printf arguments
        def replace_if_has_deref(match):
            full_call = match.group(0)
            # Check if the printf contains pointer dereference (*)
            if '*' in full_call:
                return 'printf("X");  // Replaced: had pointer deref'
            # Otherwise keep original
            return full_call
        
        # Match printf calls and selectively replace based on content
        code = re.sub(r'printf\s*\([^;]*\);', replace_if_has_deref, code, flags=re.MULTILINE)
        return code
    
    def get_type_default_value(self, var_type: str) -> str:
        """Get the appropriate default initialization value for a given type."""
        var_type = var_type.strip()
        
        # Integer types
        if var_type in ['int', 'int32_t', 'uint32_t', 'unsigned int', 'long', 'short', 'char']:
            return '0'
        # Boolean
        elif var_type == 'bool':
            return 'false'
        # Float/double
        elif var_type in ['float', 'double']:
            return '0.0'
        # Enum or custom types (cast to avoid warnings)
        else:
            return f'({var_type})0'
    
    def generate_reactor_file(self, reactor_name: str, func_name: str, code: str,
                              state_vars: Dict[str, str], 
                              input_ports: List[Tuple[str, str]],
                              output_vars: List[str]) -> str:
        """Generate GameTime C file for a single reactor, passing state as parameters."""
        reactor_dir = self.output_dir / f"{reactor_name}_analysis"
        reactor_dir.mkdir(exist_ok=True)

        output_file = reactor_dir / f"{reactor_name}.c"

        with open(output_file, 'w') as f:
            # Headers
            f.write("#include <stdbool.h>\n")
            f.write("#include <stdio.h>\n")
            f.write("#include <stdint.h>\n")
            f.write("#include <stdlib.h>\n\n")

            # Add preamble if present
            if self.preamble:
                f.write("// Preamble from LF file\n")
                f.write(self.preamble)
                f.write("\n\n")

            f.write(f"// Reactor: {reactor_name}\n")
            f.write(f"// Generated from LF compiler output\n\n")

            # Add schedule_count for lf_schedule replacement
            if 'schedule_count' in code:
                f.write("// Scheduling counter for WCET analysis\n")
                f.write("int schedule_count = 0;\n\n")

            # Function signature with input ports and state variables as parameters
            has_output = len(output_vars) > 0
            return_type = 'int' if has_output else 'void'

            params = []
            # Add state variables as pointers so they can be updated
            if state_vars:
                for var_name, var_type in state_vars.items():
                    params.append(f"{var_type}* {var_name}")
            for port_name, port_type in input_ports:
                params.append(f"{port_type} {port_name}")

            param_str = ', '.join(params) if params else 'void'

            f.write(f"{return_type} {func_name}({param_str}) {{\n")

            # Declare output variable if needed
            if has_output:
                output_var = output_vars[0]
                f.write(f"    int __output_{output_var};\n")

            # Write reaction body (indent by 4 spaces)
            for line in code.split('\n'):
                if line.strip():
                    # Replace state variable usage with pointer dereference
                    # CRITICAL: Add parentheses to fix operator precedence issues
                    # *var++ would mean *(var++) but we want (*var)++
                    if state_vars:
                        for var_name in state_vars.keys():
                            # Use a single regex that handles all cases with proper precedence
                            # Matches: var followed by ++, --, any assignment operator, or any other context
                            # Replacement ensures proper parentheses for pointer dereference
                            
                            # Match var followed by operator that needs (*var) on LHS
                            pattern = rf'\b{var_name}\b(?=\s*(\+\+|--|[-+*/&|^%]?=))'
                            replacement = f'(*{var_name})'
                            line = re.sub(pattern, replacement, line)
                            
                            # Match remaining var uses (reads, function args, comparisons, etc.)
                            # Use negative lookbehind to avoid double-replacing
                            pattern = rf'(?<!\(\*)\b{var_name}\b(?!\s*(\+\+|--|[-+*/&|^%]?=))'
                            replacement = f'*{var_name}'
                            line = re.sub(pattern, replacement, line)
                    f.write(f"    {line}\n")

            # Return output if has output
            if has_output:
                f.write(f"    return __output_{output_vars[0]};\n")

            f.write("}\n")

        return str(output_file)
    
    def generate_reactor_config(self, reactor_name: str, func_name: str):
        """Generate GameTime config.yaml for a single reactor."""
        reactor_dir = self.output_dir / f"{reactor_name}_analysis"
        config_file = reactor_dir / "config.yaml"
        
        with open(config_file, 'w') as f:
            f.write("---\n")
            f.write("gametime-project:\n")
            f.write("  file:\n")
            f.write(f"    location: {reactor_name}.c\n")
            f.write(f"    analysis-function: {func_name}\n")
            f.write("    start-label: null\n")
            f.write("    end-label: null\n")
            f.write("\n\n")
            f.write("  preprocess:\n")
            f.write("    include: null\n")
            f.write("    merge: null\n")
            f.write("    inline: yes\n")
            f.write("    unroll-loops: Yes\n")
            f.write("\n")
            f.write("  analysis:\n")
            f.write("    maximum-error-scale-factor: 10\n")
            f.write("    determinant-threshold: 0.001\n")
            f.write("    max-infeasible-paths: 100\n")
            f.write("    ilp-solver: glpk\n")
            f.write("    gametime-flexpret-path: ../flexpret/\n")
            f.write("    gametime-path: ../../\n")
            f.write("    gametime-file-path: ../../../..\n")
        
        return str(config_file)
    
    def parse_main_c_file(self) -> Optional[Dict]:
        """Extract main reactor structure from generated HelloWorld.c file."""
        main_c_file = self.src_gen_dir / f"{self.program_name}.c"
        
        if not main_c_file.exists():
            print(f"   ⚠ Main C file not found: {main_c_file}")
            return None
        
        with open(main_c_file, 'r') as f:
            content = f.read()
        
        instances = {}  # {instance_var: reactor_type}
        connections = []  # [(src_inst, src_port, dst_inst, dst_port)]
        init_values = {}  # {reactor_instance: {param: value}}
        execution_order = {}  # {reactor_instance: level}
        
        # Extract reactor instantiations: helloworld_c_self[0] = new__counter();
        inst_pattern = r'(\w+)_self\[0\]\s*=\s*new__(\w+)\(\);'
        for match in re.finditer(inst_pattern, content):
            instance_var = match.group(1)  # e.g., "helloworld_c"
            reactor_type = match.group(2)   # e.g., "counter"
            
            # Extract instance name from comment or variable name
            # "helloworld_c" -> "c", "helloworld_p" -> "p"
            instance_name = instance_var.replace(f'{self.program_name.lower()}_', '')
            instances[instance_name] = reactor_type
            
            # Extract parameter initialization
            # helloworld_c_self[0]->stride = 10;
            param_pattern = rf'{instance_var}_self\[0\]->(\w+)\s*=\s*([^;]+);'
            init_values[instance_name] = {}
            for param_match in re.finditer(param_pattern, content):
                param_name = param_match.group(1)
                param_value = param_match.group(2).strip()
                # Skip LF internal fields
                if not param_name.startswith('_lf') and param_name not in ['base']:
                    init_values[instance_name][param_name] = param_value
        
        # Extract execution order from reaction priorities
        # helloworld_c_self[0]->_lf__reaction_0.index = lf_combine_deadline_and_level(9223372036854775807, 0);
        level_pattern = r'(\w+)_self\[0\]->_lf__reaction_\d+\.index\s*=\s*lf_combine_deadline_and_level\([^,]+,\s*(\d+)\);'
        for match in re.finditer(level_pattern, content):
            instance_var = match.group(1)
            level = int(match.group(2))
            instance_name = instance_var.replace(f'{self.program_name.lower()}_', '')
            execution_order[instance_name] = level
        
        # Extract connections from comments
        # // Connect HelloWorld.c.out(0,1)->[HelloWorld.p.in(0,1)]
        conn_comment_pattern = r'//\s*Connect\s+\w+\.(\w+)\.(\w+)\([^)]+\)->\[\w+\.(\w+)\.(\w+)\([^)]+\)\]'
        for match in re.finditer(conn_comment_pattern, content):
            src_inst = match.group(1)  # "c"
            src_port = match.group(2)  # "out"
            dst_inst = match.group(3)  # "p"
            dst_port = match.group(4)  # "in"
            connections.append((src_inst, src_port, dst_inst, dst_port))
        
        return {
            'instances': instances,
            'connections': connections,
            'init_values': init_values,
            'execution_order': execution_order
        }
    
    def generate_driver_function(self, main_structure: Dict) -> Tuple[str, str]:
        """Generate a driver function that orchestrates all reactors."""
        driver_dir = self.output_dir / "driver_analysis"
        driver_dir.mkdir(exist_ok=True)
        
        driver_file = driver_dir / "driver.c"
        
        instances = main_structure.get('instances', {})
        connections = main_structure.get('connections', [])
        init_values = main_structure.get('init_values', {})
        execution_order = main_structure.get('execution_order', {})
        
        with open(driver_file, 'w') as f:
            f.write("#include <stdbool.h>\n")
            f.write("#include <stdio.h>\n")
            f.write("#include <stdint.h>\n")
            f.write("#include <stdlib.h>\n\n")
            
            # Add preamble if present
            if self.preamble:
                f.write("// Preamble from LF file\n")
                f.write(self.preamble)
                f.write("\n\n")
            
            f.write("// Driver function - orchestrates all reactors\n")
            f.write(f"// Represents one logical time step of {self.program_name}\n")
            f.write("// Execution order determined by LF compiler's topological sort\n\n")
            
            # Add schedule_count for lf_schedule replacement
            f.write("// Scheduling counter for WCET analysis\n")
            f.write("int schedule_count = 0;\n\n")
            
            # Declare all state variables with actual init values from LF
            f.write("// Global state variables from all reactors\n")
            for reactor_name, state_vars in self.state_vars.items():
                f.write(f"// From {reactor_name} reactor:\n")
                for var_name, var_type in state_vars.items():
                    # Use actual init value from LF if available
                    default_init = self.get_type_default_value(var_type)
                    actual_init = default_init
                    
                    # Find the instance name for this reactor
                    for inst_name, inst_type in instances.items():
                        if inst_type.lower() == reactor_name:
                            if inst_name in init_values and var_name in init_values[inst_name]:
                                raw_init = init_values[inst_name][var_name]
                                # Handle static initializers like "{ static int _initial = 0; helloworld_c_self[0]->count = _initial; }"
                                if '_initial' in raw_init or 'static' in raw_init:
                                    actual_init = default_init  # Fall back to default
                                else:
                                    actual_init = raw_init
                            break
                    
                    f.write(f"{var_type} {var_name} = {actual_init};\n")
            f.write("\n")
            
            # Forward declarations of reaction functions
            f.write("// Forward declarations of reaction functions\n")
            for func_name, code_body, reactor_name, trigger_info in self.reactions:
                # Determine parameters based on trigger
                inputs = []
                if 'input:' in trigger_info:
                    for trigger in trigger_info.split(','):
                        if trigger.startswith('input:'):
                            port_name = trigger.split(':')[1]
                            # Find port type
                            for pn, pt in self.input_ports.get(reactor_name, []):
                                if port_name in pn:
                                    inputs.append((port_name, pt))
                                    break
                
                # Determine return type: check if THIS reaction has lf_set calls (outputs)
                has_output = 'lf_set(' in code_body or '__output_' in code_body
                ret_type = 'int' if has_output else 'void'
                
                # GameTime's C parser requires explicit 'void' for functions without parameters
                params = ', '.join([f"{pt} {pn}" for pn, pt in inputs]) if inputs else 'void'
                f.write(f"{ret_type} {func_name}({params});\n")
            f.write("\n")
            
            # Driver function
            f.write(f"void {self.program_name}_tick() {{\n")
            f.write("    // Execute reactions in topological order (level 0, then level 1, ...)\n")
            
            # Sort reactors by execution level
            sorted_reactors = []
            for inst_name, reactor_type in instances.items():
                level = execution_order.get(inst_name, 0)
                sorted_reactors.append((level, inst_name, reactor_type.lower()))
            sorted_reactors.sort(key=lambda x: x[0])
            
            # Generate execution sequence based on connections
            if connections:
                conn_idx = 0
                for src_inst, src_port, dst_inst, dst_port in connections:
                    src_reactor = instances.get(src_inst, src_inst).lower()
                    dst_reactor = instances.get(dst_inst, dst_inst).lower()
                    
                    f.write(f"\n    // Connection: {src_inst}.{src_port} → {dst_inst}.{dst_port}\n")
                    
                    # Find reaction functions that produce/consume these ports
                    # For src: find reaction that has output port 'reveal'
                    # For dst: find reaction that has input port 'observe'
                    src_func = None
                    dst_func = None
                    
                    for fn, _, rn, trigger in self.reactions:
                        if rn == src_reactor:
                            # Look for reaction with output to this port
                            if 'startup' in trigger or 'action:' in trigger:
                                src_func = fn
                        if rn == dst_reactor and f'input:{dst_port}' in trigger:
                            dst_func = fn
                    
                    if src_func and dst_func:
                        var_name = f"{src_inst}_{src_port}_to_{dst_inst}"
                        f.write(f"    int {var_name} = {src_func}();\n")
                        f.write(f"    {dst_func}({var_name});\n")
                    else:
                        f.write(f"    // Note: Could not find matching reaction functions\n")
                    conn_idx += 1
            else:
                # Fallback: execute in level order
                f.write("    // Execute reactions in order:\n")
                for level, inst_name, reactor_type in sorted_reactors:
                    func_name = next((fn for fn, _, rn, _ in self.reactions if rn == reactor_type), None)
                    if func_name:
                        f.write(f"    // Level {level}: {inst_name} ({reactor_type})\n")
                        # Check if this reaction has inputs
                        has_input = any(f'input:' in t for fn, _, rn, t in self.reactions if fn == func_name)
                        if has_input:
                            f.write(f"    // Note: {func_name} requires input parameter\n")
                        else:
                            f.write(f"    {func_name}();\n")
            
            f.write("}\n")
        
        return str(driver_file), str(driver_dir / "config.yaml")
    
    def generate_driver_config(self):
        """Generate config for driver function."""
        config_file = self.output_dir / "driver_analysis" / "config.yaml"
        
        with open(config_file, 'w') as f:
            f.write("---\n")
            f.write("gametime-project:\n")
            f.write("  file:\n")
            f.write("    location: driver.c\n")
            f.write(f"    analysis-function: {self.program_name}_tick\n")
            f.write("    start-label: null\n")
            f.write("    end-label: null\n")
            f.write("\n\n")
            f.write("  preprocess:\n")
            f.write("    include: null\n")
            f.write("    merge: null\n")
            f.write("    inline: yes\n")
            f.write("    unroll-loops: Yes\n")
            f.write("\n")
            f.write("  analysis:\n")
            f.write("    maximum-error-scale-factor: 10\n")
            f.write("    determinant-threshold: 0.001\n")
            f.write("    max-infeasible-paths: 100\n")
            f.write("    ilp-solver: glpk\n")
            f.write("    gametime-flexpret-path: ../flexpret/\n")
            f.write("    gametime-path: ../../\n")
            f.write("    gametime-file-path: ../../../..\n")
    
    def convert(self) -> Dict[str, List[str]]:
        """Main conversion process - generates separate analysis for each reactor + driver."""
        print(f"🔍 Scanning {self.src_gen_dir} for LF-generated files...")
        
        # Extract preamble first
        print(f"📝 Extracting preamble from LF source...")
        self.preamble = self.extract_preamble()
        
        c_files = list(self.src_gen_dir.glob("_*.c"))
        
        print(f"   Found {len(c_files)} reaction files")
        print(f"   Program: {self.program_name}\n")
        
        generated_files = {'reactors': [], 'driver': []}
        
        # Process each reactor
        for c_file in c_files:
            h_file = c_file.with_suffix('.h')
            
            print(f"📄 Processing {c_file.name}...")
            
            # Extract ALL reactions from this reactor
            all_reactions = self.extract_all_reactions(c_file)
            if not all_reactions:
                print(f"   ⚠ No reactions found")
                continue
            
            # Get reactor name from first reaction
            _, _, reactor_name, _ = all_reactions[0]
            print(f"   ✓ Found {len(all_reactions)} reaction(s) for {reactor_name}")
            
            # Store all reactions for this reactor
            self.reactor_reactions[reactor_name] = []
            for func_name, body, _, trigger_info in all_reactions:
                print(f"      - {func_name}: triggered by [{trigger_info}]")
                self.reactor_reactions[reactor_name].append((func_name, body, trigger_info))
                # Also keep in flat list for backwards compatibility
                self.reactions.append((func_name, body, reactor_name, trigger_info))
            
            # Try to extract from include/ first (cleaner), fallback to _*.h
            state_vars, input_ports, output_ports = self.extract_from_include_header(reactor_name)
            
            if state_vars or input_ports or output_ports:
                print(f"   ✓ Using include/{self.program_name}/{reactor_name.capitalize()}.h")
                if state_vars:
                    print(f"   ✓ State vars: {list(state_vars.keys())}")
                    self.state_vars[reactor_name] = state_vars
                if input_ports:
                    print(f"   ✓ Input ports: {[p[0] for p in input_ports]}")
                    self.input_ports[reactor_name] = input_ports
                if output_ports:
                    print(f"   ✓ Output ports: {[p[0] for p in output_ports]}")
                    self.output_ports[reactor_name] = output_ports
            else:
                # Fallback to old method if include/ doesn't work
                print(f"   ⚠️  Include header not found, using _*.h fallback")
                state_vars = {}
                if h_file.exists():
                    state_vars = self.extract_state_variables(h_file)
                    print(f"   ✓ State vars: {list(state_vars.keys())}")
                    self.state_vars[reactor_name] = state_vars
                
                # Extract port information
                input_ports, output_ports = [], []
                if h_file.exists():
                    input_ports, output_ports = self.extract_ports_from_header(h_file, reactor_name)
                    self.input_ports[reactor_name] = input_ports
                    self.output_ports[reactor_name] = output_ports
                    if input_ports:
                        print(f"   ✓ Input ports: {[p[0] for p in input_ports]}")
                    if output_ports:
                        print(f"   ✓ Output ports: {[p[0] for p in output_ports]}")
            
            # Generate analysis files for each reaction
            for func_name, body, trigger_info in self.reactor_reactions[reactor_name]:
                # Determine inputs/outputs based on trigger
                reaction_inputs = []
                reaction_outputs = []
                
                if 'input:' in trigger_info:
                    # Reaction triggered by input port - add it as parameter
                    for trigger in trigger_info.split(','):
                        if trigger.startswith('input:'):
                            port_name = trigger.split(':')[1]
                            # Find port type
                            for pn, pt in input_ports:
                                if port_name in pn:
                                    reaction_inputs.append((port_name, pt))
                                    break
                
                # Transform code for this specific reaction
                transformed_code, output_vars = self.transform_reaction_code(
                    body, reactor_name, reaction_inputs, reaction_outputs if reaction_outputs else output_ports)
                
                # Generate reactor-specific file for this reaction
                analysis_name = f"{reactor_name}_{func_name.replace('_'+reactor_name, '')}"
                c_file_path = self.generate_reactor_file(
                    analysis_name, func_name, transformed_code, 
                    state_vars, reaction_inputs, output_vars)
                config_path = self.generate_reactor_config(analysis_name, func_name)
                
                generated_files['reactors'].append((analysis_name, c_file_path, config_path))
                print(f"   ✓ Generated {analysis_name}_analysis/")
        
        # Generate driver function
        print(f"\n📝 Generating driver function...")
        main_structure = self.parse_main_c_file()
        if main_structure:
            print(f"   ✓ Parsed {self.program_name}.c")
            print(f"   ✓ Found instances: {list(main_structure['instances'].keys())}")
            print(f"   ✓ Found connections: {len(main_structure['connections'])}")
            driver_c, _ = self.generate_driver_function(main_structure)
            self.generate_driver_config()
            generated_files['driver'] = [driver_c, str(self.output_dir / "driver_analysis" / "config.yaml")]
            print(f"   ✓ Generated driver_analysis/")
        else:
            print(f"   ⚠ Could not parse main C file - driver not generated")
        
        return generated_files


def main():
    if len(sys.argv) < 2:
        print("Usage: python lf_to_gametime.py <src-gen-dir> [output-dir]")
        print("Example: python lf_to_gametime.py src-gen/HelloWorld")
        print("         (outputs to: lf-gametime-HelloWorld/)")
        print("Example: python lf_to_gametime.py src-gen/HelloWorld custom-output/")
        sys.exit(1)
    
    src_gen_dir = sys.argv[1]
    output_dir = sys.argv[2] if len(sys.argv) > 2 else None
    
    if not os.path.exists(src_gen_dir):
        print(f"Error: Directory {src_gen_dir} does not exist")
        sys.exit(1)
    
    converter = LFToGameTimeConverter(src_gen_dir, output_dir)
    results = converter.convert()
    
    print(f"\n✅ Conversion complete!")
    print(f"\n📂 Generated analysis projects:")
    
    for reactor_name, c_file, config_file in results['reactors']:
        print(f"\n   {reactor_name}_analysis/")
        print(f"      ├── {Path(c_file).name}")
        print(f"      └── config.yaml")
        print(f"      Test: docker exec fa25-lf-timing bash -c 'cd /workspace/{reactor_name}_analysis && python /home/gametime/src/analyze_project.py config.yaml'")
    
    if results['driver']:
        print(f"\n   driver_analysis/")
        print(f"      ├── driver.c")
        print(f"      └── config.yaml")
        print(f"      Test: docker exec fa25-lf-timing bash -c 'cd /workspace/driver_analysis && python /home/gametime/src/analyze_project.py config.yaml'")
    
    print(f"\n💡 Determinism validation:")
    print(f"   1. Each reactor analyzed independently")
    print(f"   2. State variables initialized to known values")
    print(f"   3. Input ports become function parameters")
    print(f"   4. All execution paths preserved from LF code")


if __name__ == "__main__":
    main()
