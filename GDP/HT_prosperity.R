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
  geom_bar(stat = 'identity')+
  coord_flip()
