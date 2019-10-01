# select(), filter(), arrange(), pipeline (예제 포함)



이 튜토리얼에서는 다음에 대하여 학습한다.

- [select()](./r-select-filter-arrange_kr.html#1)
- [filter()](./r-select-filter-arrange_kr.html#2)
- [파이프라인](./r-select-filter-arrange_kr.html#3)
- [arrange()](./r-select-filter-arrange_kr.html#4)



dplyr 라이브러리는 데이터 세트의 자료들을 관리하는데 유용한 함수를 많이 포함하고 있다. 이 튜토리얼을 통해 travel_times 데이터 세트를 사용할 것이다. 이 데이터 세트는 집과 직장 사이의 운전자에 의한 여행 소요시간 정보를 수집한 것이다. 데이터 세트에는 다음의 변수를 포함하여 총 14개의 변수가 있다 :

- DayOfWeek : 운전자가 자신의 차를 사용하는 요일을 식별한다.
- Distance : 여행의 총 거리
- MaxSpeed : 여행의 최대 속도
- TotalTime : 이동 시간(분)



이 데이터 세트에서 약 200개의 관측치를 가지고 있으며, 월요일에서 금요일 사이에 자동차 이동을 포함한다.

우선 다음과 같은 작업을 수행해야 한다.

- 데이터 세트 로드
- 자료의 구조 확인  

`dplyr`의 편리한 한 가지 특징은 `glimpse()` 함수이다. 이 함수는 `str()`보다 개선된 것이다. 우리는 데이터 세트의 구조를 살펴보고 어떤 조작이 필요한지 결정하기 위해 `glimpse()` 함수를 이용할 수 있다.

```
library(dplyr) 
PATH <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/travel_times.csv"
df <- read.csv(PATH)
glimpse(df)
```

**결과 :**

```
## Observations: 205
## Variables: 14
## $ X              <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, ...
## $ Date           <fctr> 1/6/2012, 1/6/2012, 1/4/2012, 1/4/2012, 1/3/20...
## $ StartTime      <fctr> 16:37, 08:20, 16:17, 07:53, 18:57, 07:57, 17:3...
## $ DayOfWeek      <fctr> Friday, Friday, Wednesday, Wednesday, Tuesday,...
## $ GoingTo        <fctr> Home, GSK, Home, GSK, Home, GSK, Home, GSK, GS...
## $ Distance       <dbl> 51.29, 51.63, 51.27, 49.17, 51.15, 51.80, 51.37...
## $ MaxSpeed       <dbl> 127.4, 130.3, 127.4, 132.3, 136.2, 135.8, 123.2...
## $ AvgSpeed       <dbl> 78.3, 81.8, 82.0, 74.2, 83.4, 84.5, 82.9, 77.5,...
## $ AvgMovingSpeed <dbl> 84.8, 88.9, 85.8, 82.9, 88.1, 88.8, 87.3, 85.9,...
## $ FuelEconomy    <fctr> , , , , , , -, -, 8.89, 8.89, 8.89, 8.89, 8.89...
## $ TotalTime      <dbl> 39.3, 37.9, 37.5, 39.8, 36.8, 36.8, 37.2, 37.9,...
## $ MovingTime     <dbl> 36.3, 34.9, 35.9, 35.6, 34.8, 35.0, 35.3, 34.3,...
## $ Take407All     <fctr> No, No, No, No, No, No, No, No, No, No, No, No...
## $ Comments       <fctr> , , , , , , , , , , , , , , , Put snow tires o...	
```

This is obvious that the variable Comments needs further diagnostic. The first observations of the Comments variable are only missing values.

이는 `Comments` 변수는 추가 진단을 필요로 하는 것이 분명하다. `Comments` 변수의 관측치들은 결측치들 뿐이다.



```
sum(df$Comments =="")
```

**코드 설명 :** 

- sum(df$Comments =="") : `df`의 `Comments` 열의 값이 `""`인 관측치를 합한다.

**결과 :**

```
## [1] 181	
```



## select()

우리는 `select()` 함수 먼저 살펴보기로 한다. 모든 변수가 필요한 것은 아니며, 좋은 관행은 당신이 필요하다고 생각하는 변수만을 선택하는 것이다.

우리는 181건의 결측치를 가지고 있으며, 이는 데이터 세트의 90%에 달한다. 이것들을 제외하기로 결정하면 분석을 계속할 수 없을 것이다.

다른 가능성은 `select()` 함수를 이용하여 `Comment` 변수를 제거하는 것이다.

우리는 select()을 이용해 다양한 방법으로 변수를 선택할 수 있다. 첫 번째 인수는 데이터 세트이다.

```
- select(df, A, B, C): df 데이터 세트의 A, B, C 변수를 선택
- select(df, A:C): df 데이터 세트의 A에서 C까지의 모든 변수를 선택
- select(df, -C): df 데이터 세트에서 C 변수를 제외
```

세 번째 방법을 사용하여 `Comments` 변수를 제외할 수 있다.

```
step_1_df <- select(df, -Comments)
dim(df)
```

**결과 :**

```
## [1] 205  14
```



```{r}
dim(step_1_df)
```

**결과 :**

```
## [1] 205  13	
```

원 데이터 세트는 14개의 열을 갖고 있는 반면, `step_1_df` 변수는 13개의 열을 갖고 있다.



## filter()

`flter()` 함수는 기준을 따르는 관측지를 유지하는데 도움이 된다. `filter()` 함수는 `select()` 함수와 똑같이 작동하며, 먼저 데이터 프레임을 그 다음에 컴마론 구분된 조건을 기술한다 :

```
filter(df, condition)
```

**인수 :**

- df : 데이터 필터에 사용될 데이터 세트
- condition : 데이터 필터 조건	



### 단일 기준

우선 factor 변수의 각 수준 내의 관측치 수를 셀 수 있다.

```
table(step_1_df$GoingTo)
```

**코드 설명 :** 

- table() : 수준별로 관측치의 수를 센다. (**주의 :** factor 수준 변수 만이 적용된다.)
- table(step_1_df$GoingTo) : 최종 목적지로(`GoingTo`) 향하는 여행의 수를 센다.

**결과 :**

```
## 
##  GSK Home 
##  105  100	
```

`table()` 함수는 105번의 운행은 `GSK`로 가고, 100번은 `Home`으로 가고 있음을 표시한다.

데이터를 필터링하여 105개의 관측치가 있는 데이터 세트와 100개의 관측치가 있는 데이터 세트를 반환할 수 있다.

```
# Select observations
if GoingTo == Home
select_home <- filter(df, GoingTo == "Home")
dim(select_home)
```

**Output:**

```
## [1] 100  14
```



```{r}
# Select observations
if GoingTo == Work
select_work <- filter(df, GoingTo == "GSK")
dim(select_work)
```

**Output:**

```
## [1] 105  14	
```



### 복수 기준

한 개 이상의 기준으로 데이터 세트를 필터링할 수 있다. 예를 들어, 목적지가 `Home`이고 `Wednesday`에 발생한 관측치를 추출할 수 있다.

```
select_home_wed <- filter(df, GoingTo == "Home" & DayOfWeek == "Wednesday")
dim(select_home_wed)
```

**Output:**

```
## [1] 23 14	
```

23개의 관측치가 이 기준에 대응된다.



## pipeline

데이터셋을 생성하려면 다음과 같은 많은 작업이 필요하다 :

- 불러오기
- 병합
- 선택
- 필터링
- 기타 등



`dplyr` 라이브러리는 **파이프라인**이라고 하는 실용적인 연산자 `%>%`를 함께 제공한다. 파이프라인은 사용하면 조작이 깨끗하고 빠르며 오류 발생이 최소화된다.

This operator is a code which performs steps without saving intermediate steps to the hard drive. If you are back to our example from above, you can select the variables of interest and filter them. We have three steps:

이 연산자는 하드 드라이브로 중간 단계를 저장하지 않고도 단계를 수행하게 해 주는 코드이다. 위에서 본 사례로 돌아가면 관심 변수를 선택하여 필터링할 수 있다. 다음의 세 가지 단계가 있다 :

- 1단계: 데이터 불러오기: `gps` 데이터 불러오기

- 2단계: 데이터 선택: `GoingTo`와 `DayOfWeek` 선택
- 3단계: 필터 데이터: `Home`과 `Wednesday`반환



```
# Step 1
step_1 <- read.csv(PATH)

# Step 2 
step_2 <- select(step_1, GoingTo, DayOfWeek)

# Step 3 
step_3 <- filter(step_2, GoingTo == "Home", DayOfWeek == "Wednesday")

head(step_3)
```

**Output:**

```
##   GoingTo DayOfWeek
## 1    Home Wednesday
## 2    Home Wednesday
## 3    Home Wednesday
## 4    Home Wednesday
## 5    Home Wednesday
## 6    Home Wednesday	
```



그것은 특히 많은 조작을 수행하기에는 편리한 방법이 아니다. 특히 많은 단계마다 거치는 상황의 경우는 더 그렇다.  환경은 결국 많은 오브젝트를 저장하는 결과를 가져온다.

대신 파이프라인 연산자 `%>%`를 사용합시다. 우리는 단지 처음에 사용되는 데이터 프레임을 정의하기만 하면 되고 모든 과정은 거기에서 흘러갈 것이다.

파이프라인의 기본 구문 : 

```
New_df <- df %>%
step 1 %>%
step 2 %>%
...

```

**인수 : **

- New_df : 새 데이터 프레음 이름 (생성되는 변수)

- df : 단계에서 계산에서 사용되는 데이터 프레임

- step: 각 단계별 처리 명령

  **참고 :** 마지막 처리 명령은 파이프 연산자 '%>%'가 필요하지 않으므로 더 이상 파이프에 대한 명령이 없다.
  **참고 :** 새 변수 생성은 선택 사항이다. 포함되지 않은 경우, 출력이 콘솔에 표시된다.



위에 열거한 단계를 따라 첫 번째 파이프를 작성할 수 있다.

```
# Create the data frame filter_home_wed.It will be the object return at the end of the pipeline
filter_home_wed <- 

#Step 1
read.csv(PATH) %>% 

#Step 2
select(GoingTo, DayOfWeek) %>% 

#Step 3
filter(GoingTo == "Home",DayOfWeek == "Wednesday")
identical(step_3, filter_home_wed)
```

**결과 :**

```
## [1] TRUE	
```

우리는 파이프라인 연산자로 놀라운 데이터 세트를 생성할 준비가 되어 있다.



## arrange()

[이전 tutorial](./r-sort-data-frame_kr.html)에서는 `sort()` 함수를 사용하여 값을 정렬하는 방법에 대해 학습하였다. dplyr 라이브러리는 정렬 함수가 있다. 파이프라인과 함께 매력적으로 작용한다. `arrange()` 함수는 오름차순(기본값) 또는 내림차순으로 한 개 또는 여러 행의 순서를 변경할 수 있다.

```
- arrange(A): 변수 A의 오름차순 정렬
- arrange(A, B): 변수 A와 B의 오름차순 정렬
- arrange(desc(A), B): 변수 A는 내림차순으로 그리고 변수 B는 오름차순으로 정렬
```

우리는 목적지(`GoingTO`)별로 거리(`Distance`)를 정렬할 수 있다.

```
# Sort by destination and distance
step_2_df <-step_1_df %>%
	arrange(GoingTo, Distance)
head(step_2_df)
```

**Output:**

```
##     X       Date StartTime DayOfWeek GoingTo Distance MaxSpeed AvgSpeed
## 1 193  7/25/2011     08:06    Monday     GSK    48.32    121.2     63.4
## 2 196  7/21/2011     07:59  Thursday     GSK    48.35    129.3     81.5
## 3 198  7/20/2011     08:24 Wednesday     GSK    48.50    125.8     75.7
## 4 189  7/27/2011     08:15 Wednesday     GSK    48.82    124.5     70.4
## 5  95 10/11/2011     08:25   Tuesday     GSK    48.94    130.8     85.7
## 6 171  8/10/2011     08:13 Wednesday     GSK    48.98    124.8     72.8
##   AvgMovingSpeed FuelEconomy TotalTime MovingTime Take407All
## 1           78.4        8.45      45.7       37.0         No
## 2           89.0        8.28      35.6       32.6        Yes
## 3           87.3        7.89      38.5       33.3        Yes
## 4           77.8        8.45      41.6       37.6         No
## 5           93.2        7.81      34.3       31.5        Yes
## 6           78.8        8.54      40.4       37.3         No
```



## 요약

아래 표에 튜토리얼 중에 학습한 모든 작업을 요약하였다.

| 함수      | 목적                                     | 코드                                       | 설명                                 |
| :-------- | :--------------------------------------- | :----------------------------------------- | :----------------------------------- |
| glimpse() | df의 구조 확인                           | `glimpse(df)`                              | `str()`과 동일                       |
| select()  | 변수의 선택/제거                         | `select(df, A, B ,C)`                      | 변수 A, B, C의 선택                  |
|           |                                          | `select(df, A:C)`                          | A에서 C까지의 모든 변수 선택         |
|           |                                          | `select(df, -C)`                           | C 제외                               |
| filter()  | 한 개 혹은 여러 조건으로 df를 필터       | `filter(df, condition1)`                   | 한 조건                              |
|           |                                          | `filter(df, condition1,condition2)`        | 두개의 조건                          |
| arrange() | 데이터 세트를 하나 또는 여러 변수로 정렬 | `arrange(A)`                               | 변수 A의 오름차순 정렬               |
|           |                                          | `arrange(A, B)`                            | 변수 A, B의 오름차순                 |
|           |                                          | `arrange(desc(A), B)`                      | 변수 A는 내림차순, 변수 B는 오름차순 |
| %>%       | 각 단계별로 파이프라인 생성              | `step 1 %>% <br />step 2 %>% <br />step 3` |                                      |



 

