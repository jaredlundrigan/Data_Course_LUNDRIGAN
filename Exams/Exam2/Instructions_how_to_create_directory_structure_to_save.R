#create new R project
#create new folder
#inside folder, you have some folders where you data and work will be saved

library(tidyverse)

df <- read_csv("./data/DatasaurusDozen-wide.tsv")

p <- df %>% 
  ggplot(aes(x=x,y=y)) +
  geom_point() +
  facet_wrap(~dataset)

p

ggsave("./output/myplot.png",device="png")
