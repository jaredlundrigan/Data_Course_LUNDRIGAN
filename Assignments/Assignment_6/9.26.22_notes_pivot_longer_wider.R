library(tidyverse)


# learning about tidy data
# Assignment 6
# HOW TO MAKE WIDE DATA LONG AND LONG DATA INTO WIDE DATE

df <- read_csv("./Data/wide_income_rent.csv")
view(df)


# TIDY RULES
#   1. every column is a SINGLE variable
#   2. every row is a single observation of those variables
#   3. must be rectangular (missing cells have NA)

# The problem with this data is that there are 3 variables- income, rent, State. It is in wide format
# We have to change it to just 3 columns.

df %>% names
df %>% 
  ggplot(aes(x=))  # ???? wide format means that some variable(s) are spread across multiple columns



# if someone gives you an Excel file. Do not change to a csv. Just do as below:
library(readxl)
df2 <- read_xlsx("./Data/wide_data_example.xlsx")
df2
# The problem is that this is a wide format. There is no column called 'Treatment 1' or 'Treatment 2'
# The columns are SampleID, Treatment, Weight


# how to turn wide format to a long format
df2 %>% 
  mutate(`Treatment 1` = `Treatment 1` %>% as.numeric()) %>%     # since Treatment 1 is chr, it will try to convert to numbers (NA by coercion)
  pivot_longer(cols = starts_with("Treatment"),
               names_to = "Treatment",
               values_to = "Weight") %>% 
# it is long data now, since each SampleID is now measured twice (because of Treatment 1 and 2)
  ggplot(aes(x=SampleID,
             y=Weight)) +
  geom_point()



# now try it with wide_income_rent (df)

df %>% 
  pivot_longer(cols = -variable,    # this says everything except variable
               names_to = "State") %>% View 
# the problem is, income and rent are in same column

# pivot_wider() separates income and rent into 2 columns
df %>% 
  pivot_longer(cols = -variable,    
               names_to = "State") %>% 
  pivot_wider(names_from = variable)










