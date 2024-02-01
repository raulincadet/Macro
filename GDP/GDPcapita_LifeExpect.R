library(dplyr)
library(ggplot2)
library(wbstats)


# indicators code for GDP per capita and Life expectancy at birth
windicators<-c('NY.GDP.PCAP.KD',
               "SP.DYN.LE00.IN")

names(windicators)<-c('GDP per capita',
                      'Life expectancy at birth')


# function to import and combine data from the World Bank
fmerge_wb<-function(){
  df=(wb_data(windicators[1],mrv = 1)%>%
        filter(date==max(date)))[,c(2,3,5)]
  i=2
  # while (i<=length(windicators)) {
  while (i<=length(windicators)) {
    do=(wb_data(windicators[i],mrv = 1)%>%
          filter(date==max(date)))[,c(2,3,5)]
    # do=do[,c(2,3,5)]
    df=merge(df,do,all.x=TRUE)
    i=i+1
  }
  return(df)
}

# data frame of data imported from the World Bank
df1=fmerge_wb()

# find data related to countries' regions
dcountries<-wbstats::wb_countries()[,c('iso3c','region')]
df2=merge(df1,dcountries,all.x = TRUE)

# Find country with maximum life expectancy
max_life_country <- df2 %>%
  filter(`Life expectancy at birth` == max(`Life expectancy at birth`,na.rm=T)) %>%
  pull(country)

# Find country with minimum life expectancy
min_life_country <- df2 %>%
  filter(`Life expectancy at birth` == min(`Life expectancy at birth`,na.rm=T)) %>%
  pull(country)

df2%>%
  ggplot(aes(x=`GDP per capita`,y=`Life expectancy at birth`))+
  geom_point(aes(colour=region),size=3.1)+
  theme_classic()+
  labs(title = "GDP per capita and Life Expectancy in 2022",
       caption="Source: By Raulin Cadet, with data from the World Bank.")+ # Set the new legend title for fil)+
  scale_color_discrete(name = "Regions") + 
  geom_text(data = df2 %>% filter(country == max_life_country),
            aes(label = country),
            vjust = -0.5, hjust = 0.5, color = "blue") +  # Adjust positioning and color
  geom_text(data = df2 %>% filter(country == min_life_country),
            aes(label = country),
            vjust = 1, hjust = -0.2, color = "blue") + 
  xlab("GDP per capita (constant 2015 US$)")+
  ylab("Life expectancy at birth (years)")+
  theme(
    #axis.line = element_blank(),
    # axis.text.x = element_blank(),
    axis.title = element_text(size = 11,color = 'black'),  # Modify axis title font size
    axis.text = element_text(size = 10,color = 'black'),   
    strip.text = element_text(size = 12,color='black'),  # Modify facet title font size
    plot.title = element_text(size = 16,color = 'black', margin = margin(b = 15))   # Modify plot title font size
  )+
  xlim(0, 120000)  # Adjust the x-axis limits as needed
