#!/usr/bin/env bash
set -e

rm -rf TCP
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/TCP.lf

pushd TCP/s
cp ../../s_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd TCP/c
cp ../../c_prj.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
popd
