# ggplot2를 이용한 산포도 작성 (예제 포함)



그래프는 데이터 분석 과정의 세 번째 부분이다. 첫 번째 부분은 **데이터 추출(data extraction)**에 관한 것으로, 두 번째 부분은 **클린징(cleansing)과 데이터 조작(data manipulation)**을 다룬다. 마지막으로 데이터 과학자는 자신의 **결과를 그래픽으로 전달(시각화 : visualization)**해야 하는 것이다.

데이터 과학자의 일은 다음 그림에서 검토될 수 있다.

- 데이터 과학자의 첫 번째 과제는 연구 문제를 정의하는 것이다. 이 연구 문제는 프로젝트의 목적과 목표에 달려 있다.
- 그 이후에 가장 눈에 띄는 업무 중 하나가 바로 '피쳐 엔지니어링(feature engineering)'이다. 데이터 과학자가 데이터를 수집하여, 조작하고 정리해야 한다.
- 이 단계가 완료되면 데이터 세트의 탐색을 시작할 수 있다. 때로는 새로운 발견에 따라 인해 원래의 가설을 다듬고 변화시킬 필요가 있다.  

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot1.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot1.png)



- **설명 분석(explanatory analysis)**이 끝나면, 데이터 과학자는 **기본적인 개념과 모델을 ** 이해할 수 있는 독자의 능력을 고려해야 한다.
- 그의 결과는 모든 이해관계자가 이해할 수 있는 형식으로 제시되어야 한다. 결과를 **전달**하는 가장 좋은 방법 중 하나는 **그래프**를 통한 것이다.
- 그래프는 복잡한 분석을 단순화할 수 있는 유용한 도구이다.

이 튜토리얼에서, 다음에 대하여 학습한다.

- [ggplot2 패키지](./r-scatter-plot-ggplot2_kr.html#1)
- [산포도](./r-scatter-plot-ggplot2_kr.html#2)
- [축 변경](./r-scatter-plot-ggplot2_kr.html#3)
- [산포도 with fitted values](./r-scatter-plot-ggplot2_kr.html#4)
- [그래프에 정보 추가](./r-scatter-plot-ggplot2_kr.html#5)
- [x축과 y축의 제목 설정](./r-scatter-plot-ggplot2_kr.html#6)
- [척도 제어](./r-scatter-plot-ggplot2_kr.html#7)
- [테마](./r-scatter-plot-ggplot2_kr.html#8)
- [그래프 저장](./r-scatter-plot-ggplot2_kr.html#9)



## ggplot2 패키지

튜토리얼의 이 부분은 R로 그래프/차트를 만드는 방법에 초점을 맞춘다.

이 튜토리얼에서는 `ggplot2` 패키지를 사용할 것이다. 이 패키지는 2005년 Wilkinson에 의해 쓰여진 '그래픽의 문법(Grammar of Graphics)'의 일관된 기초 위에 만들어졌으며, `ggplot2`는 매우 유연하며, 많은 주제와 플롯 사양을 높은 추상화 수준에서 통합한다. `ggplot2`로는 3차원 그래픽과 인터랙티브 그래픽을 만들 수는 없다.  

ggplot2에서 그래프는 다음과 같은 인수로 구성된다.

- 데이터
- 미적 매핑
- 기하학적 오브젝트
- 통계적 변환
- 척도
- 좌표
- 위치 조정
- faceting



당신은 튜토리얼에서 그러한 인수들을 제어하는 방법을 배우게 될 것이다.

`ggplot2`의 기본 구문은 다음과 같다.

```
ggplot(data, mapping=aes()) +
geometric object 
```

**인수 :** 

- data : 그래픽 작성을 위해 사용되는 데이터 세트
- mapping : x와 y축 제어
- geometric object : 보여주고 싶은 그래픽 유형. 가장 일반적인 유형은 다음과 같다 :
  - 점(Point) : `geom_point()` 
  - 막대(Bar) : `geom_bar()`
  - 선(Line) : `geom_line()` 
  - 히스토그램(Histogram) : `geom_histogram()`



## 산포도

ggplot이 mtcar 데이터 세트에서 어떻게 작동하는지 확인해 보자. 먼저 mpg 변수와 drat 변수의 산포도를 작성하기로 한다.



### 기본 산포도

```
library(ggplot2)
ggplot(mtcars, aes(x = drat, y = mpg)) +
    geom_point()
```

**코드 설명 :**

- 먼저 데이터 집합 `mtcars`를 ggplot에 전달한다.
- aes() 함수의 인수 안에 x축과 y축을 추가한다.
- `+` 기호는 R의 코드가 계속 이어짐을 의미한다. 그것은 코드를 분할해서 더 읽기 쉽게 만든다.
- 기하학적 오브젝트로 geom_point()를 사용한다.

**결과 :**

![1569663167066](C:\Users\Kim_DaeHo\AppData\Roaming\Typora\typora-user-images\1569663167066.png)



### 그룹별 산포도

때로는 데이터 그룹(즉, factor 수준 데이터)에 의해 값들을 구별하는 것이 흥미로울 수 있다.

```
ggplot(mtcars, aes(x = mpg, y = drat)) +
    geom_point(aes(color = factor(gear)))
```

**코드 설명 :**

- geom_point() 내부의 aes()는 그룹의 색깔을 조절한다. 집단은 factor 변수가 되어야 한다. 따라서 변수 `gear`는 factor 타입으로 변환한다.
- aes(color = factor(gear)) 점들의 색을 바꾸는 코드이다.

**결과 :**

![1569663508759](C:\Users\Kim_DaeHo\AppData\Roaming\Typora\typora-user-images\1569663508759.png)



## 축 변경

데이터의 척도 변경은 이터 과학자의 업무에서 큰 부분을 차지한다. 드물게 데이터는 멋진 종 모양으로 나온다. 데이터를 특이치(outlier)에 덜 민감하게 만드는 한 가지 해결책은 데이터의 크기를 다시 조정하는 것이다.

```
ggplot(mtcars, aes(x = log(mpg), y = log(drat))) +
    geom_point(aes(color = factor(gear)))
```

**코드 설명 :**

- aes() 매핑 안에서 log() 함수를 이용하여 직접 x와 y 변수를 변환한다.

**주의 :** 다른 변환은 표준화(standardization)와 정규화(normalization) 등을 적용할 수 있다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot4.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot4.png)



## 예측 값(fitted value)의 산포도

그래프에 다른 수준의 정보를 추가할 수 있다. 선형 회귀 분석에 의한 예측값(fitted value)을 표시할 수 있다.

```
my_graph <- ggplot(mtcars, aes(x = log(mpg), y = log(drat))) +
    geom_point(aes(color = factor(gear))) +
    stat_smooth(method = "lm",
        col = "#C42126",
        se = FALSE,
        size = 1)
my_graph
```

**코드 설명 :**

- my_graph : ggplot()과 geom_point(), 그리고 stat_smooth() 함수의 정보를 my_graph 변수에 저장한다. 나중에 사용하는데 유용하고 또는 복잡한 코드을 피하게 해준다.
- stat_smooth() 함수의 인수는 평활 방법(the smoothing method)을 제어한다.
- method = "lm" : 선형 회귀분석
- col = "#C42126" : 선의 색깔을 빨강색으로 정한다.
- se = FALSE : 표준 에러를 출력하지 않는다.
- size = 1: 선의 크기는 1

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot5.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot5.png)

주의 : 이용가능한 평활 방법은 다음과 같다.

- glm
- gam
- loess : default value
- rim



## 그래프에 정보 추가

지금까지 그래프에 정보를 추가하지 않았다. 그래프는 많은 정보를 담고 있어야 한다. 독자는 추가 문서를 참조하지 않고 그래프를 보는 것만으로도 데이터 분석 뒤에 숨어있는 스토리를 보아야 한다. 따라서 그래프는 좋은 라벨을 필요로 한다. lab() 함수를 사용하여 라벨을 추가할 수 있다.

lab() 함수의 기본 구문은 다음과 같다 :

```
lab(title = "Hello Guru99")	
```

**인수 :**

- title : 제목 제어. 제목을 변경하거나 추가할 수 있다.

- subtitle : 제목 밑에 부제를 추가

- caption : 그래프 밑에 그래프 설명 추가	

- x : x-축 제목			

- y : y-축 제목

  예제 : lab(title = "Hello Guru99", subtitle = "My first plot")



### 제목 추가

추가해야 할 하나의 필수 정보는 분명히 **제목(title)**이다.

```
my_graph +
    labs(
        title = "Plot Mile per hours and drat, in log"
         )
```

**코드 설명 :**

- my_graph : 저장하는 그래프. 그래프에 새 정보를 추가할 때모든 코드의 작성을 불필요하게 한다.
- lab()안에 title을 기입한다.

- 선의 빨간 색 코드
- se = FALSE : 표준 에러는 표시하지 않는다.
- size = 1: 선의 크기는 1

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot6.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot6.png)



### 동적 이름을 갖는 제목 추가

동적 제목(dynamic title)은 제목에 더 정확한 정보를 추가하는 데 도움이 된다.

정적 텍스트(static text)와 동적 텍스트(dynamic text)를 출력할 paste() 함수를 사용할 수 있다. paste()의 기본 구문은 다음과 같다.

```
paste("This is a text", A)
```

**인수 :**

- " " : 인용부호 안의 텍스트는 정적 텍스트이다.
- A : A에 저장된 변수를 표시

  **주의 :** 원하는 만큼의 정적 텍스트와 변수를 추가할 수 있다. 그것들은 컴마(,)로 구분해야 한다.

**예제 :**

```
A <-2010
paste("The first year is", A)
```

**결과 :**

```
## [1] "The first year is 2010"
```



```{r}
B <-2018
paste("The first year is", A, "and the last year is", B)
```

**결과 :**

```
## [1] "The first year is 2010 and the last year is 2018"	
```



이제 우리의 그래프에 동적 이름, 즉 `mpg`의 평균을 추가할 수 있다.

```
mean_mpg <- mean(mtcars$mpg)
my_graph + labs(
    title = paste("Plot Mile per hours and drat, in log. Average mpg is", mean_mpg)
)
```

**코드 설명 :**

- manage_mpg 변수에 저장되는 mean(mtcars$mpg)을 사용하여 mpg 평균을 생성
- mane_mpg와 paste()를 사용하여 mpg의 평균값을 반환하는 동적 제목 생성

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot7.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot7.png)



### 부제목 추가

두 가지 추가 세부 사항이 그래프를 더 명확하게 만들 수 있다. 부제목(subtitle)과 캡션(caption)을 말하고 있는 것이다. 부제목(subtitle)은 제목(title) 바로 아래에 있다. 캡션(caption)은 누가 계산을 했는지 그리고 데이터의 출처에 대하여 알려줄 수 있다.

```
my_graph +
    labs(
        title =
        "Relation between Mile per hours and drat",
        subtitle =
        "Relationship break down by gear class",
        caption = "Authors own computation"
    )
```

**코드 설명 :**

- lab() 안에 다음의 것들을 추가할 수 있다 :
  - title = "Relation between Mile per hours and drat": 제목 추가
  - subtitle = "Relationship break down by gear class": 부제목 추가
  - caption = "Authors own computation: 캡션 추가
  - 각각의 새 정보들은 컴마(`,`)로 구분한다.
- **주의 :** 코드의 줄을 분리하라. 필수는 아니지만 코드를 좀 더 쉽게 이해할 수 있게 해준다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot8.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot8.png)



## x축과 y축의 제목 설정

데이터 세트에 있는 변수 자체는 항상 명시적이지 않으며 또는 복수의 단어(예: GDP_CAP)가 있는 경우 관례상 _를 이용한다. 당신은 그런 이름이 당신의 그래프에 나타나기를 원하지 않는다. 이름을 변경하거나 단위와 같은 세부사항을 추가하는 것이 중요하다.

```
my_graph +
    labs(
        x = "Drat definition",
        y = "Mile per hours",
        color = "Gear",
        title = "Relation between Mile per hours and drat",
        subtitle = "Relationship break down by gear class",
        caption = "Authors own computation"
    )
```

**코드 설명 :**

- lab() 안에 다음을 추가할 수 있다.
  - x = "Drat definition" : x축의 이름 변경
  - y = "Mile per hours" : y축의 이름 변경

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot9.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot9.png)



## 척도의 제어

축의 척도를 조절할 수 있다.

seq() 함수는 연속된 숫자(수열, sequence)를 만들 필요가 있을 때 편리하다. 기본 구문은 다음과 같다 :

```
seq(begin, last, by = x)
```

**인수 :**

- begin : 수열의 첫 수
- last : 수열의 마지막 수
- by= x : 단계. 예를 들어, x가 2이면, 코드는 last가 될 때까지 begin에 2를 더해 간다.



예를 들어, 0에서 12까지 4을 단계로 하는 범위를 생성하고자 한다면,  0, 4, 8, 12 등의 네 개의 숫자가 생성될 것이다.

```
seq(0, 12, 4)
```

**결과 :**

```
## [1]  0  4  8 12	
```



여러분은 x-축과 y-축의 척도를 다음과 같이 제어할 수 있다.

```
my_graph +
    scale_x_continuous(breaks = seq(1, 3.6, by = 0.2)) +
    scale_y_continuous(breaks = seq(1, 1.6, by = 0.1)) +
    labs(
        x = "Drat definition",
        y = "Mile per hours",
        color = "Gear",
        title = "Relation between Mile per hours and drat",
        subtitle = "Relationship break down by gear class",
        caption = "Authors own computation"
    )
```

**코드 설명 :**

- scale_y_continuous() 함수는 **y-축**을 제어한다.
- scale_x_continuous() 함수는 **x-축**을 제어한다..
- 파라미터 브레이크가 축의 분할이 제어된다. 수열을 수동으로 추가하거나 seq() 함수를 사용할 수 있다.

  - seq(1, 3.6, by = 0.2) : 0.2단계로 1부터 3.6까지의  14개의 숫자 생성
  - seq(1, 1.6, by = 0.1): 0.1단계로 1에서 1.6까지 7개의 숫자 생성

**결과 : **

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot10.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot10.png)



## 테마

마지막으로, R은 우리가 다양한 테마로 플롯을 커스터마이징할 수 있게 해준다. `ggplot2` 라이브러리에는 다음과 같은 8가지 테마가 포함되어 있다 :

- theme_bw()
- theme_light()
- theme_classis()
- theme_linedraw()
- theme_dark()
- theme_minimal()
- theme_gray()
- theme_void()

```
my_graph +
    theme_dark() +
    labs(
        x = "Drat definition, in log",
        y = "Mile per hours, in log",
        color = "Gear",
        title = "Relation between Mile per hours and drat",
        subtitle = "Relationship break down by gear class",
        caption = "Authors own computation"
    )
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot11.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot11.png)



## 그래프 저장

이 모든 단계를 거쳐, 그래프를 저장하고 공유할 시간이다. 그래프를 그린 직후 ggsave('FILE의 이름')를 추가하면 하드 드라이브에 저장된다.

그래프는 작업 디렉토리에 저장된다. 작업 디렉토리를 확인하려면 다음 코드를 실행한다 :

```
directory <-getwd()
directory		
```

환상적인 그래프를 그려보고, 저장하고, 위치를 확인해보자

```
my_graph +
    theme_dark() +
    labs(
        x = "Drat definition, in log",
        y = "Mile per hours, in log",
        color = "Gear",
        title = "Relation between Mile per hours and drat",
        subtitle = "Relationship break down by gear class",
        caption = "Authors own computation"
    )
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot12.png)](https://www.guru99.com/images/r_programming/032918_0732_Scatterplot12.png)

```
ggsave("my_fantastic_plot.png")
```

**Output:**

```
## Saving 5 x 4 in image
```

**주의 :** 교육적 목적으로만, 우리는 당신을 위해 디렉토리 폴더를 열기 위한 `open_folder()`라는 함수를 만들었다. 아래 코드를 실행하여 사진이 저장되어 있는 위치를 확인하고, `my_fantastic_plot.png` 파일 이름을 확인하십시오.

```
# Run this code to create the
function
open_folder <- function(dir) {
    if (.Platform['OS.type'] == "windows") {
        shell.exec(dir)
    } else {
        system(paste(Sys.getenv("R_BROWSER"), dir))
    }
}

# Call the function to open the folder open_folder(directory)
```



## 요약

아래 표에 산포도를 작성하기 위한 인수를 요약한다 :

| 목적             | 코드                                                         |
| :--------------- | :----------------------------------------------------------- |
| 기본 산포도      | `ggplot(df, aes(x = x1, y = y)) + geom_point()`              |
| 컬러 그룹 산포도 | `ggplot(df, aes(x = x1, y = y)) +<br /> geom_point(aes(color = factor(x1)) + stat_smooth(method = "lm")` |
| 예측치 추가      | `ggplot(df, aes(x = x1, y = y)) + geom_point(aes(color = factor(x1))` |
| 제목 추가        | `ggplot(df, aes(x = x1, y = y)) + <br />geom_point() + <br />labs(title = paste("Hello Guru99"))` |
| 부제목 추가      | `ggplot(df, aes(x = x1, y = y)) + <br />geom_point() + labs(subtitle = paste("Hello Guru99"))` |
| x축 재설정       | `ggplot(df, aes(x = x1, y = y)) + geom_point() + labs(x = "X1")` |
| y축 재설정       | `ggplot(df, aes(x = x1, y = y)) + geom_point() + labs(y = "y1")` |
| 척도의 제어      | `ggplot(df, aes(x = x1, y = y)) + <br />geom_point() + <br />scale_y_continuous(breaks = seq(10, 35, by = 10)) + <br />scale_x_continuous(breaks = seq(2, 5, by = 1)` |
| log 생성         | `ggplot(df, aes(x =log(x1), y = log(y))) + geom_point()`     |
| 테마             | `ggplot(df, aes(x = x1, y = y)) + geom_point() + <br />theme_classic()` |
| 저장             | `ggsave("my_fantastic_plot.png")`                            |

 