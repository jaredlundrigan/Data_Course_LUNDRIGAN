library(tidyverse)
library(dplyr)


# I. 

df <- read.csv("cleaned_covid_data.csv")
head(df)


# II.

A_states <- df[df$Province_State == c("Alabama", "Arkansas", "Arizona", "Alaska"), ]


# III.

A_states %>% 
  ggplot(aes(x=Last_Update,
             y=Deaths)) +
  geom_point(color = 'black', size = 0.5) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~Province_State, scales = "free") +
  theme_classic() +
  labs(x = "Over Time (2020-21)", 
       y = "COVID Deaths",
       title = "COVID Deaths Over Time (2020-21)") 


# IV.

df3 <- df[ ,c("Province_State", "Case_Fatality_Ratio")]


aggregate(df$Case_Fatality_Ratio, by = list(df$Province_State), max, na.rm = TRUE)


df9 <- aggregate(df$Case_Fatality_Ratio, by = list(df$Province_State), max, na.rm = TRUE)
df9

df_desc <- df9 %>% arrange(desc(x))
df_desc


# V. 


df9 %>% 
  ggplot() +
  geom_col(aes(x=Group.1,
               y=x)) +
  facet_wrap(~Group.1, scales = "free") +
  theme_classic() +
  labs(x = "State/Province", 
       y = "Maximum Case Fatality Ratio",
       title = "Maximum Case Fatality Ratio by State") 

  

