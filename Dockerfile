FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y git wget software-properties-common gnupg
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 16 && \
    rm llvm.sh
RUN apt-get install -y clang-16 llvm-16 python3 python3.10-venv
RUN apt-get install -y graphviz libgraphviz-dev
RUN apt-get install -y python3-dev pkg-config build-essential
RUN apt-get install -y vim gcc
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 100 && \
  update-alternatives --install /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-16 100

WORKDIR /home
RUN git clone https://github.com/icyphy/gametime.git && cd gametime && git submodule update --init --recursive
RUN git clone https://github.com/pretis/flexpret.git && cd flexpret && git submodule update --init --recursive

# gametime
WORKDIR /home/gametime
RUN python3 -m venv .venv
RUN clang++-16 -shared -fPIC src/custom_passes/custom_inline_pass.cpp -o src/custom_passes/custom_inline_pass.so `llvm-config --cxxflags --ldflags --libs` -Wl,-rpath,$(llvm-config --libdir)

# change yaml to pyyaml in requirements.txt
RUN sed -i '/^yaml$/d' requirements.txt
RUN .venv/bin/pip install -e . && .venv/bin/pip install -r requirements.txt

# flexpret
WORKDIR /tmp
RUN wget -q --show-progress https://github.com/xpack-dev-tools/riscv-none-elf-gcc-xpack/releases/download/v14.2.0-2/xpack-riscv-none-elf-gcc-14.2.0-2-linux-x64.tar.gz -O gcc.tar.gz
RUN tar xvf gcc.tar.gz --directory=/opt
RUN echo "export RISCV_TOOL_PATH_PREFIX=/opt/xpack-riscv-none-elf-gcc-14.2.0-2" >> /root/.bashrc

RUN apt-get install -y verilator openjdk-17-jdk cmake
RUN apt-get install -y apt-transport-https curl gnupg
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list
RUN echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list
RUN curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import
RUN chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg
RUN apt-get update
RUN apt-get install -y sbt

WORKDIR /home/flexpret
RUN sbt test
SHELL ["/bin/bash", "-c"]
RUN source env.bash && cmake -B build && cd build && make all install

RUN ln -s /opt/xpack-riscv-none-elf-gcc-14.2.0-2/bin/riscv-none-elf-* /bin/
RUN source env.bash && cd sdk && cmake -B build && cd build && make && ctest

RUN echo "export PATH=\"\$PATH:/home/flexpret/build/emulator\"" >> /root/.bashrc
RUN echo "source /home/flexpret/env.bash" >> /root/.bashrc

# mbed
RUN mkdir /home/mbed
WORKDIR /home/mbed
RUN python3 -m venv .venv
RUN source .venv/bin/activate && pip install mbed-tools
RUN apt-get install -y gcc-arm-none-eabi
RUN apt-get install -y ninja-build

# done
WORKDIR /home
