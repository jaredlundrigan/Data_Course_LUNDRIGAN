#learning about functions
library(tidyverse)

x <- 1:10
sum(x)

#how to create a function
my_sum <- function(x){sum(x,na.rm=TRUE)}
y <- c(1:3,NA)

sum(y)
my_sum(y)


mpg

function_1 <- function(mpg){
  ggplot(mpg, aes(x=displ,y=cty)) + geom_point()
}
function_1(mpg)

ggplot(mpg, aes(x=displ,y=cty)) + geom_point()

function_2 <- function(x,var1,var2){
  ggplot(x,aes(x=x %>% pluck(var1),
               y=x %>% pluck(var2)) +
    geom_point() +
    labs(x=var1,
         y=var2) +
    theme_minimal()
}

function_2(mpg,"hwy","cty")

function_2(mpg,"year","cty")

x <- mpg

if(!is.character(var1)){stop("var1 is not a character, you idiot!")}

function_2(iris,"Sepal.Length","Sepal.Width")


# take a vector of numbers 
# calculate the difference between each number and the minimum value

abs_min_diff <- function(x){
  if(!is.numeric(x)){stop("x must be a numeric vector, loser")}
  abs(x-min(x))
}
abs_min_diff(x)





