
. /u/local/Modules/default/init/modules.sh
module load python/3.9.6

for i in {1..16}
do
    qsub /u/project/pellegrini/rainyliu/Daphnia/script/b1_cgmap_filter_old.sh ${i}
done

