# vina_testing
Here we are running some redocking experiments to understand the limitations of
Vina AutoDock.
We are working with three protein-ligand complex structures which were obtained from
PDB: 1HWJ, 1J3K and 3ERT.

For each of these structures we are running three scripts:

1. prep_test.sh: This script downloads the structure, prepares ligand and protein
and runs Vina with a box size of 20x20x20A around the known binding site.
The purpose of this s just to show that Vina is working in this confuguration and
understand what the baseline grid score (affinity) of the interaction.

2. seed_run.sh: This is a script designed to test the capability of Vina with
increasing box size, which is progressively increased from 10A up to 130A.
The search space is centred around the known binding site.
Because Vina uses a random seed which impacts the performance, each box size
test is repeated 200 times. This is important for large box sizes because
at a low exhaustiveness, optimal poses are less likely to be discovered in a
single run. We expect that Vina will find optimal poses at a small box size
and then progressively struggle with increasing box size.

3. negative_seed.sh: This script is designed to be a type of negative control.
It begins with small box sizes and increases to large size, but the starting
position is not at the known binding site, rather it is designated at a point
on the surface of the protein furthest away from the known binding site.
At a small box size, we expect Vina to only find very weak poses, but at larger
box sizes, there is a chance that it could find the known binding site.
This test will show how Vina can be used to specifically find high affinity
poses without any previous knowledge of ligand interactions.

Together these tests will determine whether Vina is useful for finding
biologically relevant protein-drug interactions.
