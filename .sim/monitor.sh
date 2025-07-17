#! /bin/bash

cd /scratch/ibp5092/manCULTA/.sim
watch 'squeue -u ibp5092 ; tail -10 sim.out; grep "check" sim.out ; cat sim.err'
