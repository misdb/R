# ch_5_solution_exercise

# CDNow 데이터 소스 위치
url <- "https://raw.githubusercontent.com/cran/BTYD/master/data/cdnowElog.csv"


# 데이터 읽기
data <- read.csv(url, header=T)

# 헤더 부분 출력
head(data)

# 거래량
quantity <- data$cds

# 거래량 이원 분류표(거래량 대 빈도수)
table(quantity)

# 거래량에 대한 빈도수를 히스토그램으로 출력 : 1) 기본 출력 [빈도]
hist(quantity, 
	main="거래량 분포", 
	xlab="주문 당 CD 거래량", 
	ylab="빈도 수",  
	xlim=c(0,20), 
	ylim=c(0,5000))


# 거래량에 대한 빈도수를 히스토그램으로 출력  : 2) 칼라 지정 [빈도]
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")
hist(quantity, 
	main="거래량 분포", 
	xlab="주문 당 CD 거래량", 
	ylab="빈도 수",
	col=colors, 
	breaks=seq(0, 40, by=5), 
	xlim=c(0,20), 
	ylim=c(0,7000))

# 거래량에 대한 빈도수를 히스토그램으로 출력  : 3) 상대도수 (%)
hist(quantity, 
	main="거래량 분포", 
	xlab="주문 당 CD 거래량", 
	ylab="상대도수",
	col=colors, 
	breaks=seq(0, 40, by=5), 
	freq=FALSE, 
	xlim=c(0,20), 
	ylim = c(0, 0.2))	 


# 거래량에 대한 빈도수를 히스토그램으로 출력  : 4) Sturges 공식에 의한 계급 계산, 상대도수 (%)
hist(quantity, 
	main="거래량 분포", 
	xlab="주문 당 CD 거래량", 
	ylab="상대도수",
	col=colors, 
	breaks="Sturges", 
	freq=FALSE, 
	xlim=c(0,20))
