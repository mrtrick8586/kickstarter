source(file = '/Volumes/Stuff/FinalKickstarterStuff/libraries.R')

#Load the data and libraries
load(file = "/Users/pmlandis/Desktop/Kickstarter.Rda")

#kickstarter.sample = sample_n(kickstarter.data, 10)

Description.Data.Analysis = suppressWarnings(do.call(rbind.data.frame,lapply(kickstarter.data$Description,
                                                                             function(i){
                                                                               
                                                                               #data preprocessing
                                                                               docs.d = Corpus(VectorSource(i))
                                                                               docs.d = tm_map(docs.d, content_transformer(tolower))
                                                                               docs.d = tm_map(docs.d, removeNumbers)
                                                                               docs.d = tm_map(docs.d, removeWords,stopwords("english"))
                                                                               docs.d = tm_map(docs.d, removePunctuation)
                                                                               docs.d = tm_map(docs.d, removeWords, c('\n'))
                                                                               docs.d = tm_map(docs.d, stemDocument, language = "english")
                                                                               syuzhet.sentences = get_sentences(as.character(i))
                                                                               
                                                                               # Freq of Words
                                                                               dtm = TermDocumentMatrix(docs.d)
                                                                               m = as.matrix(dtm)
                                                                               v = sort(rowSums(m), decreasing = TRUE)
                                                                               d = tryCatch(data.frame(word = names(v), freq = v), error = function(err) NA)
                                                                               
                                                                               
                                                                               #NRC Sentiment Analysis
                                                                               sentiment = get_nrc_sentiment(as.character(i))
                                                                               sentiment.dataframe = data.frame(t(d))
                                                                               
                                                                               #Syuzhet Sentiment Analysis
                                                                               syuzhet.sentiment.sum = sum(get_sentiment(syuzhet.sentences, method = "syuzhet"))
                                                                               syuzhet.sentiment.mean = mean(get_sentiment(syuzhet.sentences, method = "syuzhet"))
                                                                               syuzhet.sentiment.value = get_sentiment(as.character(i), method = "syuzhet")
                                                                               
                                                                               #Data postprocessing
                                                                               D.Word1 = tryCatch(as.character(d$word[[1]]), error = function(err) NA)
                                                                               D.Word2 = tryCatch(as.character(d$word[[2]]) , error = function(err) NA)
                                                                               D.Word3 = tryCatch(as.character(d$word[[3]]) , error = function(err) NA)
                                                                               D.Word4 = tryCatch(as.character(d$word[[4]]) , error = function(err) NA)
                                                                               D.Word5 = tryCatch(as.character(d$word[[5]]) , error = function(err) NA)
                                                                               D.WordCount1 = tryCatch(as.numeric(d$freq[[1]]) , error = function(err) NA)
                                                                               D.WordCount2 = tryCatch(as.numeric(d$freq[[2]]) , error = function(err) NA)
                                                                               D.WordCount3 = tryCatch(as.numeric(d$freq[[3]]) , error = function(err) NA)
                                                                               D.WordCount4 = tryCatch(as.numeric(d$freq[[4]]) , error = function(err) NA)
                                                                               D.WordCount5 = tryCatch(as.numeric(d$freq[[5]]), error = function(err) NA)
                                                                               D.Anger = tryCatch(sentiment$anger , error = function(err) NA)
                                                                               D.Anticipation = tryCatch(sentiment$anticipation , error = function(err) NA)
                                                                               D.Disgust = tryCatch(sentiment$disgust , error = function(err) NA)
                                                                               D.Joy = tryCatch(sentiment$joy , error = function(err) NA)
                                                                               D.Fear = tryCatch(sentiment$fear , error = function(err) NA)
                                                                               D.Sadness = tryCatch(sentiment$sadness , error = function(err) NA)
                                                                               D.Surprise =  tryCatch(sentiment$surprise , error = function(err) NA)
                                                                               D.Trust =  tryCatch(sentiment$trust , error = function(err) NA)
                                                                               D.Positive =  tryCatch(sentiment$positive , error = function(err) NA)
                                                                               D.Negative = tryCatch(sentiment$negative , error = function(err) NA)
                                                                               Description = tryCatch(i , error = function(err) NA)
                                                                               D.syuzhet.score = syuzhet.sentiment.value
                                                                               D.syuzhet.sum = syuzhet.sentiment.sum
                                                                               D.syuzhet.mean = syuzhet.sentiment.mean
                                                                               
                                                                               Tempdata.D = tryCatch(data.frame(D.Word1, D.Word2, D.Word3, D.Word4, D.Word5, D.WordCount1, D.WordCount2,
                                                                                                                D.WordCount3, D.WordCount4, D.WordCount5, D.Anger, D.Anticipation,
                                                                                                                D.Disgust, D.Fear, D.Sadness, D.Surprise, D.Trust, D.Positive, D.Negative,  D.syuzhet.score, D.Joy,
                                                                                                                D.syuzhet.sum, D.syuzhet.mean, Description), error = function(err) NA)
                                                                               cat("*")
                                                                               
                                                                               return(Tempdata.D)
                                                                               
                                                                             })))

#Risk Section Sentiment Analysis

Risk.Data.Analysis = suppressWarnings(do.call(rbind.data.frame,lapply(kickstarter.data$Risks,
                                                                      function(i){
                                                                        
                                                                        #data preprocessing
                                                                        docs.description = Corpus(VectorSource(i))
                                                                        docs.description = tm_map(docs.description, content_transformer(tolower))
                                                                        docs.description = tm_map(docs.description, removeNumbers)
                                                                        docs.description = tm_map(docs.description, removeWords,stopwords("english"))
                                                                        docs.description = tm_map(docs.description, removePunctuation)
                                                                        docs.description = tm_map(docs.description, removeWords, c('\n'))
                                                                        docs.description = tm_map(docs.description, stemDocument, language = "english")
                                                                        syuzhet.sentences = get_sentences(as.character(i))
                                                                        
                                                                        # Freq of Words
                                                                        dtm = TermDocumentMatrix(docs.description)
                                                                        m = as.matrix(dtm)
                                                                        v = sort(rowSums(m), decreasing = TRUE)
                                                                        d = tryCatch(data.frame(word = names(v), freq = v), error = function(err) NA)
                                                                        
                                                                        #NRC Sentiment Analysis
                                                                        sentiment = get_nrc_sentiment(as.character(i))
                                                                        sentiment.dataframe = data.frame(t(d))
                                                                        
                                                                        #Syuzhet Sentiment Analysis
                                                                        syuzhet.sentiment.sum = sum(get_sentiment(syuzhet.sentences, method = "syuzhet"))
                                                                        syuzhet.sentiment.mean = mean(get_sentiment(syuzhet.sentences, method = "syuzhet"))
                                                                        syuzhet.sentiment.value = get_sentiment(as.character(i), method = "syuzhet")
                                                                        
                                                                        #Data postprocessing
                                                                        R.Word1 = tryCatch(as.character(d$word[[1]]), error = function(err) NA)
                                                                        R.Word2 = tryCatch(as.character(d$word[[2]]) , error = function(err) NA)
                                                                        R.Word3 = tryCatch(as.character(d$word[[3]]) , error = function(err) NA)
                                                                        R.Word4 = tryCatch(as.character(d$word[[4]]) , error = function(err) NA)
                                                                        R.Word5 = tryCatch(as.character(d$word[[5]]) , error = function(err) NA)
                                                                        R.WordCount1 = tryCatch(as.numeric(d$freq[[1]]) , error = function(err) NA)
                                                                        R.WordCount2 = tryCatch(as.numeric(d$freq[[2]]) , error = function(err) NA)
                                                                        R.WordCount3 = tryCatch(as.numeric(d$freq[[3]]) , error = function(err) NA)
                                                                        R.WordCount4 = tryCatch(as.numeric(d$freq[[4]]) , error = function(err) NA)
                                                                        R.WordCount5 = tryCatch(as.numeric(d$freq[[5]]), error = function(err) NA)
                                                                        R.Anger = tryCatch(sentiment$anger , error = function(err) NA)
                                                                        R.Anticipation = tryCatch(sentiment$anticipation , error = function(err) NA)
                                                                        R.Disgust = tryCatch(sentiment$disgust , error = function(err) NA)
                                                                        R.Joy = tryCatch(sentiment$joy , error = function(err) NA)
                                                                        R.Fear = tryCatch(sentiment$fear , error = function(err) NA)
                                                                        R.Sadness = tryCatch(sentiment$sadness , error = function(err) NA)
                                                                        R.Surprise =  tryCatch(sentiment$surprise , error = function(err) NA)
                                                                        R.Trust =  tryCatch(sentiment$trust , error = function(err) NA)
                                                                        R.Positive =  tryCatch(sentiment$positive , error = function(err) NA)
                                                                        R.Negative = tryCatch(sentiment$negative , error = function(err) NA)
                                                                        Risks = tryCatch(i , error = function(err) NA)
                                                                        R.syuzhet.score = tryCatch(syuzhet.sentiment.value, error = function(err) NA)
                                                                        R.syuzhet.sum = tryCatch(syuzhet.sentiment.sum, error = function(err) NA)
                                                                        R.syuzhet.mean = tryCatch(syuzhet.sentiment.mean, error = function(err) NA)
                                                                        
                                                                        Tempdata.R = tryCatch(data.frame(R.Word1, R.Word2, R.Word3, R.Word4, R.Word5, R.WordCount1, R.WordCount2,
                                                                                                         R.WordCount3, R.WordCount4, R.WordCount5, R.Anger, R.Anticipation, 
                                                                                                         R.Disgust, R.Fear, R.Sadness, R.Surprise, R.Trust, R.Positive,
                                                                                                         R.Negative, R.Joy,
                                                                                                         R.syuzhet.score, R.syuzhet.sum, R.syuzhet.mean, Risks), error = function(err) NA)
                                                                        cat("*")
                                                                        
                                                                        return(Tempdata.R)
                                                                        
                                                                      })))


#Joining, Post-processing, and saving the data with and without the text fields that are making it big.
kickstarter.data.joined = left_join(kickstarter.data, Description.Data.Analysis, by = "Description")
kickstarter.data.joined2 = left_join(kickstarter.data.joined, Risk.Data.Analysis, by = "Risks")
kickstarter.data.joined3 = distinct(kickstarter.data.joined2)

#saved with the description and risk section in the table
save(kickstarter.data.joined3, file = "/Users/pmlandis/Desktop/KickstarterFull.Rda")

kickstarter.data.joined4 = kickstarter.data.joined3 %>% select(-c(Risks,Description))

#saved without the description and risk section in the table
save(kickstarter.data.joined4, file = "/Users/pmlandis/Desktop/KickstarterAnalysis.Rda")



