1. `cd /Users/anagha/Documents/Fall\ 2025/CS262A/project/final/fa25-lf-timing`

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
7. ```docker exec gametime-work bash -c "cd /home/gametime && clang++-16 -shared -fPIC src/custom_passes/custom_inline_pass.cpp -o src/custom_passes/custom_inline_pass.so \$(llvm-config --cxxflags --ldflags --libs) -Wl,-rpath,\$(llvm-config --libdir)"

```

7. `cd /home/gametime/test/tacle_test`
 
8. If you get klee header error, run this in the container:
 ```
    mkdir -p /opt/homebrew/include
    ln -sf /usr/local/include/klee /opt/homebrew/include/klee
```