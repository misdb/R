## 제4장 엑셀 주소록을 구글 맵에 표시하기



**[데이터세트 :** [삼성전자서비스센터.csv](data/서비스센터(대전)주소록.csv)]



1. ##### 사용할 라이브러리

```{r}
# 사용할 라이브러리
library(ggplot2)
library(RgoogleMaps)
library(ggmap)

# 라이브러리가 설치되지 않은 경우 라이브러리를 설치한다.
install.packages("ggplot2")
install.packages("RgoogleMaps")
install.packages("ggmap")
```



2. ##### 주소록 파일 불러오기(import)

```{r}
# 주소록 파일(csv)을 불러온다. 
# 단. csv 파일은 엑셀파일 작성 후 저장 시, 
# [CSV(쉼표로 분리)(*.csv)] 형식으로 저장이 되어 있어야 함

df.addr <- read.csv(file.choose())
df.addr
```

결과 :

```
##         센터명                    주소
## 1   1.유성센터  대전 유성구 계룡로 111
## 2   2.대전센터  대전 유성구 계백로 953
## 3 3.동대전센터 대전 동구 동서대로 1684
## 4   4.서구센터  대전 서구 대덕대로 222
## 5 5.중대전센터   대전 중구 계
```



3. `센터명`과 `주소` 열의 데이터 타입이 factor 형. 이를 문자형으로 변환한다. (`as.character()` 함수 사용)

```{r}
# 주소 열을 문자벡터로 변환하여 addr에 저장한다.
addr <- as.character(df.addr$주소)
addr
```

결과 :

```
## [1] "대전 유성구 계룡로 111"  "대전 유성구 계백로 953" 
## [3] "대전 동구 동서대로 1684" "대전 서구 대덕대로 222" 
## [5] "대전 중구 계백로 
```



4. ##### 구글 API 인증 및 주소록의 geocode 다운로드

```{r}
# Google API Authentication
register_google(key = "AIzaSyAf8vkz_1OJj4o8zCUkPJMYY7nEK8LbFJw")

# 주소의 geocode 다운로드 
gc <- geocode(enc2utf8(addr))
gc
```

결과 :

```
## # A tibble: 5 x 2
##     lon   lat
##   <dbl> <dbl>
## 1  127.  36.4
## 2  127.  36.3
## 3  127.  36.3
## 4  127.  36.4
## 5  127.  36.3
```



5. ##### `센터명` 열의 데이터 타입도 문자열로 변경한다.

```{r}
# 센터명 열을 문자벡터로 변환하여 names에 저장한다.
names <- as.character(df.addr$센터명)
names
```

결과 :

```
## [1] "1.유성센터"   "2.대전센터"   "3.동대전센터" "4.서구센터"  
## [5] "5.중대전센
```



6. ##### 이제 센터명과 geocode로 구성된 데이터 프레임 변수 `df`를 생성한다.

```{r}
# 센터 별 geocode를 담고 있는 데이터 프레임 df 생성
df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df
```

결과 :

```
##           name      lon      lat
## 1   1.유성센터 127.3432 36.35354
## 2   2.대전센터 127.2917 36.27933
## 3 3.동대전센터 127.4371 36.34877
## 4   4.서구센터 127.3797 36.35236
## 5 5.중대전센터 127.4061 36.32
```



7. ##### 지도의 중심 지점 계산

```{r}
# 지도의 중심점 계산
cen <- c(mean(df$lon), mean(df$lat))
cen
```

결과 :

```
## [1] 127.37157  36.33099
```



8. ##### 구글 지도정보 확인 및 구글 지도에 센터  위치 표시하기

```{r}
# 구글 지도정보 확인 및 구글 지도에 표시하기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=gc)
ggmap(map)
```

결과 :

![1570056116746](images/1570056116746.png)

--------

[<img src="images/R.png" alt="R" style="zoom:80%;" />](source/ch_4_Excel_Address_Google_Map.R) [<img src="images/pdf_image.png" alt="pdf_image" style="zoom:80%;" />](pdf/ch_4_Excel_Address_Google_Map.pdf)

