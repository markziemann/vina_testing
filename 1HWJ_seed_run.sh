#!/bin/bash
PROT=1HWJ
CONFIG=${PROT}_seedrun_config.txt
DIR=${PROT}_seed_run_docking

if [ ! -d  $DIR ] ; then
  mkdir $DIR
fi

DIR_CNT=$(find $DIR | wc -l)

if [ $DIR_CNT -gt 1 ] ; then
  echo "Stopping - directory $DIR not empty!"
  exit
fi

runvina() {
  SIZE=$1
  SEED=$2
  vina --config "$CONFIG" \
    --size_x "$SIZE" --size_y "$SIZE" --size_z "$SIZE" \
    --cpu 1 --seed "$SEED" \
    --out "$DIR/${PROT}_seedrun_${SIZE}_${SEED}.pdbqt" 
}
export -f runvina

for SIZE in $(seq 10 10 130)  ; do
  parallel -j 16 runvina $SIZE ::: $(seq 100 100 20000)
done
