# 막대 그래프와 히스토그램 (예제 포함)



막대 그래프는 x축에 범주형 변수를 표시하는 좋은 방법이다. 이 유형의 그래프는 Y축에 두 가지 측면을 나타낸다.

1. 집단 간의 발생 횟수
2. 변수의 요약 통계치(최소, 최대, 평균 등)

다음 변수를 가지고 있는 `mtcar` 데이터 세트를 사용할 것이다.

- cyl : 차의 실린더 수. (수치 변수)
- am : 변속기의 종류. 자동의 경우 0, 수동의 경우 1. (수치 변수)
- mpg : 갤런당 마일 수. (수치 변수)



이 튜토리얼에서는 다음에 대하여 학습한다 :

- [막대 그래프 작성법](./r-bar-chart-histogram_kr.html#1)
- [막대 색의 변경](./r-bar-chart-histogram_kr.html#2)
- [색상 강도의 변경](./r-bar-chart-histogram_kr.html#3)
- [그룹 별 색](https://www.guru99.com/r-bar-chart-histogram.html#4)
- [막대에 그룹 추가](https://www.guru99.com/r-bar-chart-histogram.html#5)
- [상대빈도 막대 그래프](./r-bar-chart-histogram_kr.html#6)
- [가로형 막대 그래프](./r-bar-chart-histogram_kr.html#7)
- [히스토그램](https://www.guru99.com/r-bar-chart-histogram.html#8)



## 막대 그래프 작성법

R로 그래프를 작성하려면 ggplot 라이브러리를 사용할 수 있다. 이 라이브러리의 기본 구문은 다음과 같다 :

```
ggplot(data, mapping = aes()) +
geometric_object 
```

**인수 :**

- data : 그래프 작성에 사용되는 데이터 세트
- mapping : x-축과 y-축 제어
- geometric object : 작성할 그래프 종류. 가장 일반적인 오브젝트는 다음과 같다 :
  - 점 : `geom_point()`
  - 막대 : `geom_bar()`
  - 선 : `geom_line()`
  - 히스토그램 : `geom_histogram()` 

이 튜토리얼에서는 막대 그래프를 작성하는 `geom_bar()`를 살펴보겠다.



## 막대 그래프 : 빈도

첫 번째 그래프는 `geom_bar()`로 실린더의 빈도수를 보여준다. 아래의 코드는 가장 기본적인 구문이다.

```
library(ggplot2)
# Most basic bar chart
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()
```

**코드 설명 :**

- 데이터 세트 `mtcar`를 ggplot에 전달한다.
- aes() 인수 내에서 x-축을 factor 변수(`cyl`)로 추가
- `+`기호는 R이 코드를 계속 읽기를 원한다는 것을 의미한다. 그것은 코드를 분할해서 더 읽기 쉽게 만든다.
- 기하 오브젝트로 `geom_bar()`를 사용한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis1.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis1.png)

**주의** : 변수를 factor 타입으로 변환하는지 확인하라. 그렇지 않으면 R은 변수를 숫자로 처리한다. 아래의 예를 참조하라.

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis2.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis2.png)



## 그래프의 사용자 지정

네 갱의 인수가 그래프의 사용자 지정을 위해 이용된다 :



### 막대 색의 변경

막대의 색을 바꿀 수 있다. 막대의 색은 모두 비슷하다는 점에 유의하라.

```
# Change the color of the bars
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar(fill = "coral") +
    theme_classic()
```

**코드 설명 :**

- 막대의 색상은 기하 오브젝트(즉, `ggplot()`이 아님) 내의 `aes()` 매핑에 의해 제어된다. `fill` 인수에 따라 색을 변경할 수 있다. 여기서 산호색(`coral`)을 선택한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis3.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis3.png)

다음의 코드를 사용할 수 있다.

```
grDevices::colors()		
```

R에서 이용가능한 모든 색상을 볼 수 있다. 거의 650개의 색상이 있다.



### 색상 강도의 변경

막대 색의 강도를 증가시키고 감소시킬 수 있다.

```
# Change intensity
ggplot(mtcars,
        aes(factor(cyl))) +
    geom_bar(fill = "coral",
        alpha = 0.5) +
    theme_classic()
```

**코드 설명 :**

- 막대 색의 강도를 높이거나 낮추려면 알파 값(alpha)을 변경하면 된다. 큰 알파는 강도를 높이고, 낮은 알파는 강도를 감소시킨다. 알파 범위는 0부터 1까지입니다. 만약 1이면, 색상은 팔레트와 같다. 만약 0이면, 색깔은 흰색이다. 알파 = 0.1을 선택한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis4.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis4.png)



### 그룹 별 색

You can change the colors of the bars, meaning one different color for each group. For instance, cyl variable has three levels, then you can plot the bar chart with three colors.

각 그룹별로 서로 다른 색을 적용할 수 있다. 예를 들어, `cyl` 변수는 세 가지 수준이 있으며, 각 수준별로 세 가지 색상으로 막대 그래프를 그릴 수 있다.

```
# Color by group
ggplot(mtcars, aes(factor(cyl),
        fill = factor(cyl))) +
    geom_bar()
```

**코드 설명 :**

- `fill` 인수가 aes() 안에서 바의 색상을 바꿀 수 있다. `fill = x축 변수`를 설정하여 색상을 변경한다. 예제에서는 x-축 변수로  `cyl`,  `fill = factor(cyl)`로 설정한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis5.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis5.png)



### 막대에 그룹 추가

다른 factor 수준에 따라 y-축을 더 분할할 수 있다. 예를 들어, 실린더 타입(`cyl`)에 따라 자동 및 수동 변속기(`transmission`)의 수를 셀 수 있다.

다음과 같이 진행해 나간다.

- 1단계 : `mtcar` 데이터 세트를 사용하여 데이터 프레임 생성

- 2단계 : `am` 변수에 대해 자동 변속기의 경우 `auto`, 수동 변속기의 경우 `man`으로 표시한다. `ggplot()` 함수에 `factor()` 함수를 사용할 필요가 없도록 `am`과 `cyl` 을 factor 타입으로 변환한다.
- 3단계: 실린더별(`cyl`) 변속기 종류(`am`)의 빈도수를 막대 그래프로 그린다.

```
# Add a group in the bars
library(dplyr)
# Step 1
data <- mtcars %>% 
#Step 2
mutate(am = factor(am, labels = c("auto", "man")),
    cyl = factor(cyl))
```

이제 데이터 세트가 준비되었으므로 그래프를 작성한다.

```
# Step 3
ggplot(data, aes(x = cyl, fill = am)) +
    geom_bar() +
    theme_classic()
```

**코드 설명 :**

- ggpplot()에는 데이터 세트와 aes()를 포함한다.
- aes()에 변수 x-축과 막대를 채울 변수(즉, `am`)를 지정.
- geom_bar(): 막대 그래프 작성

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis6.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis6.png)

맵핑은 각 수준별별로 두 가지 색으로 막대를 채울 것이다. 데이터 세트에 있는 다른 factor 변수를 선택하여 그룹을 쉽게 변경할 수 있다.



### 상대 빈도(%) 막대 그래프

빈도수 대신에 상대빈도로 막대 그래프를 작성할 수 있다.

```
# Bar chart in percentage
ggplot(data, aes(x = cyl, fill = am)) +
    geom_bar(position = "fill") +
    theme_classic()
```

**코드 설명 :**

- `geom_bar()` 인수에 `position = "fill"`을 사용하여 y-축에 백분율로 그래픽을 생성할 수 있다. 

  (**주의 :** y-축의 척도가 0 ~ 1의 범위로 변경됨)

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis7.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis7.png)



### 가로형(Side by side) 막대 그래프

그룹 변수를 갖는 막대 그래프는 세로형 막대 그래프로 표시가 되는데, 이것을 가로형으로 작성할 수 있다.

```
# Bar chart side by side
ggplot(data, aes(x = cyl, fill = am)) +
    geom_bar(position = position_dodge()) +
    theme_classic()
```

**코드 설명 :**

- `position=position_dodge()`: 막대 배열 방법을 명시적으로 지정

**Output :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis8.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis8.png)

## 히스토그램

막대 그래프 튜토리얼의 두 번째 부분에서는 변수의 값들로 그룹을 y-축에 표시할 수 있다.

여기에서는 각 실린더 유형에 대한 갤런 당 평균 마일을 나타내는 그래프를 작성할 것이다. 유용한 그래프를 작성하기 위해 다음의 단계로 진행해 나간다.

- 1단계 : 실린더별 갤런당 평균 마일로 새 변수 생성

- 2단계 : 기본 히스토그램 작성
- 3단계 : 방향 변경
- 4단계 : 색상 변경
- 5단계 : 크기 변경
- 6단계 : 그래프에 레이블 추가



**단계 1)** 새 변수 생성

`data_histogram`이라는 데이터 프레임을 생성하여, 자동차의 실린더 수별로 갤런당 평균 마일을 반환한다. 이 새 변수를 `mean_mpg`라고 부르고, 소숫점 둘째 자리에서 반올림한다.

```
# Step 1. Create a new variable
data_histogram <- mtcars %>%
mutate(cyl = factor(cyl)) %>%
group_by(cyl) %>%
summarize(mean_mpg = round(mean(mpg), 2))
```

**단계 2) ** 기본 히스토그램 작성

히스토그램을 작성할 수 있다. 이 그래프는 완전하지는 않지만 동향에 대한 직감을 갖게 해준다.

```
# Step 2. Create a basic histogram
ggplot(data_histogram, aes(x = cyl, y = mean_mpg)) +
    geom_bar(stat = "identity")
```

**코드 설명 :**

- aes()는 이제 두 가지 변수를 가진다.  `cyl` 변수는 x-축을 가리키고, `mean_mpg`는 y축이다.
- `stat="identity"` 인수를 전달해서 y-축의 변수를 수치형으로 참조해야 한다. `geom_bar`는 `stat="bin"`을 기본값으로 사용한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis9.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis9.png)

**단계 3)** 방향 변경

수직 형태의 그래프를 수평 방향으로 변경할 수 있다.

```
# Step 3. Change the orientation
ggplot(data_histogram, aes(x = cyl, y = mean_mpg)) +
    geom_bar(stat = "identity") +
    coord_flip()
```

**코드 설명 :**

- coord_flip()으로 그래프의 방향을 제어할 수 있다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis10.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis10.png)

**단계 4)** 색상 변경

x-축 변수의 factor 수준에 따라 막대의 색상을 구분할 수 있다.

```
# Step 4. Change the color
ggplot(data_histogram, aes(x = cyl, y = mean_mpg, fill = cyl)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    theme_classic()
```

**코드 설명 :**

- `fill = cyl` 매핑을 사용하여 그룹별로 그래프를 표시할 수 있다. R은  `cyl`변수의 수준에 따라 자동으로 색상을 관리한다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis11.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis11.png)

**단계 5)** 크기 변경

그래프를 더 보기 좋게 하기 위해 막대 너비를 조절할 수 있다.

```
# Step 5. Change the size
graph <- ggplot(data_histogram, 
                aes(x = cyl, y = mean_mpg, fill = cyl)) +
         geom_bar(stat = "identity", width = 0.5) +
         coord_flip() +
         theme_classic()
graph
```

**코드 설명 :**

- `geom_bar()` 내부의 `width` 인수는 막대 크기를 제어한다. 값이 크면 폭이 넓어진다.

  **주의 :** 그래프를 `graph` 변수에 저장한다. 다음 단계는 `grapht` 변수의 코드를 변경하지 않기 때문에 그렇게 한다. 그것은 코드의 가독성을 향상시킨다.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis12.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis12.png)

**Step 6)** 그래프에 라벨 추가

마지막 단계는 mean_mpg 변수의 값을 라벨에 추가하도록 구성한다.

```
# Step 6. Add labels to the graph
graph +
    geom_text(aes(label = mean_mpg),
              hjust = 1.5,
              color = "white",
              size = 3) +
    theme_classic()
```

**코드 설명 :**

- `geom_text()` 함수는 텍스트의 미관을 제어하는 데 유용하다.
  - label = : 막대 내부에 라베 추가
  - mean_mpg : 레이블에 mean_mpg 변수 사용
- `hjust` 인수는 라벨의 위치를 제어한다. 1에 가까우면 막대의 상단에 라벨을 표시하고, 더 높은 값은 라벨을 하단으로 가져온다. 그래프의 방향이 수직이면 `vjust`로 변경한다.
- color = "white" : 텍스트 색상을 변경한다. 여기서는 흰색을 사용.
- size = 3: 텍스트 크기를 설정.

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis13.png)](https://www.guru99.com/images/r_programming/032918_0752_BarChartHis13.png)



## 요약

막대 그래프는 x-축이 범주형 변수일 때 유용하다. y-축은 빈도 또는 요약 통계치일 수 있다. 아래 표에는 `ggplot2`로 막대 그래프를 제어하는 방법이 요약되어 있다 :

| Objective                       | 코드                                                         |
| :------------------------------ | :----------------------------------------------------------- |
| Count                           | `ggplot(df, eas(x= factor(x1)) + geom_bar()`                 |
| 색상 변경                       | `ggplot(df, eas(x= factor(x1), fill = factor(x1))) + geom_bar()` |
| 그룹별 빈도, 세로형 막대 그래프 | `ggplot(df, eas(x= factor(x1), fill = factor(x2))) + geom_bar(position=position_dodge())` |
| 그룹별 빈도, 가로형 막대 그래프 | `ggplot(df, eas(x= factor(x1), fill = factor(x2))) + geom_bar()` |
| 그룹별 빈도, 상대 빈도(%)       | `ggplot(df, eas(x= factor(x1), fill = factor(x2))) + geom_bar(position=position_dodge())` |
| 값들                            | `ggplot(df, eas(x= factor(x1)+ y = x2) + geom_bar(stat="identity")` |