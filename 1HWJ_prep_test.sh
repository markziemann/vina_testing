#!/bin/bash
PYTHONSH=~/app/mgltools_x86_64Linux2_1.5.7/bin/pythonsh
PREPRECEPTOR=~/app/mgltools_x86_64Linux2_1.5.7/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_receptor4.py
PREPLIGAND4=~/app/mgltools_x86_64Linux2_1.5.7/MGLToolsPckgs/AutoDockTools/Utilities24/prepare_ligand4.py

## 1HWJ crystal ligand redocking
## Ligand: cerivastatin, residue name 116, chain A

## Download 1HWJ
wget -N https://files.rcsb.org/download/1HWJ.pdb.gz
gunzip -kf 1HWJ.pdb.gz

## Extract crystal ligand A
awk 'substr($0,1,6)=="HETATM" && substr($0,18,3)=="116" && substr($0,22,1)=="A" {print}' 1HWJ.pdb > 1HWJ_crystal_ligand_A.pdb

## Check ligand
echo "Crystal ligand atom count:"
wc -l 1HWJ_crystal_ligand_A.pdb
head 1HWJ_crystal_ligand_A.pdb

## Prepare receptor protein : remove ligand, ADP and water
grep '^ATOM' 1HWJ.pdb > 1HWJ_clean.pdb
echo "END" >> 1HWJ_clean.pdb

## Convert receptor to PDBQT
$PYTHONSH $PREPRECEPTOR -r 1HWJ_clean.pdb -o 1HWJ_clean.pdbqt

## Prepare ligand: add hydrogens using OpenBabel
obabel 1HWJ_crystal_ligand_A.pdb -O 1HWJ_ligand.pdb -h

## Convert ligand to PDBQT
$PYTHONSH $PREPLIGAND4 -l 1HWJ_ligand.pdb -o 1HWJ_ligand.pdbqt

## Run docking
vina --config 1HWJ_config.txt --out 1HWJ_docking.pdbqt --cpu 8

## Convert docking result to PDB
obabel 1HWJ_docking.pdbqt -O 1HWJ_docking.pdb

## Show docking score
head -30 1HWJ_docking.pdbqt

