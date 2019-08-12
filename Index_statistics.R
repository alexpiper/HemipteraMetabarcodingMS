
## Statistics of indices used

```{r supplementary - Index switching}

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

gplate +  facet_grid(~Plate,scales="free")
```
