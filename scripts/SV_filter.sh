#!/usr/bin/env tclsh             

module load bio/AnnotSV/3.1.1
module load bio/AnnotSV/3.1.1-BEDtools-2.3.0
module load bio/BCFtools/1.11-GCC-8.3.0
export ANNOTSV=/resources/tools/apps/software/AnnotSV/

run_sample_annotation() {
	export LC_ALL=C;
	while IFS=“read -r line || [[ -n “$line” ]]; do
	echo “Text read from line: $line”;
	fname=$(basename “$line”);
	echo “$fname”
	name=$(echo $fname | cut -f 1 -d ‘.’);
	IFS=’-‘ read -r -a array <<< “$name”;
	 
bcftools view -i ‘INFO/SVLEN[0] > -10000000 & INFO/SVLEN[0]< 10000000’ $LINE | grep -v -E “_random|chrUn|JTFH0|SVTYPE=BND|KN707|chrM” > /path/of/filtered/vcf file/directory/$name.filtered.vcf; 
$ANNOTSV/bin/AnnotSV -SVinputFile /$name.filtered.vcf -outputFile /path/of/annotated/vcf file/directory/$name/$name.annotated.tsv -outputDir /path/of/annotated/vcf file/directory/$name/ -svtBEDcol 4 -SVinputInfo 1 -genomeBuild GRCh38;

done < “$1”

}

echo “starting annotation”

vcf_list=$1
out_dir=$2
	
run_sample_annotation $vcf_list
