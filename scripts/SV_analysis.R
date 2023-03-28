Install.packages( "tidyr") 
llbrary(tidyr) 
library(dplyr) 
library( stringr) 

SV_files <- read.table("~/---PATH OF SV FILE PATHS LIST---/SV_files.list", quote=”\"", comment.char="") 

PCG_genes_panel <- read.csv( "~/---PATH OF THE GENE PANEL---/PCG_gene_panel", sep="")  
final = data.frame() 

for (i In 1:nrow(SV_files)) { 
  print(SV_files[i,"V1"]) 
  
  sample<-strsplit(SV_files[i,''V1"], "/")[[1]][8] 

cur_sample<-str_replace(sample,".SV. vcf.gz","") 

path<-paste("~/---Path of directory into which annotated file will be saved---/",cur_sample, "/",cur_sample,".annotated.tsv",sep = "") 

cur_sample_data <- read.delim(path) 

in_genelist<-cur_sample_data[cur_sample_data$Gene_name %in% PCG_gene_panel$AnnotSV_ID,]  
in_genelist <-in_genellst[which(in_genelist$Annotation_mode=="split"),] 

in_genelist_split<-separate(data=in_genelist,col=Location, into = c(“loc1”,”loc2”),sep=”-“,remove = FALSE) 

in_genelist_split_exon <-filter(in_genelist_split ,grepl("ex|tx",Location)) 

in_gene_list_intron <-filter(in_genellst_split,grepI("intron", loc 1), grep I("intron", loc2)) 

in_gene_list_dif_intron<-filter(in_gene_list_intron,loc1!=loc2) 
#For example if loc1 = intron2 and loc2 = intron2 also, then loc1=loc2 so this will be skipped, as this ultimately does not contain any exonic region, it only harbours introns.

in_genellst_exonic <-rbind(in_genellst_split_exon, in_gene_list_dif_intron) 

final_full_split<-cur_sample_data[cur_sample_data$AnnotSV_ID %in% in_genelist_exonic$AnnotSV_ID,] 

names(final_full_split)[15] <-"GT" 

final =rbind(final,final_full_split)
 
}
 
write.table(final, "~/---Path of the annotated file---/filename.tsv", row.names = F)

