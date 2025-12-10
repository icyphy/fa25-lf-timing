#!/usr/bin/env bash
set -e

rm -rf SyncFlow2
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/SyncFlow2.lf

pushd SyncFlow2/host
cp ../../host.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd SyncFlow2/top_fed
cp ../../top.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
popd

pushd SyncFlow2/mid_fed
cp ../../mid.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ2/
popd
