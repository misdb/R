# 결측치(NA)의 대체: na.omit & na.rm



데이터 과학에서 결측치는 데이터 프레임의 열에 값이 없거나 숫자 값 대신 문자 값을 포함할 때 발생한다. 결측치는 데이터에서 정확한 결론을 도출하기 위해 삭제되거나 다른 값으로 대체되어야 한다.

이 튜토리얼에서는 `dplyr` 라이브러리를 통해 결측치를 처리하는 방법을 학습하게 된다. `dplyr` 라이브러리는 데이터 분석을 실현하기 위한 생태계의 일부분이다.

 (데이타 분석 : 데이터 조작, 데이터 클린징, 데이터 시각화)

[![img](https://www.guru99.com/images/r_programming/032918_0440_ReplaceMiss1.png)](https://www.guru99.com/images/r_programming/032918_0440_ReplaceMiss1.png)

이 튜토리얼에서는 다음에 대하여 학습한다.

- [mutate()](./r-replace-missing-values_kr.html#1)
- [결측치(NA) 제거](./r-replace-missing-values_kr.html#2)
- [결측치(NA)를 평균과 중앙값으로 대체하기](./r-replace-missing-values_kr.html#3)



## mutate()

`dplyr` 라이브러리의 네 번째 동사(명령어)는 새로운 변수를 만들거나 기존 변수의 값을 변경할 때 유용하다.

우리는 두 부분으로 나누어 진행할 것이다. 다음 방법에 대하여 학습한다.

-  데이터 프레임에서 결측치 제거

- 평균 및 중앙값으로 결측치 대체

그 동사는 매우 사용하기 쉽다. 다음의 표현법에 따라 새 변수를 만들 수 있다:

```
mutate(df, name_variable_1 = condition, ...)
```

**인수 :**

- df : 새 변수의 생성에 사용될 데이터 프레임
- name_variable_1 : 새 변수의 생성을 위한 이름과 공식
- ... : 무제한 제약. mutate() 함수 내에서 하나 이상의 변수를 생성할 가능성



### 결측치(NA) 제거

`dplyr` 라이브러리의 `na.omit()` 함수는 결측치를 간단히 제거해 준다. 데이터에서 모든 NA를 삭제하는 것이 쉽지만 그것이 가장 좋은 방업이라는 것은 아니다. 분석 중에는 결측치를 처리하기 위한 다양한 방법을 사용하는 것이 현명하다.

결측치의 문제를 해결하기 위해 티타닉 데이터 세트를 사용하기로 한다. 이 데이터 세트에는 비극적인 사건 동안에 배에 승선한 승객들에 대한 정보를 접근할 수 있다. 이 데이터 세트는 신경써야 할 많은 결측치(NA)를 가지고 있다.

인터넷에서 csv파일을 다운받아, NA가 있는 열들을 확인하겠다. 결측치를 갖는 열들을 반환하려면 다음 코드를 사용할 수 있다:

데이터를 불러와서 결측치를 확인해보자.

```
PATH <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/test.csv"
df_titanic <- read.csv(PATH, sep = ",")
# Return the column names containing missing observations
list_na <- colnames(df_titanic)[ apply(df_titanic, 2, anyNA) ]
list_na
```

**결과 : **

```
## [1] "Age"  "Fare"
```

여기에서 다음의 구문은

```
colnames(df_titanic)[apply(df_titanic, 2, anyNA)]
```

결측치를 갖는 열의 이름을 알려준다.

`Age`와 `Fare` 열들이 결측치를 가지고 있다.

우리는 `na.omit()` 함수를 이용하여 그 값들을 없앨 수 있다.

```
library(dplyr)
# Exclude the missing observations
df_titanic_drop <-df_titanic %>%
                  na.omit()		
dim(df_titanic_drop)
```

**결과 : **

```
## [1] 331   11
```

이제 새 데이터 세트는, 원래의 데이터 세트가 가지고 있는 418개의 행과 비교하여, 331개의 행을 포함한다.

![cap003](C:\Users\Kim_DaeHo\Pictures\cap003.png)



### 결측치를 평균과 중앙값으로 대체

결측치를 중앙값이나 평균으로 계산할 수도 있다. 좋은 방법은 평균과 중앙값 대해 두 개의 변수를 별도로 만드는 것이다. 일단 만들면, 결측치를 새로 형성된 변수로 대체할 수 있다.



`NA`가 포함된 열의 평균을 계산하기 위해 `apply()` 함수를 사용할 것이다. 예를 보자.

**단계 1)** 앞서 튜토리얼에서는`list_na`라는 리스트에 결측치를 갖는 열의 이름을 저장했다. 우리는 이 리스트를 사용할 것이다.



**단계 2)** 이제 `na.rm = TRUE`라는 인수로 평균을 계산해야 한다. 이 인수는 칼럼이 결측치를 가지고 있기 때문에 반드시 사용해야 하고, 이 요소는 R에게 그 결측치들을 무시하라고 지시하는 것이다.

```
# Create mean
average_missing <- apply(df_titanic[,colnames(df_titanic) %in% list_na],
      2,
      mean,
      na.rm = TRUE)
average_missing
```

**코드 설명 :**

`apply()` 함수에 4개의 인수를 전달한다.

- df : `df_titanic[,colnames(df_titanic) %in% list_na]`. 이 코드는 `list_na object`의 열들을 반환한다. (즉,. "Age"와 "Fare")
- 2 : 열을 대상으로 함수의 연산을 수행한다.
- mean : 평균값을 구한다.
- na.rm = TRUE : 결측치는 무시

**결과 :  **

```
##      Age     Fare 
## 30.27259 35.62719
```

결측치를 포함하고 있는 열의 평균을 성공적으로 생성했다. 이 두 값들은 결측치를 대체하는 데 사용될 것이다.



**단계 3)** 결측치(NA)의 대체

`dplyr` 라이브러리의 `mutate()` 는 새 변수를 만드는 데 유용하다. 우리는 NA를 갖지 않는 새 변수를 만들기 위해 원래의 열을 바꿀 필요는 없다. `mutate()`는 사용하기 쉽다. 우리는 단지 변수 이름을 선택하고 이 변수를 만드는 방법을 정의한다. 여기에 완전한 코드가 있다.

```
# Create a new variable with the mean and median
df_titanic_replace <- df_titanic %>%
   mutate(replace_mean_age  = ifelse(is.na(Age),  average_missing[1], Age),
          replace_mean_fare = ifelse(is.na(Fare), average_missing[2], Fare))
```

**코드 설명 :**

`replace_mean_age`와 `replace_mean_fare` 등의 두 변수를 다음과 같이 생성하였다 :

- `replace_mean_age = ifelse(is.na(Age), average_missing[1], Age)`
- `replace_mean_fare = ifelse(is.na(Fare), average_missing[2], Fare)`

`age`열이 결측치를 갖고 있다면,  has missing values, then replace with the first element of `average_missing` 의 첫째 요소(mean of age)로 대체하고, 그렇지 않으면 원래의 값을 그대로 유지한다. `Fare`열도 같은 방법으로 대체한다.



```
sum(is.na(df_titanic_replace$Age))
```

**결과 :  **

```
## [1] 86
```



데이터를 대체한다.

```
sum(is.na(df_titanic_replace$replace_mean_age))
```

**결과 :  **

```
## [1] 0		
```

원래의 `Age` 열은87개의 결측치를 갖고 있는 반면, 새로 생성된 변수는 결측치들을 `Age`의 평균값으로 대체되었다.



**단계 4)** 결측치를 중앙값으로도 대체할 수 있다.

```
median_missing <- apply(df_titanic[,colnames(df_titanic) %in% list_na],
      2,
      median,
      na.rm =  TRUE)
median_missing
```

**결과 :** 

```{}
##     Age    Fare 
## 27.0000 14.4542 
```



```{r}
df_titanic_replace <- df_titanic %>%
            mutate(replace_median_age  = ifelse(is.na(Age), median_missing[1], Age), 
            replace_median_fare = ifelse(is.na(Fare), median_missing[2], Fare))
tail(df_titanic_replace)
```

**결과 :  **

![cap004](C:\Users\Kim_DaeHo\Pictures\cap004.png)



**단계 5)** 빅 데이터 세트는 많은 결측치를 가질 수 있고 위의 방법은 번거로울 수 있다. 우리는 `sapply()` 함수를 사용하는 한 줄의 코드로 위의 모든 단계를 실행할 수 있다. 비록 우리가 평균과 중앙값을 알지는 못하겠지만.

sapply는 데이터 프레임을 생성하지 않기 때문에 `sapply()` 함수를 `data.frame()`으로 변환하여 데이터 프레임 객체를 만들 수 있다.

```
# Quick code to replace missing values with the mean
df_titanic_impute_mean <- data.frame (
     								sapply(
        							df_titanic,
        							function(x) ifelse(is.na(x),
            									mean(x, na.rm = TRUE),
           							x)))
tail(df_titanic_impute_mean)
```

**결과 :  **

![cap005](C:\Users\Kim_DaeHo\Pictures\cap005.png)



## Summary

결측치를 처리하는 데에는 3 가지 방법이 있다.

- 모든 결측치를 제거
- 평균으로 대체
- 중앙값으로 대체

다음의 표는 모든 관측치를 제거하는 방법을 요약하고 있다.

| 라이브러리 | 목적             | 코드                                |
| :--------- | :--------------- | :---------------------------------- |
| base       | 결측치 나열      | `colnames(df)[apply(df, 2, anyNA)]` |
| dplyr      | 모든 결측치 제거 | `na.omit(df)`                       |



평균 또는 중앙값으로 대체하는 데에는 두 가지 방법이 있다.

- `apply()` 함수 사용
- `sapply()` 함수 사용

| Method                 | Details                                                      | Advantages                | Disadvantages                                               |
| :--------------------- | :----------------------------------------------------------- | :------------------------ | :---------------------------------------------------------- |
| apply()로 <br />단계별 | 결측치 열 확인, 평균/중앙값 계산, <br />그 값들 저장, mutate() 를 이용하여 대체 | 평균/중앙값을 알 수 있다. | 실행시간이 많이 걸림.<br />빅 데이터 세트에는 느릴 수 있다. |
| sapply() 로 한번에     | sapply() 와 data.frame()을 이용하여 <br />자동으로 결측치를 검색하고 평균/중앙값으로 대체 | 짧은 코드와 빠름          | 대체 값을 모른다.                                           |



 