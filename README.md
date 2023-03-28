## Molecular Diagnosis of Unsolved Cases in the Primary Congenital Glaucoma Cohort of the Genomics England 100,000 Genomes Project
   
   The paper describing the study is available [here]()
   
   This repo includes the scripts used for the data extraction and analysis of the GE100KGP PCG cohort.
   
   This analysis involves two stages of data extraction and annotation: a) single nucleotide variants (SNVs) annotations using `vep99` and b) structural variants (SVs) annotatoions using `AnnotSV`.

   The glaucoma gene panel used is shown in the table below:

      |            |            |           |
      |------------|------------|-----------|
      | _ADAMTS10_ | _ADAMTS17_ | _CPAMD8_  |
      | _CREBBP_   | _CYP1B1_   | _DDX58_   |
      | _FOXC1_    | _FOXE3_    | _IFIH1_   |
      | _LMX1B_    | _LTBP2_    | _MYOC_    |
      | _OCRL_     | _PAX6_     | _PITX2_   |
      | _SBF2_     | _SH3PXD2B_ | _TEK_     |
      | _ANGPT1_   | _COL1A1_   | _GPATCH3_ |
      | _GUCA1C_   | _KERA_     | _OPA1_    |
      | _PLOD2_    | _PXDN_     | _SLC4A11_ |
      | _SLC4A4_   | _WDR36_    |           |


### 1. SNV analysis:
    
- Prepare the coordinates of the regions of interests (ROIs), with genome assembly GRCh38 or GRCH37

 - Prepare a list with the paths of the subjects VCF files 

 - Scan the ROIs over the VCF files using the loop in `scan.sh`
    
    run the script as follows: `sh scan.sh file_paths.list ROIs.list directory_name`

-  Merge and VCF files generated and normalise the merged file

- Annotate with VEP tools (vep99), using the command in `vep_annotate.sh`

- Prior to annotation, load the following:

   * module purge

   * module load bio/VEP/99.1-foss-2019a-Perl-5.28.1

   * export PERL5LIB=${LOFTEE38}:${PERL5LIB}


- Parse the annotated file using bcftools(1.11)
  
  using the command: `bcftools +split-vep -f %CHROM\t%POS\t%REF\t%ALT\t%CSQ\n' -d -A tab annotated_file.vcf >> output.tsv`


### 2. SV analysis:

  Calling of GEL’s SVs was done using Manta, and CNVs using CANVAS.

  In this analysis we used AnnotSV to annotate.

- Prepare a list with the paths of the SV files

- Run the `SV_filter.sh` script to filter the structural variants files by removing variants > 10 Mb, removing the random, unknown unidentified chromosomes, and the mitochondrial chromosomes, etc. Then annotate the filtered file.

- Prior to annotation, load the following modules:
    
   * bio/AnnotSV/3.1.1

   * bio/AnnotSV/3.1.1-BEDtools-2.3.0

   * bio/BCFtools/1.11-GCC-8.3.0

   then,

   * export ANNOTSV=/resources/tools/apps/software/AnnotSV/

- Make sure you have the following as the first line of the main script `#!/usr/bin/env tclsh`

    run the script as follows: `sh SV_filter.sh SVfile_paths.list`

- Filter the generated files for ROIs using `SV_analysis.R`


