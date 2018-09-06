library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict the Word in American English"),
      
  tabsetPanel(
    tabPanel("main / plot",
     
  sidebarLayout(          
    sidebarPanel(
      textInput("phrase", "Enter a phrase up to 5 words:"),
      submitButton("Submit")),
                            
           mainPanel(plotOutput("plot")))),
  
  tabPanel("wordcloud",
           mainPanel(plotOutput("wordcloud"))),
  
  tabPanel("table",
           h4("Glossary of Terms"),
           h5("Content: The predicted phrase."),
           h5("tip: The phrase that was entered."),
           h5("last_word: The predicted word."),
           h5("words: The number of words of the Content phrase."),
           h5("freq: The number of times the Content phrase appeared."),
           h5("percent: Percent of the time the particular phrase appeared."),
           
           br(),
           mainPanel(dataTableOutput("table"))),
  
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }") 
  
  )
                   
)
)

