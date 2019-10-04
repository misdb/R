## 제5장 계급의 수에 라벨 붙이기.

##### 

```{r}
head(quakes)
mag <- quakes$mag

h <- hist(mag, breaks="Sturges")


```

결과 :

![1570061360541](images/1570061360541.png)

```{r}
plot(h,,
	main="지진 발생 강도의 분포", 
	xlab="지진 강도", 
	ylab="발생 건수",
	col=colors, 
	ylim=c(0,250))
```

결과 :

![1570061380519](images/1570061380519.png)

```{r}
#=== 라벨달기
(height <- h$counts)
text(x=h$mids, y=height, labels=round(height,0), pos=3)
#=== 라벨달기 끝
```

결과 :

![1570061416283](images/1570061416283.png)

**[ [R Source](source/ch_5_144_Labelling_the_Class.R) ]**



------

 <img src="images/R.png" alt="R" style="zoom:80%;" /> <img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />