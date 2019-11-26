# ch_9_Bus_Route_of_Daejeon_106

#===============================================
# (1) 대전광역시 노선별 기본정보 조회 
#===============================================
# install.packages("XML")
# install.packages("ggmap")
library(XML)
library(ggmap)

#===============================================
# 노선버스정보 조회 (노선버스 전체)
#===============================================
busRtNm <- "106"                              # 노선번호
API_key <- "data.go.kr API Key"               # data.go.kr에서 발급받은 API_key 입력

url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getRouteInfoAll?serviceKey=", API_key, "&reqPage=1", sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE)
head(df)

# 노선 ID 확인 방법 #1)
busRoute <- df[which(df$ROUTE_NO==busRtNm), names(df) %in% c("ROUTE_CD")]  # df$ROUTE_NO == busRtNm인 ROUTE_CD (노선ID) 값 반환
busRoute

# 노선 ID 확인 방법 #2)
df_busRoute <- subset(df, ROUTE_NO==busRtNm)   # 노선번호로 검색
df_busRoute
(busRoute <- df_busRoute$ROUTE_CD)             # 노선 ID 확인

#===============================================
# (2) 노선별 경유 정류소 목록 조회 
#===============================================
url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getStaionByRoute?busRouteId=",
			busRoute, 
			"&serviceKey=", 
			API_key, 
			sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"), stringsAsFactors = FALSE )
df
str(df)


gpsX <- as.numeric(df$GPS_LONG)
gpsY <- as.numeric(df$GPS_LATI)

name <- df$BUSSTOP_NM

gc <- data.frame(lon=gpsX, lat=gpsY)
str(gc)

#===============================================
# (3) 노선별 경유 정류소 출력
#===============================================

cen <- c(mean(gc$lon), mean(gc$lat))             # 중앙 위치.

register_google(key="Google API Key")            # 구글 API 인증

map <- get_googlemap(center=cen, maptype="roadmap",zoom=12)
gmap <- ggmap(map)

gmap + geom_text(data = gc,                  # 정류장 이름 출력
	 	    aes(x=lon, y=lat), 
		    size=3, 
		    label=name) +                               
	geom_point(data = gc,                  # 정류장 점 찍기
		    aes(x=lon, y=lat), 
		    size = 2, 
		    colour='blue') +                    
	geom_path(data = gc,                   # 노선을 선으로 잇기
		    aes(x =lon, y =lat), 
		    color = "blue", 
		    alpha = .5, 
		    lwd = 1)                  