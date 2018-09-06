# Loading the libraries
library(tm);library(quanteda);library(stringi);library(stringr);library(data.table);library(dplyr)

blogs <- readLines(file("./en_US.blogs.txt"), encoding = "UTF-8", skipNul = TRUE)
blogs <- iconv(blogs, from = "latin1", to = "UTF-8", sub="")
news <- readLines(file("./en_US.news.txt"), encoding = "UTF-8", skipNul = TRUE)
news <- iconv(news, from = "latin1", to = "UTF-8", sub="")
twitter <- readLines(file("./en_US.twitter.txt"), encoding = "UTF-8", 
                     skipNul = TRUE)
twitter <- iconv(twitter, from = "latin1", to = "UTF-8", sub="")
corpus <- c(blogs,news,twitter)
rm(blogs);rm(news);rm(twitter)

set.seed(410)
sample <- sample(corpus, length(corpus)*0.33333)
badwords <-VectorSource(readLines("./badwords.txt"))
sample <- Corpus(VectorSource(sample))
sample <- tm_map(sample, stripWhitespace)
sample <- tm_map(sample, tolower)
sample <- tm_map(sample, removeNumbers)
#sample <- tm_map(sample, removeWords, stopwords("english"))
sample <- tm_map(sample, removePunctuation)
sample <- tm_map(sample, removeWords, badwords)
sample <- tm_map(sample, PlainTextDocument)
sample <- tm_map(sample, function(x) gsub("[^0-9A-Za-z///' ]", "", x))

myCorpus <- corpus(sample)

rm(badwords)

tok<-tokens(myCorpus,remove_numbers = TRUE, remove_punct = TRUE, remove_symbols = TRUE)

#mydf1<-dfm(tok,ngrams=1,concatenator = " " )
#mydf1<-dfm_trim(mydf1, min_termfreq = 50, min_docfreq = 50)
#df1 <- data.table(Content = featnames(mydf1), freq = colSums(mydf1),tip = ""
#df1<-df1[order(df1$freq,decreasing=TRUE),]

#Creating bigram table
mydf2<-dfm(tok,ngrams=2,concatenator = " " )
mydf2<-dfm_trim(mydf2, min_termfreq = 10, min_docfreq = 2)
df2 <- data.table(Content = featnames(mydf2), freq = colSums(mydf2),tip = sub("^\\s*((?:\\S+\\s+){0}\\S+).*", "\\1", featnames(mydf2)))
df2<-df2[order(df2$freq,decreasing=TRUE),]
rm(mydf2)

#Creating trigram table

mydf3<-dfm(tok,ngrams=3,concatenator = " " )
mydf3<-dfm_trim(mydf3, min_termfreq = 8, min_docfreq = 2)
df3 <- data.table(Content = featnames(mydf3), freq = colSums(mydf3), tip = sub("^\\s*((?:\\S+\\s+){1}\\S+).*", "\\1",featnames(mydf3)))
df3<-df3[order(df3$freq,decreasing=TRUE),]
rm(mydf3)

#Creating quadgram table
mydf4<-dfm(tok,ngrams=4,concatenator = " " )
mydf4<-dfm_trim(mydf4, min_termfreq = 6, min_docfreq = 2)
df4 <- data.table(Content = featnames(mydf4), freq = colSums(mydf4), tip = sub("^\\s*((?:\\S+\\s+){2}\\S+).*", "\\1",featnames(mydf4))
)
df4<-df4[order(df4$freq,decreasing=TRUE),]
rm(mydf4)

#Creating quintgram table
mydf5<-dfm(tok,ngrams=5,concatenator = " " )
mydf5<-dfm_trim(mydf5, min_termfreq = 4, min_docfreq = 2)
df5 <- data.table(Content = featnames(mydf5), freq = colSums(mydf5), tip = sub("^\\s*((?:\\S+\\s+){3}\\S+).*", "\\1",featnames(mydf5))
)
df5<-df5[order(df5$ freq,decreasing=TRUE),]
rm(mydf5)

#Creating sextgram table, might be overkill
mydf6<-dfm(tok,ngrams=6,concatenator = " " )
mydf6<-dfm_trim(mydf6, min_termfreq = 2, min_docfreq = 2)
df6 <- data.table(Content = featnames(mydf6), freq = colSums(mydf6), tip = sub("^\\s*((?:\\S+\\s+){4}\\S+).*", "\\1",featnames(mydf6))
)
df6<-df6[order(df5$ freq,decreasing=TRUE),]
rm(mydf6)

#combining the ngram data tables
df <- rbind(df2,df3,df4,df5,df6)

# adding the number of words from the ngrams, used for reference, not needed to run the function
df$words <- sapply(df$Content, function(x) length(unlist(strsplit(as.character(x), "\\W+"))))

save(df, file="capstone_ngram.RData")

rm(myCorpus)
rm(tok)
rm(corpus)

