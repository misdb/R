# ch_5_142_Labelling_PDF_Histogram

#===== 라벨달기

head(quakes)
mag <- quakes$mag

hp <- hist(mag, breaks=seq(4, 6.5, by=0.5), freq=FALSE)	 
hp                      # 변수 hp 의 값들을  꼭 확인해 보기 바람.

plot(hp,, 
	freq=FALSE,
	main="지진 발생 강도의 분포", 
	xlab="지진 강도", 
	ylab="확률밀도",
	col=colors, 
	ylim=c(0,1))

(height <- hp$density)
text(x=hp$mids, y=height, labels=height, pos=3)

#======= 라벨달기 끝


lines(density(mag))