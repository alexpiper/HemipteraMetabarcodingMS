library(viridis)

##CREATE ALL COMBINATIONS

#Read in original sample sheet
SampleSheet <- read_csv("demulti/SampleSheet.csv",skip=20)

I7_Index_ID <- SampleSheet$index
I5_Index_ID <- SampleSheet$index2

combos <- unique(expand.grid(I7_Index_ID, I5_Index_ID))
combos$name <- paste0(combos$Var1,"_",combos$Var2)


#exclude real combinations

real <- as.data.frame(cbind(I7_Index_ID,I5_Index_ID,SampleSheet$Sample_ID))
real$name <- paste0(real$I7_Index_ID,"_",real$I5_Index_ID)

unexpected <- combos[!combos$name %in% real$name, ]

#write.csv(unexpected,file="demulti/Run5_unexpected.csv")

##READ DEMULTIPLEXED ALL

demulti <- read.table("demulti/readcount_250.txt")

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
  geom_tile(aes(fill = reads))  + scale_fill_viridis(name = "reads", trans = "log10")  + geom_text(label=demulti$reads) +
  scale_x_discrete(limits=SampleSheet$index,expand=c(0,0))+ scale_y_discrete(limits=SampleSheet$index2,expand=c(0,0)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), plot.subtitle =element_text(hjust = 0.5), legend.position = "bottom") +
  labs(title= "Trap Samples", subtitle = paste0("Index switch rate for the run: ", sprintf("%1.2f%%", switch_rate)))


##Subset to C5

combinatorial <- SampleSheet[1:5,]
unique <- SampleSheet[6:10,]

c5 <- plot[plot$i5 %in% combinatorial$index2 & plot$i7 %in% combinatorial$index, ]

c5plot <- ggplot(data = c5, aes(x = i7, y = i5), stat="identity") +
  geom_tile(aes(fill = reads)) + scale_fill_viridis(name = "reads", trans = "log10") + geom_text(label=c5$reads)+
  scale_y_discrete(limits=combinatorial$index2,expand=c(0,0)) +  scale_x_discrete(expand=c(0,0))+
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), legend.position = "bottom") +
  labs(title= "Combinatorial Indexing")

u5 <- plot[plot$i5 %in% unique$index2 & plot$i7 %in% unique$index, ]


u5plot <-  ggplot(data = u5, aes(x = i7, y = i5), stat="identity", main="Unique-Dual Indexing") +
  geom_tile(aes(fill = reads)) + scale_fill_viridis(name = "reads", trans = "log10")  + geom_text(label=u5$reads) +
  scale_x_discrete(limits=unique$index,expand=c(0,0))+ scale_y_discrete(limits=unique$index2,expand=c(0,0)) + 
  theme(axis.text.x = element_text(angle=90, hjust=1), plot.title=element_text(hjust = 0.5), legend.position = "bottom") +labs(title= "Unique-Dual Indexing")


##Summary of index switching rate - U5
u5_exp <- u5 %>% 
  filter( reads > 100000)
u5_obs<- u5 %>% 
  filter( reads < 100000)

switch_rate <- (sum(u5_obs$reads)/sum(u5_exp$reads)) *100


ggarrange(c5plot,u5plot, ncol=2,nrow=1, common.legend = TRUE, legend="bottom")

