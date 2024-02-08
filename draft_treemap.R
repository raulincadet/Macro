library(dplyr)
library(plotly)
library(treemapify)


# data retrieved
dcorrup<-readxl::read_excel("CPI2023_GlobalResultsTrends.xlsx",range ="A4:V184",col_names = TRUE)
dcorrup<-dcorrup%>%mutate(Region = case_when(
  Region == "AME" ~ "Americas",
  Region == "ECA" ~ "Eastern Europe\n &\n Central Asia",
  Region=="SSA"~"Sub-Saharan \n Africa",
  Region=="MENA"~"Middle East\n &\n North Africa",
  Region=="AP"~"Asia Pacific",
  Region=="WE/EU"~"Western Europe\n &\n European Union",
  TRUE ~ Region
))

ggplot(dcorrup, aes(area = `CPI score 2023`, fill = Region,
               label = `Country / Territory`, subgroup = Region)) +
  geom_treemap()+
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                               "white", fontface = "italic", min.size = 0) +
  geom_treemap_subgroup_border() +
  geom_treemap_text(colour = "black",
                    place = "centre",
                    size = 12,
                    reflow = T) +

  theme(legend.position = "none")
  