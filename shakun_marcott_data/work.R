library(readr)
library(dplyr)
library(stringr)
library(purrr)
library(assertthat)

getwd()

source("clear_marcott_data.R")
source("clear_shakun_data.R")

A7 <- read_csv("~/marcott_data/A7.csv")
View(A7)

A7_cleared <- clear_marcott_data(A7)

# This is just an example. Import selected dataset based on https://yeshancqcq.github.io/paleo/paleo_index.html.
