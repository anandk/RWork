library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

#Go to apps.twitter.com to get the keys
#My keys are stored in the parent directory & hence... 
twitterAccess <- read.csv("../TwitterKeys.csv", stringsAsFactors = FALSE)

consumerKey <- twitterAccess[,"ConsumerKey"]
consumerSecret <- twitterAccess[,"ConsumerSecret"]
accessToken <- twitterAccess[,"AccessToken"]
accessTokenSecret <- twitterAccess[,"AccessTokenSecret"]

setup_twitter_oauth(consumerKey,consumerSecret,accessToken,accessTokenSecret)

targetUser <- getUser("_eroteme_")
tweets <- userTimeline(targetUser, n=3100, excludeReplies = TRUE)


tweets <- read.csv("erotemeTweets.csv",header = FALSE)
tweetCorpus <- Corpus(VectorSource(tweets[,3]))
tm <- TermDocumentMatrix(tweetCorpus, control = list(removePunctuation = TRUE,
                                                     stopwords = c("amp", 
                                                                   "thismomentonly",
                                                                   "fieryverse",
                                                                   "neernool",
                                                                   "emptyelegance",
                                                                   "like", 
                                                                   "can", 
                                                                   "elfincharms",
                                                                   "oceanofsong",
                                                                   "heidiayala",
                                                                   stopwords("english")), 
                                                     removeNumbers = TRUE, tolower = TRUE))
m = as.matrix(tm)
word_freqs = sort(rowSums(m), decreasing=TRUE)
dm = data.frame(word=names(word_freqs), freq=word_freqs)
dm <- dm[dm$freq > 10,]
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(16, "Dark2"))
wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(16, "Set2"))
