library(dplyr)
library(ggplot2)



# data retrieved
dcorrup<-readxl::read_excel("CPI2023_GlobalResultsTrends.xlsx",range ="A4:V184",col_names = TRUE)
dcorrup<-dcorrup%>%mutate(Region = case_when(
  Region == "AME" ~ "Americas",
  Region == "ECA" ~ "Eastern Europe & Central Asia",
  Region=="SSA"~"Sub-Saharan Africa",
  Region=="MENA"~"Middle East & North Africa",
  Region=="AP"~"Asia Pacific",
  Region=="WE/EU"~"Western Europe & European Union",
  TRUE ~ Region
))

c("orangered", "orange","olivedrab", "forestgreen", "black", "gray")


reg_colors <- c("royalblue4", "red4",'lightblue',"olivedrab", "forestgreen")

# Plot the data
dcorrup %>%
  arrange(`CPI score 2023`) %>%
  head(11) %>%
  ggplot(aes(x = `CPI score 2023`, y = reorder(`Country / Territory`, `CPI score 2023`,decreasing = TRUE))) +
  geom_bar(stat = 'identity', aes(fill = Region)) +
  xlab('CPI score') +
  ylab('Country/Territory') +
  geom_text(aes(label = paste("(",Rank,"th)",sep="")), vjust = 0, hjust = 1.1, color = "white", size = 4.5) +  # Add labels with Rank data
  
  scale_fill_manual(values = reg_colors) +  # defined my own colors
  theme_minimal()+
  labs(caption = "Source: By Raulin L. Cadet, with data from Transparency International.",
       title = "2023 Top Countries with Highest Corruption Perception Rank")+
  theme(
    axis.title = element_text(size = 13,color = 'black'),  # Modify axis title font size
    axis.text = element_text(size = 13,color = 'black'),   
    strip.text = element_text(size = 13,color='black'),  # Modify facet title font size
    plot.title = element_text(size = 18,color = 'black'),   # Modify plot title font size
    legend.position = "bottom"
    )+
  guides(fill = guide_legend(title = NULL))  # remove legend title
