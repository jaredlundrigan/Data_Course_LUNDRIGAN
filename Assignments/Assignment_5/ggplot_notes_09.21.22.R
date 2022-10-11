library(tidyverse)
data("faithful")
faithful
view(faithful)
ggplot(data = faithful,
       mapping = aes(x = eruptions,
                     y = waiting,
                     color = eruptions < 3)) +
  geom_point()


ggplot(data = faithful) +
  geom_point(mapping = aes(x = eruptions,
                      y = waiting),
                 color = 'steelblue')


ggplot(data = faithful) + 
  geom_histogram(mapping = aes(x = eruptions))


?geom_histogram

ggplot(faithful,
       aes(x = eruptions, y = waiting)) +
  geom_density_2d() +
  geom_point()

?geom_density_2d

ggplot(faithful)+
  geom_point(aes(x = eruptions,
                 y = waiting),
             shape = 'square',
             alpha = 0.3)
#alpha can calculate transparency on scale of 0 to 1

ggplot(data = faithful) +
  geom_histogram(mapping = aes(x = eruptions, 
                     fill = waiting < 60),
                     position = 'identity')
# look at difference btwn position = 'identity' rather 
# than the default ('stack')
#put in alpha = 0.3. This shows that they are just hiding
#behind each other

ggplot(data = faithful) +
  geom_histogram(mapping = aes(x = eruptions, 
                               fill = waiting < 60),
                 position = 'dodge')
# dodge is useful to put them beside each other


# Add a line that separates the two point distributions.
# See ?geom_abline for how to draw straight lines
# from a slope and intercept

ggplot(data = faithful) +
  geom_point(mapping = aes(x = eruptions, y=waiting)) +
  geom_abline(slope = -40, intercept = 200)



# new dataset
ggplot(mpg) +
  geom_jitter(aes(x=class, y=hwy),
              width = 0.2) +
  stat_summary(aes(x=class,y=hwy),
               fun = mean,
               geom = 'point', color = 'red', size = 2)


?stat_summary






