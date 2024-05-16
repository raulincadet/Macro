library(dplyr)
library(ggplot2)


df_bil<-readxl::read_excel("Remittance/bilateral_remittance_matrix_2021_0.xlsx",range = "A2:HH217")

# selected countries receiving remittances from the USA
df_filus<-df_bil%>%filter(`Remittance-receiving country (across)                                                              -                                                 Remittance-sending country (down)`=="United States")%>%
  t()%>%data.frame()%>%   # transpose the unique row and convert it to a data frame
  slice(2:215)%>%         # remove first and last rows containing the names of USA and World data respectively
  na.exclude()%>%         # remove all rows with NA
  mutate(remit=as.numeric(.),Country=rownames(.))%>%
  arrange(remit)

df_filus$Country<-rownames(df_filus)  # add a colunn with the country names


g2<-df_filus%>%arrange(remit)%>%tail(10)%>%
  ggplot(aes(x=reorder(Country,remit),y=remit))+
  geom_bar(stat='identity',fill='orangered',width = 0.7)+
  geom_text(aes(label = round(remit,2)), hjust = -0.1, size = 3) +  # Add labels
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
