## 제5장 움직이는 차트에 데이터라벨 달기



```{r}
# 1초 간격으로 그래프 그리기

library(animation)
ani.options(interval = 1)

while(TRUE) {
    y <- runif(5, 0, 1)
    bp <- barplot(y, ylim = c(0, 1), col=rainbow(5))
    
    text(x=bp, y=y, 
         labels=round(y,2),       # 라벨 y
         pos=1)   
    
    ani.pause()
}
```

![1570052490511](images/1570052490511.png)

**주의 :** 위의  바플롯이 계속 갱신이 됨..



**[ [R Source](source/ch_5_165_Labelling_Moving_Chart.R) ]**



------

 [<img src="images/R.png" alt="R" style="zoom:80%;" />](source/ch_5_165_Labelling_Moving_Chart.R) [<img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](pdf/ch_5_165_Labelling_Moving_Chart.pdf)

------

[<img src="images/l-arrow.png" alt="l-arrow" style="zoom:67%;" />](ch_5_146_Labelling_Boxplot.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/home-arrow.png" alt="home-arrow" style="zoom:67%;" />](index.html)    [<img src="C:/Users/Dae%20Ho%20Kim/Pictures/r-arrow.png" alt="r-arrow" style="zoom:67%;" />](ch_5_Examples_of_Chart_3D.html)

