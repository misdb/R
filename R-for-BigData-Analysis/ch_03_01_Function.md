## 함수



[TOC]

### 1. 내장 함수

#### 1-1. 내장함수의 종류	

| 함수          | R 함수                                      |
| ------------- | ------------------------------------------- |
| 제곱근        | sqrt                                        |
| 지수함수      | exp                                         |
| 로그함수      | log(5), log2(5),   log10(5), log(5, base=3) |
| 최대값        | max, pmax                                   |
| 최소값        | min, pmin                                   |
| 합            | sum                                         |
| 평균          | mean                                        |
| 절대값        | abs                                         |
| 누적연산      | cummax, cummin,   cumprod, cumsum           |
| 삼각함수      | sin, cos, tan                               |
| 올림,반올림.. | ceiling, round,   trunc, floor              |



#### 1-2. 내장함수 예제

```{r}
a <- 1:5	
sqrt(a)	
exp(a)	

out <- (a + sqrt(a))/(exp(2)+1); out	
	
x1 <- seq(-2, 4, by = .5); x1	
	
floor(x1)	
	
trunc(x1)	
	
a <- c(1,-2,3,-4)	
b <- c(-1,2,-3,4)	
	
min(a,b)	
	
pmin(a,b)
```

​	

#### 1-3. 확률분포와 관련된 함수	

##### 1) 정규분포

```{r}
dnorm(x, mean=0, sd=1) # 확률밀도함수	
x <- seq(-3,3, length=30)	
y <- dnorm(x)	
plot(x, y, type='l', main="N(0,1)", ylab="f(x)")	
	
pnorm(q, mean=0, sd=1)   # 누적분포함수P(Z≤1.96)=?, whereZ∼N(0,12)	
pnorm(1.96)	
	
rnorm(n, mean=0, sd=1)    # 난수(랜덤넘버)생성	
rnorm(10)
```

​	

##### 2) 이항분포	

```{r}
dbinom(x, size, prob)	
pbinom(q, size, prob)	
qbinom(p, size, prob)	
rbinom(n, size, prob)	
```

​	

#### 1-4. 기타 내장함수들	

##### 1) `print()` : 객체의 값을 화면에 출력	

```{r}
a <- c(5,3,6,2,4)	
print(a)	
```



##### 2) `cat()` : 문자열 및 연산결과를 동시에 출력 화면에 프린트	

```{r}
cat("mean of a is ",mean(a), "variance of a is ", var(a),"\n")	
```

​	

##### 3) `unique()` : 서로 다른 원소값들

```{r}	
x <- c(1,5,1,3,5,7,5)	
unique(x)
```



##### 4) `substr(x, start, stop)` : 문자열에서 일부 추출	

```{r}
x <- c("노무현","이명박", "박근혜", "문재인") 	
substr(x, 1, 1) 	
```



##### 5) `paste(..., sep="")`: 문자열의 결합	

```{r}
paste("x",1:3,sep="")	
paste("x",1:3,sep="M")	
paste("Today is", date())
```

​	

### 2. 사용자 정의 함수	

#### 2-1. 수학 함수	

`y = f(x1,x2)`

- f : 함수이름

- x1,x2는 입력 값	

- y는 결과값	



#### 2-2. 프로그램 함수 :  수학함수와 동일한 개념, 용어는 다소 상이

-  f : 함수이름	
-  x1, x2를 인수(input arguments)	
-  y는 결과값 (반환값, return value)	



#### 2-3. R 에서 사용자 함수의 정의 방법	

```
function_name <- function(인수1, 인수2, ...)  {	

여기에 함수 계산 내용을 R 코드로 삽입	

  return(반환값)	
}
```

​	

#### 2-4. 사용자 함수의 호출 	

```
function_name(arg_1 = 1) 	
function_name(arg_2 = 1, arg_1 = 3)	
function_name(3, 1)	
```

​	

#### 2-5. 사용자 정의 함수 작성 예제	

##### [예제 1] 아래의 수학 함수에서 f(3,4), f(1,2)를 계산해 보자.  f(x1,x2) = x1^2 + x2^2	

###### 1) R 함수 정의	

```{r}
f <- function(x1, x2) {	
y <- x1 ^2 + x2 ^2	
return(y)	
}
```


2) 함수 호출	

```{r}
f(x1=1, x2=2)	
f(3, 4)	
f(x1=c(1,2), x2=c(3,4))
```

​		

##### [예제 2] 모평균이 m이고, 모표준편차가 s인 정규분포에서, 난수 n개를 생성하여, 히스토그램과 상자그림을 그리는 함수	

###### 1) R 함수 정의	

```{r}
normal_hist <- function(m, s, n) {	
  x <-  rnorm(n, mean=m, sd=s)	
  hist(x, main=paste0("N(",m, ",", s^2, ")"))	
}
```

​	

###### 2) 함수 호출	

```{r}
normal_hist(m=5, s=3, n=100)
```



------

[<img src="https://misdb.github.io/R/R-for-BigData-Analysis/images/R.png" alt="R" style="zoom:80%;" />](https://misdb.github.io/R/R-for-BigData-Analysis/source/ch_03_01_Function.R) [<img src="https://misdb.github.io/R/R-for-BigData-Analysis/images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](https://misdb.github.io/R/R-for-BigData-Analysis/pdf/ch_03_01_Function.pdf)

