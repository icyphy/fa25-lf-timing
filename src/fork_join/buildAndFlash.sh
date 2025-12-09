#!/usr/bin/env bash
set -e

rm -rf ForkJoinFederated
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/ForkJoinFederated.lf

pushd ForkJoinFederated/host
cp ../../host.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd ForkJoinFederated/worker1
cp ../../w1_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
popd

pushd ForkJoinFederated/worker2
cp ../../w2_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ2/
popd
