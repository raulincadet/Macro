library(dplyr)
library(ggplot2)
library(plotly)

variable<-c('Road', 'Electricity', 'Hospitals/Health', 'Schools/Education', 'Access to water',
            'Credit', 'Agriculture/Livestock', 'Other infrastructure', 'Security',
            'Employment', 'Irrigation/Drainage', 'Supporting commerce', 'Industry')

percentages<-c(69.41,17.82,17.02,15.16,13.3,11.44,11.44,7.98,5.32,4.26,
               3.99,1.60,
               0.80)
df<-data.frame(variable,percentages)

df%>%
  ggplot(aes(x=reorder(variable,percentages),y=percentages))+
  geom_bar(stat = 'identity',fill='orangered')+
  #geom_text(label=percentages,hjust=-0.09)+
  coord_flip()+
  xlab('Actions proposed')+ylab("Percentages")+
  ggtitle("Key actions for Haiti's prosperity, proposed by municipal sections")+
  labs(caption="Source:Realized by Raulin Cadet, with data provided by Université Quisqueya (uniQ) and \n the Inter-American Development Bank (IDB) in a graphic of the project Trase Chimen. \nData provided by the project may be viewed by hovering over the graphics \nof its dashboard: https://uniq.edu.ht/trase-chimen/ ")+
  theme_minimal()
