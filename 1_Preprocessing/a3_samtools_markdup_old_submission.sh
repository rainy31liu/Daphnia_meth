
cd /u/home/r/rainyliu/samtools-1.17/bin/

for i in {1..16}
do
    qsub -pe shared 4 /u/project/pellegrini/rainyliu/Daphnia/script/a3_samtools_markdup_old.sh ${i}
done

