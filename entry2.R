entry2 <- function(input){
  clue <- sapply(input, tolower)  
  clue <- gsub("'",'',clue) 
  clue1 = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-1))
  clue1 = paste0(clue1, collapse = ' ')
  clue2 = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-2))
  clue2 = paste0(clue2, collapse = ' ')
  clue3 = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-3))
  clue3 = paste0(clue3, collapse = ' ')
  clue4 = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-4))
  clue4 = paste0(clue4, collapse = ' ')
  
  df1 <- subset(df, tip == clue) #creating custom dataframe of just the userentry
  df2 <- subset(df, tip == clue1) 
  df3 <- subset(df, tip == clue2) 
  df4 <- subset(df, tip == clue3)
  df5 <- subset(df, tip == clue4)
  
  num_words1 <- sapply(strsplit(clue, " "), length)
  num_words2 <- sapply(strsplit(clue1, " "), length)
  num_words3 <- sapply(strsplit(clue2, " "), length)
  num_words4 <- sapply(strsplit(clue3, " "), length)
  num_words5 <- sapply(strsplit(clue4, " "), length)
  
  
  if(nrow(df1) > 0 && num_words1 >= 1)  {
    custom_df <- subset(df, tip == clue) %>% 
      arrange(desc(freq))  %>%
      mutate(percent = round(freq / sum(freq) * 100,1)) %>%
      mutate(last_word = lapply(strsplit(as.character(Content), split=" "), tail, n=1))
    result <- data.table(custom_df)  
  }
  else if (nrow(df2) > 0 && num_words2 >= 1)  {
    clue <- sapply(input, tolower)  #converting what the user types to lowercase
    clue <- gsub("'",'',clue) #removing apostrophes
    clue = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-1))
    clue = paste0(clue, collapse = ' ')
    
    custom_df <- subset(df, tip == clue) %>% 
      arrange(desc(freq))  %>%
      mutate(percent = round(freq / sum(freq) * 100,1)) %>%
      mutate(last_word = lapply(strsplit(as.character(Content), split=" "), tail, n=1))
    
    result <- data.table(custom_df)  
  }
  else if (nrow(df3) > 0 && num_words3 >= 1) {
    clue <- sapply(input, tolower)  #converting what the user types to lowercase
    clue <- gsub("'",'',clue) #removing apostrophes
    clue = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-2))
    clue = paste0(clue, collapse = ' ')
    
    custom_df <- subset(df, tip == clue) %>% 
      arrange(desc(freq))  %>%
      mutate(percent = round(freq / sum(freq) * 100,1)) %>%
      mutate(last_word = lapply(strsplit(as.character(Content), split=" "), tail, n=1))
    
    result <- data.table(custom_df)
  }
  else if (nrow(df4) > 0 && num_words4 >= 1) {
    clue <- sapply(input, tolower)  #converting what the user types to lowercase
    clue <- gsub("'",'',clue) #removing apostrophes
    clue = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-3))
    clue = paste0(clue, collapse = ' ')
    
    custom_df <- subset(df, tip == clue) %>% 
      arrange(desc(freq))  %>%
      mutate(percent = round(freq / sum(freq) * 100,1)) %>%
      mutate(last_word = lapply(strsplit(as.character(Content), split=" "), tail, n=1))
    
    result <- data.table(custom_df)
  }
  
  else if (nrow(df5) > 0 && num_words5 >= 1) {
    clue <- sapply(input, tolower)  #converting what the user types to lowercase
    clue <- gsub("'",'',clue) #removing apostrophes
    clue = tail(strsplit(clue, split=" ")[[1]],(sapply(strsplit(clue, " "), length)-4))
    clue = paste0(clue, collapse = ' ')
    
    custom_df <- subset(df, tip == clue) %>% 
      arrange(desc(freq))  %>%
      mutate(percent = round(freq / sum(freq) * 100,1)) %>%
      mutate(last_word = lapply(strsplit(as.character(Content), split=" "), tail, n=1))
    
    result <- data.table(custom_df)
  }
  
  else{print("Sorry. There is no solution")}
  return(result)
}

  