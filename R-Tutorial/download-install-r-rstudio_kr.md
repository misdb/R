# Mac이나 Windows에서 R, RStudio, Anaconda의 다운로드와 설치



R은 프로그램언어이다. R을 사용하려면 **통합개발환경(Integrated Development Environment**, IDE)을 설치해야 한다. **Rstudio** 은 사용자 친화적이고, 오픈소스이며 Anaconda 플랫폼에 속하는 것으로 가장 훌륭하게 이용할 수 있는 IDE이다.

이 튜토리얼에서는 다음의 내용에 대하여 학습한다.

- [Anaconda 설치](./download-install-r-rstudio_kr.html#1)
  - [Mac 사용자](./download-install-r-rstudio_kr.html#2)~~
  - [Widows 사용자](./download-install-r-rstudio_kr.html#3)
- [R 설치](./download-install-r-rstudio_kr.html#4)
  - [Mac 사용자](./download-install-r-rstudio_kr.html#15)
  - [Windows 사용자](./download-install-r-rstudio_kr.html#5)
- [Rstudio 설치](./download-install-r-rstudio_kr.html#6)
  - [Mac 사용자](./download-install-r-rstudio_kr.html#7)
  - [Windows 사용자](./download-install-r-rstudio_kr.html#8)
- [Rstudio 실행](./download-install-r-rstudio_kr.html#9)
- [테스트](./download-install-r-rstudio_kr.html#10)
- [package 설치](./download-install-r-rstudio_kr.html#11)
- [library 열기](./download-install-r-rstudio_kr.html#12)
- [R 코드 실행](./download-install-r-rstudio_kr.html#13)



[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo1.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo1.png)



## Anaconda 설치

**Anaconda?**

Anaconda 무료 오픈소스는 Python과 R 프로그래밍 언어를 배포하고 있다. Anaconda는 과학계와 데이터 과학자들이 기계학습 프로젝트나 데이터 분석 등을 수행하는데 널리 이용되고 있다.

**왜 Anaconda를 사용하는가?**

Anaconda는 Python이나 R에 요구되는 library를 관리하는데 도움을 줄 것이다. Anaconda는 package 관리를 단순화하기 위해 하나의 폴더에 모든 요구되는 libarary와 IDE를 설치할 것이다. 그렇지 않으면 여러분은 그것들은 하나하나 따로 설치해야 할 것이다.



### Mac 사용자

**단계 1) https://www.anaconda.com/download/ 에 접속하여 ** 여러분의 OS에 맞는 Anaconda for Python 3.6을 **다운로드**한다.

기본적으로 Chrome은 여러분의 시스템의 downloading page를 선택한다. 이 튜토리얼에서는 Mac 용 설치에 대하여 알아본다. 여러분이 Windows나 Linux를 이용하고 있다면, Windows의 경우는 Wndows Installer를 위해 Anaconda 5.1을, Linux의 경우 Linux Instaler를 위한 Anaconda 5.1을 다운로드한다.



[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo2.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo2.png)



**단계 2)** 이제 Anaconda를 설치할 준비가 되었다. 설치를 시작하기 위해 다운로드한 파일을 더블 클릭한다. Mac에서는 .dmg 파일을, Windows는 .exe 파일이다. 설치를 확인하는지 묻는다. **Continue** 버튼을 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo3.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo3.png)



**Anaconda3 Installer**가 나타난다..

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo4.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo4.png)



**단계 3)** 다음 창은 **ReadMe**를 표시한다. 문서의 내용을 읽은 후 **Continue**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo5.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo5.png)



**단계 4)** 이 창은 Anaconda End User License Agreement를 보여준다. 동의하기 위해 **Continue**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo6.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo6.png)



**단계 5)** 다음 단계로 가기 위해 **Agree** 버튼을 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo7.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo7.png)



**단계 6)** Anaconda의 설치 위치를 지정하기 위해 **Change Install Location**를 클릭한다. 기본으로, Anaconda는 사용자의 환경(**Users/YOURNAME/**)에 설치된다. 

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo8.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo8.png)



나만 접속할 수 있게 **Install for me only**를 선택한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo9.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo9.png)



**단계 7)** 이제 Anaconda를 설치할 수 있다. 설치를 진행하기 위해 **Install**을 클릭한다. Anaconda는 하드 드라이브의 2.5GB 정도를 차지한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo10.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo10.png)



메시지 상자가 나타나고, 여기에 사용자 이름(User Name)과 비밀번호(Password)를 입력한다. **Install Software**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo11.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo11.png)



설치하는데 약간의 시간이 소요되며 그 시간은 여러분의 컴퓨터에 따라 다르다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo12.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo12.png)



**단계 8)** Anaconda는 Microsoft VSCode를 설치할 것인지 묻는다. 무시하고 **Continue**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo13.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo13.png)



**단계 9)** 설치가 완료되었다. 이제 창을 닫을 수 있다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo14.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo14.png)



이제 "Anaconda3" Installer를 삭제할 것인지 묻는다. **Move to Trash**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo15.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo15.png)



**이제 macOS 시스템에서 Anaconda 설치가 완료되었다.**



### Windows 사용자

**단계 1)** 다운로드한 exe를 실행하고, **Next**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo16.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo16.png)



**단계 2)** License Agreement를 승인한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo17.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo17.png)



**단계 3)** **Just Me**를 선택하고 **Next**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo18.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo18.png)



**단계 4)**  **Destination Folder**를 선택하고 **Next**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo19.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo19.png)



**단계 5)** **Install** 버튼을 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo20.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo20.png)



**단계 6)** 설치가 시작된다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo21.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo21.png)

**Anaconda가 설치될 것이다.**



## R 설치

### Mac 사용자

**단계 1)** Anaconda는 library를 설치하기 위해 **terminal**을 사용한다. terminal은 library를 설치하기 위는 빠른 방법이다. 올바른 경로로 설치를 지시하는 것을 확인할 필요가 있다. 우리의 경우, Anaconda의 위치를 **Users/USERNAME/**로 설정한다. 우리는 이를 **anaconda3** 점검하여 확인할 수 있다.

**Computer**를 연다음 **Users**, **USERNAME** 그리고 **anaconda3**를 선택한다. 우리가 올바른 경로에 Anaconda를 설치한 것을 확인시켜 준다. 이제 macOS가 어떻게 경로를 작성하는지 살펴보자.  오른쪽 마우스로 클릭한 다음 **Get Info**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo22.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo22.png)



경로 **Where**를 선택한 다음, **Copy**를 클릭한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo23.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo23.png)



**단계 2)** Mac 사용자의 경우:

- 가장 간단한 방법은 **Spotlight Search**를 사용하는 것이고, 그곳에  **terminal**을 입력한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo24.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo24.png)



terminal은 기본 작업 디렉토리를 **Users/USERNAME**으로 설정한다. 아래의 그림에서 볼 수 있듯이, **anaconda3**의 결로와 작업 디렉토리는 같다. macOS에서는 가장 최근의 폴더는 **$** 기호 앞에 나타난다. 나의 경우, **Thomas**이다. terminal은 이 작업 디렉토리에 모든 library들을 설치할 것이다.

텍스트 편집기의 경로가 작업 디렉토리와 일치하지 않는다면 terminal에서 cd PATH를 입력해서 변경할 수 있다.  **PATH**는 텍스트 편집기에 붙여 넣었던 경로이다. Don't forget to wrap the PATH with **"PATH"**를 PATH로 감싸는 것을 잊지 마라. 이 행동은 작업 디렉토리를 **PATH**로 변경할 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo25.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo25.png)

**단계 4)** 이제 R을 설치할 준비가 되었다. 나는 여러분이 terminal에서 모든 패키지와 conda 명령어와의 종속성을 설치할 것을 추천한다.

```
## In the terminal
conda install r-essentials --yes	
```



r-essentials는 conda가 R과 데이터 과학자가 사용할 모든 필요한 library를 설치하는 것을 의미한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo26.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo26.png)

**Conda**가 library들을 다운로드할 것이다. 

모든 library를 업로드하는데 시간이 걸린다. 인내하라. 모든 것이 준비가 되었다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo27.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo27.png)

terminal에서 여러분은 'Excecuting transaction : done' 메시지를 확인해야 한다. 그렇다면 성공적으로 R을 설치한 것이다.

어디에 R에 위치하고 있는지 확인할 수 있다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo28.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo28.png)

### Windows 사용자

**단계 1)** Anaconda 명령 프롬프트를 연다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo29.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo29.png)



**단계 2)** 명령 프롬프트에서 

1. R install 명령어를 입력한다.
2. 환경이 결정될 것이다.
3. 설치될 패키지 목록이 나열될 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo30.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo30.png)



**Step 3)** 설치를 시작하기 위해 y를 입력하고 <return>키를 친다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo31.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo31.png)

**단계 4)** 설치하는데 시간이 걸릴 것이고, done 메시지를 보게 될 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo32.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo32.png)



## Rstudio 설치

### Mac 사용자

terminal에서 다음의 코드를 입력한다.

```
## In the terminal
conda install -c r rstudio --yes
```

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo33.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo33.png)

terminal에서 'Executing transaction: done' 메시지를 확인해야 한다. 그렇다면, **Rstudio**를 성공적으로 설치한 것이다.

이제 모든 것이 준비되었다. 축하합니다!!!



### Windows 사용자

**단계 1)** Anaconda 프롬프트에서 R Studio 설치를 위한 명령어를 입력한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo34.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo34.png)



**단계 2)** 설치될 패키지 목록을 확인할 수 있을 것이다. y를 입력한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo35.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo35.png)



**단계 3)** R Studio가 설치될 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo36.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo36.png)



**주의**

Python과 R을 위해 pip를 사용하는 library를 설치하는 것은 가능하면 피하기 바란다.  Conda library 들은 많은 패키지들을 모아 놓았기 때문에, conda 환경 밖의 library들을 설치할 필요는 없다.



## Rstudio 싫ㅇ

Rstudio를 열기위해 terminal의 명령어 라인에서 직접 실행한다. terminal을 열고 rstudio 라고 입력한다. 또한 데스크탑 단축키를 사용할 수도 있다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo37.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo37.png)

Or

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo38.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo38.png)

**Rstudio** 창이 새롭게 열릴 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo39.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo39.png)



## 시험

Terminal에서 Rstudio를 열고 스크립트를 열어라. 그리고 다음의 명령어를 입력하라.

1. \## In Rstudio 

   **summary**(cars)

2. Run을 클릭

3. Output을 확인한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo40.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo40.png)



여러분이 summary 통계수치를 확인할 수 있다면 이제 작동하는 것이다. 파일을 저장하지 말고 Rstudio를 닫을 수 있다.



## package 설치

anaconda 패키지 설치는 사소한 일이다. 선호하는 브라우저를 열고 library 이름 다음에 **anaconda r** 를 입력하라..

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo41.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo41.png)

anaconda를 지시하는 링크를 선택한다. 그리고 terminal로 그 library를 복사하여 붙여 넣는다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo42.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo42.png)

예를 들어,  랜덤 포리스트에 관한 튜토리얼을 위해 randomForest를 설치할 필요가 있다:  [**https://anaconda.org/r/r-randomforest**](https://anaconda.org/r/r-randomforest)**.**

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo43.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo43.png)

terminal 에서 `conda install -c r r-randomforest --yes`를 입력한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo44.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo44.png)

설치가 완료되었다.

이 튜토리얼을 통해 가장 자주 이용되는 library들이 r-essential conda library와 함께 설치되기 때문에 많은 library들을 설치할 필요가 없다. 그래프를 위한 ggplot과 기계학습 프로젝트를 위한 caret 등을 포함한다.



## library 열기

R 함수인 randomForest()를 실행하기 위해서, 이 함수를 포함하고 있는 library를 열어야 한다. Rstudio script에`library(randomForest)`라고 입력한다.

```
## In Rstudio
library(randomForest)	
## randomForest 4.6-12	
## Type rfNews() to see new features/changes/bug fixes.	
```

**주의:** 불필요한 패키지를 가능하면 열지 않도록 하라. library들 간의 충돌이 발생하는 결과를 가져올 수 있다.



## R code 실행

R에서 코드를 실행하는데에는 두 가지 방법이 있다.

1. 우리는 Console 내에서 code를 실행할 수 있다. 우리의 데이터는 Global Environment에 저장이 될 것이지만 history는 기록되지 않는다. 일단 R을 닫고 나면 그 결과를 복사할 수 없을 것이다. 그러면 우리는 코드 전체를 다시 입력해야 한다. 코드를 저장하기 원한다면 이 방법은 추천하고 싶지 않다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo45.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo45.png)

2. script에 코드를 작성하라. 우리가 원하는 만큼의 많은 줄의 코드를 작성할 수 있다. 코드를 실행하기 위하여 원하는 줄들을 단순히 선택하라. 그리고 run 을 클릭한다. 그러면 Console 에서 그 결과를 볼 수 있다. 스크립트를 저장하여 나중에 열어 볼 수 있다. 우리의 결과를 잃어버리지 않을 것이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo46.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo46.png)

**주의**: 두번쨰 줄(즉, `slice_vector[1:5]`)에 커서를 위치시킨 다음 run을 클릭하면, Console은 에러를 표시한다. 그것은 우리가 첫번째 줄을 실행하지 않았기 때문이다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo47.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo47.png)

마찬가지로, 빈 줄에 커서를 위치시키고 run을 클릭하면 R은 빈 출력을 반환한다.

[![img](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo48.png)](https://www.guru99.com/images/r_programming/032818_0958_HowtoDownlo48.png)

 