#install.packages("devtools")

#install.packages("digest")
#install.packages("Rcpp")

#if (!require("devtools")) {
#  install.packages("devtools")
#}
#install.packages("Rcpp", dependencies=TRUE)
#devtools::install_github("mkanai/grimon")

#R.version

library(grimon)
data("grimon.example")

#pdf(file = "plot_%03d.pdf")
#?grimon
example[1:10,1:10]
#write.csv(example, file = "grimon_example.csv")
example_col
grimon(x = example, col = example_col, label = 1:6,
       optimize_coordinates = TRUE, maxiter = 1e3,
       score_function = "angle",
       segment_alpha = 0.5,
       plot_2d_panels = TRUE)
#dev.off()


# Geuvadis Project data (Lappalainen, T., et al., Nature, 2013)
# "geuvadis" and "geuvadis_col" will be loaded.
data("grimon.geuvadis")
dim(geuvadis)

geuvadis$Population
write.csv(geuvadis$Population, file = "geuvadis_Population.csv")
geuvadis$Genotype
write.csv(geuvadis$Genotype, file = "geuvadis_Genotype.csv")
geuvadis$mRNA
write.csv(geuvadis$mRNA, file = "geuvadis_mRNA.csv")
geuvadis$miRNA
write.csv(geuvadis$miRNA, file = "geuvadis_miRNA.csv")

grimon(x = geuvadis, col = geuvadis_col,
       optimize_coordinates = TRUE, maxiter = 1e3,
       score_function = "angle",
       segment_alpha = 0.5)
?grimon


# JointLCL data (Li, YI., et al., Science, 2016)
# "jointLCL" and "jointLCL_col" will be loaded.
data("grimon.jointLCL")

jointLCL$Genotype
write.csv(jointLCL$Genotype, file = "jointLCL_Genotype.csv")
jointLCL$`DNA methylation`
write.csv(jointLCL$`DNA methylation`, file = "jointLCL_DNAmethylation.csv")
jointLCL$H3K27ac
write.csv(jointLCL$H3K27ac, file = "jointLCL_H3K27ac.csv")
jointLCL$`RNA-seq`
write.csv(jointLCL$`RNA-seq`, file = "jointLCL_RNA-seq.csv")
jointLCL$`Ribo-seq`
write.csv(jointLCL$`Ribo-seq`, file = "jointLCL_Ribo-seq.csv")
jointLCL$Protein
write.csv(jointLCL$Protein, file = "jointLCL_Protein.csv")


jointLCL_col
typeof(jointLCL_col)
grimon(x = jointLCL, col = jointLCL_col,
       optimize_coordinates = TRUE, maxiter = 1e3,
       score_function = "angle",
       segment_alpha = 0.5)
