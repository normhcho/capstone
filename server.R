library(shiny)
library(dplyr)
library(data.table)
library(ggplot2)
library(wordcloud)
source('entry2.R')

shinyServer(function(input, output) {
  prediction <- reactive({
    words = input$phrase
    prediction = entry2(words)})
  
  output$table <- renderDataTable({
    table <- prediction()
    table <- table[,c(1,3,6,4,2,5)]
    table
    })
  
  output$plot <- renderPlot({
    
    pred <- prediction() 
    pred <- pred[1:4,]
    pred$last_word <- as.character(pred$last_word)

    ggplot(pred, aes(reorder(x=last_word, -percent), y=percent, fill=last_word)) +
    geom_bar(stat="identity") +
    ggtitle("The Top 4 Next Words and their Probabilities") +
    geom_text(aes(label=percent),color = 'black',vjust=-1) +
    xlab("word") +
    theme(plot.title = element_text(size = 16, face = "bold"),
          axis.text.x = element_text(size = 14),
          axis.text.y = element_text(size = 14))
  })
  
  output$wordcloud <-renderPlot({
    pred2 <- prediction() 
    pred2$last_word <- as.character(pred2$last_word)
    one_word_wc <- pred2[,c(2,6)]
  
    wordcloud(words = one_word_wc$last_word,
              freq = one_word_wc$freq, 
              min.freq= 3,
              max.words = 100, 
              family = "serif",
              colors=brewer.pal(8, "Dark2"),
              scale=c(4, 0.5))
  })
  
})
