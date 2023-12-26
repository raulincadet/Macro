library(dplyr)
library(ggplot2)
library(plotly)
library(fredr)

# set my API key
fredr_set_key('3f3ea2b88220ca8b204bdbb8a5ced854')


# creating a function to retrieve data related to several variables
ffreds<-function(symbols,
                 spec_unit=NULL,# specific unit for a variable
                 spec_symbols=NULL # vector of variables symbol to calculate the specific requested unit:chg, pch,pch1 etc
){
  dat=data.frame()
  i=1
  while (i<=length(symbols)) {
    if (symbols[i] %in% spec_symbols){
      ds=fredr(
        series_id = symbols[i],
        observation_start = as.Date("1990-01-01"),
        observation_end = Sys.Date(),units=spec_unit
      )
      dat=rbind.data.frame(dat,ds)
      i=i+1
    }else{
      ds=fredr(
        series_id = symbols[i],
        observation_start = as.Date("1990-01-01"),
        observation_end = Sys.Date()
      )
      dat=rbind.data.frame(dat,ds)
      i=i+1
    }
    
  }
  return(dat)
}

###############################################
##### Monthly and some daily data variable  ###

fredM_prices=c('FEDFUNDS',    # Federal Funds Effective Rate - NSA - Monthly
               'CPIAUCNS',    # Consumer Price Index for All Urban Consumers: All Items in U.S. City Average - NSA - Monthly
                'UNRATE'      # Unemployment rate - SA - Monthly
              
)


names(fredM_prices)<-c('(a) Federal funds effective rate','(b) Inflation (monthly)','(c) Unemployment rate')



######################################################

dfredp<-ffreds(fredM_prices,spec_unit = 'pch',spec_symbols = c("CPIAUCNS",'HPIPONM226S','PPIACO'))
dfredp$Variable<-names(dfredp$series_id)
########################################
###### Graphics

dfredp%>%
  ggplot(aes(x=date,y=value))+
  geom_line()+
  facet_wrap(~series_id)


#########################
# Identify trends and determine the colors
dfredp2 <- dfredp %>%
  group_by(Variable) %>%
  mutate(color = ifelse(value < lag(value), "orange", "blue"))

# Plotting
g1<-dfredp2 %>%filter(date>="2019-01-01")%>%
  ggplot(aes(x = date, y = value)) +
  geom_line(color='blue') +
  
  geom_smooth(se=F,color='orangered',linetype='dashed')+
  facet_wrap(~Variable,scales = "free_y") +
  labs(title = "Economic Indicator")+
  layout(annotations = list(
    text = "Source: by RC",
    showarrow = FALSE,
    x = as.Date("2019-01-01"),
    y = -0.1,
    xref = "paper",
    yref = "paper",
    xanchor = "center",
    yanchor = "top",
    font = list(size = 12)
  ))
ggplotly(g1)

#####################################
g1 <- dfredp2 %>%
  filter(date >= "2019-01-01") %>%
  ggplot(aes(x = date, y = value)) +
  geom_line(color = 'blue') +
  geom_smooth(se = FALSE, color = 'orangered', linetype = 'dashed') +
  facet_wrap(~Variable, scales = "free_y") +
  labs(title = "Economic Indicator",x='Date (months)',y='Percent')+
  theme_classic()

# Convert ggplot to plotly
g1_plotly <- ggplotly(g1)

g1_plotly <- g1_plotly %>%
  layout(margin = list(b = 100))  # Adjust the bottom margin as needed

# Add text below the graphic
g1_plotly <- g1_plotly %>%
  layout(annotations = list(
    list(
      text = "Source: by Raulin Cadet, with data provided by FRED.",
      showarrow = FALSE,
      x = 0.2,
      y = -0.2,
      xref = "paper",
      yref = "paper",
      xanchor = "center",
      #yanchor = "top",
      font = list(size = 12)
    )
  ))

g1_plotly


#######################333
#######################################
drec<-fredr(
  series_id = 'USREC',
  observation_start = as.Date("1990-01-01"),
  observation_end = Sys.Date()
)
drec<-drec%>%rename(recession=value,Date=date) # change variable name from 'value' to 'recession'
dada<-cbind.data.frame(dfredp2,drec%>%select(Date,recession))  # merge data frame

g1 <- dada %>%
  filter(date >= "2022-01-01") %>%
  ggplot(aes(x = date, y = value)) +
  geom_line(color = 'blue') +
  geom_smooth(se = FALSE, color = 'orangered', linetype = 'dashed') +
  geom_vline(aes(xintercept = as.Date(Date)), linetype = 'dotted', color = 'red')+
 
  
  facet_wrap(~Variable, scales = "free_y") +
  labs(title = "Economic Indicator",x='Date (months)',y='Percent')

# Convert ggplot to plotly
g1_plotly <- ggplotly(g1)

g1_plotly <- g1_plotly %>%
  layout(margin = list(b = 100))  # Adjust the bottom margin as needed

# Add text below the graphic
g1_plotly <- g1_plotly %>%
  layout(annotations = list(
    list(
      text = "Source: by Raulin Cadet, with data provided by FRED.",
      showarrow = FALSE,
      x = 0.2,
      y = -0.2,
      xref = "paper",
      yref = "paper",
      xanchor = "center",
      #yanchor = "top",
      font = list(size = 12)
    )
  ))

g1_plotly
