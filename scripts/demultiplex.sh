#load module
module load bcl2fastq2/2.20.0-foss-2018b

#raise amount of available file handles
ulimit -n 4000

### Demultiplex Run1
bcl2fastq -p 12 --runfolder-dir /group/sequencing/180309_M03633_0209_000000000-BN3J6 \
--output-dir /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run1_mock \
--sample-sheet /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run1_mock/SampleSheet.csv \
--no-lane-splitting --barcode-mismatches 1

### Demultiplex Run2
bcl2fastq -p 12 --runfolder-dir /group/sequencing/180221_M03633_0206_000000000-BN3K7 \
--output-dir /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run2_250 \
--sample-sheet /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run2_250/SampleSheet.csv \
--no-lane-splitting --barcode-mismatches 1

### Demultiplex Run3
bcl2fastq -p 12 --runfolder-dir /group/sequencing/180226_M03633_0208_000000000-BN3MN \
--output-dir /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run3_trap \
--sample-sheet /group/pathogens/Alexp/Metabarcoding/HemipteraMetabarcodingMS/data/run3_trap/SampleSheet.csv \
--no-lane-splitting --barcode-mismatches 1