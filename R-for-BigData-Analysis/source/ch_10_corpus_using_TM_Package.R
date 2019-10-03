# ch_10_corpus_using_TM_Package

# 1. 텍스트 파일을 읽어서 Corpus (복수 개의 파일 묶음) 만들기
# 1) 
install.packages("tm")
library(tm)
txt <- system.file("texts", "txt", package="tm") # tm 패키지의 texts/txt 경로 : ./R/win-library/3.5/tm/texts/txt

# 2)
ovid <- Corpus(DirSource(txt), readerControl=list(language="lat"))   # 5개의 text files (ovid_1.txt ~ ovid_5.txt)

# 3)
getReaders()      # a character vector with readers provided by package tm


# 4)로이터 통신 뉴스 데이터로 21578개의 문서
#   (토픽, 저자, 위치 등에 대한 메타데이터 존재)로 구성
reut21578 <- system.file("texts","crude", package = "tm")

# 5) 
(reuters <- Corpus(DirSource(reut21578), 
            readerControl = list(reader = readReut21578XML)))

(reuters <- Corpus(DirSource(reut21578),
            readerControl = list(reader = readReut21578XMLasPlain)))

# 
inspect(reuters[1:3])   # 읽어들인 3개의 문서 검토


# 2. 벡터 소스(docs)로 부터 읽어 들이기 : 예..

# 6) 
docs <- c("This is a text","This another one.", "My name is Eric")
Corpus(VectorSource(docs))

# 7)
docsCorpus <- Corpus(VectorSource(docs))
writeCorpus(docsCorpus)

# docsCorpus의 내용 보기
inspect(docsCorpus[1:3])

docsCorpus[[1]]$content
docsCorpus[[2]]$content
docsCorpus[[3]]$content


# 3. xml 문서를 tm_map() 이용해서 텍스로 전환하기
# 읽어들일 문서의 directory path 정보
reut21578 <- system.file("texts","crude", package = "tm")

# XML 리더(readReut21578XML)를 통해 문서 읽음
(reuters <- Corpus(DirSource(reut21578), readerControl = list(reader = readReut21578XML)))

# 8) XML문서를 text(PlainTextDocument)로 전환
reuters <- tm_map(reuters, PlainTextDocument)

# ** 숫자 제거 (removeNumbers)
reuters <- tm_map(reuters, removeNumbers)

# 9) 중간의 공백 (stripWhitespace) 제거 
reuters <- tm_map(reuters, stripWhitespace)

# 10) 글자들을 모두 소문자로 변경(content_transformer(tolower))하여 
#     사전의 내용과 비교할 수 있도록 표준화
reuters <- tm_map(reuters, content_transformer(tolower))

# 11-1) 영어의 stopwords 제거 (띄어쓰기와 시제 등의 내용 제거)
reuters <- tm_map(reuters, removeWords, stopwords("english"))

# ** 구두점 제거 
reuters = tm_map(reuters, removePunctuation, preserve_intra_word_dashes = TRUE)

# 11-2) 형태소 분석 : 표준형으로 다 바꿔줌(과거형이나 복수형을 표준형으로 바꿔줌)
install.packages("SnowballC")
library(SnowballC)
tm_map(reuters, stemDocument)


# 4. 변형 및 결과 보기
# 12) 문서 번호와 단어 간의 사용여부 또는 빈도수를 이용하여 matrix를 만드는 작업
dtm <- DocumentTermMatrix(reuters, control=list(weighting=weightTf))
inspect(dtm[1:5,1:5])

# 13) 10회 이상의 빈출어 찾아 내기
findFreqTerms(dtm, 10)

# 14) opec와 상관계수가 0.8 이상이 단어 찾기
findAssocs(dtm, "opec", 0.6)

# 15) 희소한 단어들 제거하기
dtm2 <- removeSparseTerms(dtm, 0.2)
dtm2

# 5. 워드 클라우드

library(wordcloud)

# 16) 단어의 빈도를 계산하고, 빈도의 내림차순으로 정렬
freq <- colSums(as.matrix(dtm2))
freq2 <- apply(as.matrix(dtm2), 2, function(x) sum(x>0))

barplot(freq2)

# 17) 텍스트 크기나 색깔 등 효과를 주고, 워드 클라우드 만들기
wordcloud(names(freq2), 
          freq2, 
          colors=rainbow(20))
