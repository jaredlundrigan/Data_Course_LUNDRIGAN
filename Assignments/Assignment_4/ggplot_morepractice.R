library(tidyverse)
library(patchwork)
data("iris")
view(iris)
df <- iris
glimpse(iris)
ggplot(data = df,
       mapping = aes(
         x = Sepal.Length,
         y = Sepal.Width,
         color = Species
       )) +
  geom_point() +
  geom_smooth(method = "lm") 
  
p1 <- ggplot(df,
       aes(
         x = Sepal.Length,
         y = Sepal.Width
       )) +
  geom_point() +
  geom_smooth(aes(color=Species), se = FALSE, method = "lm")

p2 <- ggplot(df,
             aes(
               x = Sepal.Length,
               y = Sepal.Width,
               color = Species
             )) +
  geom_point() + 
  geom_smooth(color="black"), se= FALSE, method = "lm")

p1 + p2

# save a plot as an object
p3 <- ggplot(iris, aes(x=Species, y=Sepal.Length)) +
  geom_boxplot()
p3

(p1 + p2) / p3


# save plot as a file
dir.create("Figures") # this creates a new file
ggsave("./Figures/myfirstplot.png", plot = p3, width = 14, height = 6, dpi = 300)


#using patchwork to combine multiple plots
((p1+p2) / p3) / (p1+p2)

p4 <- p3 +
  theme_minimal() +
  labs(y="Sepal length",
       title = "QWERTYIOP",
       subtitle = "your mom",
       caption = "Data from iris")


ggsave("./Figures/mysecondplot.png" , p4, width = 4, height = 4, dpi = 300)

p5 <- p4 + 
  theme(axis.text.x = element_text(face = "bold.italic",
                                   size = 14,
                                   color = "blue"),
        plot.background = element_rect(fill = "red"),
        axis.title = element_text(size = 18, face = "bold"))



p6 <- 
  ggplot(iris, aes(x=Species, y=Sepal.Length, fill = Species)) +
  geom_boxplot()
p6



pal <- c("#6032a8" , "#5caac4" , "#5cc45e") # go to google, type 'color picker'
p6 +
  scale_fill_manual(values = pal)
# scale_fill is a good function to remember to change the colors

p6 +
  scale_fill_viridis_d()   #for colorblind ppl

ggplot(iris, aes(x = Sepal.Length,
                 y = Sepal.Width,
                 color = Sepal.Width)) +
  geom_point()
#how do you change the color from here?  

ggplot(iris, aes(x = Sepal.Length,
                 y = Sepal.Width,
                 color = Sepal.Width)) +
  geom_point() +
  scale_color_viridis_c(option = "inferno")
#use scale to choose your color scale


viridis::rocket(100)
#how to look up some color codes from viridis package

viridis::



  ggplot(iris,
         aes(x=Sepal.Width,
             y=Sepal.Length,
             color=Species)) +
  geom_point() +
  geom_smooth(data = iris[iris$Species != "setosa",],
              method="lm",
              se=FALSE) +
  labs(x="Sepal width",
       y="Sepal length") +
  theme_bw() +
  theme(legend.text = element_text(face="italic"))

#labs is how to rename axis titles
#look at 1st part in geom_smooth. That's how to remove a line