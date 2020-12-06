<<<<<<< HEAD
##################################################
# 3. 오픈 API 활용
##################################################


##################################################
# 1) p.251 노선 번호에 대한 노선 ID 확인  
#      (노선정보조회 서비스 Open API 활용가이드 P. 10)
##################################################

install.packages("XML")
install.packages("ggmap")
library(XML)
library(ggmap)

##################################################
# 1-1) 서울시 운행중인 노선 번호와 노선 ID 확인
#      (노선정보조회 서비스 Open API 활용가이드 P. 10)
##################################################

busRtNm <- ""                      # 검색할 노선버스 번호를 빈문자로 정한다. 
API_key <- "API Key"               # data.go.kr에서 발급받은 API_key 입력

url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=",busRtNm,sep="")

xmefile <- xmlParse(url)           # 해당 url에 데이터를 요구(request)하고, 
                                   # 그 결과(response)를 xmefile 변수에 저장한다.
xmlRoot(xmefile)                   # xmefile변수의 내용을 콘솔에 출력한다. 

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))    # xml 형식을 데이터프레임으로 변환.
str(df)                            # 노선정보조회 서비스 Open API 활용 가이드 : p. 10-11 (2) 응답메시지 명세 참고...

head(df)

df$busRouteId                      # 노선ID 전체 출력


##################################################
# 1-2) 서울시 운행중인 특정 노선 번호 (402)의 노선 ID 확인 방법
##################################################


busRtNm <- "402"                                  # 검색할 노선버스 번호

url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=",busRtNm,sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.252
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
head(df)

df_busRoute <- subset(df, busRouteNm==busRtNm)     # busRouteNm 이 busRtNm=402 인 부분집합
df_busRoute

df_busRoute$busRouteId                             # 402번 노선번호의 노선ID 확인


##################################################
# p.253 노선 ID에 대한 버스 실시간 위치 정보 확인
#       버스위치정보조회 서비스 Open API 활용가이드 P. 8 참고
##################################################

url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=",
            df_busRoute$busRouteId, sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.254
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
df

gpsX <- as.numeric(as.character(df$gpsX))
gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=gpsX, lat=gpsY)
gc

##################################################
# p.257 구글 맵에 버스 위치 출력 (marker 표시)
##################################################

register_google(key="Google API Key")      # https://console.cloud.google.com 에서 확인

cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=gc)
ggmap(map, extent="device")


#--------------------------------------------------------------
# 차량번호 포함시키기 => 지도 위에 현재 운행 위치에 차량번호를 표시하기 위해....
#--------------------------------------------------------------
gc1 <- data.frame(BusNo=df$plainNo, lon=gpsX, lat=gpsY)
gc1

cen <- c(mean(gc1$lon), mean(gc1$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map, extent="device")
gmap1 <- gmap + geom_text(data=gc1, aes(x=gc1$lon, y=gc1$lat), size=3, label=gc1$BusNo) +     # 운행중인 버스번호 출력
         geom_point(data = gc1, aes(gc1$lon, gc1$lat), size = 1, colour='#018b4d')            # 운행중인 버스 위치 표시


##################################################
# <추가> 노선 ID에 대한 버스 노선 지도에 표시하기
#       버스 노선정보조회 서비스 Open API 활용가이드 P. 13 참고
##################################################
df_busRoute$busRouteId <- "100100112"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=", API_key, "&busRouteId=",
            df_busRoute$busRouteId, sep="")             # 노선ID에 해당하는 노선의 지도상 경로
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.254
df_path <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
df_path

gpsX <- as.numeric(as.character(df_path$gpsX))
gpsY <- as.numeric(as.character(df_path$gpsY))

#---------------------------------------------------------------------
# http://philogrammer.com/2017-03-15/encoding/ (한글 인코딩문제 해결 방안)
# library(devtools)
# install_github("plgrmr/readAny", force = TRUE)
# library(readAny)
#---------------------------------------------------------------------

stationNo <- type.convert(df_path$stationNo, as.is=TRUE)      # factor -> character로 변환... (한글정거장 이름 stationNm -> 한글변환 에러 발생)
stationNo <- as.character(stationNo)

gc2 <- data.frame(stationNo=stationNo, lon=gpsX, lat=gpsY)
gc2

cen2 <- c(mean(gc2$lon), mean(gc2$lat))

map <- get_googlemap(center=cen2,                # 3) 기본적인 지도 정보 확인
                      maptype = "roadmap",       
                      zoom=12)
gmap <- ggmap(map)

gmap + geom_text(data = gc2, aes(x=lon, y=lat), size=2, label=stationNo, color="red") +         # 정거장 번호 출력
       geom_point(data = gc2, aes(x=gc2$lon, y=gc2$lat), size = 1, colour='#018b4d') +          # 정거장 위치에 점 찍기
       geom_path(data = gc2, aes(x=gc2$lon, y=gc2$lat), color = "blue", alpha = .5, lwd = 1)    # 노선 경로 그리기
=======
##################################################
# 3. 오픈 API 활용
##################################################

##################################################
# 1) p.251 노선 번호에 대한 노선 ID 확인  
#      (노선정보조회 서비스 Open API 활용가이드 P. 10)
##################################################

install.packages("XML")
install.packages("ggmap")
library(XML)
library(ggmap)

##################################################
# 1-1) 서울시 운행중인 노선 번호와 노선 ID 확인
#      (노선정보조회 서비스 Open API 활용가이드 P. 10)
##################################################

busRtNm <- ""                      # 검색할 노선버스 번호를 빈문자로 정한다. 
API_key <- "data.go.kr API Key"               # data.go.kr에서 발급받은 API_key 입력

url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=",busRtNm,sep="")
xmefile <- xmlParse(url)           # 해당 url에 데이터를 요구(request)하고, 
                                   # 그 결과(response)를 xmefile 변수에 저장한다.
xmlRoot(xmefile)                   # xmefile변수의 내용을 콘솔에 출력한다. 

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors=FALSE)    # xml 형식을 데이터프레임으로 변환.
str(df)                            # 노선정보조회 서비스 Open API 활용 가이드 : p. 10-11 (2) 응답메시지 명세 참고...

head(df)

df$busRouteId                      # 노선ID 전체 출력


##################################################
# 1-2) 서울시 운행중인 특정 노선 번호 (402)의 노선 ID 확인 방법
##################################################


busRtNm <- "402"                                  # 검색할 노선버스 번호

url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=",busRtNm,sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.252
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
head(df)

busRouteId <- df$busRouteId   # 402번 노선번호의 노선ID 확인
busRouteId                    # "10010063"


##################################################
# p.253 노선 ID에 대한 버스 실시간 위치 정보 확인
#       버스위치정보조회 서비스 Open API 활용가이드 P. 8 참고
##################################################

url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=",
            busRouteId, sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.254
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
df

gpsX <- as.numeric(df$gpsX)
gpsY <- as.numeric(df$gpsY)
gc <- data.frame(lon=gpsX, lat=gpsY)
gc

##################################################
# p.257 구글 맵에 버스 위치 출력 (marker 표시)
##################################################

register_google(key="Google API Key")      # https://console.cloud.google.com 에서 확인

cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=gc)
ggmap(map, extent="device")


#--------------------------------------------------------------
# 차량번호 포함시키기 => 지도 위에 현재 운행 위치에 차량번호를 표시하기 위해....
#--------------------------------------------------------------
gc1 <- data.frame(BusNo=df$plainNo, lon=gpsX, lat=gpsY)
gc1

cen <- c(mean(gc1$lon), mean(gc1$lat))
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map, extent="device")

gmap + geom_text(data=gc1, aes(x=gc1$lon, y=gc1$lat), size=3, label=gc1$BusNo) +     # 운행중인 버스번호 출력
       geom_point(data = gc1, aes(gc1$lon, gc1$lat), size = 1, colour='#018b4d')            # 운행중인 버스 위치 표시


##################################################
# <추가> 노선 ID에 대한 버스 노선 지도에 표시하기
#       버스 노선정보조회 서비스 Open API 활용가이드 P. 13 참고
##################################################

url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getStaionByRoute?serviceKey=", API_key, "&busRouteId=",
            busRouteId, sep="")             # 노선ID에 해당하는 노선의 지도상 경로
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# p.254
df_path <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
df_path

gpsX <- as.numeric(df_path$gpsX)
gpsY <- as.numeric(df_path$gpsY)

#---------------------------------------------------------------------
# http://philogrammer.com/2017-03-15/encoding/ (한글 인코딩문제 해결 방안)
# library(devtools)
# install_github("plgrmr/readAny", force = TRUE)
# library(readAny)
#---------------------------------------------------------------------

gc2 <- data.frame(stationNo=stationNo, lon=gpsX, lat=gpsY)
gc2

cen2 <- c(mean(gc2$lon), mean(gc2$lat))

map <- get_googlemap(center=cen2,                # 3) 기본적인 지도 정보 확인
                      maptype = "roadmap",       
                      zoom=12)
gmap <- ggmap(map)

gmap + geom_text(data = gc2, aes(x=lon, y=lat), size=2, label=stationNo, color="red") +         # 정거장 번호 출력
       geom_point(data = gc2, aes(x=gc2$lon, y=gc2$lat), size = 1, colour='#018b4d') +          # 정거장 위치에 점 찍기
       geom_path(data = gc2, aes(x=gc2$lon, y=gc2$lat), color = "blue", alpha = .5, lwd = 1)    # 노선 경로 그리기
>>>>>>> e540b2c741f11756a20da0117693866a4a43dac9
