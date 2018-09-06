# capstone
Capstone Project for the Johns Hopkins Data Science Specialization 

The shiny application is located at: https://normhcho.shinyapps.io/CapstoneProjectSwiftKey/

The purpose of the model is to predict the next word based off of samples from Twitter, blogs, and news articles.

This was an extensive process where the text was converted to the UTF-8 format.  From there, a corpus was created using a 33% sample and then cleaned by:  removing numbers, stripping white space, erasing punctuation, etc.

The next step was to create individual tables of 1 to 6 words or unigrams to sextgrams.  The resulting dataframe is the capstone_ngram file.

The processing of the ngram data file is done with the entry2 file.  Then, the ui and server files provide the code for the Shiny application.

The application predicts the next word based off the existing results of the corpus.  The first tab graphs the first 4 words.  The second tab is a wordcloud object and then the third tab shows a data table with more detail.




