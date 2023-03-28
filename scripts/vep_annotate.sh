#!/bin/bash

vep --input_file INPUTVCFFILE (YOUR_normalised_mergedVCF.vcf.gz) \
--output_file OUTPUTVCFFILE (YOUR_normalised_mergedVCF.vep.vcf.gz) \
--vcf \
--compress_output bgzip \
--species homo_sapiens \
--assembly GRCh38 \
--offline \
--cache \
--dir_cache ${CACHEDIR} \
--cache_version 99 \
--force \
--fork 32
--no_stats \
--everything \
--fasta /---path of the reference genome---/GRCh38Decoy_no_alt.fa \
--plugin CADD,/---path of CADD plugins---/CADD/v1.6/GRCh38/whole_genome_SNVs.tsv.gz \
--plugin LoF,loftee_path:${LOFTEE38},human_ancestor_fa:${LOFTEE38HA},gerp_bigwig:${LOFTEE38GERP},conservation_file:${LOFTEE38SQL} \
--plugin dbNSFP,[dbNSFPfile],Uniprot_acc_Polyphen2,Uniprot_id_Polyphen2,Uniprot_aapos_Polyphen2,MutationAssessor_UniprotID,Polyphen2_HDIV_score,Polyphen2_HDIV_rankscore,Polyphen2_HDIV_pred,Polyphen2_HVAR_score,Polyphen2_HVAR_rankscore,Polyphen2_HVAR_pred,SIFT_score,SIFT_converted_rankscore,SIFT_pred,MutationTaster_score,MutationTaster_converted_rankscore,MutationTaster_pred,MutationTaster_model,MutationTaster_AAE,MutationAssessor_variant,MutationAssessor_score,MutationAssessor_score_rankscore,MutationAssessor_pred,MutPred_AAchange
--custom /---path of ClinVar plugins---/clinvar/vcf_GRCh38/clinvar_20190219.vcf.gz,ClinVar,vcf,exact,0,CLNDN,CLNDNINCL,CLNDISDB,CLNDISDBINCL,CLNHGVS,CLNREVSTAT,CLNSIG,CLNSIGCONF,CLNSIGINCL,CLNVC,CLNVCSO,CLNVI
