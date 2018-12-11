# Reproducible Analyses from the Hemipteran Metabarcoding Manuscript


This repository hosts the R based reproducible workflow that performed the analyses presented for the manuscript "  " by Batovska et al

Rmarkdown documents are hosted in the root directory. The input sequencing data is not included in the repository for size reasons, and is instead available from the SRA under accession: PENDING. 

The taxonomic assignment stage of the analysis relies on reference fasta files formatted for the RDP classifier as natively implemented in the DADA2 package. These fasta files were created with the makedb.rmd script found in the root directory. These files are not included in the repository for size reasons, and are instead available from:

Auxiliary data is included in the Docs/ directory,

RDS files holding intermediate data objects suitable for performing the analyses of the processed sequencing data are in the relevant subdirectory in the data directory, and figures created by the Rmarkdown documents are in the output/ directory.

You can run these analyses on your own machine by (1) cloning the repository, (2) obtaining the raw sequencing data in fastq format, (3) Seperating the fastq files by run in the relevant subdirectory in the data directory, (4) installing required libraries, and (5) pressing Run. Even without the sequencing data, the analysis and plotting portion of each Rmarkdown document can be run using the stored rds files in the data directory.

These Rmarkdown documents have also been rendered into html format, and can be viewed in your web browser: 

[Analysis](https://alexpiper.github.io/HemipteraMetabarcodingMS/hemiptera_metabarcoding.html)

[Ref database](https://alexpiper.github.io/HemipteraMetabarcodingMS/database_builder.html)
