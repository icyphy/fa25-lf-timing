# FA25 CS294-262 Project Repo
This is the repository for the CS294-262 final project titled "Timing Verification in Distributed Real-Time Systems."

1. `cd fa25-lf-timing`

2. `docker build -f dockerfile_mac -t fa25-lf-timing .`

3. 
```
docker run -d --name gametime-work -v "$PWD/gametime":/home/gametime fa25-lf-timing tail -f /dev/null
```

4. **Setup venv in mounted directory (first time only):**
```
docker exec gametime-work bash -c "cd /home/gametime && python3 -m venv .venv && sed -i '/^yaml$/d' requirements.txt && .venv/bin/pip install -e . && .venv/bin/pip install -r requirements.txt"
```

5. **Connect to container:**
```
docker exec -it gametime-work bash
```

6. **Inside container - activate environment:**
```
source /home/gametime/.venv/bin/activate && export PYTHONPATH=/home/gametime/src:$PYTHONPATH
```
7. 
```
docker exec gametime-work bash -c "cd /home/gametime && clang++-16 -shared -fPIC src/custom_passes/custom_inline_pass.cpp -o src/custom_passes/custom_inline_pass.so \$(llvm-config --cxxflags --ldflags --libs) -Wl,-rpath,\$(llvm-config --libdir)"
```

8. `cd /home/gametime/test/tacle_test`
 
9. If you get klee header error, run this in the container:
 ```
    mkdir -p /opt/homebrew/include
    ln -sf /usr/local/include/klee /opt/homebrew/include/klee
```

## Convert LF to Gametime Conversion
Requirements: Lingua Franca VS Code Extension
1. Write your Lingua Franca Program. e.x:- `HelloWorld.lf`
2. Compile and run on VSCode. The output will be stored in a directory `src-gen/<program-name>`
3. Convert LF output in C to Gametime compatible format:
`python lf_to_gametime_v2.py <src-gen-dir> `
A new directory `output-dir` will contain the C code in Gametime compatible format.
Example: `python lf_to_gametime_v2.py src-gen/HelloWorld `
- Each LF Reaction is converted to a C function with a corresponding yaml file.

## Running Files in GameTime to get WCET
1. Manually copy the `lf-gametime-<program-name>` directory to `gametime/test/`
2. Run `gametime lf-gametime-<program-name>/<reaction-name> --backend flexpret`