# Reproducible Analyses from the Hemiptera Metabarcoding Manuscript

This repository hosts the R based reproducible workflow that performed the analyses presented for the manuscript "Developing a non-destructive metabarcoding protocol for detection of pest insects in bulk trap catches" by J. Batovska, A.M. Piper, I. Valenzuela, J.P. Cunningham & M.J. Blacket

The reproducible workflow to conduct the analyses can be found as Rmarkdown documents in the root directory, or [rendered here](https://alexpiper.github.io/HemipteraMetabarcodingMS/hemiptera_metabarcoding.html). The input sequencing data are not included in the repository for size reasons, and are instead available from the SRA under accession: PENDING. However RDS files holding intermediate data objects such as the OTU and taxonomy tables suitable for performing the analyses are contained inside the data directory.

The taxonomic assignment stage of the analysis relies on reference fasta files formatted for the RDP classifier as natively implemented in the DADA2 package. These fasta files were created with the database_builder.rmd script found in the root directory, which is also [rendered here](https://alexpiper.github.io/HemipteraMetabarcodingMS/database_builder.html). References files are not included in the repository for size reasons, and are instead hosted by [zenodo](http://doi.org/10.5281/zenodo.3557020)

You can run these analyses on your own machine by (1) cloning the repository, (2) obtaining the raw sequencing data in fastq format, (3) Seperating the fastq files by run in the relevant subdirectory in the data directory, (4) obtaining reference databases from [zenodo](http://doi.org/10.5281/zenodo.3557020), (5) installing required R libraries, and (6) pressing Run in the Rmarkdown file. Even without the sequencing data, the analysis and plotting portion of each Rmarkdown document can be run using the stored rds files in the data directory.
