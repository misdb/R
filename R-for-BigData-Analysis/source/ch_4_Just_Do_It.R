########################################
#제4장 무조건 따라하기
########################################

########################################
#1. 차트로 영업실적 비교하기
########################################

########################################
# p.104 - 1) 단순 파이 차트
########################################

x <- c(9, 15, 20, 6)

# 1) 단순 파이차트 그리기
pie(x)                   # 벡터 데이터의 파이차트 그리기

# 차트의 조각들에 데이터의 색인번호가 출력됨.

# 2) 
label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

# 데이터 요소들의 이름 지정하기
pie(x, 
    labels = label)      # 데이터 요소들의 이름을 차트에 출력하기

# 3) 파이차트의 전체 제목 달기
pie(x, 
    labels = label,
    main="부서별 영업 실적")   # 차트의 제목 출력

# 4) 최종
pie(x,                         # 벡터 데이터
    labels=label,              # 벡터 데이터의 names
    main="부서별 영업 실적")   # 차트의 제목

# 파이 조각에 데이터 라벨을출력하는 것은 제5장에서 확인함.

########################################
# p. 105 - 2) 단순 바 차트
########################################

height <- c(9, 15, 20, 6)
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

# 1) 단순 바차트 그리기
barplot(height)                    # 벡터 데이터를 바차트로 출력

# 2) 바차트의 x축에 이름달기
barplot(height,                    # 벡터 데이터
        names.arg = name)          # 벡터 데이터의 names
       
# 3) 바차트에 제목 달기
barplot(height,                      # 벡터 데이터
        names.arg = name,            # 벡터 데이터의 names
        main = "부서별 영업실적")    # 차트 제목

# 4) 바차트에 바에 색깔칠하기         
barplot(height,                       # 벡터 데이터
        names.arg = name,             # 벡터 데이터의 names
        main = "부서별 영업실적",     # 차트 제목
        col = rainbow(length(height)))

# 5) 바차트의 X축에 제목달기
barplot(height,                        # 벡터 데이터
        names.arg = name,              # 벡터 데이터의 names
        main = "부서별 영업실적",      # 차트 제목
        col = rainbow(length(height)), # 바의 색깔 지정
        xlab = "부서")

# 6) 바차트의 y축에 제목달기
barplot(height,                        # 벡터 데이터
        names.arg = name,              # 벡터 데이터의 names
        main = "부서별 영업실 적",     # 차트 제목
        col = rainbow(length(height)), # 바의 색깔 지정
        xlab = "부서",                 # x축 제목  
        ylab = "영업 실적(억 원)")     # y축 제목

# 7) 최종
barplot(height,                        # 벡터 데이터
        names.arg = name,              # 벡터 데이터의 names
        main = "부서별 영업실 적",     # 차트 제목
        col = rainbow(length(height)), # 바의 색깔 지정
        xlab = "부서",                 # x축 제목  
        ylab = "영업 실적(억 원)")     # y축 제목


########################################
# 2. 애니메이션으로 카운트 다운
########################################

########################################
# p. 106 - 1) 문자 출력: 카운트 다운
########################################

install.packages("animation")      # 'animation' package 설치
library(animation)                 # 'animation' package 사용

ani.options(interval = 1)          # 시간 간격 = 1초

plot.new()                         # 새로운 그래픽 프레임 출력

for (i in 10:0) {                  # 10 ~ 1 까지 1씩 감소하면서 반복

  rect(0, 0, 1, 1, col="yellow")   # 그래픽 프레임 내에서 그래픽 출력 영역을 최대로 설정하여, 노란색으로 출력

  text(0.5, 0.5, i,             # i 값은 (0.5, 0.5) 위치에 출력
       cex=5,                   # 출력되는 글자의 크기
       col=rgb(.2,.2,.2,.7))    # 색깔 지정

  ani.pause()                   # 1초간 애니메이션 대기
}

########################################
# 3. 단양팔경을 구글 맵 위에
########################################

# p.107 단양팔경 위치 출력

install.packages("ggplot2")
install.packages("RgoogleMaps")
install.packages("ggmap")
library(ggplot2)
library(RgoogleMaps)
library(ggmap)

names <- c("1.도담삼봉/석문", "2.구담/옥순봉", "3.사인암", "4.하선암", "5.중선암", "6.상선암")
addr <- c("충청북도 단양군 매포읍 삼봉로 644-33",
          "충청북도 단양군 단성면 월악로 3827",
          "충청북도 단양군 대강면 사인암2길 42",
          "충청북도 단양군 단성면 선암계곡로 1337",
          "충청북도 단양군 단성면 선암계곡로 868-2",
          "충청북도 단양군 단성면 선암계곡로 790")
addr

# p.108

register_google(key="Google_API_Key")     # Google API Key 사용
register_google(key="AIzaSyAf8vkz_1OJj4o8zCUkPJMYY7nEK8LbFJw")     # Google API Key 사용

gc <- geocode(enc2utf8(addr))      # 주소지에 대한 geocode 확보
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat) # 데이터 프레임 생성
df

cen <- c(mean(df$lon), mean(df$lat))                 # 중앙지점의 좌표 계산
cen

map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=gc)  # 지도 정보 가져오기

ggmap(map, fullpage = TRUE)        # 구글 지도에 표시

########################################
# 4. 워드 클라우드로 연설문 키워드 분석
########################################

# p.110  키워드와 빈도수에 대한 워드 클라우드 출력
install.packages("wordcloud")
install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)

pal2 <- brewer.pal(8,"Dark2")     # 팔레트 생성 : pal2

x <- c("국민", "신한국사회", "민족")   # 키워드 목록
y <- c(5, 4, 3)                        # 키워드의 빈도(Count)

wordcloud(x, y, colors=pal2)           # 키워드의 빈도수에 따라 Dark2 색으로 wordcloud 출력

########################################
# 5. 동전 던지기 시뮬레이션
########################################

# p.112 동전을 5,000번 던질 때 횟수에 따라 앞면이 나오는 확률의 변화
iteration <- 5000
plot(0, 0, xlab="동전을 던진 횟수", ylab="앞면이 나오는 비율", xlim=c(0, iteration), ylim=c(0, 1))

abline(a=0.5, b=0, col="red")

sum <- 0

for(x in 1:iteration) {
    y <- sample(c("앞면", "뒷면"), 1, replace=T)
    if ( y == "앞면")
        sum = sum + 1
    prob <- sum / x
    points(x, prob)
}
########################################


