# 데이터 프레임 결합: 완전(Full) & 부분(Partial) 대응



종종, 우리는 여러 출처로부터 데이터를 얻는다. 분석을 수행하려면 하나 이상의 **공통 키 변수**를 갖는 두 개의 데이터 프레임을 함께 **결합**해야 한다.

이 튜토리얼에서 다음의 내용을 학습한다 :

- [완전 대응](./r-merge-data-frames.html_kr#1)
- [부분 대응](./r-merge-data-frames_kr.html#2)



## 완전 대응

완전 대응(full match)은 오른 쪽 테이블에 상대편이 있는 값을 반환한다. 대응하지 않는 값들은 새 데이터 프레임에 반환되지 않는다. 그러나 부분 대응은 `NA`로 결측치를 반환한다.

우리는 간단한 **inner join(내부 결합)**을 살펴볼 것이다. 내부 결합 키워드는 두 표에 일치하는 값을 가진 레코드(행)를 선택한다. 두 데이터셋을 결합하려면 `merge()` 함수를 사용한다. 이 함수는 다음과 같은 세 가지 인수를 사용할 것이다.

```
merge(x, y, by.x = x, by.y = y)
```

**인수(Arguments) :**

- **x** : 원래의 데이터 프레임

- **y** : 병합할 데이터 프레임

- **by.x** : x 데이터 프레임에서 결합에 사용되는 열. 결합된 결과는 x열로 표시된다.

- **by.y** : y 데이터 프레임에서 결합에 사용되는 열. 결합된 결과는 y열로 표시된다.



**Example :**

다음의 변수를 갖는 첫 데이터 프레임을 생성.

- surname
- nationality

다음의 변수를 갖는 둘째 데이터 세트를 생성.

- surname
- movies



 공통의 key 변수는 `surname`이다. 우리는 두 데이터를 합쳐서, 차원이 7x3인지 확인할 수 있다.

우리는 R이 문자열이 factor로 변환되는 것을 원치않기 때문에(즉, 변수를 문자로 처리하기 위해) 데이터 프레임에  `StringsAsFactors=FALSE`를 추가한다. 

```
# Create origin dataframe(

producers <- data.frame(   
    surname =  c("Spielberg","Scorsese","Hitchcock","Tarantino","Polanski"),    
    nationality = c("US","US","UK","US","Poland"),    
    stringsAsFactors=FALSE)

# Create destination dataframe
movies <- data.frame(    
    surname = c("Spielberg",
		        "Scorsese",
                "Hitchcock",
              	"Hitchcock",
                "Spielberg",
                "Tarantino",
                "Polanski"),    
    title = c("Super 8",
    		"Taxi Driver",
    		"Psycho",
    		"North by Northwest",
    		"Catch Me If You Can",
    		"Reservoir Dogs","Chinatown"),                
     		stringsAsFactors=FALSE)

# Merge two datasets
m1 <- merge(producers, movies, by.x = "surname")
m1
dim(m1)
```

**결과 : **

```
surname		nationality		title
1 Hitchcock		UK		Psycho
2 Hitchcock		UK		North by Northwest
3 Polanski		Poland		Chinatown
4 Scorsese		US		Taxi Driver
5 Spielberg		US		Super 8
6 Spielberg		US		Catch Me If You Can
7 Tarantino		US		Reservoir Dogs
```



공통의 key 변수가 서로 다른 이름을 가지고 있을 경우에 데이터 프레임들을 병합해 보자.

우리는 `movies` 데이터 프레임에서 `surname`을 `name`으로 바꾼다. 우리는 `identical(x1, x2)` 함수를 사용하여 두 데이터 프레임이 동일한지 확인한다.

```
# Change name of ` movies ` dataframe
colnames(movies)[colnames(movies) == 'surname'] <- 'name'

# Merge with different key value
m2 <- merge(producers, movies, by.x = "surname", by.y = "name")

# Print head of the data
head(m2)
```



**결과 :**

```
##surname     nationality		title
## 1 Hitchcock          UK		Psycho
## 2 Hitchcock          UK		North by Northwest
## 3 Polanski          Poland		Chinatown
## 4 Scorsese           US		Taxi Driver
## 5 Spielberg          US		Super 8
## 6 Spielberg          US		Catch Me If You Can
# Check if data are identical
identical(m1, m2)
```



**결과 :**

```
## [1] TRUE
```

이는 열 이름이 다르더라도 병합 작업이 수행됨을 보여준다.



## 부분 대응

두 데이터 프레임이 동일한 공통 key 변수를 가지고 있지 않다는 것은 놀라운 일이 아니다. **완전 대응(full matching)**에서 데이터프레임은 `x`와 `y` 데이터 프레임 모두에서 발견되는 **행만** 반환한다. **부분 병합(partial merging)**을 사용하면 다른 데이터 프레임에 대응하는 행이 없는 행을 유지할 수 있다. 이러한 행은 대개 `y` 값들로 채워진 열에 `NA`를 가진다. 우리는 `all.x=TRUE`라고 설정함으로써 그렇게 할 수 있다.

For instance, we can add a new producer, Lucas, in the producer data frame without the movie references in movies data frame. If we set all.x= FALSE, R will join only the matching values in both data set. In our case, the producer Lucas will not be join to the merge because it is missing from one dataset.

예를 들어, `movies`데이터 프레임에 영화 참조가 없는 `producer`데이터 프레임에 새로운 프로듀서로 `Lucas`를 추가할 수 있다. 만일 `all.x = FALSE`로 설정하면, R은 두 데이터 세트의 일치 값만 결합한다. 우리의 경우, `producer` `Lucas`는 하나의 데이터 세트에서 누락되었기 때문에 합병에 참여하지 않을 것이다.

`all.x=TRUE`를 지정할 때와 그렇지 않을 때 각 결과의 차원을 살펴보자.

```
# Create a new producer
add_producer <-  c('Lucas', 'US')
#  Append it to the ` producer` dataframe
producers <- rbind(producers, add_producer)
# Use a partial merge 
m3 <-merge(producers, movies, by.x = "surname", by.y = "name", all.x = TRUE)
m3
```

**결과 : **

[![img](https://www.guru99.com/images/r_programming/merge_data_frames.png)](https://www.guru99.com/images/r_programming/merge_data_frames.png)

```
# Compare the dimension of each data frame
dim(m1)
```

**결과 : **

```
## [1] 7 3
```



```{r}
dim(m2)
```

**결과 :**

```
## [1] 7 3
```



```{r}
dim(m3)
```

**결과 : **

```
## [1] 8 3
```

우리가 볼 수 있듯이, 새로 데이터 프레임 `m3`의 차원은 8x3인데, `m1`과 `m2`의 차원 7x3과 대조된다. R은 `books` 데이터 프레임에서 저자 명이 누락된 부분에 대해서는 `NA`가 입력된다.