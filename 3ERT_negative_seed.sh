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

for SIZE in $(seq 10 10 130) ; do
  for SEED in $(seq 100 100 20000) ; do
    OUTNAME=$DIR/3ERT_negative_${SIZE}_${SEED}.pdbqt
    echo "Running $OUTNAME"

    vina --config "$CONFIG" \
             --seed "$SEED" \
             --size_x "$SIZE" \
             --size_y "$SIZE" \
             --size_z "$SIZE" \
             --out "$OUTNAME" \
             --cpu 16
  done
done
