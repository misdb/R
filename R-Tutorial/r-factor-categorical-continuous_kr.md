# factor : 범주형 변수와 연속형 변수



## factor

factor는 제한된 수의 상이한 값을 갖는 R의 변수이며 그러한 변수는 종종 범주형 변수(categorical variables)라 불린다.

데이터 세트에서 우리는 **범주형**과 **연속형**의 두 가지 유형의 변수를 구분할 수 있다.

- 범주형 변수에서는 그 값들이 제한되어 있고 보통 특정 유한한 그룹에 기반한다. 예를 들어, 범주형 변수에는 국가, 연도, 성별, 그리고 직업 등을 들 수 있다.
- 그러나 연속형 변수(continuous variable)는 정수형에서 실수에 이르는 어떠한 값도 가질 수 있다. 예를 들어, 수익, 주식의 가격 등이 있다.



## 범주형 변수

R은 범주형 변수를 factor로 저장한다. 문자 변수를 factor 변수로 변환하는 아래의 코드를 검토해 보자. 문자들은 기계 학습 알고리즘에서는 지원되지 않으며, 유일한 방법은 문자열을 정수로 변환하는 것이다.

**Syntax**

```
factor(x = character(), levels, labels = levels, ordered = is.ordered(x))
```

**인수(Arguments):**

- **x**: 데이터의 벡터. 실수가 아닌 문자열이나 정수여야 한다.
- **Levels**: x가 가질 수 있는 가능한 값의 벡터. 이 인수는 선택사항이다. 기본 값은 벡터 x의 각 항목들의 단일값 목록이다.
- **Labels**: x 데이터에 라벨을 추가한다. 예를 들어,  `male`라벨에는 1을, 반면에  `female`라벨에는 0.
- **ordered**: levels이 서열화되어야 하는지를 결정한다.



**예제 :**

factor 데이터 프레임을 생성해 보자.

```
# Create gender vector
gender_vector <- c("Male", "Female", "Female", "Male", "Male")
class(gender_vector)

# Convert gender_vector to a factor
factor_gender_vector <-factor(gender_vector)
class(factor_gender_vector)
```

**결과 :**

```
## [1] "character"
## [1] "factor"
```

기계학습 업무를 수행할 때 문자열(**string**)을 factor로 변환하는 것은 중요하다.

범주형 변수는 **명목 범주형 변수**(**nominal categorical variable**)와 **서열 범주형 변수**(**ordinal categorical variable**)로 구분할 수 있다..



### 범주형 변수

서너 개의 값을 갖는 범주형 변수로 순서가 중요하지 않다. 예를 들어, 남성 혹은 여성은 범주형 변수이지만 서열을 가지고 있지 않다.

```
# Create a color vector
color_vector <- c('blue', 'red', 'green', 'white', 'black', 'yellow')

# Convert the vector to factor
factor_color <- factor(color_vector)
factor_color
```

**결과:**

```
## [1] blue   red    green  white  black  yellow
## Levels: black blue green red white yellow
```

`factor_color` 변수에서 우리는 색깔의 서열을 구분할 수 없다.



### 서열 범주형 변수

서열 명목형 변수(Ordinal categorical variables)는  자연스런 서열을 가지고 있다. 물론 가장 낮은 서열부터 높은 서열 순을 나타내기 위해 `order = TRUE`를 이용하고, 가장 높은 서열에서 가장 낮은 서열로 나타내기 위해서는 `order = FALSE`를 이용하는 등 그 서열을 정할 수도 있다. 



**예제:**

우리는 각각의 factor 값을 세기 위해 `summary()` 함수를 사용할 수 있다.

```
# Create Ordinal categorical vector 
day_vector <- c('evening', 'morning', 'afternoon', 'midday', 'midnight', 'evening')
# Convert `day_vector` to a factor with ordered level
factor_day <- factor(day_vector, order = TRUE, levels =c('morning', 'midday', 'afternoon', 'evening', 'midnight'))
# Print the new variable
factor_day
```

**결과:**

```
## [1] evening   morning   afternoon midday    
midnight  evening  
```



**예제:**

```
## Levels: morning < midday < afternoon < evening < midnight
# Append the line to above code
# Count the number of occurence of each level
summary(factor_day)
```

**결과:**

```
##   morning    midday afternoon   evening  midnight
##         1         1         1         2         1
```

R은 `levels=`를 이용하여 'morning'에서 부터 'midnight' 순으로 level에 순서를 매길 수 있다.



## 연속형 변수

연속형 변수(Continuous class variables)는 R에서 기본 값이다. 이 변수들은 숫자 또는 정수를 저장한다. 우리는 다음의 데이터 세트에서 그것에 대해 살펴볼 수 있다. `mtcars`는 R에 내장된 데이터 세트이다. 이 데이터 세트는 다양한 유형의 자동차에 관한 정보를 담고 있다. 우리는 `mtcars`를 이용하여 그 데이터를 import 할 수 있다. mpg(mile per gallon) 변수의 class를 확인해 보자. 그것은 연속형 변수를 포함하는 `numeric` 값을 반환한다.

```
dataset <- mtcars
class(dataset$mpg)
```

**결과 : **

```
## [1] "numeric"
```

 

