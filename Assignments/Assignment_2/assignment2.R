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

# write a command that displays the first line
#of each of those "b" files

# the dumb way of reading in all 3 files' first lines
readLines("Data/data-shell/creatures/basilisk.dat", n=1)
readLines("Data/data-shell/data/pdb/benzaldehyde.pdb")
readLines("Data/Messy_Take2/b_df.csv")

# the slightly better way (no copypasting required)
x <- list.files(path = "Data",
                full.names = TRUE,
                recursive = TRUE,
                pattern = "^b") #save the results as 'x'

readLines(x[1], n=1) # use [] notation to access those results
readLines(x[2], n=1) # one at a time, like a chimp would do it
readLines(x[3], n=1)

# for-loop   # how to read 1st line of the 3 files but in one command
for(eachfile in x){
  print(readLines(eachfile, n=1))
  }


for(each)
  
# do the for-loop thing for all csv files
  
for(eachfile in csv_files){
    print(readLines(eachfile, n=1))
  
}

