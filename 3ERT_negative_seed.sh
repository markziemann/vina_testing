#!/bin/bash
PROT=3ERT
CONFIG=${PROT}_negative_config.txt
DIR=${PROT}_negative_docking

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
    --out "$DIR/${PROT}_negative_${SIZE}_${SEED}.pdbqt" 
}
export -f runvina
export CONFIG DIR PROT

for SIZE in $(seq 10 10 130)  ; do
  parallel --tmpdir . -j 16 runvina $SIZE ::: $(seq 100 100 20000)
done
