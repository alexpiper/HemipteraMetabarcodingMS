rm readcount.txt
for i in *.fastq.gz; do
name=$(echo $i)
stats=$(zcat  $(echo $i) | awk '((NR-2)%4==0){read=$1;total++;count[read]++}END{for(read in count){if(!max||count[read]>max) {max=count[read];maxRead=read};if(count[read]==1){unique++}};print total,unique,unique*100/total,maxRead,count[maxRead],count[maxRead]*100/total}')
echo $name $stats >> readcount.txt
done
