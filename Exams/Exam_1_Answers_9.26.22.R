library(tidyverse)
library(dplyr)


# I. 

df <- read_csv("cleaned_covid_data.csv")
head(df)
# it's better to do read_csv rather than read.csv 


# II.

A_states <- df[df$Province_State == c("Alabama", "Arkansas", "Arizona", "Alaska"), ]


# Dr. Zahn's answer:
A_states <- df %>% 
  filter(grepl("^A", Province_State)

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


# Dr. Zahn's answer:
names(A_states)

A_states %>% 
  ggplot(aes(x=Last_Update,y=Deaths)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  facet_wrap(~Province_State, scales = "free")
  
  
  
  

# IV.

df3 <- df[ ,c("Province_State", "Case_Fatality_Ratio")]


aggregate(df$Case_Fatality_Ratio, by = list(df$Province_State), max, na.rm = TRUE)


df9 <- aggregate(df$Case_Fatality_Ratio, by = list(df$Province_State), max, na.rm = TRUE)
df9

df_desc <- df9 %>% arrange(desc(x))
df_desc


# Dr. Zahn's answer:

state_max_fatality_rate <- df %>% 
  group_by(Province_State) %>% 
  summarize(Maximum_Fatality_ratio = max(Case_Fatality_Ratio, na.rm= TRUE)) %>% 
  arrange(desc(Maximum_Fatality_ratio))



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


# Dr. Zahn's answer:

state_max_fatality_rate %>% 
  mutate(Province_State = factor(Province_State, levels=Province_State)) %>% 
  ggplot(aes(x=Province_State,
             y=Maximum_Fatality_ratio)) +
  geom_col() +
  theme(axis.text.x = element_text(angle=90, hjust=1))


# BONUS Answer:

df %>% 
  group_by(Last_Update) %>% 
  summarize(TOTAL_DEATHS = sum(Deaths, na.rm = TRUE)) %>% 
  ggplot(aes(x=Last_Update,y=TOTAL_DEATHS)) +
  geom_point()








