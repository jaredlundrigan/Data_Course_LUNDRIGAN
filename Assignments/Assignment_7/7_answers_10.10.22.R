library(tidyverse)
read_csv(Assignment_7/Utah_Religions_by_County.csv)
files <- list.files(pattern=".csv", full.names = TRUE)
files
readLines(files[5], n=1)
df <- read_csv(files[5])
view(df)
df
#Import the Assignment_7/Utah_Religions_by_County.csv data set

#Clean it up into “tidy” shape

#Explore the cleaned data set with a series of figures (I want to see you exploring the data set)

#Address the questions:
  
#“Does population of a county correlate with the proportion of any specific religious group in that county?”
#“Does proportion of any specific religion in a given county correlate with the proportion of non-religious people?”
#Just stick to figures and maybe correlation indices…no need for statistical tests yet

#Add comment lines that show your thought processes _____________




# clean the data using janitor package

library(janitor)
library(tidyverse)
names(df)  

# 3 NEW LINE



df <- df %>% janitor::clean_names()
view(df)
# do gitpull first to be able to push it to GitHub

df <- df %>% 
  pivot_longer(-c("county","pop_2010","religious"),
               names_to = "denomination",
               values_to = "frequency")

df

df %>% 
  plot(x=df$County,y=df$Religious)

plot1 <- df %>% 
  ggplot(aes(x=County,
             y=Religious)) +
  geom_col()


plot2 <- df %>% 
  ggplot(aes(x=County,
             y=Pop_2010)) +
  geom_col()

df %>% 
  group_by(Pop_2010) %>% 
  ungroup() %>% 
  arrange(desc(Pop_2010)) %>% 
  summarize(County = County,
            Pop_2010 = Pop_2010,
            Religious = Religious,
            LDS = LDS)

df %>% cor(df$Pop_2010,df$Religious)

df %>% 
  ggplot(aes(x=LDS,
             y=Pop_2010,
             color = County)) +
  geom_point()+
  geom_smooth(method="lm") 


df %>% 
  pivot_longer(cols = df$`Assemblies of God`:df$Orthodox,
               names_to = Denomination,
               values_to = Proportion)

df
?pivot_longer


