# ch_9_Bus_Route_of_Daejeon_106

#===============================================
# (1) 대전광역시 노선별 기본정보 조회 
#===============================================

install.packages("XML")
install.packages("ggmap")

library(XML)
library(ggmap)


#===============================================
# 노선버스정보 조회 (노선버스 전체)
#===============================================

busRtNm <- "106"                # 노선번호
API_key <- "Google API Key"     # https://console.cloud.google.com/

url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getRouteInfoAll?serviceKey=", API_key, "&reqPage=1", sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
head(df)

df_busRoute <- subset(df, ROUTE_NO==busRtNm)   # 노선번호로 검색
df_busRoute

(df_busRoute$ROUTE_CD)                         # 노선 ID 확인

#===============================================
# (2) 노선별 경유 정류소 목록 조회 
#===============================================

url <- paste("http://openapitraffic.daejeon.go.kr/api/rest/busRouteInfo/getStaionByRoute?busRouteId=",
			df_busRoute$ROUTE_CD, 
			"&serviceKey=", 
			API_key, 
			sep="")
xmefile <- xmlParse(url)
xmlRoot(xmefile)

df <- xmlToDataFrame(getNodeSet(xmefile, "//itemList"))
df
str(df)


gpsX <- as.numeric(as.character(df$GPS_LONG))
gpsY <- as.numeric(as.character(df$GPS_LATI))

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

gmap + 
	geom_text(data = gc, 
			aes(x=lon, y=lat), 
			size=2, 
			label=name) +                               # 정류장 이름 출력
	geom_point(data = gc, 
			aes(x=lon, y=lat), 
			size = 1, 
			colour='#018b4d') +                    # 정류장 점 찍기
	geom_path(data = gc, 
			aes(x =lon, y =lat), 
			color = "blue", 
			alpha = .5, 
			lwd = 1)            # 노선을 선으로 잇기

