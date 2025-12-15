# Directory Tree Structure

## Simulation Source Files/Project Folder

Run the following to prepare the project folder.

```bash
PROJECT=manCULTA
git clone git@github.com:jeksterslab/$PROJECT.git
mv $PROJECT "/scratch/$USER"
chmod -R 777 "/scratch/$USER/$PROJECT"
```

## Simulation Scripts

The simulation scripts are in the following folder.

```bash
"/scratch/$USER/$PROJECT/.sim"
```

> **NOTE**: Build or request for `maculta.sif` and place it in `"/scratch/$USER/$PROJECT/.sif"`.

[comment]: <> (The manculta.sif used can be built with `apptainer pull manculta.sif docker://ijapesigan/manculta:2025-07-30-05204520`)

[comment]: <> (Build docker-manculta from .setup/notes/)

Run the following for `maculta.sif` to be executable and accessible to anyone.

```bash
chmod 777 /scratch/$USER/$PROJECT/.sif/maculta.sif
```

# Scripts to Run in the HPC Cluster

## Simulation

Run the following to run the simulations.

```bash
cd /scratch/$USER/$PROJECT/.sim
sbatch sim.sh
```

## Summary

Run the following to summarize the results.

```bash
cd /scratch/$USER/$PROJECT/.sim
sbatch sum.sh
```
