#!/bin/bash

echo '##Getting data'
curl -a https://biodataprog.github.io/2018_programming-intro/data/Ecoli-vs-Yersinia.BLASTP.tab.gz --output Ecoli-vs-Yersinia.BLASTP.tab.gz
echo 'Size of compressed file is:' `du -h *.gz`

echo '##Compressing and uncompressing'
gunzip *.gz
echo 'Size of uncompressed file is' `du -hk *`

echo '##Counting and viewing (Using this BLAST report)'
echo 'First 25 lines: ' 
head -25 *BLASTP.tab
echo 'Last 3 lines: ' 
tail -3 *BLASTP.tab
echo  'Total lines: ' 
wc -l *BLASTP.tab

echo '##Sorting'
curl -O https://biodataprog.github.io/2018_programming-intro/data/Nc3H.expr.tab
(head -n 1 *.expr.tab && tail +2 *.expr.tab | sort -k 6 -rn ) > Nc20H.expr.sorted.tab
echo 'Top 10 most highly expressed genes:' `head -11 *.sorted.tab | cut -f1`

echo '##Finding and Counting'
curl -O https://biodataprog.github.io/2018_programming-intro/data/D_mel.63B12.gbk
echo '#of CDS feature: ' `grep -c "    CDS" *.gbk`
echo '#Sequences with 100% similarity: ' `cat *BLASTP.tab | awk '{ if ($3 ==  100) {print $1, $3}}'| grep -c gi`
echo '#Sequences with >90% similarity: '`cat *BLASTP.tab | awk '{ if ($3 >  90) {print $1, $3}}'| grep -c gi`

echo '##Sort and Uniq'
curl -O https://biodataprog.github.io/2018_programming-intro/data/codon_table.txt
echo '# of codons for each amino acids:' 
cat codon_table.txt | awk '{print $3}' | sort | uniq -c
