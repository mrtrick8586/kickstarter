source(file="/Volumes/Stuff/FinalKickstarterStuff/libraries.R")

kickstarter.data = read.csv('/Users/pmlandis/Desktop/18k_Projects.csv')
Data.stuff = kickstarter.data %>% select(Id, Url)
Data.scraped = data.frame(Description = character(), Risks = character(), URL.Used = character())
datalist = list()
for (i in Data.stuff$Url) {
  Data = html_session(i)
  Description = tryCatch(html_nodes(Data, ".formatted-lists") %>% html_text() %>% as.character(),
           error = function(err) NA)
  Risks = tryCatch(html_nodes(Data, ".js-risks") %>% html_text() %>% as.character(),
           error = function(err) NA)
  URL.Used = tryCatch((i), error = function(err) NA)
  Tempdata = tryCatch(data.frame(Description,Risks,URL.Used),error = function(err) NA)
  datalist[[i]] = Tempdata
  cat("*")
}
Data.scraped = do.call(rbind, datalist)

Data.scraped = Data.scraped %>% rename(Url = URL.Used)

kickstarter.data = left_join(kickstarter.data, Data.scraped, by = 'Url')

save(kickstarter.data, file="/Users/pmlandis/Desktop/Kickstarter.Rda")
```
