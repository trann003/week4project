# R Studio API Code
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Data import
library(tidyverse)
week4_df <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(week4_df)
week4_df <- separate(week4_df, qs, c("q1", "q2", "q3", "q4", "q5"), sep = "-")
week4_df[,c("q1", "q2", "q3", "q4", "q5")] <- sapply(week4_df[,c("q1", "q2", "q3", "q4", "q5")], as.numeric)
week4_df[,c("q1", "q2", "q3", "q4", "q5")][week4_df[,c("q1", "q2", "q3", "q4", "q5")] == 0] <- NA
week4_df$datadate <- lubridate::mdy_hms(week4_df$datadate)






# Data analysis
q2_over_time_df <- spread(week4_df[,c("parnum","stimver","q2")], stimver, q2)
mean(complete.cases(q2_over_time_df)) # different from mean(!is.na(q2_over_time_df))
