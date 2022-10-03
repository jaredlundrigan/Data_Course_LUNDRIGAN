library(tidyverse)

1.  Cleans this data into tidy (long) form

dat1 <- dat %>% 
  pivot_longer(cols = starts_with("Hr"),
               names_to = "Time",
               values_to = "Absorbance")

dat1 <- dat1 %>% 
  mutate(Time = Time %>% as.numeric())


dat1$Time[dat1$Time == "Hr_144"] <- "144"
dat1


mutate(`Treatment 1` = `Treatment 1` %>% as.numeric())

2.  Creates a new column specifying whether a sample is from soil or water

library(dplyr)


dat2 <- dat1 %>% 
  mutate("Soil/Water" = case_when(
    Substrate == "Water" ~ "Water",
    Substrate != "Water" ~ "Soil"
  )) 
dat2


3.  Generates a plot that matches this one (note just plotting dilution == 0.1):
  
library(tidyverse)
dat3 <- dat2 %>% 
  ggplot(aes(x=Time,
         y=Absorbance,
         color = `Soil/Water`)) +
  facet_wrap(~Substrate) +
  geom_line()



4.  Generates an animated plot that matches this one (absorbance values are mean of all 3 replicates for each group):
  
  This plot is just showing values for the substrate "Itaconic Acid"

library(ggplot2)
library(gganimate)
theme_set(theme_bw())

dat4 <- dat2[dat2$Substrate == "Itaconic Acid", ]

dat4 %>% 
  ggplot(aes(x=Time,
             y=Absorbance,
             color = `Soil/Water`)) +
  facet_wrap(~Substrate) +
  geom_point()

dat4 + transition_time(Time) 




