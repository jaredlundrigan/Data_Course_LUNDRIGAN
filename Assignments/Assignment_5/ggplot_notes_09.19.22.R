library(GGally)
GGally::
# double colons to see what is in GGally
  
GGally::

ggpairs(iris)
?ggpairs

library(ggimage)


 %>% 
  #control+shift+M gives you %>%  - its called a 'pipe'
  #the thing on the left side becomes the 1st argument on the right side
  
# example of how you can use pipe
1:10 %>% sum

# OR

1:10 %>% 
  sum()

# examples
1:10 %>% 
  sum() %>% 
  plot()

iris %>% 
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color = Species)) +
  geom_point()

# using the filter function to filter out things
iris %>% 
  filter(Species != 'setosa') %>% 
  filter(Sepal.Length < 7) %>% 
  ggplot(aes(x=Sepal.Length, y=Sepal.Width, color=Species)) +
  geom_point() +
  facet_wrap(~Species) # facets make a plot for each species. ~ means 'as a function of'


iris %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point(color = 'black') +
  geom_smooth(method = "lm") +
  facet_wrap(~Species) +
  theme_bw() +
  theme(strip.text = element_text(face='italic'),
        legend.position = "none") 


data("iris")

iris %>% 
  ggplot(aes(x=Species,y=Petal.Length)) + 
  geom_violin()


 # how to change the order of the species

iris %>% 
  mutate(Sepal.Area = Sepal.Length * Sepal.Width,
         Species = factor(Species,levels = c("virginica", "versicolor", "setosa"))) %>% 
  ggplot(aes(x=Sepal.Length, y=Petal.Length, color=Species)) +
  geom_point(color = 'black') +
  geom_smooth(method = "lm") +
  facet_wrap(~Species) +
  theme_bw() +
  theme(strip.text = element_text(face='italic'),
        legend.position = "none") 



# find summary statistics by group real fast
iris %>% 
  group_by(Species) %>% 
  summarize(max_sep_len = max(Sepal.Length),
            min_sep_len = min(Sepal.Length),
            mean_sep_len = mean(Sepal.Length),
            sd_sep_len = sd(Sepal.Length))










