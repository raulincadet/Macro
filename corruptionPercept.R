library(dplyr)
library(plotly)
library(fredr)
library(wbstats)

# data retrieved
dcorrup<-readxl::read_excel("CPI2023_GlobalResultsTrends.xlsx",range ="A4:V184",col_names = TRUE)


# Identified countries with the lowest performance in Americas
dhigh_corrup<-dcorrup%>%                # data of countries with the lowest values in Americas
  arrange(`CPI score 2023`)%>%filter(Region=="AME")%>%filter(!is.na(`CPI score 2023`))%>%head(11)    


  g<-dhigh_corrup%>%
    ggplot(aes(x=reorder(`Country / Territory`,`CPI score 2023`),y=`CPI score 2023`))+
    geom_bar(stat='identity',fill='orangered')+
    geom_text(aes(label = `CPI score 2023`), hjust = -0.1, size = 3) +  # Add labels
        ggtitle("Corruption Perception: Lowest Performers in Americas")+xlab('Countries')+ylab("Scores")+
    coord_flip()+
    theme_classic()+
    theme(
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.title = element_text(size = 14,color = 'black'),  # Modify axis title font size
      axis.text = element_text(size = 12,color = 'black'),   
      strip.text = element_text(size = 13,color='black'),  # Modify facet title font size
      plot.title = element_text(size = 18,color = 'black')   # Modify plot title font size
    )
  g+labs(caption = "Source: By Raulin Cadet, with data from Transparency International.")+
    theme(plot.caption = element_text(size = 11, color = 'black'))  # to adjust font size
  
###############3
  

  # Filter data for the 10 countries with the lowest CPI scores in 2023 for each region
  dcorrup_lowest <- dcorrup %>%
    arrange(Region, `CPI score 2023`) %>%
    group_by(Region) %>%
    filter(!is.na(`CPI score 2023`)) %>%
    slice_head(n = 10)  # Select the top 10 rows for each region
  
  # Create a bar plot
  g <- dcorrup_lowest %>%
    ggplot(aes(x = reorder(`Country / Territory`, `CPI score 2023`), y = `CPI score 2023`)) +
    geom_bar(stat = 'identity', fill = 'orangered') +
    coord_flip() +
    facet_wrap(~Region, scales = "free_y", labeller = label_both) +
    theme(strip.text.y = element_text(angle = 0))  # Rotate facet labels for better readability
  
  # Display the plot
  print(g)
#######################3333


  library(treemap)
  
  treemap(dtf=dcorrup, index=c("Region","Country / Territory"),     vSize="CPI score 2023", type="index",
          fontcolor.labels=c("white","black"),    # Color of labels
          bg.labels=c("transparent"),              # Background color of labels
          )

  ###########################}
  library(treemapify)
  g <- ggplot(dcorrup, aes(x = "", y = "", fill = interaction(Region, Country), size = `CPI score 2023`)) +
    geom_treemap() +
    geom_treemap_text(place = "centre", grow = TRUE, reflow = TRUE,
                      aes(label = paste(`Country / Territory`, "\n", round(`CPI score 2023`, 2)))) +
    theme_void()
g  
