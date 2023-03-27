## Molecular Diagnosis of Unsolved Cases in the Primary Congenital Glaucoma Cohort of the Genomics England 100,000 Genomes Project
   
   The paper describing the study is available [here]()
   
   This repo includes the scripts used for the data extraction and analysis of the GE100KGP PCG cohort.
   
   This analysis involves two stages of data extraction and annotation: a) single nucleotide variants (SNVs) using `vep99` and b) structural variants (SVs) using `AnnotSV`.

  ### 1. SNV analysis:
    
     1. Prepare coordinates of the regions of interests (ROIs), with genome assembly GRCh38 or GRCH37

     2. Prepare a list with the paths of the subjects VCF files 

     3. Scan the ROIs over the VCF files using the loop in scan.sh
    
run the script as follows: `sh scan.sh file_paths.list ROIs.list directory_name`

     4. Merge and VCF files generated and normalise the merged file

     5. Annotate with VEP tools (vep99), using the command in annotate.sh

     6. Parse the annotated file using bcftools(1.11)

using the command: `bcftools +split-vep -f %CHROM\t%POS\t%REF\t%ALT\t%CSQ\n' -d -A tab annotated_file.vcf >> output.tsv`


  ### 2. SV analysis:

  Calling of GEL’s SVs was done using Manta, and CNVs using CANVAS.

  In this analysis we used AnnotSV to annotate.

- Prepare a list with the paths of the SV files

- Run the `SV_filter.sh` script to filter the structural variants files by removing variants > 10 Mb, removing the random, unknown unidentified chromosomes, and the mitochondrial chromosomes, etc. Then annotate the filtered file.

- Prior to annotation load the following modules:
    
   * bio/AnnotSV/3.1.1

   * bio/AnnotSV/3.1.1-BEDtools-2.3.0

   * bio/BCFtools/1.11-GCC-8.3.0

   then,

    export ANNOTSV=/resources/tools/apps/software/AnnotSV/

run the script as follows: `sh SV_filter.sh SVfile_paths.list`

- Filter the generated files for ROIs using `SV_analysis.r`


