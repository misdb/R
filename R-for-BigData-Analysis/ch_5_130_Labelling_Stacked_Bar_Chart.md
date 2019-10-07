## 제5장 스택형 바차트에 라벨달기



```{r}
height1 <- c(4, 18, 5, 8)
height2 <- c(9, 15, 20, 6)

height <- rbind(height1, height2)
height
```

결과 :

```
##         [,1] [,2] [,3] [,4]
## height1    4   18    5    8
## height2    9   15   20    6
```

<div style="page-break-after: always;"></div>
```{r}
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
legend_lbl <- c("2014년", "2015년")


bp <- barplot(height,
		main = "부서별 영업 실적",
		names.arg = name,
		xlab = "부서", 
		ylab = "영업 실적(억 원)",
		col = c("darkblue","red"),
		legend.text = legend_lbl,
		ylim = c(0, 35))
```

결과 :

![1570061819488](images/1570061819488.png)

```{r}
text(x=bp, y=height1, labels=round(height1,0), pos=3)            # 2014년 데이터에 라벨달기
```

결과 :

![1570061854427](images/1570061854427.png)

```{r}
text(x=bp, y=height1 + height2, labels=round(height2,0), pos=3)  # 2015년 데이터에 라벨달기
```

결과 :

![1570061909368](images/1570061909368.png)

**[ [R Source](source/ch_5_130_Labelling_Stacked_Bar_Chart.R) ]**



------

 [<img src="images/R.png" alt="R" style="zoom:80%;" />](source/ch_5_130_Labelling_Stacked_Bar_Chart.R) [<img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](pdf/ch_5_130_Labelling_Stacked_Bar_Chart.pdf)

------

[<img src="images/l-arrow.png" alt="l-arrow" style="zoom:67%;" />](ch_5__130_Labelling_Horizontal_Bar_Chart.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/home-arrow.png" alt="home-arrow" style="zoom:67%;" />](index.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/r-arrow.png" alt="r-arrow" style="zoom:67%;" />](ch_5_131_Labelling_Grouped_Bar_Chart.html)



