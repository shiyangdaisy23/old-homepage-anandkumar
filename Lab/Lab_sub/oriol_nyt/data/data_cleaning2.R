# set working directory
setwd("~/Dropbox/aaaaUCI/topic_modeling/visualization/NYTimes_modeling_demo/data")
library(R.matlab)

# gets all the data files
files_list <- list.files("matlab_data")


# function that makes all the data transformations
transform_data <- function(name_of_file_MAT){
  sprintf(name_of_file_MAT)
  data <- readMat( paste("matlab_data/", name_of_file_MAT, sep="") )
  names(data) <- c('crime', 'economy', 'education', 'online', 'sports')
  
  data$crime <- as.data.frame(data$crime)
  data$economy <- as.data.frame(data$economy)
  data$education <- as.data.frame(data$education)
  data$online <- as.data.frame(data$online)
  data$sports <- as.data.frame(data$sports)
  
  
  # rescale columns
  # aux <- apply(data$crime, 1, max)
  fun <- function(x){
    aux1 <- apply(x, 1, min)
    aux2 <- apply(x, 1, max)
    (x-aux1)/aux2
  }
  data <- lapply(data, fun)
  
  # add group column
  data$crime <- cbind( rep(c("crime"),10), data$crime )
  data$economy <- cbind( rep(c("economy"),10), data$economy )
  data$education <- cbind( rep(c("education"),10), data$education )
  data$online <- cbind( rep(c("online"),10), data$online )
  data$sports <- cbind( rep(c("sports"),10), data$sports )
  
  # name group column
  colnames(data$crime) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  colnames(data$economy) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  colnames(data$education) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  colnames(data$online) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  colnames(data$sports) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  
  row.names(data$crime) <- c("floor", "prosecutor", "police", "defendant", "restaurant", "chef", "investigator", "witness", "zzz_phil_jackson", "witnesses")
  row.names(data$economy) <- c("percent", "market", "growth", "economy", "rate", "rates", "economist", "poll", "survey", "companies")
  row.names(data$education) <- c("children", "reading", "campus", "learn", "prayer", "application", "literature", "deaf", "learning", "textbook")
  row.names(data$online) <- c("com", "information", "www", "zzz_eastern", "commentary", "web", "business", "separate", "marked", "holiday")
  row.names(data$sports) <- c("game", "ball", "guy", "run", "allowed", "threw", "throw", "left", "play", "starter")
  
  data_all <- data.frame()
  data_all <- rbind(data_all, data$crime)
  data_all <- rbind(data_all, data$economy)
  data_all <- rbind(data_all, data$education)
  data_all <- rbind(data_all, data$online)
  data_all <- rbind(data_all, data$sports)
  
  row_names <- row.names(data_all)
  row_names <- c(row_names, "")

    # add hack to rescale axis
  foo <- data.frame( rep(1,21) )
  foo[1,] <- ""
  foo <- t(foo)
  colnames(foo) <- c("group", "topic 1", "topic 2", "topic 3", "topic 4", "topic 5", "topic 6", "topic 7", "topic 8", "topic 9", "topic 10", "topic 11", "topic 12", "topic 13", "topic 14", "topic 15", "topic 16", "topic 17", "topic 18", "topic 19", "topic 20")
  data_all <- rbind(data_all, foo )
  row.names(data_all) <- row_names
  
  
  # save only 4 digits of each number
  
  data_all[,-1] <- sapply(data_all[,-1], as.numeric)
  data_all[,-1] <- sapply(data_all[,-1], round, digits = 3)
  
  name_of_file_CSV <- gsub(".mat", ".csv", name_of_file_MAT)
  
  write.csv(data_all, paste("csv_files/", name_of_file_CSV, sep="") )
}


# make the transformations for all the files in the "matlab_data" folder
sapply(files_list, transform_data)

