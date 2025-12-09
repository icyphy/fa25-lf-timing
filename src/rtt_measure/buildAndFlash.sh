#!/usr/bin/env bash
set -e

rm -rf RTTMeasure
${REACTOR_UC_PATH}/lfc/bin/lfc-dev --gen-fed-templates src/RTTMeasure.lf

pushd RTTMeasure/initiator
cp ../../initiator.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ/
popd

pushd RTTMeasure/responder
cp ../../responder.conf prj.conf
./run_lfc.sh && west build -b frdm_k64f -p always --pristine
cp build/zephyr/zephyr.bin /run/media/nightxade/FRDM-K64FJ1/
popd
