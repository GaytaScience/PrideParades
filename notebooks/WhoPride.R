#------------------------------------------------------------------------
# Pride Parades - Who is Pride For?
# Kelsey Campbell - 7/22/2017
#         Updated - 6/25/2018
# 
# Summarize prevalence of LGBTQ+ focused parade groups
# Prepare data for interactive viz
#------------------------------------------------------------------------

setwd("C:/Users/Kelsey/Desktop/PrideParades/data")

install.packages('readxl')
install.packages("ggplot2")
install.packages("dplyr")
install.packages('reshape')
library('readxl')
library('ggplot2')
library("dplyr")
library('reshape')

# Read in Data
#-------------------------------------------
df <- read_excel("Labeled.xlsx", sheet = "Sheet1")

# Split of LGBTQ+ Focused vs "None" Over Time
#-------------------------------------------

# Create Summary Variables
df$sumLGBT = df$L + df$G + df$B + df$T + df$Other
data <- mutate(df, AnyLGBT = ifelse(sumLGBT > 0, 1, 0),
                  GenLGBT = ifelse(sumLGBT == 4, 1, 0))

#Summarize Any Data

anysplit <- data %>% group_by(Year, None, AnyLGBT) %>%
                     summarize(Nonesum = sum(None),
                              Anysum = sum(AnyLGBT))

any2 <- mutate(anysplit, Focus = ifelse(None == 1, "None", "Any LGBT")) 
any2$count <- any2$Nonesum + any2$Anysum 
anydata <- any2[c('Year', 'Focus', 'count')]

any_pct<- anydata %>% group_by(Year) %>%
                      mutate(pct=count/sum(count))

# Any Chart with Percents on each section
ggplot(any_pct, aes(x = Year, y = count, fill = Focus)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=paste0(sprintf("%1.1f", pct*100),"%")), 
            position=position_stack(vjust=0.5)) +
  scale_x_continuous(breaks=(2011:2018)) +
  scale_y_continuous(limits = c(0, 400), name = "Number of Entries",expand=c(0,0)) +
  scale_fill_manual(values=c("#FE066B","#2C75BE"))

ggsave('AnyLGBTSplit2018.png', width = 9, height = 6, dpi = 200)

# What are the "None" Entries?
#-------------------------------------------

# Subset
nones <- df[ which(df$None == 1), ]

# Summarize
nonesum <- nones %>% group_by(Category) %>%
                     summarize(value = n())

# Plot (All time, don't break out by year)
g <- ggplot(nonesum, aes(x = reorder(Category, value), y = value)) +
                         geom_bar(stat="identity", fill="#5189c1") +
                         coord_flip() + ylab(NULL) + xlab(NULL)
g

ggsave('NoneCatas4.png', width = 4, height = 6, dpi = 200)

# Data for D3 Viz
#-------------------------------------------

# Dont count indicator for B and T's if general LGBT group
data2 <- mutate(data, newB = ifelse(B == 1 & GenLGBT == 0, 1, 0), 
                      newT = ifelse(T == 1 & GenLGBT == 0, 1, 0))
# Summarize
sum <- data2 %>% group_by(Year) %>%
                 summarize(GenLGBT = sum(GenLGBT),
                          L = sum(L),
                          G = sum(G),
                          B = sum(newB),
                          T = sum(newT),
                          Other = sum(Other),
                          Eth_Culture_Race_Grp = sum(Eth_Culture_Race_Grp),
                          AnyLGBT = sum(AnyLGBT),
                          total = n()) 

# Get Totals Across All Years
sum["All" ,] <- colSums(sum)
sum$Year[sum$Year > 2017] <- "All"

# Calculate Percentages
perc <- mutate( sum, GenLGBT_pct=GenLGBT/total,
                     AnyLGBT_pct=AnyLGBT/total,
                     L_pct=L/total,
                     G_pct=G/total,
                     B_pct=B/total,
                     T_pct=T/total,
                     Other_pct=Other/total,
                     Eth_Culture_Race_Grp_pct=Eth_Culture_Race_Grp/total)

# Subset for Viz
vizdata <- perc[c('Year', 'GenLGBT_pct', 'L_pct', 'G_pct', 'B_pct', 'T_pct', 'Other_pct', 'Eth_Culture_Race_Grp_pct')]

# Export to csv
write.csv(vizdata, file = "whopride_vizdata.csv")

