

df

df %>% 
  pivot_longer(-variable) %>% 
  pivot_wider(names_from = variable)

# example data sets from r4ds chapter
table1   # this is tidy
table2   # this is NOT tidy. Cases and Pop need to be columns

table2 %>% 
  pivot_wider(names_from = type, values_from = count)
# now it is tidy

table4a
table4b   # these are the same dataset but two different spreadsheets
# we have to combine them  # these are wide forms

table4a %>% 
  pivot_longer(names_to = "year", values_to = "cases", cols = -country)

table4b %>% 
  pivot_longer(names_to = "year", values_to = "population", cols = -country)
# Now, we have to merge the two datasets

full_join(table4a %>% 
            pivot_longer(names_to = "year", values_to = "cases", cols = -country),
          table4b %>% 
            pivot_longer(names_to = "year", values_to = "population", cols = -country) 
          )
# that does the trick to merge them











# practice with a new dataset- police stops - cars
install.packages("carData")
library(carData)

MplsStops
MplsDemo

MplsStops %>% names()
MplsDemo %>% names()
view(MplsStops)
MplsDemo %>% view()

MplsStops %>% 
  ggplot(aes(x=long,y=lat,color=race)) +
  geom_density_2d()
# it's always good to get a visualization of the data to understand it

MplsStops$citationIssued

#to combine both datasets
full <- full_join(MplsStops,MplsDemo)

full$race %>% table   # to get an idea of what all the races are


 # -----------------------------------------------------------------
# find the # of police stops all year in each neighborhood

full %>% 
  group_by(neighborhood) %>% 
  summarize(N=n(),
            N_per_pop = N / population,
            white=white,
            black=black,
            foreignBorn=foreignBorn) %>% 
  unique.data.frame() %>%   # this line will get rid of any duplicate rows
  arrange(desc(N_per_pop)) %>%    # this line is to get the table in descending order
  ungroup() %>%      # because it was giving an error message saying that it couldn't be plotted because it was being grouped by 'neighborhood'
  filter(!is.na(N_per_pop)) %>%    # this line was to get rid of the NA's because they were messing up the plot 
  
  ggplot(aes(x=white,y=N_per_pop)) +
  geom_point() +
  geom_smooth(method="lm")
 
# --------------------------------------------------------------------------
# 2022.10.03 notes

library(carData)
library(tidyverse)

df <- full_join(MplsStops,MplsDemo)
glimpse(df)
levels(df$problem)  # because I want to see all the levels of column Problem
levels(df$citationIssued)
levels(df$personSearch)

# lets convert those to TRUE FALSE logicals

df$citationIssued %>% table
df$citationIssued %>% summary()
# so we have a lot of NA's
# we're gonna just make the NA's FALSE

df %>% 
  mutate(citationIssued= case_when(
    citationIssued == "YES" ~ TRUE,
    citationIssued == "NO" ~ FALSE,
    is.na(citationIssued) ~ FALSE,
    TRUE ~ FALSE)) %>% 
select(citationIssued)

# a simpler way to write this code
df <- df %>% 
  mutate(citationIssued = case_when(citationIssued == "YES" ~ TRUE,
                                     TRUE ~ FALSE),
         vehicleSearch = case_when(vehicleSearch == "YES" ~ TRUE,
                                   TRUE ~ FALSE),
         suspiciousVehicleSearch = case_when(problem == "suspicious" & vehicleSearch == TRUE ~ TRUE,
                                             TRUE ~ FALSE))

df %>% 
  ggplot(aes(x=long,y=lat,color=suspiciousVehicleSearch)) + 
  geom_point()


# ---------------------------------------------- FUN PRACTICE ----------------

library(palmerpenguins)
# my attempt
penguins %>% 
  mutate(case_when(chonker= flipper_length_mm > 170 & body_mass_g > 2500)) %>% 
  ggplot(aes(x=flipper_length_mm,y=body_mass_g,color=chonker)) +
  geom_point()

# Dr. Zahn's answer
penguins %>% 
  mutate(chonker = case_when(body_mass_g > 4000 ~ TRUE,
                             TRUE ~ FALSE)) %>% 
  ggplot(aes(x=flipper_length_mm,y=body_mass_g,color=chonker)) +
  geom_point()

# now making a geom_density plot
penguins %>% 
  filter(!is.na(sex)) %>% 
  mutate(size=case_when(body_mass_g >= 5000 ~ "Fattie",
                        body_mass_g >= 4000 & body_mass_g < 5000 ~ "Medium",
                        body_mass_g < 4000 ~ "Tiny buddy")) %>% 
  ggplot(aes(x=body_mass_g, fill=size)) +
  geom_density(alpha=.5) +
  facet_wrap(~species*sex)


# -------------- MORE PRACTICE (with mpls) ---------

df %>% GGally::ggpairs()

df_sum <- 
df %>% group_by(neighborhood) %>% 
  summarize(N=n(),
            proportion_suspicious = sum(suspiciousVehicleSearch / N),
            stops_per_person = N/population,
            collegeGrad = collegeGrad,
            hhIncome = hhIncome,
            white=white,black=black,foreignBorn=foreignBorn,poverty=poverty,
            vehicleSearchtotal=sum(vehicleSearch),
            percent_searched = vehicleSearchtotal / N)

df_sum %>% 
  unique.data.frame() %>% 
  ggplot(aes(x=poverty,y=percent_searched,color=proportion_suspicious)) +
  geom_point() +
  geom_smooth(method="lm") +
  scale_color_viridis_c()
