
. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

for i in {1..16}
do
    qsub /u/project/pellegrini/rainyliu/Daphnia/script/a2_bsbolt_align_old.sh ${i}
done
