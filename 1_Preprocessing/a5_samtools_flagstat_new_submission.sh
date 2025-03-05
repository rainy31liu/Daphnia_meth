
cd /u/home/r/rainyliu/samtools-1.17/bin/

for i in {1..2}
do
    qsub -pe shared 4 /u/project/pellegrini/rainyliu/Daphnia/script/a5_samtools_flagstat_new.sh ${i}
done

