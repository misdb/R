# ch_7_using_ggmap_02

library(ggmap) # ggplot2 패키지도 함께 불러온다.
library(ggplot2)

register_google(key = "Google API Key")    # 구글 API 인증

# 1. 한국 지도 그리기.
ggmap(get_map(location='south korea', zoom=7))
ggmap(get_googlemap(location='South Korea', zoom=7))


ggmap(get_map(location='South Korea', zoom=3))
ggmap(get_map(location='South Korea', zoom=21))

myLocation <- c(lon=128.25, lat=35.95)
ggmap(get_map(location=myLocation, zoom=7))

map <- get_map(location='South Korea', zoom=7, source='google', maptype='terrain')
ggmap(map)

map <- get_map(location='South Korea', zoom=7, source='stamen', maptype='watercolor')
ggmap(map)

map <- get_map(location='South Korea', zoom=7, source='osm')
ggmap(map)


# 구글에서 흑백 도로(roadmap) 지도정보를 받아와서, map이라는 변수에 넣으라는 명령어
map <- get_map(location='South Korea', zoom=7, maptype='roadmap', color='bw')
ggmap(map)

# 공공 와이파이(WiFi) 위치 표시
wifi <- read.csv(file.choose(), header=T, as.is=T)
wifi <- subset(wifi, wifi$서비스제공사명 == c("KT", "SKT", "LGU+"))

str(wifi)

ggmap(map) +
	geom_point(data=wifi,
			aes(x = 경도, y = 위도, color = 서비스제공사명 )
)

# stat_density_2d() 함수를 활용
ggmap(map) +                                # 기본 지도
stat_density_2d(data = wifi, 
                aes(x = 경도, y = 위도))      # 2D Density 겹치기


ggmap(map) + 
stat_density_2d(data = wifi, 
                aes(x = 경도, y = 위도, fill=..level.., alpha=..level..),
                geom='polygon',
                size=2, 
                bins=30)

p2d <- ggmap(map) + 
       stat_density_2d(data=wifi, 
                       aes(x = 경도, y = 위도, fill=..level.., alpha=..level..),
                       geom='polygon', 
                       size=7, 
                       bins=28)
p2d      # 또는 print(p2d)


# 밀도를 나타내는 색깔을 바꿔 보기
# 범위에 따라 단계적으로 색깔이 변하게 하는 함수 : scale_fill_gradient()
p_grad <- p2d + scale_fill_gradient(low='yellow', high='red')
p_grad 

# ------
# 투명도 조절
p_alpha <- p2d +
scale_fill_gradient(low='yellow', high='red', guide=F) +
scale_alpha(range=c(0.02, 0.8), guide=F)
p_alpha


# 국내 항공 노선 그리기
airport <- read.csv(file.choose(), header=T, as.is=T) # airport.csv 파일 불러오기
route <- read.csv(file.choose(), header=T, as.is=T)   # route.csv 파일 불러오기

head(airport) # airport, iata, lon, lat 등의 4개 열로 구성
head(route) # id, airport, lon, lat 등의 4개 열로 구성

# 변수 map은 ‘South Korea’ 지도
# ggmap(map) : 한국지도
g_airport <- ggmap(map) + 
             geom_point(data=airport, 
                        aes(x=lon, y=lat))
g_airport

#-------
# geocode() 함수
# ggmap 패키지에는 geocode라는 함수가 들어 있다.
# 이 함수는 특정 장소 위도, 경도값을 찾아주는 기능을 한다.
# 인천공항과 김포공항의 위도, 경도 알아 보기
geocode(c('incheon airport', 'gimpo airport'))

p_point <- ggmap(map) + 
           geom_point(data=airport, aes(x=lon, y=lat))
p_line <- p_point + 
          geom_line(data=route, aes(x=lon, y=lat, group=id))
p_line
