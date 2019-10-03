# ch_8_Example_of_Wordcloud
library(wordcloud)

wordcloud(c(letters, LETTERS, 0:9), seq(1, 1000, len = 62))

## crude 데이터 세트를 이용한 워드 클라우드 ##

library(tm)
data(crude)

crude <- tm_map(crude, removePunctuation)
crude <- tm_map(crude, function(x)removeWords(x,stopwords()))

##### 			from corpus 		#####
wordcloud(crude)	

##### 		from frequency counts 	      #####
tdm <- TermDocumentMatrix(crude)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
wordcloud(d$word,d$freq)

# A bigger cloud with a minimum frequency of 2
wordcloud(d$word,d$freq,c(8,.3),2)

#####                   color 추가               ######

pal <- brewer.pal(9,"BuGn")
pal <- pal[-(1:4)]
wordcloud(d$word,d$freq,c(8,.3),2,,FALSE,,.15,pal)

pal <- brewer.pal(6,"Dark2")
pal <- pal[-(1)]
wordcloud(d$word,d$freq,c(8,.3),2,,TRUE,,.15,pal)
	
# random colors
wordcloud(d$word,d$freq,c(8,.3),2,,TRUE,TRUE,.15,pal)

##### 			with font 			#####
wordcloud(d$word,d$freq,c(8,.3),2,,TRUE,,.15,pal,
          vfont=c("gothic english","plain"))

wordcloud(d$word,d$freq,c(8,.3),2,100,TRUE,,.15,pal,vfont=c("script","plain"))
	
wordcloud(d$word,d$freq,c(8,.3),2,100,TRUE,,.15,pal,vfont=c("serif","plain"))
# Now lets try it with frequent words plotted first
wordcloud(d$word,d$freq,c(8,.5),2,,FALSE,.1)