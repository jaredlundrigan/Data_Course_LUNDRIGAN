library(janitor)
library(scales)
library(tidyverse)
library(modelr)
library(easystats)
library(broom)

# 1. Read in the unicef data (10 pts) 

files <- list.files(pattern= ".csv")
readLines(files[1])
df <- read_csv(files[1])

# 2. Get it into tidy format (10 pts) 

df <- df %>% clean_names()

df1 <- df %>% pivot_longer(cols = u5mr_1950:u5mr_2015, names_to = "year", values_to = "u5mr")

df2 <- df1 %>% 
  separate(year, into = c("code", "year"), sep = "\\_") 

df2 %>% filter(code)

df3 <- df2[,-4]

# 3. Plot each country’s U5MR over time (20 points)

df3 %>% 
  ggplot()+
  geom_line(aes(x=year,y=u5mr,
                group = country_name)) +
  facet_wrap(~continent) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_x_discrete(breaks = seq(1960, 2000, by = 20)) + 
  labs(x = "Year", y = "U5MR")

# 4. Save this plot as LASTNAME_Plot_1.png (5 pts) 

ggsave("LUNDRIGAN_Plot_1.png")


# 5. Create another plot that shows the mean U5MR for all the countries within a given continent 
# at each year (20 pts)

# get rid of NAs for entire dataset
df5 <- df3 %>% filter(!is.na(u5mr))

# find mean_U5MR for Africa by year
Africa <- subset(df3, continent == "Africa", select = c(continent, country_name, region, year, u5mr))

Africa <- Africa %>% filter(!is.na(Africa$u5mr))

dfAfrica <- Africa %>% 
  group_by(year) %>% 
  summarize(mean_U5MR = mean(u5mr)) 

dfAfrica <- dfAfrica %>% 
  mutate(continent = "Africa")

# find mean_U5MR for Americas by year
Americas <- subset(df5, continent == "Americas", select = c(continent, country_name, region, year, u5mr))

dfAmericas <- Americas %>% 
  group_by(year) %>% 
  summarize(mean_U5MR = mean(u5mr))

dfAmericas <- dfAmericas %>% 
  mutate(continent = "Americas")

# find mean_U5MR for Asia by year
Asia <- subset(df5, continent == "Asia", select = c(continent, country_name, region, year, u5mr))

dfAsia <- Asia %>% 
  group_by(year) %>% 
  summarize(mean_U5MR = mean(u5mr))

dfAsia <- dfAsia %>% 
  mutate(continent = "Asia")

# find mean_U5MR for Europe by year
Europe <- subset(df5, continent == "Europe", select = c(continent, country_name, region, year, u5mr))

dfEurope <- Europe %>% 
  group_by(year) %>% 
  summarize(mean_U5MR = mean(u5mr))

dfEurope <- dfEurope %>% 
  mutate(continent = "Europe")

# find mean_U5MR for Oceania by year
Oceania <- subset(df5, continent == "Oceania", select = c(continent, country_name, region, year, u5mr))

dfOceania <- Oceania %>% 
  group_by(year) %>% 
  summarize(mean_U5MR = mean(u5mr))

dfOceania <- dfOceania %>% 
  mutate(continent = "Oceania")

# join it all together
fullplot2 <- full_join(c(dfAfrica,dfAmericas,dfAsia,dfEurope,dfOceania))

AA <- full_join(dfAfrica,dfAmericas)
AAA <- full_join(AA,dfAsia)
AAAE <- full_join(AAA,dfEurope)
AAAEO <- full_join(AAAE,dfOceania)

# plot it
AAAEO %>% 
  ggplot() +
  geom_line(aes(x=year,
                y=mean_U5MR,
                group=continent,
                color = continent)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  scale_x_discrete(breaks = seq(1960,2000,by = 20)) +
  labs(x = "Year", y = "Mean_U5MR")

# save it as png
ggsave("LUNDRIGAN_Plot_2.png")


# 7. Create three models of U5MR (20 pts)
# 

# - mod1 should account for only Year

mod1 <- glm(data = AAAEO, formula = mean_U5MR ~ year)

summary(mod1)

tidy(mod1)

tidy(mod1) %>% 
  filter(p.value < 0.05)

# - mod2 should account for Year and Continent

mod2 <- glm(data = AAAEO, formula = mean_U5MR ~ year + continent)

summary(mod2)

tidy(mod2) %>% 
  filter(p.value < 0.05)

# - mod3 should account for Year, Continent, and their interaction term

mod3 <- glm(data = AAAEO, formula = mean_U5MR ~ year * continent)

summary(mod3)

tidy(mod3)

tidy(mod3) %>% 
  filter(p.value < 0.05) 

# 8. Compare the three models with respect to their performance
# 
# - Your code should do the comparing
# - Include a comment line explaining which of these three models you think is best

compare_performance(mod1,mod2,mod3)
compare_performance(mod1,mod2,mod3, rank = TRUE)
compare_performance(mod1,mod2,mod3) %>% plot

# I think mod3 is the best because the AIC is smaller and
# the R2 is also higher, and most everything else is smaller.


# 9. Plot the 3 models’ predictions like so

add_predictions(AAAEO,mod1) %>% 
  ggplot(aes(x=year,y=pred,color=continent,group=continent)) + 
  geom_smooth(method = "lm", se = F)

add_predictions(AAAEO,mod2) %>% 
  ggplot(aes(x=year,y=pred, color = continent)) +
  geom_smooth(method = "lm", se = F)

add_predictions(AAAEO,mod3) %>% 
  ggplot(aes(x=year,y=pred, color = continent)) +
  geom_smooth(method = "lm", se = F)

gather_predictions(AAAEO,mod1,mod2,mod3) %>% 
  ggplot(aes(x=year,
             y=pred,
             group=continent,
             color=continent)) +
  geom_smooth(method = "lm", se = F) +
  facet_wrap(~model) + 
  theme_bw() +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5)) +
  scale_x_discrete(breaks = seq(1960, 2000, by = 20)) + 
  labs(x = "Year", y = "Predicted U5MR")


# # 10. BONUS - Using your preferred model, predict what the U5MR would be for Ecuador in the year 2020. 
# The real value for Ecuador for 2020 was 13 under-5 deaths per 1000 live births. 
# How far off was your model prediction???


# I had to change the year column to numeric so that predict() would work.
AAAEO_1 <- AAAEO
AAAEO_1$year <- as.numeric(AAAEO_1$year)
mod3_1 <- glm(data = AAAEO_1, formula = mean_U5MR ~ year * continent)

predict(mod3_1,data.frame(year = 2020,
                        continent = "Americas"))


f5_2 <- df5
df5_2$year <- as.numeric(df5_2$year)
mod3_2 <- glm(data = df5_2, formula = u5mr ~ year * continent)
tidy(mod3_2)
summary(mod3_2)

predict(mod3_2, data.frame(year = 2020,
                           continent = "Americas"))


# Create any model of your choosing that improves upon this “Ecuadorian measure of model correctness.” 
# By transforming the data, I was able to find a model that predicted Ecuador would have a U5MR 
# of 16.61…not too far off from reality

Ecuador <- subset(df5, country_name == "Ecuador", select = 1:5)
Ecuador$year <- as.numeric(Ecuador$year)
mod4 <- glm(data = Ecuador, formula = u5mr ~ year)
tidy(mod4)

predict(mod4, data.frame(year = 2020))
# mod4 actually made it less accurate