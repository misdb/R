## 제5장 히스토그램에 데이터라벨 달기 (1)



```{r}
# p. 139-140

#====== hist() -> plot()으로 전환해서 라벨달기

head(quakes)
mag <- quakes$mag
hp <- hist(mag)	 

plot(hp,, main="지진 발생 강도의 분포", col=rainbow(length(height)), xlab="지진 강도", ylab="발생건수", ylim=c(0,250))

(height <- hp$counts)

text(x=hp$mids, y=height, labels=height, pos=3)
#======= 라벨달기 끝
```

결과 : 

![img](images/COMF_1803281514197df00079.bmp)

**[ [R Source](source/ch_5_139_Labelling_Histogram_01.R) ]**



------

 [<img src="images/R.png" alt="R" style="zoom:80%;" />](source/ch_5_131_Labelling_Grouped_Bar_Chart.R) [<img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](pdf/ch_5_131_Labelling_Grouped_Bar_Chart.prf)

------

[<img src="images/l-arrow.png" alt="l-arrow" style="zoom:67%;" />](ch_5__130_Labelling_Grouped_Bar_Chart.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/home-arrow.png" alt="home-arrow" style="zoom:67%;" />](index.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/r-arrow.png" alt="r-arrow" style="zoom:67%;" />](ch_5_141_Labelling_Histogram_02.html)

