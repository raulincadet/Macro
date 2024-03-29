library(dplyr)
library(ggplot2)


# Imported data - Source: https://www.bls.gov/cps/telework.htm

df23<-readxl::read_excel('telework-tables-2023-12.xlsx',
                         sheet = "Table 7",
                         range = "C6:J8",col_names = TRUE)
df23<-df23[2,]

df22<-readxl::read_excel('telework-tables-2022-12.xlsx',
                         sheet = "Table 7",
                         range = "C6:J8",col_names = TRUE)
df22<-df22[2,]


# df<-data.frame(df22%>%unlist(),df23%>%unlist())  # Created a data frame
# colnames(df)<-c("2022","2023")  # named the columns    


# df<-df%>%       
#   slice(c(1:5,7:8))             # keep all rows, except "Total"
t(df22)
df<-rbind.data.frame(df22%>%t()%>%data.frame()%>%   # merged data of years 2022 and 2023
                   mutate(Year='2022'),               # data of 2022, adding column of year
                 df23%>%t()%>%data.frame()%>%
                   mutate(Year='2023'))               # data of 2023, adding column of year

colnames(df)<-c("Persons","Year")
df<-df%>%
  mutate(Hours=rep(rownames(df)[1:8],2))%>%
  slice(c(1:5,7:13,15:16))
  

df%>%group_by(Year)%>%summarise(sum(Persons))

# Calculate position for labels at the top of each dodge group
label_position <- df %>%
  group_by(Persons) %>%
  summarize(label_y = max(Hours) + 1) %>%
  ungroup()

df%>%
  ggplot(aes(x=reorder(Hours,Persons),y=Persons,fill=Year))+
  geom_bar(stat="identity",position = "dodge")+
labs(title = "Persons by Average Weekly Telework Hours",
       caption="Source: Raulin L. Cadet, with data from U.S. Bureau of Labor Statistics.",
     x="",y="Thousands of Persons"
     ) +
  theme_minimal()+
  theme(
    axis.title = element_text(size = 13,color = 'black'),  # Modify axis title font size
    axis.text = element_text(size = 13,color = 'black'),   
    strip.text = element_text(size = 13,color='black'),  # Modify facet title font size
    plot.title = element_text(size = 18,color = 'black'),   # Modify plot title font size
    legend.position = "top"
  )+
  scale_fill_brewer(palette = "Paired")  # Change colors

 df%>%group_by(Year)%>%summarise(sum(Persons))
  
