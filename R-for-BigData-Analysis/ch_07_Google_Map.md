## 제7장 지도 활용하기

### 2. 구글 맵 다루기


#### 2-1. 도시(서울) 중심의 지도 출력

```{r}
install.packages("ggmap")
library(ggmap)

register_google(key="Google API Key") # https://console.cloud.google.com 에서 확인

gc <- geocode(enc2utf8('서울'))       # 1) 원하는 지역의 geocode확인 : '대전', '대구', Daejeon, Daegu, Seoul
gc <- geocode('Daejeon')             #    gc <- geocode('Seoul') : 지역명을 영문으로 하는 경우 코드변환 불필요

cen <- as.numeric(gc)                # 2) geocode를 수치형 데이터로 변형하고, 그 중심위치 찾기
map <- get_googlemap(center=cen)     # 3) 중심점(cen)을 중심으로 하는 지도정보 확인
ggmap(map)                           # 4) 지도 그리기



```



#### 2-2. 임의 주소지(충청북도 단양군) 중심의 지도 출력
```{r}
gc <- geocode(enc2utf8('충청북도 단양군'))          # 1) 원하는 지역의 geocode 확인
cen <- as.numeric(gc)                            # 2) geocode를 수치로 변형하고, 중심점 찾기
map <- get_googlemap(center=cen,                 # 3) 지도정보 확인 : ?get_googlemap()
       maptype="roadmap")                        #    단, 지도형태를 'terrain'으로 한다.

maptype = c("terrain", "satellite", "roadmap", "hybrid")

ggmap(map)                                       # 4) 지도 그리기
```



#### 2-3. 전체 영역으로 지도 출력
```{r}
map <- get_googlemap(center=cen, maptype="roadmap")    # 3) 지도형태 변경 'roadmap'
ggmap(map, extent="device")                            # 4) 지도 그리기 형태 변경 : 환면 전체 
```



#### 2-4. 마커 출력
```{r}
gc <- geocode(enc2utf8('대전광역시 유성구 지족동 834'))       # 1) geocode 확인
cen <- as.numeric(gc)                         # 2) 중심점 확인
map <- get_googlemap(center=cen,              # 3) gc 코드를 마커로 지정
                     maptype="roadmap", 
                     zoom=18,
                     marker=gc)
ggmap(map, extent="device")                   # 4) 지도 그리기
ggmap(map) 
```



### 3. 여러 지역(단양팔경)을 지도 위에 표시하기

#### 3-1.  단양팔경 위치의 마커 출력
```{r}
names <- c("1.도담삼봉/석문",                 # names : 단양팔경의 명칭, 문자벡터
           "2.구담/옥순봉", 
           "3.사인암", 
           "4.하선암", 
           "5.중선암", 
           "6.상선암")
addr <- c("충청북도 단양군 매포읍 삼봉로 644-33", # addr : 각 지점의 주소, 문자벡터
          "충청북도 단양군 단성면 월악로 3827",
          "충청북도 단양군 대강면 사인암2길 42",
          "충청북도 단양군 단성면 선암계곡로 1337",
          "충청북도 단양군 단성면 선암계곡로 868-2",
          "충청북도 단양군 단성면 선암계곡로 790")
gc <- geocode(enc2utf8(addr))               # 1) addr 각 요소에 대한 geocode 확인
gc

df <- data.frame(name=names,                # 2-1) gc를 데이터프레임으로 변화
                 lon=gclon, 
                 lat=gclat)   
df

cen <- c(mean(dflon), mean(dflat))        # 2-2) gc의 중심위치 찾기
cen 

map <- get_googlemap(center=cen,            # 3) 지도 정보 확인
                     maptype="roadmap",     #    지도 형태
                     zoom=11,               #    지도 크기
                     marker=gc)             #    addr의 요소를 지도에 marker 

ggmap(map)                                  # 4) 지도 그리기
```



#### 3-2. 단양팔경 이름 출력
```{r}
gmap <- ggmap(map)                          # 5) 지도 그리기를 변수로 지정
gmap + geom_text(data=df,                   # 6) 지도정보
                 aes(x=lon, y=lat), 
                 size=5, 
                 label=df$name)             # 7) 지점정보 (라벨 지정)
```



#### 3-3. 범례 출력
```{r}
map <- get_googlemap(center=cen,                # 3) 기본적인 지도 정보 확인
                     maptype = "roadmap",       
                     zoom=11)
gmap <- ggmap(map,                              # 4) 지도그림 정보
              extent="device", 
              legend="topright")

gmap + geom_text(data=df,                       # 5) 지도위에 표시될 라벨 지정 
                 aes(lon, lat, colour=factor(name)), 
                 size=10, 
                 label=seq_along(df$name))
```



### 4. 지진 위치 출력 (quakes)



#### 4-1. 지진 지역의 마커 표시

```{r}
library(ggmap)

df <- head(quakes, 100)                   # 1) 지진 위치 정보 데이터 : geocode
df

cen <- c(mean(dflong), mean(dflat))     # 2) 중심지점 확인
cen

gc <- data.frame(lon=dflong, lat=dflat)  
gclon <- ifelse(gclon>180, -(360-gclon), gclon)
gc
```



#### 4-2. 여백없이 지도 출력

```{r}
map <- get_googlemap(center=cen, 
                     scale=1, 
                     maptype="roadmap",
                     zoom=4, 
                     marker=gc)
ggmap(map, extent="device")       # extent = "device"
```



#### 4-3. 지진 규모 표시
```{r}
map <- get_googlemap(center=cen, 
                     scale=1, 
                     maptype="roadmap",
                     zoom=5)

ggmap(map, fullpage = TRUE) + 
      geom_point(data=df, 
                 aes(x=long, y=lat, size=mag), 
                 alpha=0.5)
```

