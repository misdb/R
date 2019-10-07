#### [연습문제] P. 228



### 1. 대통령 연설문 사이트

http://www.pa.go.kr/research/contents/speech/index.jsp



### 2. 연설문

http://www.pa.go.kr/research/contents/speech/index.jsp (이명박 대통령 취임사)



### 3. R Script

```{r}
text <- readLines(file.choose())

noun <- sapply(text, extractNoun, USE.NAMES=F)

noun2 <- unlist(noun) 

word_count <- table(noun2) 

wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)



noun2 <- gsub("오늘세", "", noun2)

noun2 <- gsub("여러분", "", noun2)

noun2 <- gsub("우리", "", noun2)



noun2 <- Filter(function(x){nchar(x) >= 2}, noun2)



word_count <- table(noun2)

wordcloud(names(word_count),freq=word_count,scale=c(6,0.3),min.freq=3, random.order=F,rot.per=.1,colors=pal2)
```

   

### 4. 출력 결과 (이미지 참조)





------

 [<img src="images/R.png" alt="R" style="zoom:80%;" />](source/solution_228.R) [<img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](pdf/solution_228.pdf) 

------

[<img src="images/l-arrow.png" alt="l-arrow" style="zoom:67%;" />](ch_8_wordcloud2.html)    [<img src="images/home-arrow.png" alt="home-arrow" style="zoom:67%;" />](index.html)    [<img src="images/r-arrow.png" alt="r-arrow" style="zoom:67%;" />](ch_09_Using_Public_Data.html)

