library(tidyverse)

####################################################################
### Import data related to Digital Real value added by Industry ###
df_digi=readxl::read_excel('GDP/DigitalEconomy_2017-2022.xlsx',
                           sheet = 'Table 8',range = 'B6:H103',
                           na='...'
                           )

str(df_digi)  # Verify data types

df_digi<-df_digi%>%
  rename(Industry=`...1`)%>%
  mutate(Industry=trimws(Industry))%>%              # to remove any space around industries names
  mutate(Industry=stringr::str_to_title(Industry))  # to have industries names in title style


######################################################################
######### Import and Structure NAICS Codes of Industries #############
df_naics=readxl::read_excel('GDP/2022_NAICS_Structure.xlsx',range='B3:C2147')

# remove the letter 'T' found at the end of some industries names
df_naics<-df_naics%>%
  mutate(Industry=ifelse(substr(`2022 NAICS Title`,nchar(`2022 NAICS Title`),nchar(`2022 NAICS Title`))=='T',
                         substr(`2022 NAICS Title`,1,nchar(`2022 NAICS Title`)-1),
                         substr(`2022 NAICS Title`,1,nchar(`2022 NAICS Title`))))%>%
  mutate(Industry=trimws(Industry))%>%                # to remove any space around each industries title
  mutate(Industry=stringr::str_to_title(Industry))    # to have Industries names as title style

# select only codes with two digits
df_naics<-df_naics%>%
  filter(nchar(`2022 NAICS Code`)==2)%>%
  rename(Code=`2022 NAICS Code`)

########################################
##### Add NAICS code to df_digi  ####### 

df_digi1<-merge.data.frame(df_digi,df_naics,by="Industry")

# rownames(df_digi1)=df_digi1$Industry  # row names become industries names

df_digi1<-df_digi1%>%
  select(1:7)#%>%                      # select only years 2017 to 2022
  # t()%>%                              # transpose to have years as columns
  # data.frame()                        # format as data frame



df_digi1%>%
  ggplot(aes(x=reorder(Industry,`2022`),y=`2022`))+
  geom_bar(stat = 'identity',fill='blue')+
  coord_flip()+
  xlab('Industries')+ylab("Millions of USD")+
  ggtitle("U.S. Digital Economy Value Added by Industry in 2022")+
  labs(caption="Source:Realized by Raulin Cadet, with data provided by the Bureau of Economic Analysis (BEA), updated on December 6, 2023.
")+
  theme_minimal()

