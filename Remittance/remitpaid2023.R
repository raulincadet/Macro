library(dplyr)
library(ggplot2)

# Source of data: https://www.knomad.org/data/remittances
df=readxl::read_excel("Remittance/inward_remittance_flows_december_2023_1.xlsx",
                    range = "A1:y217")

d23<-df[c("Remittance inflows (US$ million)",'2023e')]
colnames(d23)<-c("Country","2023e")

d23<-d23%>%
  filter(!is.na(`2023e`))%>%arrange(desc(`2023e`))%>%
  head(12)              # remove rows with NA, arrange and select the 12 top values

d23<-d23[3:nrow(d23),]  # remove two regions, including World

g2<-d23%>%
  ggplot(aes(x=reorder(Country,`2023e`),y=`2023e`/1000000))+
  geom_bar(stat='identity',fill='orangered',width = 0.7)+
  geom_text(aes(label = round(`2023e`,2)), hjust = -0.1, size = 3) +  # Add labels
  ggtitle("Top Countries in Received Remittances Estimated for 2023")+xlab('Countries')+ylab("Millions USD")+
  coord_flip()+
  theme_classic()+
  theme(
    axis.line = element_blank(),
    axis.text.x = element_blank(),
    axis.title = element_text(size = 13,color = 'black'),  # Modify axis title font size
    axis.text = element_text(size = 12,color = 'black'),   
    strip.text = element_text(size = 13,color='black'),  # Modify facet title font size
    plot.title = element_text(size = 18,color = 'black')   # Modify plot title font size
  )
g2+labs(caption = "Source: By Raulin Cadet, with data from the World Bank-KNOMAD, December 2023.")+
  theme(plot.caption = element_text(size = 11, color = 'black'))  # to adjust font size

# https://www.oecd-ilibrary.org/sites/4e637bf0-en/index.html?itemId=/content/component/4e637bf0-e
