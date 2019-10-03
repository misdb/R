# ch_05_Chart

# 2-1.
# 데이터 입력
x <- c(9, 15, 20, 6)
label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

# 파이차트 그리기
pie(x,                     # 파이조각으로 표시될 데이터 : x (벡터)
    labels = label,          # 파이의 조각에 부서명 표시
    main = "부서별 영업 실적")  # 차트의 전체 제목

# 2-2.
pie (x, 
     init.angle = 90,          # 12시에 기준선 설정 
     labels = label, 
     main = "부서별 영업 실적")

# 2-3.
pct <- round(x/sum(x)*100)

# label 조작. 
label <- paste(label, pct, sep=" : ")         # "영업 1팀 : 18"
label <- paste(label,"%",sep="")              # "영업 1팀 : 18%""

pie(x,
    labels=label, 
    init.angle=90, 
    col=rainbow(length(x)),   # 무지개색, 색깔의 갯수: length(x)
    main="부서별 영업 실적")

# 2-4.
install.packages("plotrix")
library(plotrix)

pie3D(x,
      labels = label, 
      explode = 0.1,          # 파이 조작 간의 간격. 0이면 간격이 없음.
      labelcex = 0.8,         # 라벨 글자 크기. (0.8배로 축소)
      main = "부서별 영업 실적")

# 3-1.
height <- c(9, 15, 20, 6)
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")

barplot(height,                     # 막대로 표시되는 데이터 : height (벡터)
        names.arg = name,             # 막대 밑에 표시되는 이름 데이터 : name (벡터)
        main = "부서별 영업 실적")      # 바차트의 제목 

# 3-2.
barplot(height, 
        names.arg = name, 
        main = "부서별 영업 실적", 
        col = rainbow(length(height)))    # height 벡터의 요소 갯수의 무지개색

# 3-3.
barplot(height, 
        names.arg = name,                
        main = "부서별 영업 실적", 
        col = rainbow(length(height)), 
        xlab = "부서",                    # x축의 제목
        ylab = "영업 실적(억 원)")         # y축의 제목

# 3-4.
barplot(height, 
        names.arg = name, 
        main = "부서별 영업 실적", 
        col = rainbow(length(height)), 
        xlab = "부서", 
        ylab = "영업 실적(억 원)", 
        ylim = c(0,25))            # y축의 표시값을 0 ~ 25표 지정

# 3-5. 1)
bp <- barplot(height,                 # 바차트를 그리고 그 결과를 변수 bp에 저장
              names.arg = name, 
              main = "부서별 영업 실적",
              col = rainbow(length(height)), 
              xlab = "부서", 
              ylab = "영업 실적(억 원)", 
              ylim = c(0,25))
bp                              # bp는 리스트 변수임.
height
text(x = bp,                    # 바에 라벨 출력, x값은 bp
     y = height,                # y 값은 바차트의 x값인 height
     labels = round(height,0),  # 바에 표시할 값 height, round(height, 0) : 소수점이하 반올림
     pos = 3)                   # 바에 라벨이 표시되는 위치 : 1, 2, 3, 4 => 3은 바의 위에...

# 3-5. 2)
bp <- barplot(height, 
              names.arg=name, 
              main="부서별 영업 실적",
              col=rainbow(length(height)), 
              xlab="부서", 
              ylab="영업 실적(억 원)", 
              ylim=c(0,25))

text(x=bp, 
     y=height, 
     labels=round(height,0), 
     pos=1)                    # 1은 바의 밑에 표시

# 3-6.
barplot(height, 
        names.arg=name, 
        main="부서별 영업 실적",
        col=rainbow(length(height)),
        xlab="영업 실적(억 원)", 
        ylab="부서", 
        horiz=TRUE,                 ###
        width=50)

# 4-1.
height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)

height <- rbind(height1, height2)
height
		
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
legend_lbl <- c("2014년", "2015년")

barplot(height, main="부서별 영업 실적",
        names.arg=name,
        xlab="부서", 
        ylab="영업 실적(억 원)",
        col=c("darkblue","red"),
        legend.text=legend_lbl,      # 차트에 범례 표시
        ylim=c(0, 35))

# 4-2.
barplot(height, main="부서별 영업 실적",
        names.arg=name,
        xlab="부서", 
        ylab="영업 실적(억 원)",
        col=c("darkblue","red"),
        legend.text=legend_lbl,
        ylim=c(0, 30),
        beside=TRUE,                  # 그룹형 바차트로 변경함
        args.legend=list(x='top'))    # 범례의 위치 지정

# 5-1. 1)
women     # data set
str(women)

weight <- women$weight  
plot(weight)               # weight 출력

# 5-1. 2)
height <- women$height

plot(height, weight,       # x축에 height, y 축에 weight
     xlab="키", 
     ylab="몸무게")

# 5-2.
lot(height, weight,       
     xlab="키", 
     ylab="몸무게",
     type="b")             # p. 135 참고 (점과 선)

# 5-3.
plot(height, weight,       
     xlab="키", 
     ylab="몸무게",
     type="l",       # 선 그리기
     lty=1,          # 실선
     lwd=1)          # 기본 값

# 5-4.
plot(height, weight,    # x축에 height, y 축에 weight
     xlab="키", 
     ylab="몸무게", 
     pch=23,               # 다이아몬드 모양
     col="blue", 
     bg="yellow", 
     cex=1.5)              # 다이아몬드 크기. 1.5배

# 6-1.
head(quakes)
str(quakes)

mag <- quakes$mag                     # mag : 지진의 강도, 연속형 변수
mag

hp <- hist(mag,                          
           main="지진 발생 강도의 분포", 
           xlab="지진 강도", 
           ylab="발생 건수")
hp

#====== hist() -> barplot()으로 전환해서 라벨달기
head(quakes)

mag <- quakes$mag
hp <- hist(mag, 
           main="지진 발생 강도의 분포", 
           xlab="지진 강도", 
           ylab="발생 건수")

(height <- hp$counts)
(name=as.character(hp$mids))

bp <- barplot(height, 
              names.arg=name, 
              col=rainbow(length(height)), 
              xlab="지진강도", 
              ylab="발생빈도", 
              ylim=c(0,250))

text(x=bp, 
     y=height, 
     labels=round(height,0), 
     pos=3)
#======= 라벨달기 끝


# 6-2.
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")
hp <- hist(mag, 
           main="지진 발생 강도의 분포", 
           xlab="지진 강도", 
           ylab="발생 건수",
           col=colors,                     # 막대의 색깔 지정, colors 변수
           breaks=seq(4, 6.5, by=0.5))     # 계급의 구간 지정, 4 ~ 6.5를 0.5 간격으로
hp

#====== hist() -> barplot()으로 전환해서 라벨달기
head(quakes)

mag <- quakes$mag
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")
hp <- hist(mag, 
           main="지진 발생 강도의 분포", 
           xlab="지진 강도", 
           ylab="발생 건수",
           col=colors, 
           breaks=seq(4, 6.5, by=0.5))

(height <- hp$counts)
(name=as.character(hp$mids))

bp <- barplot(height, 
              names.arg=name, 
              col=rainbow(length(height)), 
              xlab="지진강도", 
              ylab="발생빈도", 
              ylim=c(0,500))
bp

text(x=bp, 
     y=height, 
     labels=round(height,0), 
     pos=3)

#======= 라벨달기 끝

bp <- barplot(height, 
              names.arg = name, 
              col=rainbow(length(height)), 
              xlab="지진강도", 
              ylab="발생빈도", 
              ylim=c(0,600))        # ylim = c(0, 600) 으로 수정
bp

text(x=bp, 
     y=height, 
     labels=round(height,0), 
     pos=3)

# 6-3.
mag <- quakes$mag

hist(mag, 
     main="지진 발생 강도의 분포", 
     xlab="지진 강도", 
     ylab="확률밀도",
     col=colors, 
     breaks=seq(4, 6.5, by=0.5), 
     freq=FALSE)

lines(density(mag)) 

# 6-4.
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")

mag <- quakes$mag
h <- hist(mag, 
          breaks=seq(4, 6.5, by=0.5), 
          freq=FALSE)	 
h

h$density <- h$counts/sum(h$counts)       # 상대도수 구하기.
plot(h,                                   # 상대도수 그림 그리기
     freq=FALSE,
     main="지진 발생 강도의 분포", 
     xlab="지진 강도", 
     ylab="상대 도수",
     col=colors)

# 6-5.
hist(mag, 
     main="지진 발생 강도의 분포", 
     xlab="지진 강도", 
     ylab="확률밀도",
     col=colors, 
     breaks="Sturges", 
     freq=FALSE)

# 7-1.
mag ＜- quakes$mag

min(mag)
max(mag)
median(mag)
quantile(mag, c(0.25, 0.5, 0.75))

summary(mag)     # 앞의 min, max, median, quantile 과 비교바람.

boxplot(mag,     # summary(mag)를 그림으로 표시함.
        main="지진 발생 강도의 분포", 
        xlab="지진", 
        ylab="발생 건수",
        col="red")

# 7-2.
boxplot(mag,     # summary(mag)를 그림으로 표시함.
        main="지진 발생 강도의 분포", 
        xlab="지진", 
        ylab="발생 건수",
        horizontal=TRUE,
        col="red")

# 7-3.
boxplot(mag,     # summary(mag)를 그림으로 표시함.
        main="지진 발생 강도의 분포", 
        xlab="지진", 
        ylab="발생 건수",
        horizontal=TRUE,
        notch=TRUE,     
        col="red")


