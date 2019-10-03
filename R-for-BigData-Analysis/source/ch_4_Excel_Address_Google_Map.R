# ch_4_Excel_Address_Google_Map

# 사용할 라이브러리
library(ggplot2)
library(RgoogleMaps)
library(ggmap)

# 라이브러리가 설치되지 않은 경우 라이브러리를 설치한다.
install.packages("ggplot2")
install.packages("RgoogleMaps")
install.packages("ggmap")

# 주소록 파일(csv)을 불러온다. 
# 단. csv 파일은 엑셀파일 작성 후 저장 시, 
# [CSV(쉼표로 분리)(*.csv)] 형식으로 저장이 되어 있어야 함

df.addr <- read.csv(file.choose())
df.addr
str(df.addr)

# 주소 열을 문자벡터로 변환하여 addr에 저장한다.
addr <- as.character(df.addr$주소)
addr

# Google API Authentication
register_google(key = "Google API Key")

# 주소의 geocode 다운로드 
gc <- geocode(enc2utf8(addr))
gc

# 센터명 열을 문자벡터로 변환하여 names에 저장한다.
names <- as.character(df.addr$센터명)
names

# 센터 별 geocode를 담고 있는 데이터 프레임 df 생성
df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df

# 지도의 중심점 계산
cen <- c(mean(df$lon), mean(df$lat))
cen

# 구글 지도정보 확인 및 구글 지도에 표시하기
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=gc)
ggmap(map)