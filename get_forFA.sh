#!/bin/bash
#SBATCH --account=desi
#SBATCH -q shared
#SBATCH -t 01:00:00
#SBATCH --nodes=1
#SBATCH --constraint=cpu
#SBATCH -c 128
#SBATCH --mem 130GB
#SBATCH --array=50-69
#,66,69,72,75,78,81,84   # $SLURM_ARRAY_TASK_ID

echo "Loading Environment"
source /global/common/software/desi/desi_environment.sh main;export PATH=/global/cfs/cdirs/desi/users/raichoor/fiberassign-rerun-main/fiberassign_main_godesi23.10/bin:$PATH;export SKYHEALPIXS_DIR=$DESI_ROOT/target/skyhealpixs/v1;export PYTHONPATH=/global/cfs/cdirs/desi/users/raichoor/fiberassign-rerun-main/fiberassign_main_godesi23.10/py:$PYTHONPATH
#/global/common/software/desi/users/adematti/cosmodesi_environment.sh main
pip list
pip install fitsio --user

echo "Running Get Positions"
i=$SLURM_ARRAY_TASK_ID
num=$(($SLURM_ARRAY_TASK_ID))
for i in $(seq $SLURM_ARRAY_TASK_ID $num);

#START=$(date +%s)



do
python prepare_mocks_Y1_dark.py --mockver ab_secondgen --mockpath /pscratch/sd/t/tsfraser/HOD_mocks/AbacusSummit_base_c112_ph000/ --mockfile cutsky_LRG_z0.500_000_withrsd_${i} --base_output /pscratch/sd/t/tsfraser/HOD_mocks/AbacusSummit_base_c112_ph000/z0.500/formatted_forY1/SecondGenMocks/AbacusSummit_v4_1/mock0_HOD_${i}/ --realmax 1 --realmin 0 --hod $i;
#END=$(date +%s)
#DIFF=$(echo "$END - $START" | bc)
python /pscratch/sd/t/tsfraser/LSS/scripts/mock_tools/readwrite_pixel_bitmask_ttype_Y3.py -t lrg -i forFA0_${i}_Y1 -id /pscratch/sd/t/tsfraser/HOD_mocks/AbacusSummit_base_c112_ph000/z0.500/formatted_forY1/SecondGenMocks/AbacusSummit_v4_1/mock0_HOD_${i}/SecondGenMocks/AbacusSummit_v4_1/ --output_dir /pscratch/sd/t/tsfraser/HOD_mocks/AbacusSummit_base_c112_ph000/z0.500/formatted_forY1/SecondGenMocks/AbacusSummit_v4_1/mock0_HOD_${i}/SecondGenMocks/AbacusSummit_v4_1/;
done