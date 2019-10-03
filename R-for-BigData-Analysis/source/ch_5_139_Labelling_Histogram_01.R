# ch_5_139_Labelling_Histogram_01

#====== hist() -> plot()으로 전환해서 라벨달기

head(quakes)
mag <- quakes$mag
hp <- hist(mag)	 

plot(hp,, main="지진 발생 강도의 분포", col=rainbow(length(height)), xlab="지진 강도", ylab="발생건수", ylim=c(0,250))

(height <- hp$counts)

text(x=hp$mids, y=height, labels=height, pos=3)
#======= 라벨달기 끝