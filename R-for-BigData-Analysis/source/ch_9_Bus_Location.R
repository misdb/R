<<<<<<< HEAD
# ch_9_Bus_Location
# data.go.kr 에서   
# 1) 대전광역시 노선정보조회 서비스와 
# 2) 버스위치정보 조회 서비스 활용신청을 한다.

#===============================================
# 대전광역시 노선별 기본정보 조회 
#===============================================
install.packages("XML")
install.packages("ggmap")

library(XML)
library(ggmap)

#===============================================
# 노선번호로 노선ID 찾기 모듈 필요 (작업 중)  (예, 706번 노선번호의 노선ID 찾기)
#===============================================

busRtNm <- "706"                          # 원하는 버스번호
API_key <- "각자의 API Key 입력"            # data.go.kr   마이페이지/인증키발급현황

url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getRouteInfoAll?serviceKey=", API_key, "&reqPage=1", sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# 번호에 대한 노선 ID 확인  

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
head(df)

df_busRoute <- subset(df, ROUTE_NO==busRtNm)   # 노선번호로 검색
df_busRoute

df_busRoute$ROUTE_CD                         # 노선 ID 확인

#===============================================
# 해당 노선ID의 버스 실시간 위치정보 검색
#===============================================

url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busposinfo/getBusPosByRtid?busRouteId=",df_busRoute$ROUTE_CD, "&serviceKey=", API_key, sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
df

gpsX <- as.numeric(as.character(df$GPS_LONG))     # 경도 코드 (x축)
gpsY <- as.numeric(as.character(df$GPS_LATI))     # 위도 코드 (y축)

gc <- data.frame(lon=gpsX, lat=gpsY)
gc

#===============================================
# 구글 맵에 실시간 버스 위치 출력
#===============================================

#================ 지도 상의 중짐지점
cen <- c(mean(gc$lon), mean(gc$lat))
cen
#================ 현재 위치 마커 표시 : 
register_google(key="Google Key")            # 구글 API 인증

map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
ggmap(map, extent="device")

#================ 현재 위치 점 찍기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map) 

gmap + geom_point(data = gc, aes(x=lon, y=lat), size = 2, colour='blue')            # 현재 위치 점찍기 

#================ 차량번호 표시하기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map, extent="device", legend="right")

gmap + 
geom_point(data=gc, 			 # 현재 위치 점찍기
		aes(x=lon, y=lat), 
		size = 2, 
		colour='blue') + 
geom_text(data=gc, 
		aes(x=lon,y=lat, colour=factor(df$PLATE_NO)), 
		size=3, 
		label=seq_along(df$PLATE_NO))                # 차량번호 출력

=======
# ch_9_Bus_Location
# data.go.kr 에서   
# 1) 대전광역시 노선정보조회 서비스와 
# 2) 버스위치정보 조회 서비스 활용신청을 한다.

#===============================================
# 대전광역시 노선별 기본정보 조회 
#===============================================
# install.packages("XML")
# install.packages("ggmap")

library(XML)
library(ggmap)

#===============================================
# 노선번호로 노선ID 찾기 모듈 필요 (작업 중)  (예, 106번 노선번호의 노선ID 찾기)
#===============================================

# (1) 노선정보조회 서비스 URL 확인 : data.go.kr의 [미리보기] -> Web Browser의 url
busRtNm <- "106"                          # 원하는 버스번호
API_key <- "API Key"                       # data.go.kr   마이페이지/인증키발급현황

# (2) 노선정보조회 : xmlParse()
url <- paste0("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getRouteInfoAll?serviceKey=", API_key, "&reqPage=1")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# (3) xml 형태를 dataframe 형태로 변환 : xmlToDataFrame()
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
head(df)

# (4) 노선번호에 대한 노선ID 확인 : subset()
df_busRoute <- subset(df, ROUTE_NO==busRtNm)     # 노선번호로 검색
busRoute <- df_busRoute$ROUTE_CD                 # 노선 ID 확인
busRoute

#===============================================
# 해당 노선ID의 버스 실시간 위치정보 검색
#===============================================

# (1) [버스 위치정보 조회 서비스 - 노선별 버스위치정보 조회]의 URL 확인 : data.go.kr의 [미리보기] -> Web Browser의 url
url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busposinfo/getBusPosByRtid?busRouteId=",busRoute, "&serviceKey=", API_key, sep="")

# (2) [버스위치정보 조회] 하기
xmefile <- xmlParse(url)
xmlRoot(xmefile)

# (3) 조회된 정보를 data frame 형태로 변경하기
df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
df

# (4) 정류소별 geocode 확인해서 gc 파일에 저장하기
gpsX <- as.numeric(df$GPS_LONG)                  # 경도 코드 (x축)
gpsY <- as.numeric(df$GPS_LATI)                  # 위도 코드 (y축)

gc <- data.frame(lon=gpsX, lat=gpsY)
gc

#===============================================
# 구글 맵에 (실시간 버스) 위치 표시하기
#===============================================

# (1) 지도 상의 중짐 지점 확인
cen <- c(mean(gc$lon), mean(gc$lat))
cen

# (2)버스의 현재 위치를 마커로 표시하기
register_google(key="Google Key")            # 구글 API 인증

map <- get_googlemap(center=cen, maptype="roadmap",zoom=12, marker=gc)
ggmap(map, extent="device")

# (3) 현재 위치 점 찍기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map) 

gmap + geom_point(data = gc, aes(x=lon, y=lat), size = 2, colour='blue')            # 현재 위치 점찍기 

# (4) 차량번호 표시하기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map, extent="device", legend="right")

gmap + 
geom_point(data=gc, 			 # 현재 위치 점찍기
		aes(x=lon, y=lat), 
		size = 5, 
		colour='blue') + 
geom_text(data=gc, 
		aes(x=lon,y=lat, colour=factor(df$PLATE_NO)), 
		size=3, 
		label=seq_along(df$PLATE_NO))                # 차량번호 출력
>>>>>>> e540b2c741f11756a20da0117693866a4a43dac9
