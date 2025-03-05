#! /bin/bash
#$ -l h_rt=8:00:00
#$ -l h_data=10G
#$ -o /u/project/pellegrini/rainyliu/Daphnia
#$ -e /u/project/pellegrini/rainyliu/Daphnia

. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

echo "Starting matrix imputation for samples"
cd /u/project/pellegrini/rainyliu/Daphnia/cgmatrix_age

python3 -m bsbolt Impute -M CGmatrix.age.filt.10x.80.xD7.txt -O CGmatrix.age.filt.10x.80.xD7.imputed.txt
python3 -m bsbolt Impute -M CGmatrix.age.filt.10x.80.xD7.filtered_gene_new.txt -O CGmatrix.age.filt.10x.80.xD7.filtered_gene.imputed.txt

echo "Finished matrix imputation for samples"