# 데이터 타입, 산술과 논리 연산자 (예제 포함)



이 튜토리얼에서는 다음에 대하여 학습한다.

- [기본 데이터 타입](./r-data-types-operator_kr.html#1)
- [변수](./r-data-types-operator_kr.html#2)
- [벡터](./r-data-types-operator_kr.html#3)
- [산술 연산자](./r-data-types-operator_kr.html#4)
- [논리 연산자](./r-data-types-operator_kr.html#5)



## 기본 데이터 타입

R 프로그래밍은 다음과 같은 다양한 데이터 타입을 처리한다: 

- 스칼라 (Scalars)
- 벡터 (수치, 문자, 논리)
- 행렬 (Matrices)
- 데이터 프레임 (Data frames)
- 리스트 (Lists)



**기본 타입**

- 4.5 **수치(numerics)**라 불리는 십진수이다.
- 4는 **정수**(**integers**)라 불리는 자연수이다. 정수도 숫자이다.
- `TRUE` 또는 `FALSE` 는 **논리**(**logical**)라 불리는 불리안 값(Boolean value)이다.
-  `" "`나 `' '`안에 있는 값은 텍스트(문자열)이다. 이것들도 문자(**characters**)라 불린다.



우리는 class 함수를 이용하여 변수의 타입을 확인할 수 있다.

**예제 1:**

```
# Declare variables of different types
# Numeric
x <- 28
class(x)
```

결과:

```
## [1] "numeric"
```

**예제 2:**

```
# String
y <- "R is Fantastic"
class(y)
```

결과:

```
## [1] "character"
```

**예제 3:**

```
# Boolean
z <- TRUE
class(z)
```

결과:

```
## [1] "logical"
```



## 변수

변수는 데이터를 저장하고 특히 데이터 과학자들에게는 중요한 구성요소이다. 하나의 변수는 하나의 숫자, 오브젝트, 통계 결과, 벡터, 데이터 세트, 그리고 기본적으로 R이 출력하는 모델 예측치 등을 저장할 수 있다. 우리는 단순히 변수명을 호출함으로써 나중에 그 변수를 사용할 수 있다.

변수를 선언하기 위해서는 변수의 이름을 지정해야 한다. 변수 이름은 공란이 있어서는 안된다. 단어를 연결하기 위해 `_`를 사용할 수 있다.

변수에 데이터를 저장하기 위해 `<-` 또는 `=`를 사용한다.

여기에 사용방법이 있다:

```
# First way to declare a variable:  use the `<-`
name_of_variable <- value
# Second way to declare a variable:  use the `=`
name_of_variable = value
```

command 라인에서 우리는 다음과 같이 어떠한 일이 벌어지는지 알아보기 위해 다음의 코드를 작성할 수 있다:

**예제 1:**

```
# Print variable x
x <- 42
x
```

결과:

```
## [1] 42
```



**예제 2:**

```
y  <- 10
y
```

결과:

```
## [1] 10
```



**예제 3:**

```
# We call x and y and apply a subtraction
x-y
```

결과:

```
## [1] 32
```



## 벡터

벡터(vector)는 일차원 배열(array)이다. 우리는 앞에서 배운 모든 기본 데이터를 이용하여 벡터를 생성할 수 있다. R에서 벡서를 만드는 가장 간단한 방법은  c( ) 함수를 사용하는 것이다.

**예제 1:**

```
# Numerical
vec_num <- c(1, 10, 49)
vec_num
```

결과:

```
## [1]  1 10 49
```



**예제 2:**

```
# Character 
vec_chr <- c("a", "b", "c")
vec_chr
```

결과:

```
## [1] "a" "b" "c"
```



**예제 3:**

```
# Boolean 
vec_bool <-  c(TRUE, FALSE, TRUE)
vec_bool
```

결과:

```
##[1] TRUE FALSE TRUE
```

우리는 벡터의 산술 연산을 수행할 수 있다.



**예제 4:**

```
# Create the vectors
vect_1 <- c(1, 3, 5)
vect_2 <- c(2, 4, 6)
# Take the sum of A_vector and B_vector
sum_vect <- vect_1 + vect_2
# Print out total_vector
sum_vect
```

결과:

```
[1]  3  7 11
```



**예제 5:**

R에서는 벡터를 잘라낼 수 있다. 어떤 경우에는 벡터의 첫 다섯 행만 관심이 있을 수 있다. 그런 경우 1에서 5까지의 값을 추출하기 위해 우리는 [1:5] 명령을 사용할 수 있다.

```
# Slice the first five rows of the vector
slice_vector <- c(1,2,3,4,5,6,7,8,9,10)
slice_vector[1:5]
```

결과:

```
## [1] 1 2 3 4 5
```



**예제 6:**

값의 범위를 생성하는 가장 간단한 방법은 두 개의 수 사이에 `:`를 사용하는 것이다. 예를 들어, 위의 예에서와 같이 우리는 1부터 10까지의 숫자 벡터를 생성하기 위해 `c(1:10)` 또는 `1:10`이라고 작성할 수 있다.

The shortest way to create a range of value is to use the: between two numbers. For instance, from the above example, we can write c(1:10) to create a vector of value from one to ten.

```
# Faster way to create adjacent values
c(1:10)
# or
1:10
```

결과:

```
## [1]  1  2  3  4  5  6  7  8  9 10
```



## 산술 연산자

먼저 R에서 사용되는 기본적인 산술 연산자를 살펴볼 것이다. 

| 연산자  | 설명                 |
| :------ | :------------------- |
| +       | 덧셈(Addition)       |
| -       | 뺄셈(Subtraction)    |
| *       | 곱셈(Multiplication) |
| /       | 나눗셈(Division)     |
| ^ or ** | 제곱(Exponentiation) |



**예제 1:**

```
# An addition
3 + 4
```

결과:

```
## [1] 7
```



여러분은 R 코드를 Rstudio Console에 쉽게 복사해서 붙여 넣기할 수 있다. **결과**는 `#` 기호 다음에 표시가 된다. 예 들어, `print('Guru99')`라고 코드를 작성하면 결과는 `## [1] Guru99`가 될 것이다.

`##` 는 결과를 프린트하는 것을 그리고 대괄호(`[ ]`) 안의 숫자는 출력물의 갯수를 의미한다.

 `#` 로 시작하는 문장은 **주석(annotation)**이다. R 스크립트 내에 우리가 원하는 주석(설명)을 추가하기 위해 `#`를 사용할 수 있다. R은 실행하는 동안 그 이하의 문장을 읽지 않을 것이다.



**예제 2:**

```
# A multiplication
3*5
```

결과:

```
## [1] 15
```



**예제 3:**

```
# A division
(5+5)/2
```

결과:

```
## [1] 5
```



**예제 4:**

```
# Exponentiation
2^5
# or
2**5
```

결과:

```
## [1] 32
```



**예제 5:**

```
# Modulo : %% (나머지)
27%%6
```

Output:

```
## [1] 3
```



**예제 6:**

```
# Quotient : %/% (몫)
27%/%6
```

Output:

```
## [1] 4
```



## 논리 연산자

논리 연산자를 가지고 논리 조건식에 기반하여 벡터 내의 값들을 반환하고자 한다. 다음은 R에서 사용할 수 있는 논리 연산자의 상세 목록이다.

| 연산자    | 설명          |
| --------- | ------------- |
| <         | 작다          |
| <=        | 작거나 같다   |
| >         | 크다          |
| >=        | 크거나 같다   |
| ==        | 같다          |
| !=        | 다른다        |
| !x        | not x         |
| x         | x             |
| x\|y      | 논리합 (or)   |
| x&y       | 논리곱 (and)  |
| isTRUE(x) | x가 TRUE인가? |



R에서의 논리문은 대괄호(`[ ]`) 안에 둘러 싸여 있다. 우리가 원하는 만큼의 조건 문장을 추가할 수 있지만 그 조건들을 괄호(`()`)안에 포함시켜야 한다. 우리는 조건문을 생성하기 위해 다음의 구조를 따를 수 있다:

```
variable_name[(conditional_statement)]
```

변수(variable)를 참조하는 변수명(variable_name)을 가지고 우리는 문장에 사용하고자 한다. 우리는 `variable_name > 0` 같은 논리 문장을 생성한다.  끝으로, 논리문을 종료하기 위해 대괄호(`[ ]`)를 사용한다. 아래에 논리문의 예가 있다.

**예제 1:**

```
# Create a vector from 1 to 10
logical_vector <- 1:10

# logical statement
logical_vector > 5
```

결과:

```
## [1]FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE
```



위의 결과에서 R은 벡터 내의 각각의 요소를 읽고 그것을 `logical_vector > 5`와 비교한다. 만일 벡터의 원소 값이 5보다 크면 조건은 `TRUE`이고, 그렇지 않으면 `FALSE`이다. 즉 R은 `TRUE`와 `FALSE`로 구성된 벡터를 출력한다.



**예제 2:**

아래의 예에서 우리는 '5보다 큰' 조건을 만족하는 값들만을 추출하고자 한다. 이를 위해, 우리는 값을 포함하는 벡터 다음의 대괄호 안에 조건을 삽입할 수 있다.

```
# Print value strictly above 5
logical_vector[(logical_vector>5)]
```

결과:

```
## [1]  6  7  8  9 10
```



**예제 3:**

```
# Print 5 and 6
logical_vector <- 1:10
logical_vector[(logical_vector>4) & (logical_vector<7)]
```

결과:

```
## [1] 5 6
```

 