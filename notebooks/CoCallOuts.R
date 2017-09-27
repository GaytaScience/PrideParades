#------------------------------------------------------------------------
# Pride Parade Company Call Outs
# Kelsey Campbell - 7/15/2017
# 
# Summarize company participation in Pride parades
# Identify consistently supportive companies 
#------------------------------------------------------------------------

setwd("C:/Users/Kelsey/Desktop/PrideParades/data")

install.packages('readxl')
install.packages("ggplot2")
install.packages("dplyr")
library('readxl')
library('ggplot2')
library("dplyr")

# Read in Data
#-------------------------------------------
df <- read_excel("Labeled.xlsx", sheet = "Sheet1")

# Subset to only Companies
companies <- df[ which(df$Category =='Large National Company' | df$Category =='Local/Regional Company'), ]


# Split of Large/Local Companies over Time
#-------------------------------------------

# Quick Plot
g <- ggplot(companies, aes(Year))
g + geom_bar(aes(fill = Category)) 

# Counts for each Category by Year
sum = summarise(group_by(companies,Year, Category),count =n())

ggplot(sum, aes(x = Year, y = count, fill = Category, label = count)) +
  geom_bar(stat = "identity") +
  geom_text(size = 3, position = position_stack(vjust = 0.5))

# Percents on each section
ggplot(companies %>% group_by(Year, Category) %>%
         summarize(n = n()) %>%    
         mutate(pct=n/sum(n)),           
       aes(Year, n, fill=Category)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=paste0(sprintf("%1.1f", pct*100),"%")), 
            position=position_stack(vjust=0.5)) + 
  scale_x_continuous(breaks=(2011:2017)) +
  scale_y_continuous(breaks = seq(0, 120, by = 20), name = "Number of Entries")

ggsave('CompanySplit.png', width = 9, height = 6, dpi = 200)

# Sector Breakdown over Time
#-------------------------------------------

# Counts for each Sector by Year
sumsector = summarise(group_by(companies,Year, Sector),count =n())

ggplot(data=sumsector, aes(x=Year, y=count, group = Sector, colour = Sector)) +
  geom_line(size = 1.05) + geom_point( size=2) +
  scale_x_continuous(breaks=(2011:2017)) +
  scale_y_continuous(breaks = seq(0, 40, by = 10), name = "Number of Entries")

ggsave('SectorOverTime.png', width = 9, height = 6, dpi = 200)

# Consistent Companies (Large National Only)
#-------------------------------------------

lncompanies <- df[ which(df$Category =='Large National Company'), ]

groupcnts <- summarise(group_by(lncompanies,Group),count =n())

groupcnts[which(groupcnts$count == 7), ]


