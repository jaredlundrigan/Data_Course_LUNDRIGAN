# ggplot lesson

# load packages # previously I installed tidyverse from Packages # tidyverse cleans data # load this every time you work
library(tidyverse)

#load data
data("iris")

# rename the iris object
df <-  iris

# to get a glimpse of iris to know how to plot it
glimpse(iris)

# plot
ggplot(data = df,
       mapping = aes(x=Petal.Length, 
                     y = Petal.Width))
# it just maps - just the aesthetics - no data points on plot

# now add layers to it (calls geoms (geometries))
ggplot(data = df,
       mapping = aes(x=Petal.Length, 
                     y = Petal.Width)) +
  geom_point() +       # to add the data points
  geom_smooth()        # to add a smooth line

# aes is the components of the graph - the x and y graphs
# geoms are the types of graphs and customizing the graphs

ggplot(data = df,
       mapping = aes(x=Petal.Length, 
                     y = Petal.Width,
                     color = Species,
                     shape = Species,
                     size = Sepal.Length)) +
  geom_point() +       
  geom_smooth(method = "lm")  # to get a straight line

# look at distribution of a variable
ggplot(df,
       aes(x=Sepal.Length))+
  geom_density(fill = "Green")+
  facet_wrap(~Species)

# PRACTICE

# boxplot
ggplot(data = df,
       mapping = aes(x = Species,
                     y = Sepal.Length * Sepal.Width,
                     )) +
  geom_boxplot() +
  geom_smooth()


ggplot(data = df,
       mapping = aes(x = Sepal.Length * Sepal.Width,
                     y = Petal.Length * Petal.Width,
                     color = Species)) + 
  geom_boxplot() +
  geom_smooth()

# violin plot
ggplot(data = df,
       mapping = aes (x = Species,
                      y = Sepal.Length,
                      fill = Species)) +
  geom_violin() +
  geom_jitter(width = .1, height = 0, alpha = .5) +
  theme_minimal()
 
# aesthetics NEED to be the name of a column in your data frame

ggplot(df,
       aes(x=Sepal.Length,
           y=Sepal.Width,
           color = Species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)


# since you have tidyverse loaded, it's better to use read_csv rather than read.csv
df <- read_delim("./Data/DatasaurusDozen.tsv")

# another data set to practice with creating ggplots 
mtcars









