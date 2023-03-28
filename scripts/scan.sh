#!/bin/bash
#module load bcftools/1.9
vcf=$1
intervals=$2
output=$3

mkdir -p $output

for i in ‘cat $vcf’
do
     prefix1=’basename $i’; prefix=${prefix1%%.*};
     tabix -h -R $intervals $i | bgzip -c > $output/$prefix.filename.vcf.gz
     bcftools index -t $output/$prefix.filename.vcf.gz

done

