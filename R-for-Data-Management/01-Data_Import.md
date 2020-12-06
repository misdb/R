# Data Import and Export     {#data_import}

## Data Import

### 준비하기

이 장에서는 `tidyverse` 의 핵심 구성요소인 **`readr`** 패키지를 사용하여 **플랫 파일**을 불러오는 방법을 학습한다.

```{r warning=FALSE}
# install.packages("tidyverse")
library(tidyverse)
```

### 시작하기

`readr`패키지의 함수 대부분은 *플랫 파일*을 **데이터 프레임(엄밀히 말하면 `tibble`)**으로 바꾸는 것과 연관이 있다.

- **`read_csv()`** 는 **쉼표(`,`)로 구분된 파일**을 읽고, 
- **`read_tsv()`** 는 **탭-구분 파일**을 읽는다.  
- **`read_delim()`**은 **임의의 구분자로 된 파일**을 읽는다.
- **`read_fwf()`** 는 **고정 너비 파일**을 읽는다. 
  - *필드 너비*는 `fwf_widths()` 를 이용하여, 
  - *필드 위치*는 `fwf_positions()` 를 이용하여 지정할 수 있다.
- **`read_table()`** 은 **고정 너비 파일**의 일반적 변형 형태인 *열이 공백으로 구분된 파일*을 읽는다.
- **`read_log()`** 는 **Apache 스타일의 로그 파일**을 읽는다. (하지만 `read_log()` 기반으로 구축되어 더 많은 유용한 도구를 제공하는 [`webreadr`](https://github.com/Ironholds/webreadr) 도 확인하라.)

이 함수들은 문법이 모두 비슷하다. 하나를 익히면 나머지는 쉽게 사용할 수 있다. 이 장의 나머지 부분에서는 **`read_csv()`**에 초점을 맞출 것이다. CSV 파일은 가장 일반적인 형태의 데이터 저장 형태일 뿐 아니라 **`read_csv()`** 를 이해하면 **`readr`** 의 다른 모든 함수에 쉽게 적용할 수 있다.

#### 첫 번째 인수 : 불러올 파일 경로 지정

`read_csv()` 의 **첫 번째 인수**가 가장 중요한데 바로 ***불러올 파일의 경로***다.
```{r}
heights <- read_csv("data1/heights.csv")
heights
```
- `read_csv()`를 실행하면 **각 열의 이름**과 **유형**을 제공하는 ‘열 사양, cols’이 화면 출력된다. 이는 `readr` 패키지에서 중요한 부분이다. [파일 파싱하기](https://sulgik.github.io/r4ds/data-import.html#-)에서 다시 살펴보겠다.


**인라인(in-line) CSV 파일**이 첫 번째 인수가 될 수도 있다. 이것은 `readr` 로 실험해 볼 때와 다른 사람들과 공유할 재현 가능한 예제를 만들 때 유용하다.

```{r}
read_csv("a,b,c
1,2,3
4,5,6")
```

#### 다른 인수들

##### `skip =` 인수와 `comment =` 인수 : 메타 데이터 지정

두 경우 모두 `read_csv()` 는 데이터의 **첫 번째 줄을 “열 이름”으로 사용**한다. 이는 매우 일반적인 규칙이다. 이 동작을 조정해야 하는 경우는 두 가지이다.

파일 앞 부분에 ** *메타 데이터*가 몇 줄이 있는 경우**가 있다. `skip = n` 을 사용하여 첫 `n` 줄을 건너 뛸 수 있다. 또는 `comment = "#"` 을 사용하여 `#` 으로 시작하는 모든 줄을 무시할 수 있다.
```{r}
read_csv("메타 데이터 첫번째 행
  메타 데이터 두번째 행
  x,y,z
  1,2,3", skip = 2)
```
- `skip = 2`로 인해 첫 두 줄은 데이터로 읽혀지지 않았음을 알 수 있다.

```{r}
read_csv("# 건너뛰고 싶은 주석
  x,y,z
  1,2,3", comment = "#")
```
- `comment = “#”`로 인해, 첫째 줄의 내용이 데이터로 읽혀지지 않았음을 알 수 있다.

##### `col_names =` 인수 : 첫 줄의 컬럼 제목 사용여부

데이터에 *열 이름이 없을 수 있다*. `col_names = FALSE` 를 사용하면 `read_csv()`가 첫 행을 헤드로 취급하지 않고 대신 `X1`에서 `Xn`까지 순차적으로 컬럼 이름을 붙인다.
```{r}
read_csv("1,2,3\n4,5,6", col_names = FALSE)

read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))
```
- (`"\n"` 은 **새 줄을 추가하는 편리한 단축키**이다. 
- 이 때, 컬럼 제목은 지정이 되지 않았기 때문에, 자동으로 `X1`, `X2`, `X3`라고 부여된다.

다른 방법으로는 `col_names` 에 **열 이름으로 사용할 문자형 벡터**를 전달할 수도 있다.

##### `na =` 인수 : 결측값의 처리 방법

일반적으로 조정이 필요한 또 다른 옵션은 `na` 이다. 파일에서 **결측값을 나타내는데 사용되는 값(들)을 지정**한다.
```{r}
read_csv("a,b,c\n1,2,.", na = ".")
```

여기까지 배운 것들로 실제로 마주하게 될 CSV 파일의 75% 정도를 불러올 수 있다. 또한 **탭으로 구분된 파일**을 `read_tsv()` 를 사용하여, 혹은 **고정간격 파일**을 `read_fwf()` 를 사용하여 불러오는 데도 쉽게 적용할 수 있다. 

더 복잡한 파일을 읽으려면 `readr` 이 **각 열을 파싱하여 R 벡터로 바꾸는 방법**에 대해 자세히 배워야한다.

#### `base` R과 비교

R을 이전에 사용한 사람은 우리가 **`read.csv()`** 를 사용하지 않는 이유가 궁금할 것이다. `base` 패키지의 함수보다 `readr`패키지의 함수가 좋은 이유는 다음과 같다.

- 일반적으로 `base` 함수보다 **훨씬 더(~10배) 빠르다**. 오래 걸리는 작업은 진행 표시줄을 통해 상황을 알 수 있다. raw speed로 작업하려면 **`data.table::fread()`** 를 사용해보라. 이 함수는 `tidyverse` 에 잘 어울리지는 않지만, 훨씬 더 빠를 수 있다.
- **티블(tibble)을 생성**한다. 문자 벡터를 팩터형으로 변환하지도, 행 이름을 사용하거 나 열 이름을 변경하지도 않는다. `base` R 함수는 변환, 변경하기 때문에 늘 불편하다. (R version 4.0 이후에는 factor 변환은 옵션임)
- **좀 더 재현 가능하다**. `base` R 함수는 운영체제 및 환경 변수의 일부 동작을 상속하므로 자신의 컴퓨터에서 작동하는 불러오기 코드가 다른 사람의 컴퓨터에서 작동하지 않을 수 있다.

#### 다른 함수들의 이용은 [[별도의 파일](ch01-1_read_tabular_data.html) 참고...]

#### 연습문제

1. 필드(데이터 항목)가 “`|`” 로 분리된 파일을 읽으려면 어떤 함수를 사용하겠는가? {-}

   - `delim="|"`를 인수로 하는 `read_delim()` 함수를 사용한다.
```{r}
file <- "data1/dates_delimeter.csv"
read_delim(file, delim = "|")
```

** `data` 디렉토리의 `dates_delimeter1.csv` ~ `dates_delimeter5.csv` 파일들도 연습해 보기 바람. **


2. `read_csv()` 와 `read_tsv()` 가 공통으로 가진 인수는 `file`, `skip`, `comment` 외에 또 무엇이 있는가?

   - 두 함수의 공통 인수를 찾기 위해 다음을 수행한다.
```{r}
union(names(formals(read_csv)), names(formals(read_tsv)))
```

   - `col_names` 와 `col_types` : 컬럼 이름을 지정과 그 컬럼을 어떻게 parse할 지를 지정한다.
   - `locale` : 인코딩과 관련한 것들의 지정 또 십진수 표시를 “,”로 할 찌 “.”으로 할 지의 지정에 사용된다.
   - `na` 와 `quoted_na` : 벡터를 파싱할 때 어떤 문자열이 결측치로 처리될 지를 지정한다.
   - `trim_ws` : 파싱하기 전에 셀의 앞 뒤로 공백문자를 제거
   - `n_max` : 읽어 들일 행의 갯수 지정
   - `guess_max` : 컬럼 형을 추측할 때 몇 개의 행을 사용할 지를 지정
   - `progress` : 진행 막대를 표시할 지를 결정

3. `read_fwf()` 에서 가장 중요한 인수는 무엇인가?
   - 고정너비 형식의 파일을 불러오는 `read_fwf()`의 가장 중요한 인수는 데이터 열의 시작과 끝을 함수에게 알려주는 `col_position=` 인수이다. 
   
4. CSV 파일의 문자열에 쉼표가 포함되는 경우가 있다. 그것들이 문제를 일으 키지 않게 하려면 `"` 혹은 `'`와 같은 인용 문자로 둘러싸일 필요가 있다. `read_csv()` 는 인용 문자가 `"`라고 가정한다. 이를 변경하려면 `read_delim()` 을 대신 사용하면 된다. 다음 텍스트를 데이터프레임으로 읽으려면 어떤 인수를 설정해야하는가? 
```{r}
x <- "x,y\n1,'a,b'"
read_delim(x, ",", quote = "'")
```

   - `read_delim()`함수를 사용하려면, 구분자를 지정해야 한다. 이 경우의 구분자는 `“,”`이며, `quote = `인수의 값은 `“‘“`. 

   ```{r}
   x <- "x,y\n1,'a,b'"
   read_delim(x, ",", quote = "'")
   ```

   - `x`를 **`“,”`** 기호로 데이터 요소들을 구분하고, 문자열 데이터는 **`“'"`** 로 묶여 있음(`quote="'"`)을 지정한다. 
     - `x`, `y` : 컬럼 제목 `x`와 `y`
     - `\n` : 줄 바꾸기
     - `1, ‘a,b’` :  데이터 요소로 `1`과 `a,b`


5. 다음 각 인라인 CSV 파일에 어떤 문제가 있는지 확인하라. 코드를 실행하면 어떻게 되는가?

```{r}
read_csv("a,b\n1,2,3\n4,5,6")
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")
read_csv2("a;b\n1;3")
```

   - 두 개의 열만 “`a`”와 “`b`”라는 헤더가 있는데, 데이터 요소는 3개이다. 따라서 **마지막 요소의 값은 자동 삭제가 된다.**

     ```{r}
     read_csv("a,b\n1,2,3\n4,5,6")
     ```   
   
   - 셋 째의 경우는 의도가 분명치 않다. `"1` 은 삭제되는데, 이는 `“`로 닫히지 않았기 때문이다 그리고  `a`컬럼은 정수형으로 처리된다.

     ```{r}
     read_csv("a,b\n\"1")
     ```

   - “`a`”와 “`b`” 모두는 비수치 문자열을 포함하고 있기 때문에 모두 문자 벡터로 처리된다. 이는 의도적으로 각각의 열에  “`1,2`”와 “`a,b`” 값을 할당하는 것이다.

     ```{r}
     read_csv("a,b\n1,2\na,b")
     ```

   - 데이터가 컴마(`,`)가 아닌 세미콜론(`;`)으로 구분되어 있으면, `read_csv2()`함수를 이용한다:

     ```{r}
     read_csv("a;b\n1;3")
     read_csv2("a;b\n1;3")
     ```

      - 첫 번째의 경우, 	`read_csv()` 함수는  `a;b`가 컬럼 제목이고, `1;3`은 이 컬럼의 데이터인 것으로 읽는다.
      - 두 번째의 경우, `read_csv2()` 함수는 데이터 구분자로 세미콜론(`;`)을 사용하기 때문에,  `a;b`는 `a`컬럼과 `b`컬럼으로,  `1;3`은 이 컬럼의 데이터로 `1`과 `3`인 것으로 읽는다.
      
      

### 벡터 파싱하기
`readr`이 디스크에서 파일을 읽는 방법에 대해 깊이 알아보기 전에, 잠깐 벗어나서 **`parse_*()`** 함수에 대해 살펴볼 필요가 있다. 

#### 파싱 함수의 사용 예

이 함수들은 **문자형 벡터**를 입력으로 하여 **논리형**, **정수형** 또는 **날짜형**과 같은 좀 더 *특수화된 벡터를 반환*한다.

##### 문자형 벡터를 논리형 벡터로 파싱하기.
```{r}
a <- (parse_logical(c("TRUE", "FALSE", "NA")))
a
class(a)
str(a)
```
- 문자열 데이터  `c("TRUE", "FALSE", "NA")`를 `parse_logical()` 함수가 **논리형(`logical`)**으로 변환해 준다.

##### 문자형 벡터를 숫자형 벡터로 파싱하기
```{r}
b <- parse_integer(c("1", "2", "3"))
b
class(b)
str(b)
```
- 문자열 데이터  `c("1", "2", "3")`을 `parse_integer()` 함수가 **정수형(`integer`)**으로 변환해 준다.

##### 문자형 벡터를 날짜형 벡터로 파싱하기
```{r}
c <- parse_date(c("2010-01-01", "1979-10-14"))
c
class(c)
str(c)
```
- 문자열 데이터 `c("2010-01-01", "1979-10-14")`을 `parse_date()` 함수가 **날짜형(`Date`)**으로 변환해 준다.

#### 파서 함수의 인수 사용 예

`tidyverse`의 모든 함수와 마찬가지로, `parse_*()` 함수는 동일한 형태이다. 

즉, **첫 번째 인수**는 파싱할 *문자형 벡터*이며 **`NA =` 인수**는 결측값으로 처리되어야 하는 문자열을 지정한다.

```{r}
parse_integer(c("1", "231", ".", "456"), na = ".")
```
- 파싱에 실패하면 경고 메시지가 나타난다.

```{r}
x <- parse_integer(c("123", "345", "abc", "123.45"))
```
- 3번째 요소(`3`)의 경우 정수형이어야 하는데 “`abc`”로 입력되었음을 경고함.
- 4번째 요소(`4`)의 경우 허락되지 않는 문자가 따라와서 `.45`를 경고함.

- 이런 경우에는 출력에서 누락될 것이다.

```{r}
x
```
- `3`번째와 `4`번째 행의 요소의 경우, **결측치(`NA`)로 처리**됨을 알 수 있다.


##### problem() 함수의 활용 {-}
파싱에 실패한 경우가 많으면 `problems()` 를 사용하여 실패 전체를 가져와야 한다. `problems()` 이 반환한 티블(tibble)을 `dplyr`로 작업할 수 있다.

```{r}
problems(x)
```

#### 파서 함수의 종류

이 함수들은 독립적으로도 유용하지만, `readr` 패키지의 중요한 구성요소이기도 하다. 이 절에서는 개별 파서(parser)가 어떻게 **동작**하는지를 우선 배우고, 다음 절에서 개별 파서들이 어떻게 **구성**되어 파일 전체를 파싱하는지 살펴볼 것이다.

파서를 잘 활용하려면, 어떤 종류가 있는지, 각종 입력 유형을 어떻게 다루는지를 잘 이해해야 한다. 

위의 그림에서 보듯이 특별히 중요한 **8개의 파서 함수**가 있다.

1. **`parse_logical()`** 과 **`parse_integer()`** 는 각각 **논리형 및 정수형을 파싱**한다. 기본적으로 이 파서에 잘못될 수 있는 것은 없으므로 여기서 더 설명하지 않겠다.
2. **`parse_double()`** 은 **엄격한 수치형 파서**이고, **`parse_number()`** 는 **유연한 수치형 파서**이다. 이들은 예상보다 더 복잡하다. 왜냐하면 세계 여러 지역이 각자 다른 방식으로 숫자를 쓰기 때문이다.
3. **`parse_character()`** 는 너무 단순해서 필요 없을 것 같다고 생각할지도 모른다. 그러나 어떤 복잡성 때문에 **이 파서가 매우 중요**하다. 바로 **문자 인코딩**이 그것이다.
4. **`parse_factor()`** 는 **팩터형**을 생성하는데, 팩터형은 R이 미리 정해지고 알려진 값으로 범주형 변수를 나타내기 위해 사용하는 데이터 구조이다.
5. **`parse_datetime()`** , **`parse_date()`** , **`parse_time()`**  을 사용하면 다양한 **날짜와 시간 데이터를 파싱**할 수 있다. 날짜를 쓰는 방법은 다양하기 때문에 **이 함수들이 가장 복잡**하다. 다음 절들에서 더 자세히 살펴보기로 하자.


#### 숫자 파싱

숫자 파싱하는 것은 간단한 것처럼 보이지만, 까다로운 세 가지 문제가 있다.

1. 세계 여러 지역에서 사람들은 숫자를 다르게 쓴다. 예를 들어, 어떤 국가에서는 실수의 정수 부분과 소수 부분 사이에 `.` 를 쓰고 다른 국가에서는 `,` 를 쓴다. (`decimal_mark`)
2. 숫자는 ‘$1000’, ‘10%’ 와 같이 단위를 나타내는 다른 문자가 붙어있을 때가 많다.
3. 숫자는 ‘1,000,000’ 과 같이 쉽게 읽을 수 있도록 ‘그룹화’ 문자가 포함되는 경우가 많다. 이러한 그룹화 문자는 국가마다 다르다. (`grouping_mark`)

##### 천 단위와 소숫점의 처리
**첫 번째 문제**를 해결하기 위해서 `readr`은 지역에 따라 파싱 옵션을 지정하는 객체인 ‘`로캘(locale)`’이라는 개념을 사용한다. 숫자를 파싱할 때 가장 중요한 옵션은 **소수점으로 사용하는 문자**이다. 새로운 로캘을 생성하고 `decimal_mark` 인수를 설정하여 기본값인 `.` 를 다른 값으로 재정의할 수 있다.

숫자의 파싱에 있어서, 천 단위(grouping mark)의 표시와 소숫점(decimal mark)의 표시가 지역에 따라 다름을 잘 알고 있어야 한다.

```{r}
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))
```
`readr` 의 **기본 로캘**은 *미국* 중심인데, 왜냐하면 일반적으로 R 은 미국 중심이기 때문이다 (즉, `base` R의 문서가 미국식 영어로 작성되었다). 

다른 방법은 운영체제의 기본값을 추측하여 시도하는 것이다. 이러한 방법은 잘 동작하지 않고, 더 중요한 것은 코드가 취약하게 된다. 자신의 컴퓨터에서 동작하더라도 코드를 다른 국가의 동료에게 이메일로 보낼 때 오류가 발생할 수 있다.


##### 통화 및 백분율 처리

**두 번째 문제**를 처리하는 `parse_number()` 는 *숫자 앞뒤의 숫자가 아닌 문자 (non-numeric character) 를 무시*한다. **통화** 및 **백분율**에 특히 유용하지만, **텍스트에 포함 된 숫자를 추출**하는 데도 효과적이다.

화페 단위, %, 문자열 등을 모두 무시한다.
```{r}
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")
```

##### 국가 및 대륙별 차이
**마지막 문제**는 `parse_number()` 와  `locale=` 인수를 조합하여,  `parse_number()` 가 “``.``”을 무시하게(`locale(grouping_mark = ".")` 함으로써 해결할 수 있다.

###### 미주 방식
미주방식 : grouping mark는 `,`, decimal mark는 `.`를 사용
```{r}
parse_number("$123,456,789")
```

###### 유럽의 많은 국가 방식
미주방식 : grouping mark는 `.`, decimal mark는 `,`를 사용
```{r}
parse_number("123.456.789", locale = locale(grouping_mark = "."))
```

###### 스위스 방식
미주방식 : grouping mark는 `'` 혹은 ` `(공란), decimal mark는 `.`를 사용.
```{r}
parse_number("123'456'789", locale = locale(grouping_mark = "'"))
```

##### `decimal_mark`와  `grouping_mark`의 관련성
소숫점 표시(decimal mark)와 그루핑 마크(grouping mark)를 같은 문자를 설정하면, `locale`은 에러를 발생한다:
```{r}
# locale(decimal_mark = ".", grouping_mark = ".")  # 
```
-- 에러: `decimal_mark` and `grouping_mark` must be different 추가정보: 경고메시지(들): In strsplit(info, "\n") : 이 로케일에서는 입력문자열 3는 유효하지 않습니다 실행이 정지되었습니다

- decimal mark와 grouping mark는 같은 부호를 사용하면 안됨.

```{r}
locale()
locale(decimal_mark = ",")
locale(decimal_mark = ".")

locale(grouping_mark = ".")
locale(grouping_mark = ",")
```
- decima mark를 `,`로 지정하면, 자동으로 grouping mark는 `.`으로 바뀐다. 반대의 경우도 마찬가지다.


#### 문자열 파싱

##### 문자의 ASCII 코드
`parse_character()` 는 정말 단순해 보인다. 입력을 단순히 반환하는 것 아닌가. 그런데 불행하게도 삶은 그렇게 호락호락하지 않다. 같은 문자열을 나타내는 방법은 여러 가지이다. 이게 무슨 이야기인지 이해하려면 컴퓨터가 문자열을 표시하는 방법에 대해 깊고 상세하게 들어가야 한다. R에서는 **`charToRaw()`** 를 사용하여 문자열의 기본 표현을 볼 수 있다.
```{r}
charToRaw("Hadley")
charToRaw("대한민국")
```
- 각 16진수값은 정보 바이트를 나타낸다. 
- 예를 들면 `48` 은 H를 나타내고, `61` 은 a 를 나타낸다. 
- 영문은 글자 하나가 1 바이트 : 즉, `H`의 ASCII 코드는 48
- 한글은 글자 하나가 2 바이트 : `대`의 ASCII 코드는 b4 eb가 된다.

##### 16진수 코드의 인코딩
16진수 수치를 문자로 매핑하는 것을 **인코딩**이라고 하며, 앞의 인코딩은 **ASCII** 라고 한다. **ASCII** 는 정보 교환을 위한 **미국 표준 코드(American Standard Code for Information Interchange**)의 줄임말이며 따라서 영문자를 잘 표현한다.

영어가 아닌 다른 언어의 경우 더욱 복잡해진다. 컴퓨터 시대 초창기에는 비영어권 문자 인코딩을 위한 여러 표준 규격이 있었다. 문자열을 정확하게 해석하기 위해서는 값과 인코딩을 모두 알아야했다. 예를 들어 두 가지 일반적인 인코딩은 **Latin1** (ISO-8859-1, 서유럽 언어들에서 사용)과 **Latin2** (ISO-8859-2, 동유럽 언어들에서 사용)이다. Latin1에서 바이트 `b1` 은 ‘±’이지만, Latin2 에서는 ‘ą’이다! 다행히 오늘날에는 거의 모든 곳에서 지원되는 하나의 표준인 `UTF-8 `이 있다. `UTF-8` 은 오늘날 인간이 사용하는 거의 모든 문자와 기타 기호들(예: 이모티콘)을 인코딩할 수 있다.

**`readr`** 은 모든 곳에서 **`UTF-8`** 을 사용한다. 데이터를 읽을 때 `UTF-8` 이라고 가정하며, 쓸 때는 항상 사용한다. `UTF-8` 은 좋은 기본값이지만, 이를 인식하지 못하는 구형 시스템에서 생성된 데이터에 사용할 수 없다. 이런 상황이면 문자열을 화면 출력할 때 이상하게 보인다. 한 두 개의 문자만 엉망이 될 수도 있고, 완전히 외계어들을 볼 수도 있다. 다음의 예를 보자.

```{r}
x1 <- "El Ni\xf1o was particularly bad this year"
x1
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
x2
x3 <- "\xb4\xeb\xc7\xd1\xb9\xce\xb1\xb9"
x3
```
- `x1`의 경우 일부 문자의 파싱이 안되었음.
- `x2`의 경우 파싱이 제대로 되지 않았음. 즉, 코드가 불일치함을 보여줌.


문제를 해결하려면 `parse_character()` 에서 인코딩을 지정해야 한다.

```{r}
parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))
parse_character(x3, locale = locale(encoding = "EUC-KR"))
```
- `encoding = `인수를 이용하여 코드를 지정해 줌.


##### 인코딩 방식의 추출

**올바른 인코딩을 어떻게 찾을 수 있을까?** 운이 좋다면 데이터 문서의 어딘가 에 포함되었을 것이다. 하지만 불행하게도 그런 경우는 거의 없으므로, readr 는 `guess_encoding()` 을 제공하여 사용자가 알아낼 수 있도록 도와준다. 이것은 완벽하지도 않고, (앞의 사례와 달리) 텍스트가 많아야 더 잘 작동하지만, 한번 시도해볼 만한 방법이다. 올바른 인코딩을 찾기 전에 몇 가지 다른 인코딩을 시도해보라.
```{r}
guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))
guess_encoding(charToRaw(x3))
```

`guess_encoding()` 의 **첫 번째 인수**로는 *파일의 경로*, 혹은 이 예제와 같이 *원시 벡터* (문자열이 이미 R에 있는 경우 유용함)가 될 수 있다.

- 인코딩은 방대하고 복잡한 주제이며, 여기서 우리는 단지 겉핥기만 한 것이다. 더 배우고 싶으면 [Encoding](http://kunststube.net/encoding) 에서 자세한 설명을 읽어보길 추천한다.


#### factor 형 
R 은 factor 형을 사용하여, 가질 수 있는 값을 미리 알고 있는 **범주형 변수**를 나타낸다. 예상치 못한 값이 있을 때마다 경고를 생성하려면 `parse_factor()`에 가질 수 있는 레벨 벡터를 지정하면 된다.
```{r}
fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)
```
- `bananana`의 경우 `fruit`의 요소가 아니기 때문에 `NA`(결측치)로 처리됨.
그러나 입력값에 문제가 많이 있는 경우에는, 그 입력값을 우선 문자형 벡터로 남겨두고 [문자열](https://sulgik.github.io/r4ds/strings.html#strings)과 [팩터형](https://sulgik.github.io/r4ds/factors.html#factors)에서 배울 도구를 사용하여 정리하는 것이 쉬울 때가 많다.


####  데이트형, 데이트-타임형, 타임형 파싱
원하는 것이 `date` (1970-01-01 이후의 일 수), `date-time` (1970-01-01 자정 이후의 초), `time` (자정 이후의 초)인지에 따라 세 가지 파서 중에서 선택하면 된다. 추가 인수 없는 각 파서의 동작은 다음과 같다.


##### parse_datetime 함수
`parse_datetime()`은 `ISO 8601 date-time`을 입력으로 한다. `ISO 8601`은 국제 표준인데 날짜가 가장 큰 것부터 가장 작은 것(즉, 년, 월, 일, 시, 분, 초)으로 구성된다.
```{r}
parse_datetime("2010-10-01T2010")
```
`ISO 8601`은 가장 중요한 날짜/시간 표준이며, 날짜와 시간을 자주 다루는 경우 [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)을 읽어볼 것을 추천한다.

###### 날짜 파싱
`parse_date()` 는 네 자리 **연도**, `-` 또는 `/`, **월**, `-` 또는 `/`, **날짜**를 입력으로 한다.
```{r}
parse_datetime("20101010")

parse_date("2010-10-01")
```

###### 시간 파싱
`parse_time()` 은 **시** `:` **분** 그리고 선택적으로 `:`, **초**, 선택적 **`a.m.`/`p.m.`** 표시를 입력으로 한다.
- `base` R에는 시간 데이터를 위한 좋은 내장 클래스가 없기 때문에, 우리는 `hms` 패키지에서 제공하는 클래스를 사용한다.
```{r}
# install.packages("hms")
library(hms)
parse_time("01:10 am")
parse_time("20:10:01")
```


###### `format` 인수의 활용

이러한 기본 설정으로 주어진 데이터를 처리하지 못한다면 다음의 요소들로 이루어진 **자신만의 날짜-시간 형식**(`format`)을 만들어 쓸 수 있다.

- Year
  - `%Y` (4 자리).
  - `%y` (2 자리); 00-69 -> 2000-2069, 70-99 -> 1970-1999.

- Month
  - `%m` (2 자리).
  - `%b` (“Jan”과 같이 축약된 명칭).
  - `%B` (전체 명칭, “January”).

- Day
  - `%d` (2 자리).
  - `%e` (선택적 선행 공백).

- Time
  - `%H` 0-23 시간.
  - `%I` 0-12, `%p`와 함께 사용해야 함.
  - `%p` AM/PM 구분자.
  - `%M` 분.
  - `%S` 정수 초.
  - `%OS` 실수 초.
  - `%Z` 시간대 (이름, 예 `America/Chicago`).

**참고:** 줄임말에 주의하라. ‘`EST`’는 일광 절약 시간제가 없는 캐나다 표준 시간대임을 주의하라. 그것은 동부 표준시가 아니다! [시간대](https://sulgik.github.io/r4ds/dates-and-times.html#time-zones)에서 이를 다시 살펴보겠다.

  - `%z` (UTC 와의 오프셋, 예: `+0800`).

- 숫자가 아닌 문자
  - `%.` 숫자가 아닌 문자 하나를 건너뛴다.
  - `%*` 숫자가 아닌 문자 모두를 건너뛴다.


###### 날짜 형식의 지정 (숫자)
올바른 포맷을 파악하는 가장 좋은 방법은 **문자형 벡터**로 몇 가지 예제를 만들고, 파싱함수 중 하나로 테스트하는 것이다.
```{r}
parse_date("01/02/15", "%m/%d/%y")
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/15", "%y/%m/%d")
parse_date("2020년 06월 17일", "%Y년 %m월 %d일")
```


###### 날짜 형식의 지정 (알파벳 날짜명)
비영어권의 월 이름에 `%b` 또는 `%B` 를 사용하는 경우, `locale()`의 `lang` 인수를 설정해야 한다. `date_names_langs()`에 내장된 언어 목록을 보라.

```{r}
date_names_langs()
```
- 한국은 `ko`

자신의 언어가 아직 포함되어 있지 않았으면 `date_names()` 를 사용하여 생성하라.
```{r}
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
parse_date("20-06-17", "%y-%m-%d")
parse_date("2020-06-17", "%Y-%m-%d")
parse_date("2020년 06월 17일", "%Y년 %m월 %d일")
```

### 연습문제

1. `locale()` 에서 가장 중요한 인수들은 무엇인가?

   - `locale()`함수는 다음과 같은 인수들이 있다:
     - 날짜와 시간 형식 : `date_names`, `date_format`, 그리고 `time_format`
     - 시간대 : `tz`
     - 숫자 : `decimal_mark`, `grouping_mark`
     - 인코딩 : `encoding`

2. `decimal_mark` 와 `grouping_mark` 를 동일 문자로 설정하려고 하면 어떻게 되는가? `decimal_mark` 를 ‘,’로 설정하면 `grouping_mark` 의 기본값은 어떻게 되는가?

   - 소숫점 표시와 그루핑 마크가 같은 문자로 설정되어 있으면 `locale`은 에러를 발생시킨다:

     ```{r}
     # locale(decimal_mark = ".", grouping_mark = ".")
     ```

   - 소숫점 표시( `decimal_mark` )가 컴마("`,"`)로 설정되어 잇으면, 그루핑 마크(`grouping_mark`)는 점(`"."`)으로 설정된다.

     ```{r}
     locale(decimal_mark = ",")
     ```

   - 그루핑 마크(`grouping_mark`)가 컴마("`,"`)으로 설정되어 있으면,  소숫점 표시( `decimal_mark` )는 점(`"."`)으로 설정된다: 

     ```{r}
     locale(grouping_mark = ",")
     ```


3. `locale()`의 `date_format` 및 `time_format` 옵션에 대해서는 논의하지 않았다. 이 들이 하는 일은 무엇인가? 이들이 유용할 수 있는 경우를 보여주는 예제를 작성해보라.

   - 이것들은 디폴트의 날짜와 시간 형식을 제공한다. [readr vignette](https://cran.r-project.org/web/packages/readr/vignettes/locales.html) 는 날짜를 파싱하기 위해 이 함수들을 이용하는 것에 대하여 다루고 있다: 날짜는 언어 특유의 요일과 월 이름 그리고 AM/PM에 대한 서로 다른 표기법을 가지고 있을 수 있기 때문이다. 

   ```{r}
   locale()
   ```

   - 프랑스 날짜를 파싱한 `readr vignette`의 예를 들면 다음과 같다:

   ```{r}
   parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))
   parse_date("14 oct. 1979", "%d %b %Y", locale = locale("fr"))
   ```

  - 확실히 시간 형식은 사용되지 않지만, 날짜 형식은 열의 데이터 형식을 파악하는데 사용된다.

4. 가장 많이 읽는 파일 형식에 대한 설정을 압축한 새로운 로캘 객체를 만들어 보라.

   - 설정될 수 있는 상이한 변수들에 대해 알고 싶으면 `?locale()`를 이용하여 `locale()` 도움말을 참조한다.
   
   - 호주를 예를 들어 보겠다. `02/02/2007`으로 ‘January 2, 2006’을 의미하는 날짜 형식이 “(d)d/mm/yyyy”라는 것을 제외하면, 대부분의 디폴트 값이 유효하다. 
   
   - 그러나, 드폴트 locale은 날짜를 February 1, 2006으로 파싱할 것이다.

   ```{r}
   parse_date("02/01/2006")
   ```

   호주의 날짜를 정확히 파싱하기 위해서는 새로운 `locale` 오브젝트를 정의해야 한다: 

   ```{r}
   au_locale <- locale(date_format = "%d/%m/%Y")
   ```

   locale을 au_locale로 하고 `parse_date()`를 사용하면 날짜를 정확히 파싱할 것이다:

   ```{r}
   parse_date("02/01/2006", locale = au_locale)
   ```

5. `read_csv()` 와 `read_csv2()` 은 무엇이 다른가?

   - 구분자의 차이이다. `read_csv()`함수는 컴마를 구분자로 사용하면 반면에 `read_csv2()` 함수는 세미콜론(`;`)을 사용한다. 세미콜론을 사용하는 것은 컴마가 소숫점으로 사용(예를 들어 유럽에서 처럼)될 때 유용하다. 

6. 유럽에서 사용되는 가장 일반적인 인코딩은 무엇인가? 아시아에서 가장 많이 사용되는 인코딩은 무엇인가? 구글 검색해서 알아보라.

   - 아랍어와 베트남어는 ISO와 윈도우즈 표준을 가지고 있다. 다른 주요 아시어 언어는 그들 자신만의 표준을 가지고 있다:
     - 일본어 : JIS X 0208, Shift JIS, ISO-2022-JP
     - 중국어 : GB 2312, GBK, GB 18030
     - 한국어 : KS X 1001, EUC-KR, ISO-2022-KR

   - `stringi::stri_enc_detect`의 문서에 있는 목록은 가장 보통의 인코딩을 지원하기 때문에 인코딩 목록을 잘 보여주고 있다.
     - 서유럽 라틴 언어 : ISO-8859-1, Windows-1250 (also CP-1250 for code-point)
     - 동유럽 라틴 언어 : ISO-8859-2, Windows-1252
     - 그리스어 : ISO-8859-7
     - 터키어 : ISO-8859-9, Windows-1254
     - 히브리어 : ISO-8859-8, IBM424, Windows 1255
     - 러시아어 : Windows 1251
     - 일본어 : Shift JIS, ISO-2022-JP, EUC-JP
     - 한국어 : ISO-2022-KR, EUC-KR
     - 중국어 : GB18030, ISO-2022-CN (Simplified), Big5 (Traditional)
     - 아랍어 : ISO-8859-6, IBM420, Windows 1256

   문자열 인코딩에 대한 보다 상세한 내용은 다음의 사이트를 참고하라.

   - Wikipedia 페이지 [Character encoding](https://en.wikipedia.org/wiki/Character_encoding)
   - Unicode [CLDR](http://cldr.unicode.org/) 프로젝트
   - [What is the most common encoding of each language](https://stackoverflow.com/questions/8509339/what-is-the-most-common-encoding-of-each-language) (Stack Overflow)
   - “What Every Programmer Absolutely, Positively Needs To Know About Encodings And Character Sets To Work With Text”, http://kunststube.net/encoding/.

   텍스트 인코딩을 다루는 프로그램들은 다음과 같다:

   - `readr::guess_encoding()`
   - `stringi::str_enc_detect()`
   - [iconv](https://en.wikipedia.org/wiki/Iconv)
   - [chardet](https://github.com/chardet/chardet) (Python)

7. 올바른 형식 문자열을 생성하여 다음 날짜와 시간을 파싱하라.

   ```{r}
   d1 <- "January 1, 2010"
   d2 <- "2015-Mar-07"
   d3 <- "06-Jun-2017"
   d4 <- c("August 19 (2015)", "July 1 (2015)")
   d5 <- "12/30/14" # Dec 30, 2014
   t1 <- "1705"
   t2 <- "11:15:10.12 PM"
   ```

   - The correct formats are:

   ```{r}
   parse_date(d1, "%B %d, %Y")
   parse_date(d2, "%Y-%b-%d")
   parse_date(d3, "%d-%b-%Y")
   parse_date(d4, "%B %d (%Y)")
   parse_date(d5, "%m/%d/%y")
   parse_time(t1, "%H%M")
   parse_time(t2, "%H:%M:%OS %p")
   ```

### 파일 파싱하기
이제까지 개별 벡터를 파싱하는 방법을 배웠으므로, 처음으로 돌아가서 `readr`을 이용하여 파일을 파싱하는 방법을 알아볼 차례이다. 이 절에서는 다음의 두 방법을 배운다.

1. `readr`이 각 열의 유형을 자동으로 추측하는 방법.
2. 기본 사양을 재정의하는 방법.

#### 전략
`readr`은 휴리스틱 방법을 사용하여 각 열의 유형을 파악한다. 첫 번째 1000행을 읽고 (적절히 보수적인) 휴리스틱 방법을 사용하여 각 열의 유형을 찾는다. 

`guess_parser()`(`readr`의 추정을 반환)와 `parse_guess()` (앞의 추정을 사용하여 열을 파싱)를 사용하여 문자형 벡터에 이 과정을 재현해볼 수 있다.

```{r}
guess_parser("2010-10-01")
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))
guess_parser(c("12,352,561"))

str(parse_guess("2010-10-10"))
```
`parse_***`의 ***을 결정하기 곤란한 경우 `guess_parse()` 함수 활용

이 휴리스틱 방법은 다음 유형들을 각각 시도하여 일치하는 항목을 찾으면 멈춘다.

- 논리형: “`F`”, “`T`”, “`FALSE`”, “`TRUE`”만 포함.
- 정수형: 수치형 문자(와 `-`)만 포함.
- 더블형: (`4.5e-5`와 같은 숫자를 포함하는) 유효한 더블형만 포함.
- 수치형: 내부에 그룹화 마크가 있는 유효한 더블형을 포함.
- 타임형: `time_format`의 기본형식과 일치.
- 데이트형: `date_format`의 기본형식과 일치.
- 데이트-시간형: ISO8601 날짜.

이러한 규칙 중 어느 것도 적용되지 않으면 해당 열은 문자열 벡터로 그대로 남는다.

#### 문제점
큰 파일의 경우 이러한 기본값이 항상 잘 작동하지는 않는다. 두 가지 문제가 있다.

1. 처음 1,000 행이 특수한 경우이어서 `readr`이 충분히 일반적이지 않은 유형으로 추측할 수 있다. 예를 들어 첫 번째 1,000개의 행에 정수만 있는 더블형 열이 있을 수 있다.
2. **열에 결측값**이 많이 있을 수 있다. 첫 번째 1,000 개의 행에 `NA` 만 있는 경우 `readr` 이 문자형 벡터로 추측했지만, 여러분은 좀 더 구체적으로 파싱하고 싶을 수 있다.


`readr`에는 이러한 두 가지 문제를 모두 보여주는 까다로운 CSV 가 포함되어 있다.
```{r}
challenge <- read_csv(readr_example("challenge.csv"))

problems(challenge)
```
- `challenge.csv` 파일은 `readr` 패키지가 제공하는 예제 데이터 세트임.
- `read_csv()`에서 열에 대한 데이터 타입을 지정하지 않아 `y`컬럼의 값이 모두 `NA`로 인식함.

[**] `readr_example()` 함수는 `challenge.csv` 파일이 저장된 폴더의 경로를 확인함.

(패키지에 포함된 파일의 경로를 찾아 주는 **`readr_example()`** 을 사용한 것에 주목하라.) 

두 가지가 출력되었다. 

- 첫 번째 1,000 개의 행을 보고 생성된 열 상세 내용과 첫 다섯 개의 파싱 오류가 그것이다. 
- 발생한 문제들을 ‘`problems()`’ 로 명시적으로 추출하여 더 깊이 탐색하는 것은 좋은 방법이다.

```{r}
readr_example("challenge.csv")
```


#### 문제 해결 전략

**문제가 남아있지 않을 때까지 열 단위로 작업하는 것은 좋은 전략**이다. 
`x` 열에 파싱 문제가 많다는 것을 알 수 있다. 정수값 다음에 따라오는 문자가 있었던 것이다. 이는 더블형 파서를 사용해야 함을 암시한다.

이 호출을 수정하기 위해 먼저 열 사양을 복사하여 원래 호출에 붙여 넣어보라.

##### `x` 컬럼 타입을 정수로, 그리고 `y`컬럼을 문자형으로 지정

`x`는 정수형, `y`는 문자형으로 지정해 보기로 한다.
```{r}
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_integer(),
    y = col_character()
  )
)
```


##### `x` 컬럼 타입을 실수형 그리고 `y`컬럼을 문자형으로 지정

그런 다음 `x` 열의 유형을 ‘`col_double()`’로 조정할 수 있다.
```{r}
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)

tail(challenge)
```
첫 번째 문제는 해결되었지만, 마지막 몇 행을 보면 **날짜**가 **문자형 벡터(*`<chr>`*)**로 저장되었다.

##### `x` 컬럼 타입을 실수형 그리고 `y`컬럼을 날짜형으로 지정

`y` 열을 **데이트형(`col_date()`)**으로 설정하여 이를 수정할 수 있다.
```{r}
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)
```
모든 `parse_xyz()` 함수는 해당하는 `col_xyz()` 함수를 가지고 있다. 데이터가 이미 R 의 문자형 벡터인 경우에는 `parse_xyz()` 를 사용하면 되고, `readr` 이 데이터를 불러오는 방법을 설정할 경우에는 `col_xyz()` 를 사용하면 된다.

`col_types` 를 항상 설정하여 `readr` 이 생성하는 출력물로부터 만들어 나가는 것을 강력히 추천한다. 이렇게 하면 일관되고 재현할 수 있는 데이터 불러오기 스크립트를 갖게 된다. 기본값으로 추측하여 데이터를 읽는다면 데이터 변경 시 `readr` 은 과거 설정으로 읽게 될 것이다. 정말로 엄격하게 하고 싶다면 `stop_for_problems()` 를 사용하라. 파싱 문제가 생기면 오류를 내며 스크립트를 중단할 것이다.


#### 기타 전략

파일을 파싱하는 데 도움이 되는 몇 가지 다른 일반적인 전략이 있다.

- 앞의 예제에서 우리는 단지 운이 없었다. 즉, 기본값보다 한 행만 더 살펴보면 한 번에 정확하게 파싱할 수 있다.
```{r}
challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)
```


- 모든 열을 문자형 벡터로 읽으면 문제를 쉽게 진단할 수 있는 경우가 많다.
```{r}
challenge2 <- read_csv(readr_example("challenge.csv"), 
                       col_types = cols(.default = col_character())
)
```

이 방법은 `type_convert()` 와 함께 사용하면 특히 유용한데, 이 함수는 휴리스틱한 파싱 방법을 데이터프레임의 문자형 열에 적용한다.

**`tribble()` 함수의 활용**
```{r}
df <- tribble(
  ~x,  ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df
```

##### 열 유형을 주의
```{r}
type_convert(df)
```
- 매우 큰 파일을 읽는 경우, `n_max` 를 10,000 또는 100,000 과 같이 작은 숫자로 설정할 수 있다. 이렇게 하면 일반적인 문제를 해결하는 동시에 반복작업을 가속화할 수 있다.
- 파싱에 중대한 문제가 있는 경우에는 `read_lines()` 을 이용하여 라인으로 이루어진 문자형 벡터로 읽거나 `read_file()` 을 이용하여 길이가 1인 문자형 벡터로 읽는 것이 더 쉬울 수 있다. 그런 다음 나중에 배울 문자열 파싱 방법을 사용하여 좀 더 특이한 포맷을 파싱하면 된다.


## Data Export        {#data_export}

### `write_csv()`
```{r}
write_csv(challenge, "data1/out/challenge.csv")

challenge
```

```{r}
write_csv(challenge, "data1/out/challenge-2.csv")
read_csv("data1/out/challenge-2.csv")
```


### `write_rds()`
```{r}
write_rds(challenge, "data1/out/challenge.rds")
read_rds("data1/out/challenge.rds")
```
- `RDS`, `Rdata`, `Rda`의 차이점에 대하여 알아보자...
- [R 데이터 용량 줄이기](https://m.blog.naver.com/PostView.nhn?blogId=plasticcode&logNo=221230650368&proxyReferer=https:%2F%2Fwww.google.com%2F)

### `write_feather()`
```{r}
library(feather)
write_feather(challenge, "data1/out/challenge.feather")
read_feather("data1/out/challenge.feather")
```
- [feather 파일](https://riptutorial.com/ko/r/example/19271/%ED%8E%98%EB%8D%94-%ED%8C%8C%EC%9D%BC-%EA%B0%80%EC%A0%B8-%EC%98%A4%EA%B8%B0-%EB%98%90%EB%8A%94-%EB%82%B4%EB%B3%B4%EB%82%B4%EA%B8%B0)


앞의 예에서 불러온 `challenge.csv` 데이터 세트를 `data1/out` 폴더에 저장해 보기로 한다.

```{r}
challenge <- read_csv(
  readr_example("challenge.csv"), 
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
)
tail(challenge)
```


`readr`에는 디스크에 데이터를 다시 기록하는 데 유용한 함수인 **`write_csv()`** 와 **`write_tsv()`** 가 있다. 두 함수 모두 다음 동작을 통해 출력 파일이 올바르게 다시 읽힐 수 있게 한다.
- 항상 `UTF-8`로 문자열을 인코딩한다.
- `날짜`와 `날짜-시간`을 **ISO 8601** 형식으로 저장하여 어디에서든 쉽게 파싱될 수 있게 한다.

또한, CSV 파일을 엑셀로 내보내려면 **`write_excel_csv()`** 를 사용하면 된다. 이는 파일의 시작 부분에 특수 문자(‘byte order mark’)를 작성하여, `UTF-8` 인코딩을 사용하고 있음을 엑셀에 전달한다.

#### 인수 {-}
- **가장 중요한 인수**는 `x` (저장할 데이터프레임)와 `path` (그 데이터프레임을 저장할 위치)이다.
- **결측값을 지정하는 인수**, `na=` 와 **기존 파일에 첨부할지를 지정하는 인수** `append=` 도 있다.

```{r}
write_csv(challenge, "data1/out/challenge.csv")
```


### `read_csv()`와 `read_rds()`의 비교

CSV 로 저장하면 **데이터의 유형 정보가 없어진다**는 것에 유의하라. 즉, plain text 파일로 저장이 된다.

```{r}
challenge
```

```{r}
write_csv(challenge, "data1/out/challenge-2.csv")
challenge1 <- read_csv("data1/out/challenge-2.csv")
```

```{r}
str(challenge1)
```
- `x` 컬럼은 실수형으로 불러왔으나, `y` 컬럼은 logical 형으로 불러왔다.


이런 이유로 중간 결과를 캐싱하기에 `CSV` 파일을 신뢰할 수 없다. 

불러올 때마다 열 사양을 다시 만들어야 한다. 즉, parsing을 해 주어야 한다. 



여기에는 두 가지 대안이 있다.

1. **`write_rds()`** 와 **`read_rds()`** 는 베이스 함수인 **`readRDS()`** 와 **`saveRDS()`** 의 래퍼 함수들이다. 이들은 `RDS` 라는 R 의 **커스텀 바이너리 형식**으로 데이터를 저장한다.

```{r}
   write_rds(challenge, "data1/out/challenge.rds")
   challenge2 <- read_rds("data1/out/challenge.rds")
```
- `write_rds()` 함수로 `challenge` 데이터 세트를 `data` 폴더에 `challenge.rds`에 export 했다.
- `read_rds()`  함수를 이용하여 `data1/out/challenge.rds` 파일을 `challenge2` 변수로 import 했다.

`challenge2`의 데이터 구조를 확인해 보자.
```{r}
   str(challenge2)
```
- `str(challenge2)`으로 `challenge2`의 데이터 구조를 확인해 보면, 컬럼들의 데이터 타입이 실수형과 날짜형으로 되어 있음을 알 수 있다. 즉, parsing이 필요없다.

2. `feather` 패키지는 다른 프로그래밍 언어와 공유할 수 있는 **빠른 바이너리 파일 형식**을 구현한다.
```{r}
   library(feather)
   write_feather(challenge, "data1/out/challenge.feather")
   challenge3 <- read_feather("data1/out/challenge.feather")
```


```{r}
   str(challenge3)
```
- x 컬럼과 y 컬럼의 데이터 타입을 잘 읽어 들였다.

`feather` 는 `RDS` 보다 대체적으로 빠르며 R 외부에서도 사용할 수 있다. 

`RDS` 는 리스트-열을 지원하지만 `feather` 는 현재 지원하지 않는다.

> 따라서, R에서 처리한 데이터 세트는 단순히 csv 파일이 아닌 RDS 파일로 저장하는 것이 좋다. {-}



## Read Tabular Data의 보충설명     {#data_import_additional}

### `read_csv()`의 예

데이터가 **컴마(`,`)**로 분리된 경우
```{r}
write_file(x = "a,b,c\n1,2,3\n4,5,NA", path="data1/out/file.csv")   # file.csv 파일의 생성
data <- read_csv("data1/out/file.csv")                              # file.csv 파일 불러오기
```

```{r}
data
```

### `read_csv2()`의 예

데이터가 **세미콜론(`;`)**로 분리된 경우
```{r}
write_file(x = "a;b;c\n1;2;3\n4;5;NA", path="data1/out/file2.csv")      # file2.csv 파일의 생성
data2 <- read_csv2("data1/out/file2.csv")                               # file2.csv 파일 불러오기
```

```{r}
data2
```

### `read_delim()`의 예

**특정의 구분자**를 사용하는 경우. 예를 들어 선문자(`|`)를 구분자로 사용하는 경우
```{r}
write_file(x = "a|b|c\n1|2|3\n4|5|NA", path="data1/out/file.txt")      # file.txt 파일의 생성
data3 <- read_delim("data1/out/file.txt", delim="|" )                  # file.txt 파일 불러오기
```

```{r}
data3
```

### `read_fwf()`의 예

데이터가 **고정 너비 간격**으로 분리된 경우
```{r}
write_file(x = "2 4 6\n1 2 3\n4 5 NA", path="data1/out/file.fwf")     # file.fwf 파일의 생성

# 1. Guess based on position of empty columns
data4 <- read_fwf("data1/out/file.fwf", fwf_empty("data1/out/file.fwf", col_names = c("V1", "V2", "V3")))
```

```{r}
data4
```

```{r}
# 2. A vector of field widths
data5 <- read_fwf("data1/out/file.fwf", fwf_widths(c(2, 2, 2), col_names = c("V1", "V2", "V3")))
```

```{r}
data5
```

```{r}
# 3. Paired vectors of start and end positions
data6 <- read_fwf("data1/out/file.fwf", fwf_positions(c(1, 5), c(2, 7), c("V1", "V3")))
```

```{r}
data6
```

```{r}
# 4. Named arguments with start and end positions
data7 <- read_fwf("data1/out/file.fwf", fwf_cols(V1 = c(1, 1), V3 = c(5, 5)))
```

```{r}
data7
```

** `data7`의 경우 마지막 데이터가 `NA`(결측치)로 `V3 = C(5,5)`에 의해 첫 글자 `N`만 읽어 들이게 되고, `V3` 컬럼은 문자형이 된다.


```{r}
# 5. Named arguments with column widths
data8 <- read_fwf("data1/out/file.fwf", fwf_cols(V1 = 2, V2 = 2, V3 = 1))
```

```{r}
data8
```
**앞의 `data7`과 같은 현상임.


**[예제]** 데이터가 다음과 같이 고정 너비 간격으로 분리된 경우 ("`file1.fwf`")
```{}
11aa222
33bb444
55cc666
```

예제의 풀이)
```{r}
write_file(x = "11aa222\n33bb444\n55cc666", path="data1/out/file1.fwf")     # file1.fwf 파일의 생성

```

```{r error = TRUE}
## 1. Guess based on position of empty columns
d1 <- read_fwf("data1/out/file1.fwf", fwf_empty("data1/out/file1.fwf", col_names = c("V1", "V2", "V3")))
View(d1)

```

```{r}
# 2. A vector of field widths
d2 <- read_fwf("data1/out/file1.fwf", fwf_widths(c(2, 2, 3), col_names = c("V1", "V2", "V3")))
```

```{r}
d2
```

```{r}
# 3. Paired vectors of start and end positions
d3 <- read_fwf("data1/out/file1.fwf", fwf_positions(c(1, 5), c(2, 7), c("V1", "V3")))
```

```{r}
d3
```

```{r}
# 4. Named arguments with start and end positions
d4 <- read_fwf("data1/out/file1.fwf", fwf_cols(V1 = c(1, 2), V3 = c(5, 7)))
```

```{r}
d4
```

```{r}
# 5. Named arguments with column widths
d5 <- read_fwf("data1/out/file1.fwf", fwf_cols(V1 = 2, V2 = 2, V3 = 3))
```

```{r}
d5
```

### read_tsv()의 예

데이터가 **탭(`\t`)으로 분리**되어 있는 경우
```{r}
write_file(x = "a\tb\tc\n1\t2\t3\n4\t5\tNA", path="data1/out/file.tsv")      # file.tsv 파일의 생성
data9 <- read_tsv("data1/out/file.tsv")                                      # file.tsv 파일 불러오기
```

```{r}
data9
```
