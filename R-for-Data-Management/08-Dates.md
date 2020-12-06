# Dates    {#dates}


```{r warning = FALSE}
library(tidyverse)
```


## R에서의 날짜 데이터   {#dates_in_R}

R에 데이터 세트에 있는 날짜 데이터가 불려오기 전에는 보통 날짜 데이터들은 문자(문자열) 값들을 가진 컬럼에 저장이 된다. 그러나 날짜 데이터들은 원래 수치 데이터이며, 문자열로 저장이 되면 아주 중요한 정보를 잃게 된다.



예를 들어, “2018년 3월 5일”에서 하루가 경과된 날을 계산하려면 다음과 같이 하면되는데, 그 결과를 에러가 날 것이다:

```{r error = TRUE}
# string dates have no numeric value, so this errors
"2018-03-05" + 1
## Error in "2018-03-05" + 1: non-numeric argument to binary operator
```


`R`에서는 이처럼 문자열로 저장된 날짜 데이터는 `R`의 `Date` 클래스로 변환해야 한다. 이 `Date` 클래스는 수치 데이터로 날짜를 보관하며, `R`에서 제공하는 다양한 날짜 관련 함수들을 활용할 수 있게 해 준다.

일단 `Date` 클래스로 변환이 되면, , 날짜에 대한 수치 값은 **January 1, 1970 (1970-01-01)** 이후의 날짜 수를 나타낸다.



### `as.Date()` 함수

`R`의 `base` 패키지는 문자열 형태의 날짜 데이터를 `Date` 클래스로 변환할 수 있는 `as.Date()` 함수를 제공한다. 그러나 사용하는데에 두 가지의 디폴트 형태(자세한 날짜 형태에 대해서는 `?srtptime`을 참고바람)로 날짜 데이터가 저장되어 있지 않다면 사용하는데 많은 어려움을 겪을 수 있다.



다음의 예를 살펴보기로 한다.

```{r}
# as.Date only accepts a couple of formats by default
# good
as.Date("2015-02-14")
```


```{r error = TRUE}
# bad
as.Date("02/14/2014")
```

```{r}
# specify a format to fix
as.Date("02/14/2014", format="%m/%d/%Y")
```

- “`2015-2-14`” 형태의 문자열에 대해서는 `Date` 클래스로 변환해 준다.
- “`02/14/2014`” 형태의 문자열은 `Date` 클래스로 변환하지 못한다.
- “`02/14/2014`” 형태의 문자열을 `Date` 클래스로 변환하기 위해서는 `format = ` 인수를 이용하여 형태를 맞춰 줘야 한다.



일단 날짜 데이터가 `Date` 클래스로 변환이 되면, 날짜 데이터에 대한 산술연산을 수행할 수 있다.

```{r}
a <- as.Date("1971-01-01")
class(a)

# days since 1970-01-01
as.numeric(a)

# date arithmetic
a <- as.Date("1970/12/31")

a + 2
```

- `a` 변수는 **`Date` 클래스**가 되었다.
- 그러면서 또한 `a` 변수는 **수치형 데이터**이다.
- 날짜의 산술연산이 가능하다. 그 결과는 **경과된 날짜 수**(`1 days`)가 된다. 
- `a + 2`는 결국 **2일이 경과된 날짜**를 확인해 준다.



이제 좀더 쉽게 문자열을 다양한 형태의 `Date` 클래스로 변환하는 방법에 대하여 살펴 보기로 한다!!!



## `lubridate` 패키지   {#dates_lubridate}

`tidyverse` 패키지는 문자열 날짜 데이터를 더 쉽게 `Date` 형식으로 변환할 수 있도록 도와주고 또 그러한 날짜형 데이터를 처리하기 위한 함수를 제공하는 `lubridate` 라는 재미있는 이름을 가진 패키지를 제공하고 있다. 

`lubridate`  패키지가 제공하는 `Date` 변환 함수는 아주 다양한 날짜 형식을 받아들이면서도, 그러한 형식에 대한 사양을 기억할 필요를 없애준다. 단지 `y`, `m`,  그리고 `d` 등의 문자를 취하고, 날짜 컬럼에 데이터를 저장할 때 이러한 문자 각각에 대하여 ‘년’, ‘월’, 그리고 ‘일’ 등의 순서를 메겨 준다. 그러한 순서가 해당 컬럼을 `Date` 로 변환하는 함수의 이름을 생성한다(예를 들어, `ymd()` 함수, `mdy()` 함수, `dmy()` 함수 등).

`lubridate` 패키지는 `tidyverse` 패키지를 설치할 때 같이 설치는 되지만, `library(tidyverse)`를 불러올 때 자동으로 불러와 지지 않는다. 따라서, 이제 이 패키지를 불러온다.

```{r}
library(lubridate)
```



### `lubridate` 패키지의 활용

`lubridate` 함수의 유연성을 보여주기 위해 먼저 다양한 날짜 형식을 가지고 있는 데이터 세트를 불어오기로 한다.

```{r}
d <- read_csv("data8/dates.csv")
d
```

- 현재, 앞의 4개 컬럼들이  `chr`, `chr`, `date`, 그리고 `dbl` 형식으로 저장이 되어 있다.
- 세 번째 컬럼은 `read_csv()` 함수로 날짜임을 알려 주는 특정한 형식으로 인해 , 사실상 `read_csv()` 함수에 의해 `Date` 형식으로 인식이 되어 있다. 
- 첫 두 개의 컬럼은 월-일-년의 형식을 사용하고 있지만,  세 번째와 네 번째 컬럼은 년-월-일 형식을 사용하고 있다. 
- 다섯 번째 컬럼의 `decision_time`은 ‘날짜-시간’  값을 포함하고 있다.

  

따라서, `mdy()` 함수와 `ymd()` 함수를 사용해 본다. 그 유연성이 놀라울 따름이다.

```{r}
# no format specifications needed
# just ordering y,m, and d
dates <- data.frame(f1=mdy(d$fmt1), f2=mdy(d$fmt2),
                    f3=ymd(d$fmt3), f4=ymd(d$fmt4))
dates
str(dates)
```

- 이제 네 개의 컬럼 모두가 같은 형식의 `Date` 클래스로 변환되었음을 알 수 있다.


## 날짜-시간 변수   {#dates_variables}

만일 날짜 컬럼이 시간 정보(예, 날짜-시간)를 추가적으로 포함하고 있다면, 문자열을 `POSIXct` 클래스로 변환하기 위해 함수 이름의 `y`, `m`, `d`에 하나 이상의 `h`, `m`, `s` 등을 추가할 수 있다. `POSIXct` 클래스는 *1970년 초를 기준으로 이후 경과된 초*에 대한 수치를 나타내는 숫자로 날짜-시간 변수를 저장한다. 

`dates` 데이터 세트의 다섯 번째 컬럼인 `decision_time`은 **날짜-시간 변수**이다(물론 `lubridate()`  함수가 무시할 `Approved/Denied` 문자열을  데이터의 앞 부분에 포함하고 있다). 구체적으로 날짜-시간은 월, 일, 년, 시, 분, 초 등으로 기록되어 있기 때문에, mdy_hms() 함수를 사용할 것이다:

```{r}
# month day year hour minute second
mdy_hms(d$decision_time)

# POSIXct is a standard way of representing calendar time
class(mdy_hms(d$decision_time))
```


표준 시간대(“time zone” standard)의 디폴트 값으로 `UTC` (Coordinated Universal Time)가 사용되었다. 시간대를 설정하기 위해서는 `tz = ` 인수를 사용한다. 유효한 시간대 사양 목록을 확인하려면 `OlsonNames()`함수를 시행하기 바란다.

```{r}
# we'll use this for our dates variable
dates$decision_time <- mdy_hms(d$decision_time, tz="US/Pacific")
dates$decision_time

# first 20 valid time zones
head(OlsonNames(),  n=20)
```


## `Date` 변수에서 정보 추출하기   {#dates_elements}

### 관련 함수

`lubridate` 패키지는 `Date` 변수로부터 특정 정보를 추출할 수 있게 해 주는 다음과 같은 함수들을 제공한다:

- `day()`: 월의 날짜
- `wday()`: 평일
- `yday()`: 년의 날짜
- `month()`: 년의 월
- `year()`: 년



### `Date` 변수의 정보 추출 예

```{r}
# we'll use the first column of our dates dataset
dates$f1

# day of the month
day(dates$f1)

# day of the year
yday(dates$f1)
```

- `dates$f1` : `dates` 데이터 세트의 `f1` 컬럼에 있는 날짜 데이터 확인
- `day(dates$f1)` : `dates` 데이터 세트의 `f1` 컬럼에 있는 날짜 데이터의 해당 월의 날짜
- `yday(dates$f1)` : `dates` 데이터 세트의 `f1` 컬럼에 있는 날짜 데이터의 해당 년도의 날짜



추가적인 예:

```{r}
# weekday as numbers
wday(dates$f1)

# weekday with labels
wday(dates$f1, label=TRUE)

# month of the year
month(dates$f1)
```

- `wday(dates$f1)` : 해당 주의 날짜 (일=`1`, 월=`2`, 화=`3`, 수=`4`, 목=`5`, 금=`6`, 토=`7`)
- `wday(dates$f1, label=TRUE)` : 해당 주의 요일
- `month(dates$f1)`: 해당 월



## 날짜-시간(`POSIXct`) 변수에서 정보 추출하기   {#dates_POSIXct}


### 관련 함수

`lubridate` 패키지는 또한 `POSIXct` 날짜-시간 변수에서 시간 정보를 추출할 수 있게 해 주는 다음과 같은 함수를 제공한다:

- `hour()`
- `minute()`
- `second()`



### `POSIXct` 변수에서 정보 추출 예

```{r}
# break up the time variable decision time
# display as a data.frame with 4 columns
with(dates,  ## with() tells R to look for variables in object "dates"
     data.frame(time=decision_time, h=hour(decision_time),
           m=minute(decision_time), s=second(decision_time)))
```


## 날짜-시간 산술연산을 위한 두 종류의 함수   {#dates_functions}

날짜 변수에 시간을 더하거나 빼야할 경우를 위해 `lubridate` 패키지는 두 종류의 함수들을 제공한다.

한 종류의 함수들은 “직관적인” 결과를 가져오는데, 윤년(leap year) 같은 관습은 무시한다.  이러한 종류의 함수로는 `seconds()`, `minutes()`, `hours()`, `days()`, `weeks()`, `years()` 등이 있다.

또 다른 종류의 함수들은 그러한 관습을 고수하는데, 앞의 함수들의 이름에 d를 추가되어 있는 함수들로서 `dseconds()`, `dminutes()`, `dhours()`, `ddays()`, `dweeks()`, `dyears()` 등이 있다.



직관적인 날짜-시간 연산의 예:

```{r}
# 2016 is a leap year
# the intuitive result
years(2) 
ymd("2015-02-14") + years(2) 
```

- `years(2)` : “y m d H M S” 형식으로 날짜 시간 데이터를 처리한다.
- `ymd("2015-02-14") + years(2)`  :  `2015-2-14`에 `2y`를 더한 연산으로 그 결과는 직관적으로 `2017-2-14`가 된다.



정확한 날짜-시간 연산의 예

```{r}
# the exact result
dyears(2)
ymd("2015-02-14") + dyears(2)
```

- `dyears(2)` : `s`(초) 형식으로 날짜-시간 데이터를 연산한다. 결과는 `63115200s (~2 years)`
- `ymd("2015-02-14") + dyears(2)` : 2016년은 윤년이어서 최종 결과는 `2017-02-13 12:00:00 UTC`가 되었다.
