# 데이터를 엑셀, CSV, SAS, STATA, Text 파일 등으로  내보내기



### R에서 데이터 내보내는 방법

이 튜토리얼에서는 R 환경에서 다른 형식으로 데이터를 내보내는 방법에 대하여 학습할 것이다.

To export data to the hard drive, you need the file path and an extension. First of all, the path is the location where the data will be stored. In this tutorial, you will see how to store data on:

데이터를 하드 드라이브로 내보내려면 파일 경로와 확장명이 필요하다. 우선, 경로는 데이터가 저장될 위치다. 이 튜토리얼에서는 데이터를 저장하는 방법을 알아보겠다 :

- 하드 드라이브
- 구글 드라이브
- 드랍 박스

둘째로, R은 사용자가 다른 종류의 파일로 데이터를 내보낼 수 있도록 한다. 우리는 중요한 파일 확장자를 다룬다 :

- csv
- xlsx
- RDS
- SAS
- SPSS
- STATA

전체적으로, R에서 데이터를 내보내는 것은 어렵지 않다.

이 튜토리얼에서는 다음에 대하여 학습한다.

- [하드 드라이브로 내보내기](./r-exporting-data_kr.html#8)
- [CSV로 내보내기](./r-exporting-data_kr.html#9)
- [엑셀 파일로 내보내기](./r-exporting-data_kr.html#1)
- [다른 소프트웨어로 내보내기](./r-exporting-data_kr.html#2)
- [SAS 파일로 내보내기](./r-exporting-data_kr.html#3)
- [STATA 파일로 내보내기](./r-exporting-data_kr.html#4)
- [클라우드 서비스 이용](./r-exporting-data_kr.html#5)
- [구글 드라이브](./r-exporting-data_kr.html#6)
- [드랍 박스로 내보내기](./r-exporting-data_kr.html#7)



## 하드 드라이브로 내보내기

To begin with, you can save the data directly into the working directory. The following code prints the path of your working directory:

우선 데이터를 작업 디렉토리에 직접 저장할 수 있다. 다음 코드는 작업 디렉토리의 경로를 출력한다.

```
directory <-getwd()
directory
```

**Output:**

```
## [1] "/Users/15_Export_to_do"	
```

기본적으로 파일은 다음의 경로에 저장이 될 것이다.

맥OS의 경우 :

```
/Users/USERNAME/Downloads/	
```

윈도우즈의 경우 :

```
C:/Users/USERNAME/Documents/     # use '/' instead of '\'
```

물론 다른 경로로 설정할 수 있다. 예를 들어, 경로를 "다운로드" 폴더로 변경할 수 있다 (`setwd()`함수 이용).



## 데이터 프레임 생성

우선, `mtcars` 데이터를 불러와서, `mpg`와 `disp`의 평균을 `gear` 그룹 별로 구해보자.

```
library(dplyr)
df <-mtcars %>%
    select(mpg, disp, gear) %>%
    group_by(gear) %>%
    summarize(mean_mpg = mean(mpg), mean_disp = mean(disp))
df
```

**Output :**

```
## # A tibble: 3 x 3
##	gear mean_mpg mean_disp
##	<dbl>	<dbl>	lt;dbl>
## 1	3 16.10667  326.3000
## 2 	4 24.53333  123.0167
## 3	5 21.38000  202.4800
```

이 테이블은 3개의 행과 3개의 열을 포함하고 있다. 이제 `write.csv()` 함수를 이용하여 CSV 파일을 생성할 수 있다.



## CSV로 내보내기

기본적인 구문법은 다음과 같다 :

```
write.csv(df, path)
```

**인수 :**

- df : 저장할 데이터 세트. 환경에 있는 데이터 프레임의과 같은 이름이어야 한다.
- path : 문자열. 저장 경로를 설정한다. (경로 + 파일명 + 확장자)
- "/Users/USERNAME/Downloads/mydata.csv" 또는 만일 폴더가 작업 디렉토리와 같다면 (파일명 + 확장자) 



**예 :**

```
write.csv(df, "table_car.csv")
```

**코드 설명**

- write.csv(df, "table_car.csv") : CSV 파일을 하드 드라이브에 저장.
  - df : 환경에 있는 데이터 프레임 이름
    - "table_car.csv" : `table_car`를 파일명으로 하고, 확장자는 csv로 저장.

**주의** : 행들을 (;)으로 구분하기 위해 write.csv2() 함수를 사용할 수 있다.

```
write.csv2(df, "table_car.csv")
```

**Note** : 교육적 목적으로만, 우리는 당신을 위한 디렉토리 폴더를 열기 위해 `open_folder()`라는 함수를 만들었다. 아래의 코드를 실행하여 csv 파일이 저장되어 있는 위치를 확인하기만 하면 된다. `table_car.csv`라는 파일 명을 확인해야 한다.

```
# Run this code to create the function
open_folder <-function(dir){
	if (.Platform['OS.type'] == "windows"){
	shell.exec(dir)  
	} else {
	system(paste(Sys.getenv("R_BROWSER"), dir))
  }
}
# Call the function to open the folder
open_folder("C:/Users")
```

**결과 :**

![cap006](C:\Users\Kim_DaeHo\Pictures\cap006.png)





## 엑셀 파일로 내보내기

Excel로 데이터 내보내기는 윈도우즈 사용자에게는 사소한 일이고 Mac OS 사용자에게는 다루기 힘든 부분이다. 두 사용자 모두 `xlsx` 라이브러리를 사용하여 엑셀 파일을 만들 것이다. 약간의 차이는 라이브러리의 설치에서 비롯된다. 실제로 `xlsx` 라이브러리는 파일을 만들기 위해 자바(Java)를 사용한다. 자바가 컴퓨터에 설치되어 있지 않으면 설치해야 한다.



**윈도우즈 사용자**

윈도우즈 사용자라면 conda를 이용하여 직접 라이브러리를 설치할 수 있다.

```
conda install -c r r-xlsx
```

일단 라이브러리가 설치되면, write.xlsx() 함수를 사용할 수 있다. 새로운 엑셀의 워크북은 작업 디렉토리에 저장된다.

```
library(xlsx)
write.xlsx(df, "table_car.xlsx")
```



만일 Mac OS 사용자라면 다음의 단계를 따라야 한다 :

- 단계 1 : Java 최신 버전 설치
- 단계 2 : `rjava` 라이브러리 설치
- 단계 3 : `xlsx` 라이브러리 설치



**단계 1)** [공식 오라클 사이트](https://java.com/ko/download/)에서 Java를 다운로드하여 설치할 수 있다. Rstudio로 돌아가서 어떤 버전의 Java가 설치되어 있는지 확인할 수 있다.

```
system("java -version")
```

이 튜토리얼을 작성할 당시의 최신의 Java 버전은 9.0.4 이다.

**단계 2)** R에 rjava 라이브러리를 설치해야 한다. 우리는 당신이 아나콘다와 함께 R과 Rstudio를 설치할 것을 권고했다. 아나콘다는 라이브러리 사이의 의존성을 관리한다. 이런 의미에서 아나콘다는 rJava 설치의 복잡성을 해결해 줄 것이다.

우선 conda를 업데이트한 다음 [library](https://anaconda.org/r/r-rjava)를 설치해야 한다. 다음 두 줄의 코드를 복사하여 단말기에 붙여넣을 수 있다.

```
conda - conda update
conda install -c r r-rjava
```

다음으로 Rstudio에서 `rjava` 라이브러리를 연다.

```
library(rJava)
```

**단계 3)** 마지막으로, xlsx를 설치할 때이다. 또 한번 더 이를 위해 [conda](https://anaconda.org/r/r-xlsx)를 사용할 수 있다 :

```
conda install -c r r-xlsx
```

윈도우즈 사용자와 마찬가지로 `write.xlsx()` 함수로 데이터를 저장할 수 있다.

```
library(xlsx)
```

**결과 :**

```
## Loading required package: xlsxjars
write.xlsx(df, "table_car.xlsx")
```



## 다른 소프트웨어로 내보내기

데이터를 다른 소프트웨어로 내보내는 것은 데이터를 가져오는 것만큼 간단하다. `haven` 라이브러리는 데이터를 다음의 형태로 편리하게 내보낼 수 있는 방법을 제공한다

- spss
- sas
- stata

우선, 라이브러리를 불러온다. 만일 `haven` 라이브러리가 없으면, 그것을 설치하기 위해 [여기](https://anaconda.org/conda-forge/r-haven)에 가면 된다.

```
library(haven)		
```



### SPSS 파일

다음은 데이터를 SPSS 소프트웨어로 내보내는 코드이다 :

```
write_sav(df, "table_car.sav")	
```



## SAS 파일로 내보내기

SPSS 만큼 간단하다. SAS로 다음과 같이 내보낼 수 있다.

```
write_sas(df, "table_car.sas7bdat")
```



## STATA 파일로 내보내기

끝으로, `haven` 라이브러리는 .dta 파일을 작성할 수 있게 해준다.

```
write_dta(df, "table_car.dta")
```



## R

데이터 프레임이나 다른 R 오브젝트를 저장하고 싶다면 `save()` 함수를 이용하면 된다.

```
save(df, file ='table_car.RData')
```



현재의 작업 디렉토리에 위에서 저장한 파일들을 확인할 수 있다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD1.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD1.png)



## 클라우드 서비스 이용하기

Last but not least, R is equipped with fantastic libraries to interact with the cloud computing services. The last part of this tutorial deals with export/import files from:

마지막으로, R은 클라우드 컴퓨팅 서비스와 상호 작용할 수 있는 환상적인 라이브러리를 갖추고 있다. 이 튜토리얼의 마지막 부분에서는 파일을 다음으로 내보내기 그리고 다음에서 불러오기에 대하여 알아본다 :

- 구글 드라이브
- 드랍 박스

**주의 **: 튜토리얼의 이 부분은 당신이 구글 드라이브(Google Drive)과 드랍 박스(Dropbox)에 계정을 가지고 있다고 가정한다. 그렇지 않은 경우 Google Drive: https://accounts.google.com/SignUp?hl=en - Dropbox: https://www.dropbox.com/h에서 쉽게 만들 수 있다.



## 구글 드라이브

Google Drive와 상호 작용할 수 있는 기능에 액세스하려면 라이브러리 `gogledrive`를 설치해야 한다.

그 라이브러리는 아나콘다에서 아직 이용할 수 없다. 콘솔에서 아래 코드를 사용하여 설치할 수 있다.

```
install.packages("googledrive")	
```

라이브러리를 다음과 같이 열 수 있다.

```
library(googledrive)
```

콘다 사용자가 아닌 경우, 라이브러리를 설치하기 쉽고, 괄호 안에 패키지 이름과 함께 `install.packages('NAME OF PACKAGE')` 함수를 사용할 수 있다. install과 packages 사이의 '. '을 잊지 마라. R은 자동으로 `libPath()`에 패키지를 설치하도록 되어 있다. 어떻게 작동하는지 살펴볼 만하다.



### 구글 드라이브에 업로드하기

Google 드라이브에 파일을 업로드하려면 `drive_upload()` 함수를 사용해야 한다.

Rstudio를 다시 시작할 때마다 Google 드라이브에 `tidyverse` 엑세스를 허용하라는 메시지가 표시된다.

`drive_upload()`의 기본 구문은 다음과 같다.

```
drive_upload(file, path = NULL, name = NULL)	
```

**인수 :**

- file : 업로드할 파일의 완전한 이름 (확장자 포함)
- path : 파일의 위치 : 원하면 이름을 다시 붙일 수 있다. 기본 값으로 로컬 경로이다.



코드를 진행시킨다음, 몇 개의 질문에 답해야 할 것이다.

```
drive_upload("table_car.csv", name ="table_car")
```

**결과 :**

```
## Local file: 
## * table_car.csv 
## uploaded into Drive file: 
## * table_car: 1hwb57eT-9qSgDHt9CrVt5Ht7RHogQaMk 
## with MIME type: 
## * text/csv
```

접근에 대한 확인을 위해 console에 `1`을 입력한다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD2.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD2.png)

그러면, 접근을 허용하는 Google API가 나타난다. `Allow` 버튼을 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD3.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD3.png)

일단 인증(authentication) 완료되면, 브라우저를 닫는다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD4.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD4.png)



Rstudio의 console에서 수행된 단계의 요약을 볼 수 있다. Google은 드라이브에 로컬에 위치한 파일을 업로드하는 데 성공했다. 구글은 드라이브에 있는 각 파일에 ID를 할당했다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD5.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD5.png)

여러분은 이 파일을 구글 스프레드시트로 볼 수 있다.

```
drive_browse("table_car")
```

**결과 :**

구글 스프레드시트가 열릴 것이다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD6.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD6.png)



### 구글 드라이브에서 불러오기

Google Drive에서 ID로 파일을 불러오면 편리하다. 파일 이름을 알면 다음과 같이 ID를 얻을 수 있다.

**주의 :** 인터넷 연결과 드라이브 크기에 따라 시간이 소요된다.



```
x <-drive_get("table_car")
as_id(x)
```

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD7.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD7.png)



ID를 x 변수에 저장했다. drive_download() 함수는 구글 드라이브에서 파일을 다운로드하게 해준다.

기본적인 구문표현은 다음과 같다 :

```
drive_download(file, path = NULL, overwrite = FALSE)
```

**인스 :**

- file :  다운로드할 파일명 또는 파일 ID
- path : 파일을 다운받을 경로. 기본적으로 작업 디렉토리에 구글 드라이브에 있는 파일명으로 저장된다.
- overwrite = FALSE: 파일이 이미 존재하고 있다면, 그 파일을 덮어쓰지 않는다. 만일 `TRUE`로 설정하면 이전의 파일은 지워지고 새 파일로 대체된다.

이제 파일을 다운로드 할 수 있다 :

```
download_google <- drive_download(as_id(x), overwrite = TRUE)
```

**코드 설명 :**

- drive_download() : 구글 드라이브에서 파일을 다운로드하는 함수
- as_id(x) : 구글 드라이브에 있는 파일을 찾기 위해 ID를 사용
- overwrite = TRUE : 만일 파일이 존재하면 덮어쓰고, 그렇지 않으면 중지한다. 로컬에 있는 파일의 이름을 보고 싶으며 사용할 수 있다.

**Output:**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD8.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD8.png)

The file is stored in your working directory. Remember, you need to add the extenstion of the file to open it in R. You can create the full name with the function paste() (i.e. table_car.csv)

파일이 작업 디렉토리에 저장된다. R에서 그것을 열려면 파일의 확장자를 추가해야 한다는 점을 기억하라. paste() 함수를 사용하여 전체 이름을 만들 수 있다(예: table_car.csv).

```
google_file <- download_google$local_path
google_file

path <- paste(google_file, ".csv", sep = "")
google_table_car <- read.csv(path)
google_table_car
```

**결과 :**

```
##   X gear mean_mpg mean_disp
## 1 1    3 16.10667  326.3000
## 2 2    4 24.53333  123.0167
## 3 3    5 21.38000  202.4800
```



마지막으로 Google 드라이브에서 파일을 제거할 수 있다.

```
## remove file
drive_find("table_car") %>% drive_rm()
```

**Output:**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD9.gif)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD9.gif)

아주 느린 과정이다. 삭제하는데 시간이 걸린다.



## 드랍 박스로 내보내기

R interacts with Dropbox via the rdrop2 library. The library is not available at Anaconda as well. You can install it via the console

R은 `rdrop2` 라이브러리를 통해 드랍 박스(Dropbox)와 상호 작용한다. 이 라이브러리는 anaconda에서도 이용할 수 없다. console을 통해 설치할 수 있다.

```
install.packages('rdrop2')
library(rdrop2)
```

자격 증명을 사용하여 드랍 박스에 임시로 액세스해야 한다. 식별이 완료된 후 R은 드랍 박스로 업로드 및 다운로드를 생성하고 제거할 수 있다.

우선 여러분의 계정에 접근할 필요가 있다. 모든 세션 중에 자격 검증이 저장된다.

```
drop_auth()
```

이제 인증을 확인하는 드랍 박스 창이 열린다. `Allow`버튼을 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD10.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD10.png)

확인 페이지가 나타나고 그 페이지를 닫으면 R로 돌아간다.

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD11.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD11.png)

`drop_create()`함수를 이용해 폴더를 생성할 수 있다.

- drop_create('my_first_drop') : 드랍 박스의 첫 폴더(`my_first_drop`)를 생성한다.
- drop_create('First_branch/my_first_drop') : `First_branch` 폴더 밑에 `my_first_drop` 폴더를 생성한다.

```
drop_create('my_first_drop')
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD12.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD12.png)

In DropBox

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD13.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD13.png)



.csv 파일을 Dropbox에 업로드하려면 drop_upload() 함수를 사용하라.

기본 구문 :

```
drop_upload(file, path = NULL, mode = "overwrite")
```

**인수 :**

- file : 로칼 파일
- path: 드랍 박스의 경로
- mode = "overwrite":  기본값으로 기존 파일을 덮어 쓴다. `add`로 설정하면 업로드가 완료되지 않는다.



```{r}
drop_upload('table_car.csv', path = "my_first_drop")
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD14.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD14.png)

At DropBox

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD15.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD15.png)

`drop_read_csv()` 함수로 Dropbox의 csv 파일을 읽을 수 있다.

```
dropbox_table_car <-drop_read_csv("my_first_drop/table_car.csv")
dropbox_table_car
```

**결과 :**

```
##   X gear mean_mpg mean_disp
## 1 1    3 16.10667  326.3000
## 2 2    4 24.53333  123.0167
## 3 3    5 21.38000  202.4800
```



파일 사용을 완료하고 삭제하려는 경우, `function drop_delete()` 함수에 파일의 경로를 기입해야 한다.

```
drop_delete('my_first_drop/table_car.csv')
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD16.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD16.png)



폴더를 삭제할 수도 있다.

```
drop_delete('my_first_drop')
```

**결과 :**

[![img](https://www.guru99.com/images/r_programming/032918_0502_RExportingD17.png)](https://www.guru99.com/images/r_programming/032918_0502_RExportingD17.png)



## 요약

다음의 표에 모든 함수를 요약하였다.

| Library     | Objective                  | Function           |
| :---------- | :------------------------- | :----------------- |
| base        | csv 내보내기               | write.csv()        |
| xlsx        | 엑셀 내보내기              | write.xlsx()       |
| haven       | SPSS 내보내기              | write_sav()        |
| haven       | SAS 내보내기               | write_sas()        |
| haven       | STATA 내보내기             | write_dta()        |
| base        | R 내보내기                 | save()             |
| googledrive | 구글 드라이브에 업로드     | drive_upload()     |
| googledrive | 구글 드라이브 열기         | drive_browse()     |
| googledrive | 파일 ID 검색               | drive_get(as_id()) |
| googledrive | 구글 드라이브에서 다운로드 | download_google()  |
| googledrive | 구글 드라이브 파일 제거    | drive_rm()         |
| rdrop2      | 인증                       | drop_auth()        |
| rdrop2      | 폴더 만들기                | drop_create()      |
| rdrop2      | 드랍 박스에 업로드         | drop_upload()      |
| rdrop2      | 드랍 박스에서 CSV 읽기     | drop_read_csv      |
| rdrop2      | 드랍 박스에서 파일 지우기  | drop_delete()      |

 