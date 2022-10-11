library(tidyverse)
library(janitor)
install.packages("janitor")

files <- list.files(pattern=".csv", full.names=TRUE)
files <- files[1:4]
files

readLines(files[1], n=1)
readLines(files[2], n=1)
readLines(files[3], n=1)
readLines(files[4], n=1)

read_csv(files[1]) %>%  clean_names()

df1 <- read_csv(files[1])
df2 <- read_csv(files[2])
df3 <- read_csv(files[3])
df4 <- read_csv(files[4])

view(df3)
df3

# Combine the data sets appropriately to investigate whether departure delay 
# was correlated with snowfall amount
#+ You will need to think carefully about column names
#+ Plot average departure delays by state over time
#+ Plot average departure delays by airline over time
#+ Plot effect of snowfall on departure *and* arrival delays

df1
df2
df3
view(df4)
df4 %>% 
  mean(df4$snow_precip_cm)
df4
df4$snow_precip_cm %>% max()
df3$DEPARTURE_DELAY %>% max()



df3 %>% 
  summarize(N = n(),
            
            %>% 
  filter(!is.na(N_per_pop))
            
            
df1        
df2            
df3
df4 %>% 
  mutate(colnames(iata = "IATA_CODE")


            
            
            