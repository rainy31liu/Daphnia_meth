#! /bin/bash
#$ -l h_rt=4:00:00
#$ -l h_data=30G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

echo "Starting matrix assembly for new samples"
CGMATRIX_DIR_NEW="/u/project/pellegrini/rainyliu/Daphnia/cgmatrix_new"

# Run the command
cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_new
python3 -m bsbolt AggregateMatrix \
    -F "S1.filt.CGmap.gz,S2.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_NEW}/CGmatrix.new.filt.10x.100.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_new_CA
python3 -m bsbolt AggregateMatrix \
    -F "S1.filt.CGmap.gz,S2.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_NEW}/CGmatrix.new.10x.100.CA.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_new_CC
python3 -m bsbolt AggregateMatrix \
    -F "S1.filt.CGmap.gz,S2.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_NEW}/CGmatrix.new.10x.100.CC.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_new_CG
python3 -m bsbolt AggregateMatrix \
    -F "S1.filt.CGmap.gz,S2.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_NEW}/CGmatrix.new.10x.100.CG.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_new_CT
python3 -m bsbolt AggregateMatrix \
    -F "S1.filt.CGmap.gz,S2.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_NEW}/CGmatrix.new.10x.100.CT.txt"

echo "Finished matrix assembly for new samples"