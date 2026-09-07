#!/bin/bash

# run the receptor and ligand prep and test that vina
# and other tools are working ok
bash 1HWJ_prep_test.sh
bash 1J3K_prep_test.sh
bash 3ERT_prep_test.sh

# run the positive test with increasing box size to test
# the limits of what vina can find in a standard run
bash 1HWJ_seed_run.sh
bash 1J3K_seed_run.sh
bash 3ERT_seed_run.sh

# run another test by analysing a small box on the opposite
# side of the protein and progressively increasing it until
# we identify the real binding site
bash 1HWJ_negative_seed.sh
bash 1J3K_negative_seed.sh
bash 3ERT_negative_seed.sh


