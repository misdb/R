## Box Plot 연습하기

데이터 세트 : iris



### 데이터 불러오기

```{r}
iris
str(iris)
```

결과 :



### 종류별 관측치 계산

```{r}
table(iris$Species)
```

결과 :

```
## 
##     setosa versicolor  virginica 
##         50         50         50 
```



### 종류별 Box plot 그리기

```{r}
plot(x=iris$Species, y=iris$Sepal.Length)
```

**인수 :**

- `x = iris$Species` : factor 변수
- `y = iris$Sepal.Length` : 꽃받침의 길이 (수치형 변수)

**결과 :**

<img src="C:\GitHub-Reposi\R-master\R-for-BigData-Analysis\images\1570621334692.png" alt="1570621334692" style="zoom:80%;" />

```{r}
plot(x=iris$Species, y=iris$Petal.Length)   # Petal.Length : 꽃잎의 길이
```

결과 :

<img src="C:\GitHub-Reposi\R-master\R-for-BigData-Analysis\images\1570621299429.png" alt="1570621299429" style="zoom:80%;" />

```{r}
plot(x=iris$Species, y=iris$Petal.Width)      # Petal.Width : 꽃잎의 넓이
```

**결과 :**

<img src="C:\GitHub-Reposi\R-master\R-for-BigData-Analysis\images\1570621250443.png" alt="1570621250443" style="zoom:80%;" />