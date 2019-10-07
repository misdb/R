# ch_03_02_Data_Import

# read.table(), read.csv() 함수 예제
titanic <- read.table("c:/temp/titanic.txt", header=T, sep="\t")	
head(titanic)

# read_csv 함수 예제
#install.packages("readr")	
library(readr)	
titanic3 <- read_csv("c:/temp/titanic.csv")      ## file name

# 예제 : 수강생 자료
# fileEncoding = "UTF-8": csv파일에서 한글 입력 코딩방식, CP949 또는 UTF-8	

test <- read.csv("c:/temp/test.csv")	
head(test)	
names(test)	
dim(test)

unique(test$Dept)	
(nid <- table(test$Dept))	
barplot(nid, main="학과별 수강생 수")	


# Excel 파일 불러오기

library(readxl)	
o <- read_excel("c:/temp/고용률.xls", sheet=1); head(o)	
	

# 엑셀 파일로 저장하기
install.packages("writexl")
library(writexl)
write_xlsx(o, "c:/temp/고용률(저장).xlsx")	

list.files(pattern="*.xlsx")