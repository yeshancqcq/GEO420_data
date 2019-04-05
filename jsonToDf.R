#' @title Converting GDD generated json file to data frame
#' @param input The json file to be converted.
#' This script is specifically for the main.R file
#' 


library(jsonlite)

jsonToDf <- function (input){
  
  # Creating a new empty data frame containing columns of interests
  glacier_df <- data.frame(
    title = character(),
    first_author = character(), 
    year = character(), 
    url = character(),
    gddid = character(),
    stringsAsFactors=FALSE
  )
  
  # Calculating the length of the json file
  json_length <- as.integer(length(input))  
  
  # Converting data of interests in the json file to the data frame
  for(i in 1:json_length){
    if(is.null(input[[i]][["title"]])){
      rd_title <- ""
    } else {
      rd_title <- input[[i]][["title"]]
    }
    if(is.null(rd_first_author <- input[[i]][["author"]][[1]][["name"]])){
      rd_first_author <- ""
    } else {
      rd_first_author <- input[[i]][["author"]][[1]][["name"]]
    }
    if(is.null(rd_year <- input[[i]][["year"]])){
      rd_year <- ""
    } else {
      rd_year <- input[[i]][["year"]]
    }
    if(is.null(rd_url <- input[[i]][["link"]][[1]][["url"]])){
      rd_url <- ""
    }else{
      rd_url <- input[[i]][["link"]][[1]][["url"]]
    }
    if(is.null(rd_gddid <- input[[i]][["_gddid"]])){
      rd_gddid <- ""
    } else {
      rd_gddid <- input[[i]][["_gddid"]]
    }

    newData <- data.frame(title=rd_title, first_author=rd_first_author, 
                          year=rd_year, url=rd_url, gddid=rd_gddid)
    glacier_df<-rbind(glacier_df, newData)
  }
  
  # Renaming columns of the data frame
  col_names <- c("Title", "First Author", "Year", "URL", "_gddid")
  colnames(glacier_df) <- col_names
  
  # Returning the generated data frame
  return(glacier_df)
}
