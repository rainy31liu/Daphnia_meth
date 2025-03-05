
. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

for i in {1..16}
do
    qsub -pe shared 10 /u/project/pellegrini/rainyliu/Daphnia/script/a6_bsbolt_call_methylation_old.sh ${i}
done

