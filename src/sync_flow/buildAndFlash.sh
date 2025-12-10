#!/usr/bin/env bash
set -e

rm -rf SyncFlow
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/SyncFlow.lf

pushd SyncFlow/host
cp ../../host.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd SyncFlow/topchain_fed
cp ../../topchain.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
popd

pushd SyncFlow/bottom_fed
cp ../../bottom.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ2/
popd
