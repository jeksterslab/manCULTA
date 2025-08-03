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

[comment]: <> (The maculta.sif used is in https://osf.io/a9g2h/)

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
