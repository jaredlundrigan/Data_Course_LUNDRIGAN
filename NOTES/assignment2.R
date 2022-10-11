list.files(recursive = FALSE, pattern = NULL, 
full.names = TRUE)
list.files(recursive = FALSE, path = ./DATA, pattern = NULL)
list.files(recursive = FALSE, path = "./Data")

#find how many csv files are there
csv_files <- list.files(path = "Data", 
                        recursive = TRUE,
                        full.names = TRUE, 
                        pattern = ".csv")

#find length of csv files
length(csv_files)
list.files(csv_files, [1:10])
wing <- list.files(path = "Data", recursive = TRUE,
           full.names = TRUE, 
           patterns = "wingspan_vs_mass.csv")

#find just the wingspan data set
wing <- list.files(path = "Data", recursive = TRUE, full.names = TRUE, pattern = "wingspan_vs_mass.csv")

list.files(path="Data", recursive=TRUE, full.names=TRUE, pattern = "^wing")
# laod that wingspan data set
df <- read.csv(file = wing)

#look at the first 5 lines of it
head(df, n=5)
head(df)


# ^ = 'starts with'
# $ = 'ends with'
# * = 0 to Infinite of anything (can be repeated 0 to infinite number of times)
# . = "any single character'

list.files(path = "Data", 
           full.names = TRUE,
           recursive = TRUE,
           pattern = "^b")

list.files(path = "Data",
           full.names = TRUE,
           recursive = TRUE,
           pattern = "^b.*b$")
#finding files that start with b and ends with b ^^)



