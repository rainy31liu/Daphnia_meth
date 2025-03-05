#! /bin/bash
#$ -l h_rt=8:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

echo "Starting matrix assembly for old samples"
CGMATRIX_DIR_OLD="/u/project/pellegrini/rainyliu/Daphnia/cgmatrix_old"

# Run the command
cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old
python3 -m bsbolt AggregateMatrix \
    -F "D1.filt.CGmap.gz,D2.filt.CGmap.gz,D3.filt.CGmap.gz,D4.filt.CGmap.gz,D5.filt.CGmap.gz,D6.filt.CGmap.gz,D7.filt.CGmap.gz,D8.filt.CGmap.gz,D9.filt.CGmap.gz,D10.filt.CGmap.gz,D11.filt.CGmap.gz,D12.filt.CGmap.gz,D13.filt.CGmap.gz,D14.filt.CGmap.gz,D15.filt.CGmap.gz,D16.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 0.8 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.filt.10x.80.txt"
python3 -m bsbolt AggregateMatrix \
    -F "D1.filt.CGmap.gz,D2.filt.CGmap.gz,D3.filt.CGmap.gz,D4.filt.CGmap.gz,D5.filt.CGmap.gz,D6.filt.CGmap.gz,D7.filt.CGmap.gz,D8.filt.CGmap.gz,D9.filt.CGmap.gz,D10.filt.CGmap.gz,D11.filt.CGmap.gz,D12.filt.CGmap.gz,D13.filt.CGmap.gz,D14.filt.CGmap.gz,D15.filt.CGmap.gz,D16.filt.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.filt.10x.100.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old_CA
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 0.8 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.80.CA.txt"
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.100.CA.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old_CC
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 0.8 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.80.CC.txt"
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.100.CC.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old_CG
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 0.8 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.80.CG.txt"
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.100.CG.txt"

cd /u/project/pellegrini/rainyliu/Daphnia/cgmap_old_CT
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 0.8 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.80.CT.txt"
python3 -m bsbolt AggregateMatrix \
    -F "D1.CGmap.gz,D2.CGmap.gz,D3.CGmap.gz,D4.CGmap.gz,D5.CGmap.gz,D6.CGmap.gz,D7.CGmap.gz,D8.CGmap.gz,D9.CGmap.gz,D10.CGmap.gz,D11.CGmap.gz,D12.CGmap.gz,D13.CGmap.gz,D14.CGmap.gz,D15.CGmap.gz,D16.CGmap.gz" \
    -min-coverage 10 -min-sample 1 -verbose -O "${CGMATRIX_DIR_OLD}/CGmatrix.old.10x.100.CT.txt"

echo "Finished matrix assembly for old samples"