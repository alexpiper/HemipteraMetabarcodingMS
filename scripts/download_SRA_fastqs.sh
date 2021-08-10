#!/usr/bin/env bash

# Make output folders
mkdir data
mkdir data/run1_mock
mkdir data/run2_250
mkdir data/run3_trap

# Download Mock communities
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/095/SRR14022295/SRR14022295_1.fastq.gz -o data/run1_mock/Pool-01-100_S1_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/095/SRR14022295/SRR14022295_2.fastq.gz -o data/run1_mock/Pool-01-100_S1_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/094/SRR14022294/SRR14022294_1.fastq.gz -o data/run1_mock/Pool-02-100_S2_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/094/SRR14022294/SRR14022294_2.fastq.gz -o data/run1_mock/Pool-02-100_S2_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/083/SRR14022283/SRR14022283_1.fastq.gz -o data/run1_mock/Pool-03-100_S3_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/083/SRR14022283/SRR14022283_2.fastq.gz -o data/run1_mock/Pool-03-100_S3_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/072/SRR14022272/SRR14022272_1.fastq.gz -o data/run1_mock/Pool-04-100_S4_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/072/SRR14022272/SRR14022272_2.fastq.gz -o data/run1_mock/Pool-04-100_S4_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/071/SRR14022271/SRR14022271_1.fastq.gz -o data/run1_mock/Pool-05-100_S5_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/071/SRR14022271/SRR14022271_2.fastq.gz -o data/run1_mock/Pool-05-100_S5_L001_R1_001.fastq.gz

curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/093/SRR14022293/SRR14022293_1.fastq.gz -o data/run1_mock/Pool-06-500_S6_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/093/SRR14022293/SRR14022293_2.fastq.gz -o data/run1_mock/Pool-06-500_S6_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/092/SRR14022292/SRR14022292_1.fastq.gz -o data/run1_mock/Pool-07-500_S7_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/092/SRR14022292/SRR14022292_2.fastq.gz -o data/run1_mock/Pool-07-500_S7_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/091/SRR14022291/SRR14022291_1.fastq.gz -o data/run1_mock/Pool-08-500_S8_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/091/SRR14022291/SRR14022291_2.fastq.gz -o data/run1_mock/Pool-08-500_S8_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/090/SRR14022290/SRR14022290_1.fastq.gz -o data/run1_mock/Pool-09-500_S9_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/090/SRR14022290/SRR14022290_2.fastq.gz -o data/run1_mock/Pool-09-500_S9_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/089/SRR14022289/SRR14022289_1.fastq.gz -o data/run1_mock/Pool-10-500_S10_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/089/SRR14022289/SRR14022289_2.fastq.gz -o data/run1_mock/Pool-10-500_S10_L001_R2_001.fastq.gz

curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/088/SRR14022288/SRR14022288_1.fastq.gz -o data/run1_mock/Pool-11-1000_S11_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/088/SRR14022288/SRR14022288_2.fastq.gz -o data/run1_mock/Pool-11-1000_S11_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/087/SRR14022287/SRR14022287_1.fastq.gz -o data/run1_mock/Pool-12-1000_S12_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/087/SRR14022287/SRR14022287_2.fastq.gz -o data/run1_mock/Pool-12-1000_S12_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/086/SRR14022286/SRR14022286_1.fastq.gz -o data/run1_mock/Pool-13-1000_S13_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/086/SRR14022286/SRR14022286_2.fastq.gz -o data/run1_mock/Pool-13-1000_S13_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/085/SRR14022285/SRR14022285_1.fastq.gz -o data/run1_mock/Pool-14-1000_S14_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/085/SRR14022285/SRR14022285_2.fastq.gz -o data/run1_mock/Pool-14-1000_S14_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/084/SRR14022284/SRR14022284_1.fastq.gz -o data/run1_mock/Pool-15-1000_S15_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/084/SRR14022284/SRR14022284_2.fastq.gz -o data/run1_mock/Pool-15-1000_S15_L001_R2_001.fastq.gz

# Download 250 pools
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/070/SRR14022270/SRR14022270_1.fastq.gz -o data/run2_250/Pool-U1-250_S6_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/070/SRR14022270/SRR14022270_2.fastq.gz -o data/run2_250/Pool-U1-250_S6_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/069/SRR14022269/SRR14022269_1.fastq.gz -o data/run2_250/Pool-U2-250_S7_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/069/SRR14022269/SRR14022269_2.fastq.gz -o data/run2_250/Pool-U2-250_S7_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/068/SRR14022268/SRR14022268_1.fastq.gz -o data/run2_250/Pool-U3-250_S8_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/068/SRR14022268/SRR14022268_2.fastq.gz -o data/run2_250/Pool-U3-250_S8_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/067/SRR14022267/SRR14022267_1.fastq.gz -o data/run2_250/Pool-U4-250_S9_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/067/SRR14022267/SRR14022267_2.fastq.gz -o data/run2_250/Pool-U4-250_S9_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/066/SRR14022266/SRR14022266_1.fastq.gz -o data/run2_250/Pool-U5-250_S10_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/066/SRR14022266/SRR14022266_2.fastq.gz -o data/run2_250/Pool-U5-250_S10_L001_R2_001.fastq.gz

# Download trap samples
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/082/SRR14022282/SRR14022282_1.fastq.gz -o data/run3_trap/Trap-01_S1_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/082/SRR14022282/SRR14022282_2.fastq.gz -o data/run3_trap/Trap-01_S1_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/081/SRR14022281/SRR14022281_1.fastq.gz -o data/run3_trap/Trap-02_S2_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/081/SRR14022281/SRR14022281_2.fastq.gz -o data/run3_trap/Trap-02_S2_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/080/SRR14022280/SRR14022280_1.fastq.gz -o data/run3_trap/Trap-03_S3_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/080/SRR14022280/SRR14022280_2.fastq.gz -o data/run3_trap/Trap-03_S3_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/079/SRR14022279/SRR14022279_1.fastq.gz -o data/run3_trap/Trap-04_S4_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/079/SRR14022279/SRR14022279_2.fastq.gz -o data/run3_trap/Trap-04_S4_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/078/SRR14022278/SRR14022278_1.fastq.gz -o data/run3_trap/Trap-05_S5_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/078/SRR14022278/SRR14022278_2.fastq.gz -o data/run3_trap/Trap-05_S5_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/077/SRR14022277/SRR14022277_1.fastq.gz -o data/run3_trap/Trap-06_S6_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/077/SRR14022277/SRR14022277_2.fastq.gz -o data/run3_trap/Trap-06_S6_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/076/SRR14022276/SRR14022276_1.fastq.gz -o data/run3_trap/Trap-07_S7_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/076/SRR14022276/SRR14022276_2.fastq.gz -o data/run3_trap/Trap-07_S7_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/075/SRR14022275/SRR14022275_1.fastq.gz -o data/run3_trap/Trap-08_S8_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/075/SRR14022275/SRR14022275_2.fastq.gz -o data/run3_trap/Trap-08_S8_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/074/SRR14022274/SRR14022274_1.fastq.gz -o data/run3_trap/Trap-09_S9_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/074/SRR14022274/SRR14022274_2.fastq.gz -o data/run3_trap/Trap-09_S9_L001_R2_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/073/SRR14022273/SRR14022273_1.fastq.gz -o data/run3_trap/Trap-10_S10_L001_R1_001.fastq.gz
curl -L ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR140/073/SRR14022273/SRR14022273_2.fastq.gz -o data/run3_trap/Trap-10_S10_L001_R2_001.fastq.gz
