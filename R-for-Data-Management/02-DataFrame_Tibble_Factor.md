# Dataframe, Tibble and Factor   {#df_tibble_factor}

## Data Frame   {#dataframe}

**데이터 프레임**은 R의 핵심적인 자료구조이다.
엑셀과 같이 숫자, 문자 등 다양한 데이터를 하나의 테이블에 담을 수 있는 자료구조이다. 
이를 잘 활용하면 엑셀의 기능들을 R에서도 자유자제로 사용할 수 있다.

```{r warning=FALSE}
library(tidyverse)
```

### 데이터 프레임의 생성

#### `data.frame()`함수 이용

먼저 데이터 데이터 프레임을 **생성**하는 방법은 다음과 같다.

```{r}
df <- data.frame(col1=c('a','b','c','d','e') , col2=c(2, 4, 6, 8, 10))
df
```

**df의 데이터 내용 보기**
```
1) R Studio의 Global Environment의 Data에서 마우스로 df를 클릭하는 방법
2) View(df)
```

#### `data.frame()` 함수의 형식

```
data.frame(..., 
            row.names = NULL, 
            check.rows = FALSE,
            check.names = TRUE, 
            fix.empty.names = TRUE,
            stringsAsFactors = default.stringsAsFactors())`
```
**주요 인수 :**

- **`...`** :  이 인수는 폼 값이나 `tag = value` 형태이다. 구성 요소명(컬럼 명)은 tag 이름으로 또는 deparsed 인수 자체로  생성된다. 
- `row.names =` : `NULL`, 단일 정수, 또는 행 이름으로 사용될 컬럼을 지정하는 문자열, 또는 데이터 프레임을 위한 행 이름을 주는 문자 또는 정수 벡터
- `check.rows =` :  `FALSE` 값이 디폴트 값. `TRUE`이면, 행들에 대한 길이와 이름에 대한 일관성 검토하고 위배되면 데이터 프레임을 생성하지 않는다.
- `check.names =` : 논리값. `TRUE`이면 데이터 프레임에 있는 변수 이름들이 문법적으로 타당하고 증복이 없는 변수 이름들인지 검토한다. 필요하면 (`make.names`에 의해) 조정된다.
- `fix.empty.names =` : 논리값 이름이 붙여지지 않은 컬럼(`someName = arg` 형태로 지정되지 않으면)이 자동으로 생성된 이름이나 `name”.”`을 가지고 있는지를 나타내는 논리값. “” 이름이 유지되어야 하지만 check.names가 false일 때에도 FALSE로 설정되어야 한다.
- `stringsAsFactors = default.stringsAsFactors()` : 버전 4.0.0 이후로 기능이 없어짐. 이전 버전의 경우, 디폴트로 문자 벡터 컬럼의 경우 factor 형으로 생성되었음.


#### 컬럼명을 지정하지 않은 경우

```{r}
df1 <- data.frame(1:5, letters[1:5])
str(df1)
df1
```
- `df1`의 첫 번째 컬럼의 값은 `1:5`, 두 번째 컬럼의 값은 `letters[1:5]`으로 지정하고 있으나, 컬럼명을 지정하지 않음. 
- 자동으로 첫 번째 컬럼명은 `x1.5`으로 그리고 두 번째 컬럼명은 `letters.1.5`으로 자동생성된다. 


```{r}
df2 <- data.frame(1:5, letters[1:5], fix.empty.names = FALSE)
str(df2)
df2
```
- `fix.empty.names = FALSE` 옵션을 설정하면, 컬럼명이 자동생성되지 않고 **공란(`“”`)**으로 남는다.

#### 컬럼명을 지정한 경우

```{r}
df3 <- data.frame(a = 1:5, b = letters[1:5])  
str(df3)
df3
```
- `df3`는 데이터 값과 더불어 각 컬럼의 이름(`a`와 `b`)을 지정하여 생성되었다.

  
#### `row.names`을 `a`로 지정한 경우

```{r}
df4 <- data.frame(a = 1:5, b = letters[1:5], row.names = "a")  
str(df4)
df4
```
- `df4`는 `row.names = “a”`로 `a`를 행이름으로 지정하고 있다. 따라서 `df4`를 출력해 보면 `a`의 값(`1:5`)들이 행의 이름임을 알 수 있다.
- 즉, `df4`는 컬럼이 하나인 데이터 프레임이다. 

#### `row.names`을 `b`로 지정한 경우

```{r}
df5 <- data.frame(a = 1:5, b = letters[1:5], row.names = "b")  
str(df5)
df5
```
- `df5`는 `row.names = “b”`로 `b`를 행이름으로 지정하고 있다. 따라서 `df5`를 출력해 보면 `b`의 값들(`letters[1:5]`)이 행의 이름임을 알 수 있다. 
- 즉, `df5`는 컬럼이 하나인 데이터 프레임이다. 

#### 각 컬럼의 행의 길이가 다른 경우
다음과 같이 a컬럼은 요소가 6개, b컬럼은 요소가 5개로 지정되는 경우에는, 데이터 프레임이 생성되지 않는다. 즉, 데이터 세트가 사각형 형태가 안된다. 
이러한 데이터 구조를 만들고 싶다면, 리스트 구조를 이용해야 한다. 

```{r error=TRUE}
df6 <- data.frame(a = 1:6, b = letters[1:5])
str(df6)
df6                 
```


#### 컬럼명이 같은 경우 : `check.names = ` 인수의 사용

**`check.names = TRUE`** 인수를 사용하는 경우,
```{r}
df7 <- data.frame(a = 1:5, a = letters[1:5], check.names = TRUE)  
str(df7)
df7
```
- 두 개의 컬럼명이 모두 `a`로 되어 있다. 
  - `df7`의 경우는 `check.names = TRUE`로 옵션을 설정하여, 컬럼명이 자동 조정되었다.

**`check.names = FALSE`** 인수를 사용하는 경우,
```{r}
df8 <- data.frame(a = 1:5, a = letters[1:5], check.names = FALSE)  
str(df8)
df8
```
- 두 개의 컬럼명이 모두 `a`로 되어 있다. 
  - `df8`의 경우는 `check.names = FASLE`로 옵션을 설정하여, 컬럼명이 조정되지 않았다.


### 데이터 프레임의 구조

데이터 프레임의 **구조**는 **`str()`** 함수로 파악할 수 있다.

#### dataframe의 구조(structure) 파악하기

`str()` 함수에 대한 도움말 보기.
```{r}
? str()
```

앞에서 생성한 `df1` 데이터 보기 : **`head()`** 함수 이용
```{r}
head(df1)
```


`df1`의 데이터 구조 파악하기 : **`str()`** 함수
```{r}
str(df1)
```

**`df1`의 통계적 요약 정보 파악** : **`summary()`** 함수 
```{r}
summary(df1)
```


#### `iris` 데이터 세트

`iris` 데이터 세트의 데이터 구조 확인
```{r}
str(iris)
```

`iris` 데이터 세트의 첫 6개 행 데이터 보기
```{r}
head(iris)
```
- `head(iris, n=10)` : `iris` 데이터 세트의 첫 10개 행을 볼 수 있다. `n = ` 인수로 행의 갯수를 조절할 수 있다. 
- `tail(iris, n=10)` : `iris` 데이터 세트의 마지막 10개 행을 볼 수 있다. `n = ` 인수로 행의 갯수를 조절할 수 있다. 

`iris` 데이터 세트의 통계적 요약 정보
```{r}
summary(iris)
```
- 5개의 컬럼별로 통계적 요약 정보인 min, 1st Qu., Median, Mean, 3rd Qu., Max. 등의 요약 정보를 출력한다. 


### 행/열 추가하기

#### 두 벡터를 각각 행(row)으로 하는 데이터 프레임의 생성

두 개의 벡터 데이터 세트
```{r}
vec1 <- c('one','two','three')
vec2 <- c(1,2,3)
```

두 벡터를 결합하여 데이터 프레임 만들기
```{r}
d <- data.frame(rbind(vec1,vec2)); d
str(d)
```
- 데이터 프레임 `d`의 행 이름은 자동으로 벡터의 이름(`vec1`, `vec2`)으로 지정된다.
- 반면에 컬럼 이름은 `x1`, `x2`, `x3` 등으로 자동 부여된다.

#### 두 벡터를 각각 열(column)으로 하는 데이터 프레임의 생성
이번에는, 두 벡터를 각각 column으로 하는 dataframe을 만들고 싶으면? : **`cbind()`**

두 개의 벡터 데이터 세트
```{r}
vec1 <- c('one','two','three'); vec1
vec2 <- c(1,2,3); vec2
```

`cbind()`를 이용하여 두 개 벡터를 컬럼으로 결합하여 `vec` 데이터 세트를 만든다. 
```{r}
vec <- cbind(vec1, vec2); vec
class(vec)
```
- `vec`는 **문자형 행렬/배열** 임을 알 수 있다.

결합된 `vec` 데이터 세트를 `data.frame()` 함수를 이용하여 데이터 프레임으로 바꾼다.
```{r}
df <- data.frame(vec)
df
str(df)
```
- 생성된 df의 컬럼 이름은 두 개의 벡터 이름이 자동으로 지정된다.

#### 앞에서 `cbind()`의 사용은 사족 {-}

두 개의 벡터 데이터 세트
```{r}
vec1 <- c('one','two','three'); vec1
vec2 <- c(1,2,3); vec2
```

`cbind()`를 이용하여 두 개 벡터를 컬럼으로 결합하여 `vec` 데이터 세트를 만드는 과정을 생략하고, 
`data.frame()` 함수에 두 개의 벡터를 입력하여 데이터 프레임을 생성할 수 있다.
```{r}
df <- data.frame(vec1, vec2)
df
str(df)
```
- `vec1` 컬럼은 **문자형(chr)**으로 생성이 되었고,
- `vec2` 컬럼은 **숫자형(num)**으로 생성이 됨을 알 수 있다.

문자형 컬럼을 factor형으로 만들고 싶은 경우에는 **`stringsAsFactors = T`**를 인수로 이용한다.

```{r}
df <- data.frame(vec1, vec2, stringsAsFactors = T)
df
str(df)
```
- vec1 컬럼의 데이터 유형이 `Factor`로 바뀌었다.


#### 데이터 프레임에 새로운 컬럼 추가

다음과 같이 새로운 컬럼을 추가할 수도 있다.

```{r}
df <- data.frame(col1=c('a','b','c','d','e') , col2=c(2, 4, 6, 8, 10))
df$col3 <- c(1,2,3,4,5)
df
```
- `df$col3 <- c(1,2,3,4,5)` : 2개의 컬럼으로 구성된 `df1`에 `col3` 컬럼을 추가한다. 그 값은 c(1, 2, 3, 4, 5).

#### 데이터 프레임의 컬럼 삭제

다음과 같이 기존의 컬럼을 제거할 수 있다.
```{r}
df <- data.frame(col1 = c('a','b','c','d','e'), 
                 col2 = c(2, 4, 6, 8, 10))
df$col2 <- NULL
df
```
- 제거하고자 하는 컬럼의 값을 `NULL`로 대입해 주면 된다.


### 행과 열 접근하기

#### 데이터 세트
```{r}
df <- data.frame(col1=c('a','b','c','d','e') , col2=c(2, 4, 6, 8, 10))
```

#### 컬럼 이름으로 접근하기

```{r}
df$col1 #column이름으로 접근하기
```

#### 인덱싱 : 위치(행/열 번호)로 접근하기

행 번호 접근 : 첫번째 행의 모든 열
```{r}
df[1,] 
```
- `[행 번호,열 번호]`로 구성되는 대괄호  안에서 `열 번호`를 생략하면 모든 열을 표시

열 번호 접근 : 2번째 열의 모든 행
```{r}
df[,2] 
```
- `[행 번호,열 번호]`로 구성되는 대괄호  안에서 `행 번호`를 생략하면 모든 행을 표시



### 연습문제

**R에 기본 내장되어 있는 `iris` 데이터를 활용하여 아래 질문에 답하시오.**

```{r}
head(iris)
```


1. **첫번째, 3번째 컬럼을 선택하시오.**

```{r}
head(iris[, c(1, 3)])
```

2. **3번째 컬럼을 빼고 선택하시오.**

```{r}
head(iris[, -3])
```

3. **각 row의 `Sepal.Length`와 `Sepal.Width`의 값을 더하여 `Sepal.Sum`이라는 컬럼을 추가하시오.**

```{r}
Sepal.Sum <- iris$Sepal.Length + iris$Sepal.Width
head(cbind(iris[, -3], Sepal.Sum))
```


**참고) `df[1,]` 과 `df[1, ,drop=T]`의 차이는?**

```{r}
df[1,]
class(df[1,])
```
- `df[1,]` : `df`의 첫 번째 행을 출력. 그 결과는 데이터 프레임

```{r}
df[1, ,drop=T]
class(df[1, ,drop=T])
```
- `df[1, , drop=T]` : `df`의 첫 번째 행을 출력하되, `drop=T`에 의해 그 결과를 list로 출력함.


### 행과 열의 이름 지정하기


#### 데이터 세트
```{r}
df <- data.frame(a=1:3,b=4:6,c=7:9); df
```

#### 컬럼 이름 확인 : **`colnames()`** 함수
```{r}
colnames(df)
```
- `df`의 컬럼 이름이 `a`, `b`, `c` 임을 확인할 수 있다. 

#### 컬럼 이름 변경하기
```{r}
colnames(df) <- c('열1','열2','열3')
colnames(df)
```
- `colnames(df) <- c('열1','열2','열3')` : 새로운 컬럼명 지정하기

#### 행 이름 확인 : **`rownames()`** 함수

```{r}
rownames(df)
```

#### 행 이름 변경하기
```{r}
rownames(df) <- c('행1','행2','행3')
rownames(df)
```

#### 행과 열의 이름 동시에 확인하기 : **`names()`** 함수
```{r}
names(df)
```


### 데이터 타입 변환

#### 데이터 타입‘만’ 알고 싶을때 : `class()` 함수

데이터 타입은 `class()` 함수로 확인할 수 있다.

**숫자형 벡터**
```{r}
class(c(1,2))
```

**문자형 벡터**
```{r}
class(c("a", "b"))
```

**논리형 벡터**
```{r}
class(c(T, FALSE))
```

**날짜형 벡터**
```{r}
class(as.Date(c("2020-09-01", "2020-09-31")))
```
- 문자형의 날짜를 as.Date() 함수를 이용하여 날짜형(Date)로 변경해야 함.


**행렬**
```{r}
class(matrix(c(1,2)))
```
- 행렬은 배열의 특수한 형태임.

**리스트**
```{r}
class(list(1,2))
```
- list() 함수에 의해 데이터 구조가 리스트로 지정됨.

**데이터 프레임**
```{r}
class(data.frame(1,2))
```


#### 데이터 타입과 데이터 모양에 대한 추가정보까지 : `str()` 함수

**`str()`** 함수는 데이터의 구조에 대한 요약 정보를 보여준다.

##### 숫자형 벡터
```{r}
str(c(1,2))
```
- 데이터 유형(`num`)과 요소의 갯수(`[1:2]`), 그리고 데이터 값( `1  2` ) 등을 확인할 수 있다.

##### 행렬
```{r}
str(matrix(c(1,2)))
```
- 데이터 유형(`num`), 요소의 갯수(`[1:2, 1]`), 여기서 행의 갯수는 `[1:2]`, 열의 갯수가 `1`개 임., 그리고 데이터 값( `1  2` ) 등을 확인할 수 있다.

##### 리스트
```{r}
str(list(c(1,2)))
```
- `List of 1` : 데이터 구조가 `List'형,  컬럼의 갯수는 `1`개
- `$ : num [1:2] 1 2` : 컬럼 명이 지정되어 있지 않으며(`$` 다음에 컬럼 이름이 표시됨), 데이터 유형은 num, 요소의 갯수는 [1:2], 실제 데이터는 `1 2`

##### 데이터 프레임
```{r}
str(data.frame(1,2))
```
- `'data.frame':	1 obs. of  2 variables:` : 데이터 구조는 `data.frame`, 행의 갯수는 1개(`1 obs.`), 열의 갯수는 2개(`2 variables`)
- `$ X1: num 1` : 첫 번째 열은 `X1`(`$ X1`), 이 열의 데이터 유형은 숫자형(num), 값은 `1`
- `$ X2: num 2` : 두 번째 열은 `X2`(`$ X2`), 이 열의 데이터 유형은 숫자형(num), 값은 `2`


#### 데이터 유형만 확인

##### 숫자형 확인 : `is.numeric()` 함수
숫사형 벡터의 확인
```{r}
is.numeric(c(1,2,3))
```

문자형 벡터의 확인
```{r}
is.numeric(c('a','b','c'))
```

##### 행렬 확인 : `is.matrix()` 함수
```{r}
is.matrix(matrix(c(1,2)))
```

##### 관련 함수들
다음 함수들을 사용하여 데이터 타입을 손쉽게 판단할 수 있다.

| 함수               | 설명                                       |
| ------------------ | ------------------------------------------ |
| `is.factor(x)`     | 주어진 객체 `x`가 팩터인가                 |
| `is.numeric(x)`    | 주어진 객체 `x`가 숫자를 저장한 벡터인가   |
| `is.character(x)`  | 주어진 객체 `x`가 문자열을 저장한 벡터인가 |
| `is.matrix(x)`     | 주어진 객체 `x`가 행렬인가                 |
| `is.array(x)`      | 주어진 객체 `x`가 배열인가                 |
| `is.data.frame(x)` | 주어진 객체 `x`가 데이터 프레임인가        |



#### 데이터 구조간의 변환

##### list를 vector로
```{r}
lst <- list(1,2,3,4)
unlist(lst)
```

##### list를 dataframe으로
```{r}
lst <- list(x=c(1,2),y=c(3,4))
data.frame(lst)
```

##### matrix를 데이터 프레임으로
```{r}
mat <- matrix(c(1,2,3,4), ncol=2)
data.frame(mat)
```

##### 벡터를 factor로, factor를 벡터

문자열을 Factor로
```{r}
x <- c("m","f")
as.factor(x)
```
- `Levels` 로 Factor임을 확인함.

Factor를 다시 숫자형으로
```{r}
as.numeric(as.factor(x))
```

타입을 **강제로 변환(Coercing)**하고자 할 때도 있을 것이다. 
문자열 벡터를 팩터로 변환하는 경우 등이 그 예다. 
이러한 변환을 하는 한 가지 방법은 타입 이름이 ‘`typename`’이라 할 때 ‘`as.typename( )`’이라는 함수를 사용하는 것이다. 

##### 관련 함수 목록

다음에 관련 함수의 목록을 보였다.

| 함수               | 의미                                          |
| ------------------ | --------------------------------------------- |
| `as.factor(x)`     | 주어진 객체 `x`를 팩터로 변환                 |
| `as.numeric(x)`    | 주어진 객체 `x`를 숫자를 저장한 벡터로 변환   |
| `as.character(x)`  | 주어진 객체 `x`를 문자열을 저장한 벡터로 변환 |
| `as.matrix(x)`     | 주어진 객체 `x`를 행렬로 변환                 |
| `as.array(x)`      | 주어진 객체 `x`를 배열로 변환                 |
| `as.data.frame(x)` | 주어진 객체 `x`를 데이터 프레임으로 변환      |


### 연습문제

1. **`남`, `여`를 `1`,`2` 로 바꿔보자**

```{r}
vec <- c('남','여','남','남','여')
vec <- ifelse(vec == "남", "여", "남"); vec
```


참고 : **`남`, `여`를 `2`, `1` 로 바꾸면?**

```{r}
vec <- c('남','여','남','남','여')
as.numeric(factor(vec, levels=c('여','남')))
```


### 실습 과제

**첨부한 파일을 다운 받고 R에서 변수 `data`로 불러들여라**. 

[toyota_sample.csv](https://insightteller.tistory.com/attachment/cfile2.uf@99A3723359F55A7E16D9D1.csv)

```{r}
data <- read_csv("https://insightteller.tistory.com/attachment/cfile2.uf@99A3723359F55A7E16D9D1.csv")
data
```



### `apply()` 함수 이해하기

- 행렬 혹은 data.frame에서 각 row, column에 대해 평균을 계산한다든지, 특정 함수를 적용하고 싶을 때가 있다. 
- 이럴 때, 가장 기본적으로 생각하는 게 `for()` loop를 활용하여 각 row(혹은 column) 별로 함수를 적용하는 것이다.

예를 들어,

```{r}
mat <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3)
# 각 row의 평균을 계산하고 싶다면
for (i in seq(1:nrow(mat))){
  print(mean(mat[i,]))
}
```

그런데 **많은 양의 데이터를 `for()` loop 하는 것은 비효율적**이다. 

- 매번 `for()` loop를 돌 때마다 함수를 불러와야 하기 때문이다. 
- 따라서 최대한 `for()` loop를 줄이는 것이 중요하다!! 
- 그 때 사용하는 함수가 바로 **`apply()`** 함수이다. 
- `apply()` 함수는 한 번만 함수를 불러와서 모든 데이터에 적용하기 때문에 훨씬 시간을 줄일 수 있다.

#### 데이터 세트
```{r}
mat <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3)
```

#### 행별로 함수 적용 : `margin = 1`

`mat` 데이터 세트의 행별(`1`) 평균값(`mean`) 산출
```{r}
apply(mat, 1, mean)             # mean이라는 함수를 row(1)로 적용
```

`mat` 데이터 세트의 행별(`1`) 범위(`range`) 산출
```{r}
apply(mat, 1, range)            # range 함수는 각행의 최소, 최댓값 2개를 반환함
```

#### 열별로 함수 적용 : `margin = 2`

`mat` 데이터 세트의 열별(`2`) 평균값(`mean`) 산출
```{r}
apply(mat, 2, mean)             # mean이라는 함수를 column(2) 별로 적용
```


### 연습문제

`iris` 데이터 세트에 적용해보자

1. **`apply()` 함수를 활용하여 `iris`의 `Species`를 제외한 4개 변수에 대해 평균을 아래와 같이 계산하라.**

```{r}
apply(iris[, -5], 2, mean)
```

2. **`apply()` 함수를 활용하여 `Sepal.Length`, `Sepal.Width`의 최소, 최대값을 아래와 같이 구하라. (최소, 최댓값을 구하는 함수는 `range`)**

```{r}
apply(iris[, c(1,2)], 2, range)
```


#### list, 벡터에 대한 for loop 계산

- 데이터 프레임과 마찬가지로 list, vector에 대해서도 `for()` loop를 최소화 하는 것이 좋다. 
- 대신, `apply()`와 비슷하게 **`lapply()`**, **`sapply()`**를 사용한다. 
- 좀 더 구체적으로 예를 들어보면,  `list(1,2,3)`을 제곱한 값을 반환하고 싶다고 하자. 
- 그런데 아래와 같이 계산하면 실행이 안 된다. list는 vector처럼 연산 함수가 적용되지 않기 떄문이다.

```{r, include=FALSE}
lst <- list(1,2,3)
lst
# lst^2
```

#### `lapply()` 함수와 `sapply()` 함수

이럴 때, `for()` loop이 아닌 `lapply()` 함수 또는 `sapply()`함수를 사용한다.

```
`lapply(벡터 혹은 리스트, 함수)`
`sapply(벡터 혹은 리스트, 함수)`
```

##### `lapply()` 함수
앞에 예를 들었듯이,  `list(1,2,3)`을 제곱하고 싶다면,

```{r}
lst <- list(1,2,3)
lapply(lst, function(x){x^2})
```

##### `sapply()` 함수
그런데 `lapply()`의 결과는 list로 나오기 때문에, 벡터로 나오게 하고 싶다면 `sapply()`를 이용한다.

```{r}
sapply(lst, function(x){x^2})
```

##### `iris`  데이터 세트의 예

**`lapply()`**  함수를 이용하여, 모든 행에 대하여 `1:4`열의 합계(`sum`)를 구한다.
```{r}
lst <- lapply(iris[, 1:4], sum)
class(lst)
```

**`sapply()`**  함수를 이용하여, 모든 행에 대하여 `1:4`열의 합계(`sum`)를 구한다.
```{r}
vec <- sapply(iris[,1:4], sum)
class(vec)
```

- `lapply()`, `sapply()`도 data.frame 에 적용할 수 있는데, 
- `apply()`는 결과값이 *data.frame*인 반면, 
- `lapply()`, `sapply()`는 결과값이 각각 *list*, *vector* 라는 차이가 있다. 
- 그리고 기본적으로 **각 column**에 대해 함수가 적용된다.


좀 더 예를 들면, 

`iris` 데이터 세트의 **각 열의 데이터 타입**을 보고 싶다면?

```{r}
sapply(iris, class)
```


3보다 큰 값을 갖는지 확인
```{r}
y <- sapply(iris[, 1:4], function(x){ x > 3 })
head(y)
```

### 연습문제

1. **iris 데이터를 0~1 사이 값으로 바꿔라.**

**hint**: 서로 다른 변수의 데이터가 scale이 다를 경우(어떤 변수는 -10~0 사이인데, 다른 변수는 10~1000인 경우), 정규분포를 활용한 정규화 뿐만 아니라, min, max를 활용하여 0~1사이로 바꾸는 방법도 있다. 즉, 다음 함수를 각 row에 적용하면 된다. `(x−min(x)) / (max(x)−min(x))`

```{r}
min <- sapply(iris[, -5], min); min
max <- sapply(iris[, -5], max); max
ran <- max - min; ran
x <- apply(iris[, -5], 1, function(x) {(x - min) / ran})
head(t(x))
```

### `apply()` 함수의 사촌들

이제부터는 `apply()` 함수와 비슷한 원리지만, 각 상황에 맞게 `tapply()`, `mapply()` 가 있는데, 자주 사용되지는 않지만, 간단히 살펴보기로 한다.

####  `tapply()`
`tapply()` : 각 집단에 따라 데이터를 처리하고 싶을때

```{r}
str(iris)
tapply(iris$Sepal.Length, iris$Species, mean)
```

### 연습문제

1. **`Species` 별 `Sepal.Width` 의 분산은?**

```{r}
tapply(iris$Sepal.Width, iris$Species, var)
```


#### `mapply()`
여러 벡터에 동일한 함수를 적용하고 싶을때 사용한다. 아래와 같이 최대공약수를 구하는 함수 `gcd()`가 있다고 하자.

```{r}
gcd <- function(a,b) {
  if (b==0) return(a)
  else return(gcd(b, a%%b))
}

gcd(6,4)
```

그러나, 아래와 같이 두 벡터의 각 원소간 값을 input으로 하고 싶을때 아래와 같은 문법은 오류가 발생합니다.

```{r}
gcd(c(3,6,9), c(12,15,18))
```

이 경우 `mapply()` 함수 활용

```{r}
mapply(gcd, c(3,6,9), c(12,15,18))
```

```
**최대공약수 함수** : 여기서 중요한 부분은 “**유클리드 호제법**”이다.

간단히 말하자면, "**두 양의 정수 A >= B에 대해, A가 B의 배수인 경우에 최대공약수는 B이며, 그렇지 않은 경우에는 최대공약수는 B와 A%%B (A를 B로 나눈 나머지)의 최대공약수이다.**"라고 할 수 있습니다.

이를 코드로 표현하면 다음과 같다.
```

```
gcd <- function(a,b) {
  if (b==0) return(a)
  else return(gcd(b, a%%b))
}
```

출처: https://kjwsx23.tistory.com/259 [香格里拉]


******

### [참고 : Sampling]  {-}

기계학습 모델링을 사용하다 보면, 무작위로 데이터를 추출해야 할 경우가 생긴다. 이럴 때 `sample()` 함수를 사용한다.

```{r}
# 1~10에서 무작위로 5개 추출
sample(1:10, 5)                     # 중복 허락 하지 않고.
sample(1:10, 5, replace=T)          # 중복을 허락해서 추출
```

`iris` 데이터에서 임의로 전체의 15% 데이터 추출하기

```{r}
index <- 1:nrow(iris)               # 1부터 iris 행의 개수
train_idx <- sample(index, round(nrow(iris)*0.15))
head(iris[train_idx,])
```

출처: https://insightteller.tistory.com/entry/R-기초-실습-3-dataframe?category=628138 [Be a Insight teller]


### Reference {-}

- [Concatenating a list of data frames](https://rfriend.tistory.com/225)


## tibble    {#tibble}

- **티블(tibbles)**은 데이터 프레임을 현대적으로 재구성한 것이다. 
- 이것은 시간 성능 테스트를 통과했고, 
- 데이터 프레임이 가지고 있던 편리했지만 지금은 불만스러운 특징들(예를 들어, **문자 벡터를 factor 형으로 변환**하는 것)을 제거하고 있다. 


- 티블은 `tidyverse` 생태계를 구성하는 한 멤버로 `tidyverse`를 설치하게 되면 즉시 활용할 수 있다. 
- 데이터프레임을 생성하고, 강제변환시키고, 외부 데이터를 데이터프레임으로 가져오는 방법에 사용되는 함수를 비교하면 다음과 같다.


| 작업유형            | 데이터프레임 명령어 | 티블 명령어                                               |
| :------------------ | :------------------ | :-------------------------------------------------------- |
| 생성                | `data.frame()`      | `data_frame()`, `tibble()`, `tribble()`                   |
| 강제변환 (Coercion) | `as.data.frame()`   | `as_tibble()`                                             |
| 데이터 불러오기     | `read.*()`          | `read_delim()`, `read_csv()`, `read_csv2()`, `read_tsv()` |


### 티블 생성

- `tibble()` 은 데이터 프레임을 생성하는 좋은 방법이다. 
- 데이터 프레임의 좋은 점들을 압축하고 있다.  
- `tribble()` 함수를 사용해서 좀 더 직관적으로 데이터프레임을 생성할 수도 있다.


#### 데이터 프레임과 티블 생성

##### 데이터프레임(data.frame)의 생성 : `data.frame()` 함수

```{r}
df <- data.frame(1:5, letters[1:5])
str(df)
```

##### 티블(tibble)**의 생성 : `tibble()` 함수

벡터 데이터 세트
```{r}
a_value <- 1:5; a_value
b_value <- letters[1:5]; b_value
```

벡터 결합에 의한 티블의 생성
```{r}
tb1 <- tibble(a = a_value, b = b_value); tb1
str(tb1)
```

티블의 생성
```{r}
tb2 <- tribble( ~a, ~b, 
       #---|----
          1, "a", 
          2, "b")
tb2
str(tb2)
```
- `~a, ~b` : 컬럼의 지정
- `#---|----` : 컬럼 이름과 데이터 구분을 위해 삽입. `#`로 R은 주석 처리함.
- `1, "a", ` : 이하는 데이터 값

#### 데이터 프레임을 티블로 변환하기 : `as_tibble()` 함수

데이터프레임을 티블로 강제 변환해야 할 경우가 있다. `as_tibble()` 를 사용하면 된다.

```{r}
str(iris)             # 데이터 프레임
str(as_tibble(iris))  # 티블
```


#### 개별 벡터를 티블로 만들기

- `tibble()` 을 사용하여 개별 벡터로부터 새로운 티블을 만들 수 있다. 
- `tibble()` 은 길이가 1인 입력을 자동으로 재사용하며, 여기에서 보이는 것처럼, 방금 만든 변수를 참조할 수도 있다.

```{r}
tb1 <- tibble(
           x = 1:5, 
           y = 1, 
           z = x ^ 2 + y
)
tb1
```
- z 컬럼은 계산된 컬럼(computed column)이다.

#### `tribble()`로 티블 만들기

- 티블을 만드는 또 다른 방법은 `tribble()` (전치된(**tr**ansposed) 티블의 줄임말)을 사용하는 것이다. 
- `tribble()` 은 코드로 데이터 입력을 하기 위해 고안되었다.
- **열 헤더**는 공식으로 정의되고 (즉, `~`로 시작), **데이터**은 쉼표로 구분된다.
- 이렇게 하면 적은 양의 데이터를 읽기 쉬운 형태로 배치할 수 있다.

##### 티블 생성
```{r}
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)
```
- 컬럼명을 지정할 때, **`~`** 를 이용한다.
- 각 컬럼의 데이터 타입( *`<chr>`,  `<dbl>`, `<dbl>`* )은 자동으로 인식하여 결정된다.


#### `tibble()`의 특징

- `data.frame()` 에 비해 `tibble()` 은 동작의 규모가 훨씬 작다는 것에 주의해야 한다. 
- 즉, 입력의 유형을 절대로 변경하지 않고 (예를 들어, 문자열을 팩터형으로 변환하지 않는다!), 변수의 이름을 바꾸거나, 행 이름을 생성하지 않는다.


1. `tibble()`은 입력 데이터의 **데이터 타입을 변경하지 않는다**.
    - (즉, `stringsAsFactors = FALSE`이 필요하지 않다!). 
    - 문자형 변수를 이용하는데 보다 편리하다.

```{r}
letters
tibble(x = letters)
```
- 이러한 점이  **list 형 컬럼의 사용**을 용이하게 해 준다:

```{r}
tbl <- tibble(x = 1:3, y = list(1:5, 1:10, 1:20))
tbl$y
tbl$y[1]
tbl$y[[1]]
```

**list 형의 컬럼**은 **`do()`** 함수에 의해 보통 생성되지만, 수작업으로 생성하는 것이 유용할 수 있다.


##### `do()` 함수의 이용 예 : [참고 바람] {-}

```{r}
by_cyl <- group_by(mtcars, cyl)
do(by_cyl, head(., 2))

models <- by_cyl %>% do(mod = lm(mpg ~ disp, data = .))
models

summarise(models, rsq = summary(mod)$r.squared)
models %>% do(data.frame(coef = coef(.$mod)))
models %>% do(data.frame(
  var = names(coef(.$mod)),
  coef(summary(.$mod)))
)

models <- by_cyl %>% do(
  mod_linear = lm(mpg ~ disp, data = .),
  mod_quad = lm(mpg ~ poly(disp, 2), data = .)
)
models
compare <- models %>% do(aov = anova(.$mod_linear, .$mod_quad))
compare$aov
```

2. `tibble()`은 **변수의 이름을 조정하지 않는다**. 
   - 티블은 R 변수명으로는 유효하지 않은 이름(비구문론적 이름)도 열 이름으로 가질 수 있다. 
   - 예를 들어, 문자로 시작하지 않거나 공백과 같은 비정상적인 문자가 포함될 수 있다. 
   - 이 변수들을 참조하려면 역따옴표(backticks, ``)로 감싸야 한다.

```{r}
names(data.frame("crazy name" = 1))
names(tibble('crazy name' = 1))

tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)
tb
```
    - `names(data.frame("crazy name" = 1))`와 같이 데이터 프레임의 경우는 컬럼명에 공란을 허용하지 않으며, 자동으로 공란을 점(`.`)으로 변경하여 `crazy.name`으로 컬럼명을 조정한다.
    - `names(tibble('crazy name' = 1))`와 같이 `tibble()` 함수는 공란이 있는 컬럼명을 허용한다.
    - `tb`의 경우, 컬럼명에 기호, 공란 그리고 숫자 등이 허용됨을 알 수 있다. 다만, 컬럼명을 지정할 때 역따옴표(` )를 사용한다. 
    - `ggplot2`, `dplyr` 및 `tidyr` 과 같은 다른 패키지에서 이러한 변수로 작업할 때도 역따옴표(` )가 필요하다.


3. `tibble()`은 **인수들을 천천히 그리고 순차적으로 평가**한다:

```{r}
tibble(x = 1:5, y = x ^ 2)
```

4. `tibble()`은  `row.names()`를 사용하지 않는다. 
   - 타이디 데이터의 중요한 점은 일관되게 변수를 저장한다는 것이다. 
   - 따라서 이것은 변수를 특별한 속성으로 저장하지 않는다.

5. `tibble()` 길이가 1인 벡터만을 리싸이클(recycling, 자동 반복) 한다. 
   - 이 보다 더 큰 길이의 벡터를 리싸이클링하는 것은 종종 버그의 원인이 된다. 

### 강제변환(Coercion)

- `tibble()`함수를 보완하기 위해, 티블은  오브젝트를 티블로 변환하기 위해  `as.data.frame()`함수보다 더 단순한 `as_tibble()`함수를 제공하고 있다.  
- 그리고 실제로 `as.data.frame()` 함수와 같이 작동하지만 `do.call(cbind, lapply(x, data.frame))`과 비슷하다.
   - 즉, 각 요소들을 하나의 데이터 프레임으로 변환한 다음 `cbind()` 함수로 그것들을 함께 결합해 준다.

`as_tibble()`함수가 성능 향상을 위해 작성되었다:

```{r}
l <- replicate(26, sample(100), simplify = FALSE)
names(l) <- letters

timing <- bench::mark(
  as_tibble(l),
  as.data.frame(l),
  check = FALSE
)

timing
```
   - `as.data.frame()`의 처리 속도는 상호작용으로 사용될 때 병목현상의 일어나지 않지만, 
   - 하나의 tidy 데이터 프레임에 많은 정제되지 않은 데이터를 입력할 때는 문제가 될 수 있다.

### 티블과 데이터 프레임의 비교

티블과 데이터 프레임 사이에는 **3가지의 중요한 차이점**이 있다 : **화면 출력, 서브세팅, 자동 반복 원칙** 등

#### 화면 출력(Printing)

- 티블을 출력하면, 처음의 10개 행과 한 화면에 맞게 모든 열을 보여준다. 
- 또한 각 열의 데이터 타입을 요약해서 보여주고, 폰트 스타일과 강조를 위한 색상을 사용한다. 

```{r}
tibble(x = -5:1000)
```

티블은 큰 데이터 프레임을 화면출력할 때 실수로 콘솔을 넘어가지 않도록 설계되었다. 

그러나 때로는 기본 디스플레이보다 더 많은 출력이 필요하곤 한다. 

도움이 되는 몇 가지 옵션이 있다.

`options` 를 설정하여 기본 출력 동작을 제어할 수도 있다.

1. `options(tibble.print_max = n, tibble.print_min = m)`: `n` 행 이상이 있는 경우, **`m`행만 출력**한다.
   - **모든 행을 표시**하려면 `options(dplyr.print_min = Inf)` 을 사용하라.

```{r}
# 최소 10줄
options(tibble.print_max = 20, tibble.print_min = 10)
tibble(a = 1:26, b = letters) 

# 최소 3줄
options(tibble.print_max = 5, tibble.print_min = 3)
tibble(a = 1:26, b = letters) 
```

   - 첫 번째 티블의 경우, 행의 갯수가 26개로 20개(``tibble.print_max = 20`)를 초과하므로, 10개의 행(`tibble.print_min = 10`)만 출력하고 있다.
   - 두 번째 티블의 경우, 행의 갯수가 26개로 5개(``tibble.print_max = 5`)를 초과하므로, 3개의 행(`tibble.print_min = 3`)만 출력하고 있다. 

2. `options(tibble.width = Inf)` 을 사용하면 화면 너비와 상관없이 **모든 열을 출력**한다.

```{r}
nycflights13::flights %>% 
  print(n = 10, width = Inf)
```


#### 서브세팅(Subsetting)

- 티블은 `data.frame` 보다 좀 더 엄격하다. 
- 절대로 부분 매칭을 사용하지 않으며, 접근하려는 열이 존재하지 않는 경우에는 경고를 생성한다.


- 변수 하나(단일 열)를 추출하려면 새로운 도구인 `$` 및 `[[]]` 이 필요하다. 
- `[[]]` 는 이름이나 위치로 추출할 수 있다. 
- `$` 는 이름으로만 추출할 수 있지만 타이핑을 조금 덜 해도 된다.


##### 데이터 세트
```{r}
set.seed(1234)
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
df
```

##### 이름으로 추출
```{r}
df$x
df[["x"]]
```

##### 위치로 추출
```{r}
df[[1]]
```


*****
##### 파이프 연산자(`%>%`)의 사용

**파이프 연산자(`%>%`)**를 사용하는 경우, 특별한 플레이스홀더(placeholder)인 **`.`**를 사용해야 한다.

```{r}
df %>% .$x
df %>% .[["x"]]
```


*****
##### `[]`의 사용

 `[]`는 **항상 또 다른 티블을 반환**한다. 이러한 특징을 데이터 프레임과 비교하면, 데이터 프레임은 어떨 때는 데이터 프레임을 또 어떨 때는 벡터를 반환한다:

```{r}
# data.frame() 함수
df1 <- data.frame(x = 1:3, y = 3:1)
class(df1[, 1:2])               # 데이터 프레임
class(df1[, 1])                 # 벡터

# tibble() 함수
df2 <- tibble(x = 1:3, y = 3:1)
class(df2[, 1:2])               # tibble
class(df2[, 1])                 # tibble
```

*****
##### `$`의 사용

티블은 `$`를 사용하는데 있어서 엄격하다. 절대로 **부분 매칭을 사용하지 않으며**, 접근하려는 열이 존재하지 않는 경우에는 경고를 생성하거나 `NULL`을 반환한다. 

```{r}
# data.frame() 함수
df <- data.frame(abc = 1)
df$a							# 'abc' 열의 첫 글자로 부분 매칭을 함

# tibble() 함수
df2 <- tibble(abc = 1)
df2$a							# NULL과 경고메시지 출력
```
- `df` 변수의 경우, `data.frame()` 함수를 사용하고 있으며, 이 경우 `df$a`는 `abc` 컬럼명을 부분 매칭하고 있다.
- `df2` 변수의 경우, `tibble()` 함수를 사용하고 있으며, 이 경우 `df$a`는 부분 매칭을 허용하지 않는다. 따라서 `NULL`과 경고 메시지를 출력한다.

*****
##### `drop = ` 옵션의 사용

1.4.1 버전 이후, 티블은 더 이상  `drop =` 인수를 무시하지 않는다:

```{r}
# data.frame() 함수
d1 <- data.frame(a = 1:3)
d1[, "a"]
d1[, "a", drop = TRUE]    # 'drop = TRUE'가 디폴트 
d1[, "a", drop = FALSE]

# tibble() 함수
d2 <- tibble(a = 1:3)
d2[, "a"]
d2[, "a", drop = TRUE]
d2[, "a", drop = FALSE]   # 'drop = FALSE'가 디폴트
```
    - `d1` 변수의 경우, `data.frame()` 함수를 사용하여 생성되었으며, 이 경우 요소 검색 시에 `drop = TRUE` 옵션이 작동하지 않는다.
    - `d2` 변수의 경우, `tibble()` 함수를 사용하여 생성되었으며, 이 경우 요소 검색 시에 `drop = TRUE` 옵션이 작동한다.


#### 자동 반복 (Recycling)

- 티블을 생성할 때 오직 길이가 1인 값만이 자동 반복된다. 
- 길이가 1이 아닌 첫 번째 열이 티블의 행 갯수를 결정하며,  충돌이 되면 에러가 발생한다. 
- 이러한 점은 또한 때때로 프로그램에 있어서 중요한 `0` 개의 행을 가진 티블로 확장된다:

```{r}
tibble(a = 1, b = 1:3)
tibble(a = 1:3, b = 1)
# tibble(a = 1:3, c = 1:2)           # Error : Tibble columns must have compatible sizes.
tibble(a = 1, b = integer())       # A tibble: 0 x 2   (0행, 2열)
tibble(a = integer(), b = 1)       # A tibble: 0 x 2   (0행, 2열)
```

### 이전 코드와 상호작용

- 일부 오래된 함수는 티블에서 동작하지 않는다. 
- 이러한 함수를 사용하려면 `as.data.frame()` 를 사용하여 티블을 `data.frame` 으로 되돌려야 한다.

```{r}
tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)

tb1 <- as.data.frame(tb)
tb1
str(tb1)
class(tb1)
```

    - 오래된 함수 중 일부가 티블에서 작동하지 않는 주된 이유는 `[` 함수 때문이다. 
    - 여기에서는 `[` 를 많이 사용하지 않는데, `dplyr::filter()` 와 `dplyr::select()` 가 더 명확한 코드로 해결할 수 있기 때문이다.
    - ([벡터 서브셋하기](https://sulgik.github.io/r4ds/tibble.html#vector-subsetting)에서 좀 더 자세히 알 수 있다). 


- `base` R의 데이터프레임을 사용하면 `[` 는 어떨 때는 *데이터프레임*을 반환하고, 또 어떨 때는 *벡터*를 반환한다. 
- 티블에서 `[` 는 항상 다른 **티블을 반환**한다.


### 외부 데이터 가져오기 (importing)

`.csv` 파일 변수명이 흥미롭게 된 파일데이터를 기존 `read.csv()` 함수와 `read_csv()` 함수로 각각 불러오는 경우를 비교하여 보자. **`read_csv()`**가 원본 데이터를 깔끔하게 가져올 뿐만 아니라 속도도 빠르다.


#### `read_lines()` 함수 →  벡터**

```{r}
file_url <- "https://gist.githubusercontent.com/theoroe3/8bc989b644adc24117bc66f50c292fc8/raw/f677a2ad811a9854c9d174178b0585a87569af60/tibbles_data.csv"

read_lines(file_url)
```


#### `read.csv()` 함수 → 데이터프레임**

`read.csv()` 함수는 외부 데이터를 가져올 때, **데이터 프레임** 형태로 가져온다

```{r}
read.csv(file_url)
```

#### `read_csv()` 함수 → 티블**

`read_csv()` 함수는 외부 데이터를 가져올 때, **티블** 형태로 가져온다.

```{r}
read_csv(file_url)
```


### 연습문제

1. **어떤 객체가 티블 인지 알 수 있는 방법은 무엇인가? (힌트: 일반 데이터프레임인 `mtcars` 를 화면 출력해보라.)**

   ```{r}
   head(mtcars)
   # mtcars
   as.tibble(mtcars)
   class(mtcars)
   ```

2. **`data.frame` 과 이에 해당하는 티블에서 다음 연산들을 비교하고 차이를 밝혀보라. 차이점은 무엇인가? 데이터프레임의 기본 동작이 혼란스러운 점은 무엇인가?**

   ```{r}
     df <- data.frame(abc = 1, xyz = "a")
     df$x
     df[, "xyz"]
     df[, c("abc", "xyz")]
   ```
   - 두 번쨰의 `df$x`의 경우 컬럼명에 `x`가 없지만 컬럼명과 부분 매칭을 해서 `xyz` 컬럼의 값들을 출력하고 있다.

   - `tibble()` 함수를 이용하면 부분 매칭이 허용되지 않는다.

   ```{r}
     tbl <- tibble(abc = 1, xyz = "a")
     tbl$x          # 컬럼명의 부분 매칭을 허용하지 않음.
     tbl[, "xyz"]
     tbl[, c("abc", "xyz")]
   ```


3. **객체에 변수 이름을 저장하고 있는 경우 (예: `var <- "mpg"`), 티블에서 이 참조 변수를 어떻게 추출할 수 있는가?**

   ```{r}
   mtcars
   t_cars <- as_tibble(mtcars)
   var <- "mpg"
   
   t_cars$var             # NULL과 경고 메시지 출력
   t_cars[[var]]
   ```
   - 이렇게 티블의 컬럼을 변수명으로 하여 검색하려 할 때에, `$`를 사용하면 `NULL`과 경고 메시지가 출력된다.  



4. **다음의 데이터프레임에서 비구문론적 이름을 참조하는 방법을 연습해보라.**
   1. **1 이라는 이름의 변수를 추출하기.**
   2. **1 vs 2 의 산점도를 플롯팅 하기.**
   3. **열 2 를 열 1 로 나누어, 3 이라는 새로운 열을 생성하기.**
   4. **열의 이름을 one, two, three 로 변경하기.**

   ```{r}
   test <- tibble(
     `1` = 1:10,
     `2` = `1` * 2 + rnorm(length(`1`))
   )
   
   ## 1.
   test[["1"]]
   
   ## 2.
   ggplot(test, aes(x = `1`, y = `2`)) +
     geom_point()
   
   ## 3.
   mutate(test, `3` = `2` / `1`)
   # 또는
   test[["3"]] <- test$`2` / test$`1`
   
   ## 4.
   test <- rename(test, one = `1`, two = `2`, three = `3`)
   glimpse(test)
   ```

5. **`tibble::enframe()` 은 어떤 동작을 하는가? 언제 사용하겠는가?**

   - `tibble::enframe()` 은 이름이 붙여진 벡터를 `name` 컬럼과 `value` 컬럼으로 구성되는 데이터 프레임으로 변환한다.

   ```{r}
  enframe(c(a = "A", b = "B", c = "C"))
   ```


6. **티블의 바닥글(footer)에 화면출력되는 열 이름의 개수를 제어하는 옵션은 무엇인가?**

   - `n_extra` 인수가 열 이름의 갯수를 제어한다. (`? print.tbl` 참고)

   ```{r}
  mtcars2 <- as_tibble(cbind(mtcars, mtcars), .name_repair = "unique")
  print(mtcars2, n = 4, n_extra = 4)
  print(mtcars2, n = 4, n_extra = 10)
   ```

   - 예를 들기 위해, `mtcars` 데이터 세트를 `cbind()` 함수를 이용하여 컬럼의 폭을 두 배로 늘렸다.
      - `n = 4`  인수를 이용하여 **출력할 행의 갯수**를 제한하였다.
      - `n_extra = ` 인수를 이용하여 **추가적인 컬럼에 대한 정보의 출력 갯수**를 제어하였다.


### References {-}

- https://statkclee.github.io/data-science/data-handling-tibble.html

- https://m.blog.naver.com/PostView.nhn?blogId=2000051148&logNo=221188223533&proxyReferer=https:%2F%2Fwww.google.com%2F

- [dtplyr: dplyr의 편리함과 data.table의 속도를 그대로!](http://henryquant.blogspot.com/2019/11/dtplyr-dplyr-datatable.html) : **data.table, dplyr, dtplyr 의 속도비교**
- [dtplyr: Data Table Back-End for 'dplyr'](https://rdrr.io/cran/dtplyr/)


## Factor   {#factor}

### 범주형 자료

R에서 **범주형 자료(Categorical Data)**를 다룰 때는 **문자형 자료**와 잘 구별할 수 있어야 한다.

미리 범주형인지 문자형인지 확인하고 적절하게 분석 목적에 맞게끔 변환시켜야 한다.
이러한 과정들이 모두 데이터 전처리의 일부이다.

쉽게 표현하면, “vector(숫자형) + level(문자형) = factor”

### Factor의 요소 및 특징

level

   - vector의 index. (그런데, level도 벡터이다.)
   - char 형이 기본값.
   - first level이 선형 모델링시 가장 basic level로 간주됨. ex] levels = c("yes", "no")


특징 : 

   - 명목형 변수를 저장할 때에 메모리를 아껴준다.
       -  ex) “MALE”, “MALE”, “FEMALE” … 로 저장해주기 보다는 1, 1, 2, … 로 저장하고,
        1 = MALE, 2 = FEMALE로 level로  묶어주는 것이 좀 더 메모리상에서 효율적
        
   - 일반 vector와는 다르게 level을 설정 가능
   
   - levels을 통해 한번에 “척”하고 변경이 가능

### `factor()` 함수의 형식

`factor()` 함수의 기본적인 형식 : 

```
factor(x = character(), levels, labels = levels,
       exclude = NA, ordered = is.ordered(x), nmax = NA)

where,
x	: 소수의 구별되는 값들로 구성되는 데이터 벡터
levels	: as.character(x)에 의해 처리된 문자열 데이터의 유일 값들로, x의 오름차순으로 정렬된 것.
이는 sort(unique(x)) 보다 더 적은 수가 된다는 점을 주목하라.

labels : 실제로 보여지는 값
exclude	: levels를 설정할 때 제외되는 값들의 벡터
ordered	: levels에 순서를 지정
nmax : levels 갯수의 상한
```

### factor 생성

```
x <- factor("문자벡터", levels = “벡터의 레벨(char)”, ordered = “ T/F” )
```

#### factor 생성

```{r}
factor(c("yes", "no", "yes") )    #  디폴트로 레벨 : 오름차순 생성
```

#### factor에 levels 부여하기

```{r}
factor(c("yes", "no", "yes"), levels = c("yes", "no")) 
```

#### levels에 순위 부여하기

```{r}
x <- factor(c("yes", "no", "yes"), levels = c("yes", "no") , ordered = T)    # 가장 처음에 온 값이 기본 레벨(basic levels)이 됨
x
```

```{r}
levels(x)[1:2]
levels(x)[1:2] <- "yes"
levels(x)                   
x                             # levels에 접근하여 모든 값을 변경 가능
```

#### factor의 exclude인자 활용하기

```{r}
x <- factor(c("yes", "no", "yes", "yeah"), 
            levels = c("yes", "no", "yeah"), 
            ordered = T, 
            exclude = "yeah")
x           # exclude를 쓰면 NA 처리된다
```

#### `addNA()` 함수 활용하기 : 

`addNA()` 함수를 이용하여 `NA`를 `levels`에 추가하기

```{r}
addNA(x, ifany = FALSE)     # Levels에 N/A를 넣고싶다면
```

#### `tapply()` 함수를 통해 factor 이해하기

```{r}
age <- c(43,35,34,37,28,30,29,25,27,36,24,36,26,28,20)
gender <- factor(c('M','F','F','M','M','F','F','M','F','F','M','M','M','F','M'))
sal <- c(seq(100, 200, length.out=15))   
emp <- data.frame(age, gender, sal)  

emp$over30 <- ifelse(emp$age >= 35, 3, (ifelse(emp$age >=30, 2, ifelse(emp$age >=25, 1, 0))))
emp$over30 <- as.factor(emp$over30)
str(emp)

round(tapply(emp$sal, list(emp$gender, emp$over30), mean))   # gender, over30 별로 sal의 급여 평균 구하기

```

#### `lm()` 함수를 통해 factor 이해하기

```{r}
hsb2 <- read_csv("https://stats.idre.ucla.edu/stat/data/hsb2.csv")
str(hsb2)

## race 컬럼에 factor 미적용시
summary(lm(write ~ race, data = hsb2))

# 팩터 변수 생성 후 race 컬럼에 적용한 결과
hsb2$race.f <- factor(hsb2$race)    # race 컬럼의 팩터형 race.f 컬럼
is.factor(hsb2$race.f)              # race.f 컬럼이 factor 형인지 확인

hsb2$race.f[1:15]                   # race.f 컬럼의 앞 15개 요소 확인

summary(lm(write ~ race.f, data = hsb2))  #  write = a * race.f + b 선형 회귀식의 요약 통계

# ggplot(hsb2, aes(race.f, write)) + geom_point() + stat_smooth(method=lm, level = 0.95)

```


#### 팩터변수를 외부에서 생성하기 싫은 경우 내부에 사용도 가능
```{r}
hsb2 <- read.csv("https://stats.idre.ucla.edu/stat/data/hsb2.csv")

summary(lm(write ~ factor(race), data = hsb2))

# ggplot(hsb2, aes(race, write)) + geom_point() + stat_smooth(aes(race, write), method=lm, level = 0.95)
```


### Reference {-}
- [R만의 명목변수 자료형 Factor 개념 이해하기](https://gigle.tistory.com/102)
