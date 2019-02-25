library(viridis)
library(stringdist)
library(tidyverse)
library(fields)
library(ggpubr)

##CREATE ALL COMBINATIONS

#Read in original sample sheet
SampleSheet <- read_csv("demulti/SampleSheet_Run6.csv",skip=20)

I7_Index_ID <- SampleSheet$index
I5_Index_ID <- SampleSheet$index2

combos <- unique(expand.grid(I7_Index_ID, I5_Index_ID))
combos$name <- paste0(combos$Var1,"_",combos$Var2)


#exclude real combinations

real <- as.data.frame(cbind(I7_Index_ID,I5_Index_ID,SampleSheet$Sample_ID))
real$name <- paste0(real$I7_Index_ID,"_",real$I5_Index_ID)

unexpected <- combos[!combos$name %in% real$name, ]

#write.csv(unexpected,file="demulti/Run6_unexpected.csv")

##READ DEMULTIPLEXED ALL

demulti <- read.table("demulti/readcount_mock.txt")

unique_sample <- demulti$V1 %>%
  str_replace_all("-","_") %>%
  str_split_fixed("_", n=3) 


unique_sample <- paste0(unique_sample[,1],"_",unique_sample[,2])

demulti$V1 <- unique_sample

colnames(demulti) <- c("sample","reads","unique.reads","unique.perc","topseq","topseq.freq","topseq.perc")

demulti <- demulti %>%
  distinct(sample, .keep_all=TRUE)

#demulti$sample[1:10] <- paste0(I7_Index_ID,"_",I5_Index_ID)

colnames(real)[3] <- "sample"

demulti <- left_join(demulti,real,by="sample")

demulti$name[is.na(demulti$name)] <- demulti$sample[is.na(demulti$name)]

##Summary of index switching rate
exp_rate <- demulti %>% 
  filter(str_detect(sample,paste(c("Pool", "Trap"),collapse = '|')))
obs_rate <- demulti %>% 
  filter(!str_detect(sample,paste(c("Pool", "Trap"),collapse = '|')))

switch_rate <- (sum(obs_rate$reads)/sum(exp_rate$reads)) *100

##plot index switching

plot <- demulti %>%
  separate(name,c("i7","i5"),"_")%>%
  select(i7,i5,reads)

p1 <- ggplot(data = plot, aes(x = i7, y = i5), stat="identity") +
  geom_tile(aes(fill = reads),alpha=0.9)  + scale_fill_viridis(name = "reads", begin=0.1,trans = "log10")  + geom_text(label=demulti$reads) +
  scale_x_discrete(limits=SampleSheet$index,expand=c(0,0))+ scale_y_discrete(limits=SampleSheet$index2,expand=c(0,0)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none") +
  labs(title= "100-500-1000 Pool Samples", subtitle = paste0("Index switch rate for the run: ", sprintf("%1.2f%%", switch_rate)))

#Plot with original sample names

searchi5 <- exp_rate$I5_Index_ID
searchi7 <-exp_rate$I7_Index_ID
replacement <- exp_rate$sample

plot2 <- plot

i=1
for (i in 1:length(replacement))
{
  plot2$i7 <- as.character(plot2$i7) %>%
  str_replace(pattern= as.character(searchi7[i]), replacement=paste0(replacement[i],"-",as.character(searchi7[i]))) 
  
  plot2$i5 <- as.character(plot2$i5) %>%
    str_replace(pattern= as.character(searchi5[i]), replacement=paste0(replacement[i],"-",as.character(searchi5[i]))) 
}
orderi7 <- c("Pool_1-GACGAGAT", "Pool_2-TAGTGGCA",  "Pool_3-CATTAACG", "Pool_4-TCGTTGAA", "Pool_5-TAGTACGC", "Pool_6-TTCACCGT",
             "Pool_7-AGGACAGT", "Pool_8-AATCGTGG",  "Pool_9-TGAATGCC",  "Pool_10-GTGCAATG", "Pool_11-AGTGGCAT",  "Pool_12-AGTCTACC",
             "Pool_13-ATCGGTAG",  "Pool_14-CGTATGAT",  "Pool_15-CTGTCGTA")

orderi5 <- c("Pool_1-GACTTCGT", "Pool_2-AATCTCGT",  "Pool_3-TTGCCACT", "Pool_4-GCGTTAAT", "Pool_5-CTTCAACG", "Pool_6-AGCGTACT",
             "Pool_7-TACGGTGA", "Pool_8-AACTGTCC",  "Pool_9-GACTGATA",  "Pool_10-ACATCTGC", "Pool_11-ACGTTAGG",  "Pool_12-CACTAGAC",
             "Pool_13-TGGCATTC",  "Pool_14-ACATTGCA",  "Pool_15-TATGCCAC")


plot2$i7 <- factor(plot2$i7, levels = orderi7)
plot2$i5 <- factor(plot2$i5 , levels = rev(orderi5))

p2 <- ggplot(data = plot2, aes(x = i7, y = i5), stat="identity") +
  geom_tile(aes(fill = reads),alpha=0.9)  + scale_fill_viridis(name = "reads", begin=0.1,trans = "log10")  + geom_text(label=demulti$reads) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none") +
  labs(title= "100-500-1000 Pool Samples", subtitle = paste0("Index switch rate for the run: ", sprintf("%1.2f%%", switch_rate)))



##Subset to C5

combinatorial <- SampleSheet[1:5,]
unique <- SampleSheet[6:10,]

c5 <- plot[plot$i5 %in% combinatorial$index2 & plot$i7 %in% combinatorial$index, ]

c5plot <- ggplot(data = c5, aes(x = i7, y = i5), stat="identity") +
  geom_tile(aes(fill = reads)) + scale_fill_viridis(name = "reads", trans = "log10") + geom_text(label=c5$reads)+
  scale_y_discrete(limits=combinatorial$index2,expand=c(0,0)) +  scale_x_discrete(expand=c(0,0))+
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), legend.position = "none") +
  labs(title= "Combinatorial Indexing")

u5 <- plot[plot$i5 %in% unique$index2 & plot$i7 %in% unique$index, ]


u5plot <-  ggplot(data = u5, aes(x = i7, y = i5), stat="identity", main="Unique-Dual Indexing") +
  geom_tile(aes(fill = reads)) + scale_fill_viridis(name = "reads", trans = "log10")  + geom_text(label=u5$reads) +
  scale_x_discrete(limits=unique$index,expand=c(0,0))+ scale_y_discrete(limits=unique$index2,expand=c(0,0)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), legend.position = "none") +labs(title= "Unique-Dual Indexing")


##Summary of index switching rate - U5
u5_exp <- u5 %>% 
  filter( reads > 100000)
u5_obs<- u5 %>% 
  filter( reads < 100000)

switch_rate <- (sum(u5_obs$reads)/sum(u5_exp$reads)) *100


ggarrange(c5plot,u5plot, ncol=2,nrow=1, common.legend = TRUE, legend="bottom")



##Get edit distance for used combinations

#Set colour table
colorTable <- designer.colors(8, c( "red","yellow", "white"),
                              x = c(0, 5, 8) / 140)
col_order <- SampleSheet$Sample_Name
# Hamming i7

  hami7 <- as.tibble(stringdistmatrix(SampleSheet$index, SampleSheet$index, "hamming"))
  
  #colnames(hami7) <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index)
  #hami7$row <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index)
  colnames(hami7) <- SampleSheet$Sample_Name
  hami7$row <- SampleSheet$Sample_Name
  hami7 <- hami7 %>% 
    gather(key="col","value",-row)
  

  hami7$row <- factor(hami7$row, levels = col_order)
  hami7$col <- factor(hami7$col, levels = rev(col_order))
  
phami7 <- ggplot(data = hami7, aes(x = row, y = col), stat="identity")  + 
  geom_tile(data = hami7,aes(fill = as.factor(value))) + 
    scale_fill_manual(values = colorTable) + 
    geom_text(label=hami7$value)   +  
  theme(axis.text.x = element_text(angle=90, hjust=1)) + theme(plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none", axis.title.x=element_blank(), axis.title.y=element_blank()) +
  labs(title= "Hamming distance for i7 index")  


# Hamming i5

hami5 <- as.tibble(stringdistmatrix(SampleSheet$index2, SampleSheet$index2, "hamming"))

#colnames(hami5) <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index2)
#hami5$row <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index2)
colnames(hami5) <- SampleSheet$Sample_Name
hami5$row <- SampleSheet$Sample_Name

hami5 <- hami5 %>% 
  gather(key="col","value",-row)


hami5$row <- factor(hami5$row, levels = col_order)
hami5$col <- factor(hami5$col, levels = rev(col_order))

phami5 <- ggplot(data = hami5, aes(x = row, y = col), stat="identity")  + 
  geom_tile(data = hami5,aes(fill = as.factor(value))) + 
  scale_fill_manual(values = colorTable) + 
  geom_text(label=hami5$value)   +  
  theme(axis.text.x = element_text(angle=90, hjust=1)) + theme(plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none", axis.title.x=element_blank(), axis.title.y=element_blank()) +
  labs(title= "Hamming distance for i5 index")  



# Levenshtein i7

lvi7 <- as.tibble(stringdistmatrix(SampleSheet$index, SampleSheet$index, "lv"))

#colnames(lvi7) <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index)
#lvi7$row <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index)
colnames(lvi7) <- SampleSheet$Sample_Name
lvi7$row <- SampleSheet$Sample_Name
lvi7 <- lvi7 %>% 
  gather(key="col","value",-row)


lvi7$row <- factor(lvi7$row, levels = col_order)
lvi7$col <- factor(lvi7$col, levels = rev(col_order))

plvi7 <- ggplot(data = lvi7, aes(x = row, y = col), stat="identity")  + 
  geom_tile(data = lvi7,aes(fill = as.factor(value))) + 
  scale_fill_manual(values = colorTable) + 
  geom_text(label=lvi7$value)   +  
  theme(axis.text.x = element_text(angle=90, hjust=1)) + theme(plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none", axis.title.x=element_blank(), axis.title.y=element_blank()) +
  labs(title= "Levenshtein distance for i7 index")  


# Levenshtein i5

lvi5 <- as.tibble(stringdistmatrix(SampleSheet$index2, SampleSheet$index2, "lv"))

#colnames(lvi5) <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index2)
#lvi5$row <- paste0(SampleSheet$Sample_Name, " - ", SampleSheet$index2)
colnames(lvi5) <- SampleSheet$Sample_Name
lvi5$row <- SampleSheet$Sample_Name

lvi5 <- lvi5 %>% 
  gather(key="col","value",-row)

lvi5$row <- factor(lvi5$row, levels = col_order)
lvi5$col <- factor(lvi5$col, levels = rev(col_order))

plvi5 <- ggplot(data = lvi5, aes(x = row, y = col), stat="identity")  + 
  geom_tile(data = lvi5,aes(fill = as.factor(value))) + 
  scale_fill_manual(values = colorTable) + 
  geom_text(label=lvi5$value)   +  
  theme(axis.text.x = element_text(angle=90, hjust=1)) + theme(plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none", axis.title.x=element_blank(), axis.title.y=element_blank()) +
  labs(title= "Levenshtein distance for i5 index")  



#Create multiplot
phami7 + phami5 + plvi7 + plvi5 + plot_layout(ncol = 2)
  


##i7 colour balancing

  spliti7 <- str_split(I7_Index_ID, "", n = Inf, simplify = FALSE)
  spliti7 <- as.tibble(t(data.frame(spliti7)))
  colnames(spliti7) <- c(1:8)
  
  spliti7$Name <- I7_Index_ID
  
  spliti7 <- spliti7 %>% 
    gather(Pos,Base,-Name)
  
  #Plots
  
  pspliti7 <-ggplot(data=spliti7, aes(x=Pos, y=1, fill=Base))+
    geom_bar(stat="identity", position=position_fill()) + theme_pubclean()  +   scale_fill_manual(values= c("Red","dodgerblue",  "Yellow", "lawngreen") ) + 
    ggtitle("Colour balance for i7 read") + theme(plot.title=element_text(hjust = 0.5), axis.title.y=element_blank()) +
    xlab("Position within index read") + ylab("Base Composition")
  
#i5 Colour balancing
  spliti5 <- str_split(I5_Index_ID, "", n = Inf, simplify = FALSE)
  spliti5 <- as.tibble(t(data.frame(spliti5)))
  colnames(spliti5) <- c(1:8)
  
  spliti5$Name <- I7_Index_ID
  
  spliti5 <- spliti5 %>% 
    gather(Pos,Base,-Name)
  
  #Plots
  
  pspliti5 <-ggplot(data=spliti5, aes(x=Pos, y=1, fill=Base))+
    geom_bar(stat="identity", position=position_fill()) + theme_pubclean()  +   scale_fill_manual(values= c("Red","dodgerblue",  "Yellow", "lawngreen") ) + 
    ggtitle("Colour balance for i5 read") + theme(plot.title=element_text(hjust = 0.5), axis.title.y=element_blank()) +
    xlab("Position within index read") + ylab("Base Composition")

  #Create multiplot
phami7 + phami5 + plvi7 + plvi5 + pspliti7 + pspliti5 + plot_layout(ncol = 2, nrow=3)


##Plot barcode plates

plates <- read_csv("demulti/qbarcodeplatescsv.csv")


plates$index <- factor(plates$index , levels=(unique(plates$index))[order(plates$Column)])
plates$index2 <- factor(plates$index2 , levels=(unique(plates$index2))[order(plates$Row)])

gplate <-ggplot(data=plates, aes(x=index, y=reorder(index2, desc(index2))))  +
  geom_tile(aes(fill=index2),alpha=0.5,colour="black") +
  geom_tile(aes(fill=index),alpha=0.5,colour="black") +
  geom_tile(aes(fill=Used),alpha=1,colour="black") +
  geom_text(aes(label = paste0(plates$Row,plates$Column)),show.legend = FALSE) +  # adding text for first course
    theme(plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "none",axis.text.x = element_text(angle=90, hjust=1)) +
  labs(title= "mpxPE Barcode plate layouts") + scale_fill_viridis(name = "reads", discrete = TRUE) +
  scale_x_discrete(breaks=(plates$index)[order(plates$Column)]) +
  scale_y_discrete(breaks=(plates$index2)) +  xlab("i7 Index") + ylab("i5 Index") +
  facet_wrap(~Plate, nrow=2,ncol=2, drop=TRUE,scales="free")

gplate +   facet_grid(~Plate,scales="free")
