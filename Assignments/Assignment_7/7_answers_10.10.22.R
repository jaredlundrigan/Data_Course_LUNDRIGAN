library(tidyverse)
read_csv(Assignment_7/Utah_Religions_by_County.csv)
files <- list.files(pattern=".csv", full.names = TRUE)
files
readLines(files[5], n=1)
df <- read_csv(files[5])

#Import the Assignment_7/Utah_Religions_by_County.csv data set

#Clean it up into “tidy” shape

#Add comment lines that show your thought processes _____________

# clean the data using janitor package

library(janitor)
library(tidyverse)

df <- df %>% janitor::clean_names()
view(df)


df <- df %>% 
  pivot_longer(cols = -c("county","pop_2010","religious"),
               names_to = "denomination",
               values_to = "frequency")


#Explore the cleaned data set with a series of figures (I want to see you exploring the data set)


df %>% 
  ggplot(aes(x=pop_2010,
             y=frequency,
             color = denomination)) +
  geom_point() +
  geom_smooth(method="lm")

df %>% 
  group_by(pop_2010) %>% 
  ungroup() %>% 
  arrange(desc(pop_2010)) %>% 
  summarize(county = county,
            pop_2010 = pop_2010,
            religious = religious,
            denomination=denomination)

plot(df)

#Address the questions:

#“Does population of a county correlate with the proportion of any specific religious group 
# in that county?”

# Yes, the proportion of muslims in a county correlates with the population. 
# the correlation quotient is 76%. As the population of a county increases, 
# so does the proportion of muslims (76% correlation)

cor(df$pop_2010,df$frequency, use = "complete.obs")
# no correlation

df %>% 
  ggplot(aes(x=pop_2010,
             y=frequency,
             color = denomination)) +
  geom_point() +
  facet_wrap(~county)

df1 <- subset(df, denomination== "lds")
df2 <- subset(df, denomination== "non_religious")
df3 <- subset(df, denomination== "catholic")
df4 <- subset(df, denomination== "evangelical")
df5 <- subset(df, denomination== "southern_baptist_convention")
df6 <- subset(df, denomination== "assemblies_of_god")
df7 <- subset(df, denomination== "episcopal_church")
df8 <- subset(df, denomination== "pentecostal_church_of_god")
df9 <- subset(df, denomination== "greek_orthodox")
df10 <- subset(df, denomination== "united_methodist_church")
df11 <- subset(df, denomination== "buddhism_mahayana")
df12 <- subset(df, denomination== "muslim")
df13 <- subset(df, denomination== "non_denominational")
df14 <- subset(df, denomination== "orthodox")

cor(df12$pop_2010,df12$frequency)
# this shows a correlation in the muslim denomination

df12 %>% 
  ggplot(aes(x=pop_2010,
             y=frequency,
            color=county)) +
  geom_point() +
  geom_smooth(method="lm")


#“Does proportion of any specific religion in a given county correlate with the 
# proportion of non-religious people?”

# df2 is non-religious
df2 %>% 
  ggplot(aes(x=pop_2010,
             y=frequency,
             color=county)) +
  geom_point()

cor(df$denomination == "orthodox", df$denomination == "non_religious")
cor(df$denomination == "lds", df$denomination == "non_religious")
cor(df$denomination == "catholic", df$denomination == "non_religious")
cor(df$denomination == "evangelical", df$denomination == "non_religious")
cor(df$denomination == "southern_baptist_convention", df$denomination == "non_religious")
cor(df$denomination == "assemblies_of_god", df$denomination == "non_religious")
cor(df$denomination == "episcopal_church", df$denomination == "non_religious")
cor(df$denomination == "pentecostal_church_of_god", df$denomination == "non_religious")
cor(df$denomination == "greek_orthodox", df$denomination == "non_religious")
cor(df$denomination == "united_methodist_church", df$denomination == "non_religious")
cor(df$denomination == "buddhism_mahayana", df$denomination == "non_religious")
cor(df$denomination == "muslim", df$denomination == "non_religious")
cor(df$denomination == "orthodox", df$denomination == "non_religious")
cor(df$denomination == "non_denominational", df$denomination == "non_religious")


# No, no specific religion in a given county correlates with non-religious people.

#Just stick to figures and maybe correlation indices…no need for statistical tests yet


