library(wbstats)
library(dplyr)
library(ggplot2)
# "BM.TRF.PWKR.CD.DT"

g<-wb_data(indicator ="BM.TRF.PWKR.CD.DT",mrv=1)%>%
  # filter(country %in% unlist(indic_high$country))%>%
  filter(date==2022)%>%              # data of countries with the highest values
  arrange(desc(`BM.TRF.PWKR.CD.DT`))%>%filter(!is.na(`BM.TRF.PWKR.CD.DT`))%>%head(10)%>%      
  ggplot(aes(x=reorder(country,`BM.TRF.PWKR.CD.DT`),y=`BM.TRF.PWKR.CD.DT`/1000000))+
  geom_bar(stat='identity',fill='forestgreen',width = 0.7)+
  geom_text(aes(label = round(`BM.TRF.PWKR.CD.DT`/1000000,2)), hjust = -0.1, size = 3) +  # Add labels
  ggtitle("Top Countries in Personal Remittances Paid: 2022")+xlab('Countries')+ylab("Millions USD")+
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
g+labs(caption = "Source: By Raulin Cadet, with data from the World Bank.")+
  theme(plot.caption = element_text(size = 11, color = 'black'))  # to adjust font size


