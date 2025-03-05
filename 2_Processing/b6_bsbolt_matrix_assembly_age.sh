#! /bin/bash
#$ -l h_rt=8:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

echo "Starting matrix assembly"
CGMATRIX_DIR_OLD="/u/project/pellegrini/rainyliu/Daphnia/dmr_age"

# Run the command
cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old
python3 -m bsbolt AggregateMatrix \
    -F "../cgmap_new/S1.filt.CGmap.gz,../cgmap_new/S2.filt.CGmap.gz,D1.filt.CGmap.gz,D2.filt.CGmap.gz,D3.filt.CGmap.gz,D4.filt.CGmap.gz,D5.filt.CGmap.gz,D6.filt.CGmap.gz,D8.filt.CGmap.gz,D9.filt.CGmap.gz,D10.filt.CGmap.gz,D11.filt.CGmap.gz,D12.filt.CGmap.gz,D13.filt.CGmap.gz,D14.filt.CGmap.gz,D15.filt.CGmap.gz,D16.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 0.05 -CG -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.age.filt.10x.1_sample.xD7.txt"

echo "Finished matrix assembly"