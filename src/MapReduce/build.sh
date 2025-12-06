#!/usr/bin/env bash
set -e

rm -rf MapReduceFederated
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/MapReduceFederated.lf

pushd MapReduceFederated/host
./run_lfc.sh && cmake -B build && cmake --build build
popd

pushd MapReduceFederated/worker1
cp ../../w1_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
#cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd MapReduceFederated/worker2
cp ../../w2_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
#cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd
