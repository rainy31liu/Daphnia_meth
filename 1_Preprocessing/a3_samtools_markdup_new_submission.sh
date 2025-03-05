
cd /u/home/r/rainyliu/samtools-1.17/bin/

for i in {1..2}
do
    qsub -pe shared 10 /u/home/r/rainyliu/project-pellegrini/Daphnia/script/a3_samtools_markdup_new.sh ${i}
done

