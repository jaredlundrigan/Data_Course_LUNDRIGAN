library(tidyverse)
library(ggimage)
mtcars
df <- mtcars

view(df)


pic10 <- "https://cdn.motor1.com/images/mgl/2zWQB/s1/jeremy-clarkson.jpg"
df$URL <- pic10
df %>% head()



df %>% 
  ggplot(aes(x=mpg,y=wt)) +
  geom_image(aes(image=URL)) + # set that new character column as an aesthetic
  geom_point(size = 12, alpha = 0.2)+
  theme(
    plot.background = element_rect(fill="lightyellow"),
    axis.title.x=element_text(face="bold.italic", color = "blue"),
    axis.title.y=element_text(family = "mono", face = "bold", size = 20, hjust = 0.2),
    strip.background = element_rect(fill = "magenta")
  ) +
  labs(x = "my x axis- mpg",
       title = "btw this is my Title for Cars chart")




