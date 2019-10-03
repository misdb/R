# ch_5_141_Labelling_Histogram_02
#====== hist() -> plot()으로 전환해서 라벨달기

head(quakes)
mag <- quakes$mag

# 계급 구간과 색 
colors <- c("red", "orange", "yellow", "green", "blue", "navy", "violet")

hp <- hist(mag, breaks=seq(4, 6.5, by=0.5))	 
hp                            # 변수 hp 의 값들을  꼭 확인해 보기 바람.

plot(hp,, 
     main="지진 발생 강도의 분포", 
     xlab="지진 강도", 
     ylab="발생건수",
     col=colors, ylim=c(0,500))

(height <- hp$counts)

text(x=hp$mids, y=height, labels=height, pos=3)
#======= 라벨달기 끝