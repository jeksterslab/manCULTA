#!/bin/bash

#SBATCH --job-name=sim
#SBATCH --mail-user=r.jeksterslab@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --qos=open                 # Enable use of 100 cores
#SBATCH --nodes=5                  # Spread over ~5 nodes (20 cores each)
#SBATCH --ntasks=100               # Total of 100 tasks (1 per core)
#SBATCH --cpus-per-task=1          # 1 core per task
#SBATCH --mem-per-cpu=8G           # Memory: 8 GB per core = 800 GB total
#SBATCH --time=2-00:00:00
#SBATCH --output=sim.out
#SBATCH --error=sim.err

# Define project variables
PROJECT=manCULTA
SIF=manculta.sif
NCORES=$SLURM_NTASKS

# load parallel module ---------------------------------------------------------
module load parallel

# pre TMP ----------------------------------------------------------------------
mkdir -p /scratch/$USER/${PROJECT}/.sim/tmp
TODAY=$(date +"%Y-%m-%d-%H-%M-%S-%N")
PARALLEL_TMP_FOLDER=$(mktemp -d -q "/scratch/$USER/${PROJECT}/.sim/tmp/$TODAY-sim-XXXXXXXX")
trap 'rm -rf -- "$PARALLEL_TMP_FOLDER"' EXIT
echo "PARALLEL_TMP_FOLDER is $PARALLEL_TMP_FOLDER"
# ------------------------------------------------------------------------------

# script -----------------------------------------------------------------------
repid_start=1
repid_end=1000
taskid_start=1
taskid_end=9

cmd="apptainer exec \
     --bind /scratch/\$USER/${PROJECT}:/scratch/\$USER/${PROJECT} \
     /scratch/\$USER/${PROJECT}/.sif/${SIF} \
     Rscript /scratch/\$USER/${PROJECT}/.sim/sim.R {1} {2}; \
     echo sim taskid \$(printf \"%05d\" {2}) repid \$(printf \"%05d\" {1}) date \$(date '+%Y-%m-%d %H:%M:%S')"

cd /scratch/$USER/${PROJECT} || exit

parallel --tmpdir "$PARALLEL_TMP_FOLDER" \
    --jobs "$NCORES" \
    --colsep ' ' "$cmd" :::: <(
    for repid in $(seq $repid_start $repid_end); do
        for taskid in $(seq $taskid_start $taskid_end); do
            echo "$repid $taskid"
        done
    done
)
# ------------------------------------------------------------------------------

# done -------------------------------------------------------------------------
echo "sim.sh done"
# ------------------------------------------------------------------------------

# post TMP ---------------------------------------------------------------------
rm -rf -- "$PARALLEL_TMP_FOLDER"
trap - EXIT
exit
# ------------------------------------------------------------------------------
