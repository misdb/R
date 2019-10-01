# order( ) 함수를 이용한 데이터 프레임 정렬



In data analysis you can **sort** your data according to a certain variable in the dataset. In R, we can use the help of the function order(). In R, we can easily sort a vector of continuous variable or factor variable. Arranging the data can be of **ascending** or **descending** order.

데이터 분석에서 데이터 세트의 특정 변수에 따라 데이터를 **정렬(sort)**할 수 있다. 
R에서는 `order()` 함수를 이용할 수 있다. 
R에서는 연속 변수나 factor 변수의 벡터를 쉽게 정렬할 수 있다. 
데이터는 **오름차순(ascending)** 또는 **내림차순(descending)**으로 정렬될 수 있다.

**Syntax:**

```
sort(x, decreasing = FALSE, na.last = TRUE):
```

**인수(Argument) :**

- **x**: 연속 또는 factor 변수를 포함하는 벡터
- **decreasing**: 정렬 방법의 순서를 제어. 기본 값으로 decreasing 값은 `FALSE`로 설정되어 있다.
- **na.last**: `NA`의 값을 마지막에 넣어야 하는지 여부를 표시한다.



## 예제 1

예를 들어, 우리는 tibble 데이터 프레임을 만들고 하나 또는 여러 변수를 정렬할 수 있다. tible 데이터 프레임은 데이터 프레임에 대한 새로운 접근법이다. 그것은 데이터 프레임의 구문을 개선하고, 특히 문자 대 factor의 경우 데이터 타입 형식지정의 어려움을 방지한다. 그것은 또한 손으로 데이터 프레임을 만드는 편리한 방법인데, 이것이 여기에서 우리의 목적이다. tibble에 대한 자세한 내용은 vignette를 참조하십시오: https://cran.r-project.org/web/packages/tibble/vignettes/tibble.html



```
library(dplyr)
set.seed(1234)
data_frame <- tibble(  
	c1 = rnorm(50, 5, 1.5),   
	c2 = rnorm(50, 5, 1.5),  
	c3 = rnorm(50, 5, 1.5),
	c4 = rnorm(50, 5, 1.5), 	
	c5 = rnorm(50, 5, 1.5)
)
# Sort by c1
df <-data_frame[order(data_frame$c1),]
head(df)
```

**결과 :**

```
# A tibble: 6 x 5
##       c1       c2       c3       c4       c5
##     <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
## 1 1.481453 3.477557 4.246283 3.686611 6.0511003
## 2 1.729941 5.824996 4.525823 6.753663 0.1502718
## 3 2.556360 6.275348 2.524849 6.368483 5.4787404
## 4 2.827693 4.769902 5.120089 3.743626 4.0103449
## 5 2.988510 4.395902 2.077631 4.236894 4.6176880
## 6 3.122021 6.317305 5.413840 3.551145 5.6067027
```



## 예제 2

```
# Sort by c3 and c4
df <-data_frame[order(data_frame$c3, data_frame$c4),]
head(df)
```

**결과 :**

```
# A tibble: 6 x 5
##        c1       c2       c3       c4       c5
##    <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
## 1 2.988510 4.395902 2.077631 4.236894 4.617688
## 2 2.556360 6.275348 2.524849 6.368483 5.478740
## 3 3.464516 3.914627 2.730068 9.565649 6.016123
## 4 4.233486 3.292088 3.133568 7.517309 4.772395
## 5 3.935840 2.941547 3.242078 6.464048 3.599745
## 6 3.835619 4.947859 3.335349 4.378370 7.240240
```



## 예제 3

```
# Sort by c3(descending) and c4(acending)
df <-data_frame[order(-data_frame$c3, data_frame$c4),]
head(df)
```

**결과 :**

```
# A tibble: 6 x 5
##         c1       c2       c3        c4       c5
##      <dbl>    <dbl>    <dbl>     <dbl>    <dbl>
## 1 4.339178 4.450214 8.087243 4.5010140 8.410225
## 2 3.959420 8.105406 7.736312 7.1168936 5.431565
## 3 3.339023 3.298088 7.494285 5.9303153 7.035912
## 4 3.397036 5.382794 7.092722 0.7163620 5.620098
## 5 6.653446 4.733315 6.520536 0.9016707 4.513410
## 6 4.558559 4.712609 6.380086 6.0562703 5.044277
```