source(file = '/Volumes/Stuff/FinalKickstarterStuff/libraries.R')

load(file = "/Volumes/Stuff/KickstarterAnalysis.Rda")
kickstarternonlog = Kickstarter.Analysis

# Transform and reformat data
# dollar values are in different currencies. Going to normalize the dollar values to usd with approximate 2014 estimates
AUD_Conversion=.85
CAD_Conversion=.90
EUR_Conversion=1.35
GBP_Conversion=1.65
NZD_Conversion=.82

kickstarternonlog = sqldf("select a.*
                          ,case when a.currency='AUD' then pledged*.85 when a.currency='CAD' then pledged*.90 when currency='EUR' then pledged*1.35 when currency='GBP' then pledged*1.65 when currency='NZD' then pledged*.82 else pledged end as pledged_usd
                          ,case when a.currency='AUD' then goal*.85 when a.currency='CAD' then goal*.90 when currency='EUR' then goal*1.35 when currency='GBP' then goal*1.65 when currency='NZD' then goal*.82 else goal end as goal_usd
                          from kickstarternonlog a ")

#enter 0's for ordinal data which make sense
kickstarternonlog$Facebook.Friends=ifelse(is.na(kickstarternonlog$Facebook.Friends), 0, kickstarternonlog$Facebook.Friends)
kickstarternonlog$Creator.....Projects.Backed=ifelse(is.na(kickstarternonlog$Creator.....Projects.Backed), 0, kickstarternonlog$Creator.....Projects.Backed)
kickstarternonlog$X..Videos=ifelse(is.na(kickstarternonlog$X..Videos), 0, kickstarternonlog$X..Videos)
kickstarternonlog$X..Words..Risks.and.Challenges.=ifelse(is.na(kickstarternonlog$X..Words..Risks.and.Challenges.), 0, kickstarternonlog$X..Words..Risks.and.Challenges.)

#impute the median value for the sentiment data
#since there are only a few NA values for the sentiment data, we are imputing the median for the NAs
meds=median(kickstarternonlog$D.Anger, na.rm=TRUE)
kickstarternonlog$D.Anger=ifelse(is.na(kickstarternonlog$D.Anger), meds, kickstarternonlog$D.Anger)
meds=median(kickstarternonlog$D.Anticipation, na.rm=TRUE)
kickstarternonlog$D.Anticipation=ifelse(is.na(kickstarternonlog$D.Anticipation), meds, kickstarternonlog$D.Anticipation)
meds=median(kickstarternonlog$D.Disgust, na.rm=TRUE)
kickstarternonlog$D.Disgust=ifelse(is.na(kickstarternonlog$D.Disgust), meds, kickstarternonlog$D.Disgust)
meds=median(kickstarternonlog$R.Fear, na.rm=TRUE)
kickstarternonlog$R.Fear=ifelse(is.na(kickstarternonlog$R.Fear), meds, kickstarternonlog$R.Fear)
meds=median(kickstarternonlog$R.Sadness, na.rm=TRUE)
kickstarternonlog$R.Sadness=ifelse(is.na(kickstarternonlog$R.Sadness), meds, kickstarternonlog$R.Sadness)
meds=median(kickstarternonlog$R.Surprise, na.rm=TRUE)
kickstarternonlog$R.Surprise=ifelse(is.na(kickstarternonlog$R.Surprise), meds, kickstarternonlog$R.Surprise)
meds=median(kickstarternonlog$R.Trust, na.rm=TRUE)
kickstarternonlog$R.Trust=ifelse(is.na(kickstarternonlog$R.Trust), meds, kickstarternonlog$R.Trust)
meds=median(kickstarternonlog$R.Positive, na.rm=TRUE)
kickstarternonlog$R.Positive=ifelse(is.na(kickstarternonlog$R.Positive), meds, kickstarternonlog$R.Positive)
meds=median(kickstarternonlog$R.Negative, na.rm=TRUE)
kickstarternonlog$R.Negative=ifelse(is.na(kickstarternonlog$R.Negative), meds, kickstarternonlog$R.Negative)
meds=median(kickstarternonlog$R.Joy, na.rm=TRUE)
kickstarternonlog$R.Joy=ifelse(is.na(kickstarternonlog$R.Joy), meds, kickstarternonlog$R.Joy)
meds=median(kickstarternonlog$R.syuzhet.mean, na.rm=TRUE)
kickstarternonlog$R.syuzhet.mean=ifelse(is.na(kickstarternonlog$R.syuzhet.mean), meds, kickstarternonlog$R.syuzhet.mean)
meds=median(kickstarternonlog$R.syuzhet.score, na.rm=TRUE)
kickstarternonlog$R.syuzhet.score=ifelse(is.na(kickstarternonlog$R.syuzhet.score), meds, kickstarternonlog$R.syuzhet.score)
meds=median(kickstarternonlog$R.syuzhet.sum, na.rm=TRUE)
kickstarternonlog$R.syuzhet.sum=ifelse(is.na(kickstarternonlog$R.syuzhet.sum), meds, kickstarternonlog$R.syuzhet.sum)

# remove the 69 records with multiple ids
kickstarternonlog=sqldf("select a.* from kickstarternonlog a left join (
                        select id, count(*) as counter from kickstarternonlog group by 1 having count(*)>1) b on a.id=b.id
                        where b.id is null
                        ")

kickstarternonlog = kickstarternonlog %>% select(-c(Id,
                                                    Latitude, 
                                                    Longitude, 
                                                    D.WordCount3, 
                                                    D.WordCount4,
                                                    D.WordCount5, 
                                                    R.WordCount3, 
                                                    R.WordCount4, 
                                                    R.WordCount5,
                                                    D.Word1,
                                                    D.Word2,
                                                    D.Word3,
                                                    D.Word4,
                                                    D.Word5,
                                                    R.Word1,
                                                    R.Word2,
                                                    R.Word3,
                                                    R.Word4,
                                                    R.Word5,
                                                    Pledged,
                                                    Facebook.Friends,
                                                    Facebook.Shares,
                                                    Comments
                                                    )
)

kickstarternonlog = 
  kickstarternonlog %>% 
  replace_na(list(Facebook.Friends = 0,Facebook.Shares = 0,
                  Creator.....Projects.Backed = 0,
                  X..Words..Risks.and.Challenges. = median(kickstarternonlog$X..Words..Risks.and.Challenges., na.rm = TRUE),
                  D.Joy = median(kickstarternonlog$D.Joy, na.rm = TRUE),
                  D.Anger = median(kickstarternonlog$D.Anger, na.rm = TRUE), 
                  D.Sadness = median(kickstarternonlog$D.Sadness, na.rm = TRUE),
                  D.Disgust = median(kickstarternonlog$D.Disgust, na.rm = TRUE),
                  D.Fear = median(kickstarternonlog$D.Fear, na.rm = TRUE),
                  D.Surprise = median(kickstarternonlog$D.Surprise, na.rm = TRUE),
                  D.Trust = median(kickstarternonlog$D.Trust, na.rm = TRUE), 
                  D.Anticipation= median(kickstarternonlog$D.Anticipation, na.rm = TRUE), 
                  D.Positive = median(kickstarternonlog$D.Positive, na.rm = TRUE),
                  D.Negative = median(kickstarternonlog$D.Negative, na.rm = TRUE),
                  D.WordCount1 = median(kickstarternonlog$D.WordCount1, na.rm = TRUE), 
                  D.WordCount2 = median(kickstarternonlog$D.WordCount2, na.rm = TRUE),
                  D.syuzhet.score = median(kickstarternonlog$D.syuzhet.score, na.rm = TRUE),
                  D.syuzhet.sum = median(kickstarternonlog$D.syuzhet.sum, na.rm = TRUE),
                  D.syuzhet.mean = median(kickstarternonlog$D.syuzhet.mean, na.rm = TRUE),
                  R.Joy = median(kickstarternonlog$R.Joy, na.rm = TRUE),
                  R.Anger = median(kickstarternonlog$R.Anger, na.rm = TRUE),
                  R.Sadness = median(kickstarternonlog$R.Sadness, na.rm = TRUE), 
                  R.Disgust = median(kickstarternonlog$R.Disgust, na.rm = TRUE), 
                  R.Fear = median(kickstarternonlog$R.Fear, na.rm = TRUE), 
                  R.Surprise = median(kickstarternonlog$R.Surprise, na.rm = TRUE), 
                  R.Trust = median(kickstarternonlog$R.Trust, na.rm = TRUE), 
                  R.Anticipation = median(kickstarternonlog$R.Anticipation, na.rm = TRUE), 
                  R.Positive = median(kickstarternonlog$R.Positive, na.rm = TRUE), 
                  R.Negative = median(kickstarternonlog$R.Negative, na.rm = TRUE), 
                  R.WordCount1 = median(kickstarternonlog$R.WordCount1, na.rm = TRUE), 
                  R.WordCount2 = median(kickstarternonlog$R.WordCount2, na.rm = TRUE), 
                  R.syuzhet.score = median(kickstarternonlog$R.syuzhet.score, na.rm = TRUE), 
                  R.syuzhet.sum = median(kickstarternonlog$R.syuzhet.sum, na.rm = TRUE), 
                  R.syuzhet.mean = median(kickstarternonlog$R.syuzhet.mean, na.rm = TRUE)
  )
  )



kickstarternonlog = kickstarternonlog %>% filter(pledged_usd<=100000)
kickstarternonlog = Filter(is.numeric, kickstarternonlog)

#Remove Highly Correlated Variables
kickstarternonlog.Cor = cor(kickstarternonlog)
kickstarternonlog.Cor.names = findCorrelation(kickstarternonlog.Cor, cutoff = .75, names = TRUE)
kickstarternonlog.Cor = findCorrelation(kickstarternonlog.Cor, cutoff = .75)
kickstarternonlog.Cor = sort(kickstarternonlog.Cor)
kickstarternonlog = kickstarternonlog[,-c(kickstarternonlog.Cor)]
kickstarternonlog.Cor.names

#Break it up into test and training sets.
sample.size = floor(0.7 * nrow(kickstarternonlog))

set.seed(123)
train.ind = sample(seq_len(nrow(kickstarternonlog)), size = sample.size)

trainingnonlog = kickstarternonlog[train.ind,]
testingnonlog =  kickstarternonlog[-train.ind,]

test_actuals=testingnonlog$pledged_usd

liquid.kickstarternonlog.data = (trainingnonlog)
write.csv(kickstarternonlog,file = "/Volumes/Stuff/FinalKickstarterStuff/Liquid.csv")

liquid.data = ttsplit(data = kickstarternonlog, testProb = 0.3)


