# R 프로그래밍 언어 : 소개와 기초



## R

R 프로그램 언어는 1993년에 Ross Ihaka와 Robert Gentleman가 개발하였다. R은 광범위한 통계와 그래픽 메소드를 보유하고 있다. 기계학습 알고리즘, 선형 회귀분석, 시계열 분석, 통계적 추론 등과 같은 몇 가지 예를 들 수 있다.  대부분의 R libraries들은 R로 작성되었지만, 복잡한 연산 처리를 위해서는 C, C++ and Fortran 코드들이 선호된다.

R은 학술분야는 물론 우버, 구글, 에어비엔비, 페이스 북 등과 같은 많은 기업들이 R을 사용하고 있다.

R을 이용한 데이터 분석은 일련의 과정으로 이루어 진다; 프로그래밍, 전환, 발견, 모델링 그리고 결과의 전달.

- **프로그램(Program)**: R은 명확하고 접속가능한 프로그래밍 도구이다.
- **전환(Transform)**: R은 데이터 과학을 위해 특별히 설계된 라이브러리(library)의 집합으로 구성된다.
- **발견(Discover)**: 데이터를 관찰하고, 가설을 정제화하고, 분석한다.
- **모델(Model)**: R은 데이터에 대한 정확한 모델을 발견할 수 있는 다양한 도구들을 제공한다.
- **전달(Communicate)**: 세상과 공유하기 위해 R Markdown이나 Shiny app 보고서에 코드, 그래프 그리고 출력물을 통합한다.

이 튜토리얼을 통해 여러분은 다음의 내용을 학습하게 될 것이다-

- [R의 용도](./r-programming-introduction-basics_kr.html#1)
- [산업별 R](./r-programming-introduction-basics_kr.html#2)
- [R 패키지](./r-programming-introduction-basics_kr.html#3)
- [R과 대화하기](./r-programming-introduction-basics_kr.html#4)
- [R을 사용해야 하는 이유](./r-programming-introduction-basics_kr.html#5)
- [R을 선택해야만 하는가?](./r-programming-introduction-basics_kr.html#6)
- [R은 어려운가?](./r-programming-introduction-basics_kr.html#7)



## R의 용도

- 통계적 추론(Statistical inference)
- 데이터 분석(Data analysis)
- 머신러닝 알고리즘(Machine learning algorithm)



## 산업별 R

산업별 R 사용을 구분해보면, 학술분야가 제일로 많이 사용하고 있음을 알 수 있다. R은 통계적 분석을 위한 언어이다. R은 의료산업이 제일 선두에 있으며, 그 다음이 정부와 컨설팅 분야이다.

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg1.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg1.png)

## R 패키지

R의 주요 용도는 통계처리, 시각화 그리고 기계학습 분야이다. 다음의 그림은 Stack Overflow에서 가장 많은 질문을 받는 R 패키지를 보여주고 있다. 상위 10위 안의 대부분은 자료준비(data preparation)와 결과의 소통(communicate the results) 등 데이터 과학자들의 워크플로우와 관련이 있다.



[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg2.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg2.png)



거의 1만 2천 개에 이르는 R의 라이브러리들은 CRAN에 저장되어 있다. CRAN은 무료의 오픈 소스이다. 여러분은 기계 학습이나 시계열 분석 등의 수행을 위해 다양한 라이브러리를 다운로드하여 사용할 수 있다.

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg3.jpg)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg3.jpg)



## R과 대화하기

R은 '마크다운 문서'나 'shiny 앱' 등을 통하여 작업을 수행하고 공유할 수 있는 다양한 방법을 가지고 있다.  그리고 모든 내용들을 Rpub, GitHub 또는 기업용 웹사이트에 올릴 수 있다.

다음은 [Rpub](https://rpubs.com/)에 호스팅 되어 있는 예이다.

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg4.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg4.png)

Rstudio는 문서를 작성하기 위해 markdown을 허용한다. 그리고 이 문서를 다음과 같은 다양한 문서로 변환출력할 수 있다. 

- 문서(Document) :
  - HTML
  - PDF/Latex
  - Word
- 변환(Presentation)
  - HTML
  - PDF beamer

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg5.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg5.png)



Rstudio는 App을 쉽게 만들 수 있는 좋은 도구이다. 다음은 World Bank 데이터를 처리하는 앱의 예이다.



[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg6.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg6.png)



## R을 사용해야 하는 이유

데이터 과학은 기업이 어떻게 운영되고 있는가를 보여주는 것이다. 의심의 여지없이, 인공지능(AI)과 기계를 멀리한다면 기업은 실패하게 될 것이다. 가장 중요한 질문은 어떠한 도구/언어를 사용해야 하는가이다.

시장에는 데이터 분석을 수행하는데 이용할 수 있는 수 많은 도구가 있다. 새로운 언어를 학습하는 것은 시간의 투자를 요구한다. 아래의 그림은 언어가 제공하는 기업의 능력과 비교한 학습곡선(learning curve)을 보여주고 있다. 마이너스의 관련성은 무상급식이 없음을 보여준다. 만일 데이터로 부터 가장 훌륭한 통찰력(insight)을 얻고자 한다면, R과 같은 적절한 도구를 학습하는데 시간을 투자할 필요가 있다.

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg7.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg7.png)

도표의 왼쪽 위에 엑셀과 PowerBI가 있음을 알 수 있다. 이 두 개의 도구들은 배우기는 쉽지만, 모델링 측면에서, 뛰어난 기업 능력을 제공하지는 못한다. 중앙에는 Python과 SAS가 위치하고 있다. SAS는 기업을 위한 **통계적 분석**을 할 수 있는 전용의 도구이다. SAS는 클릭해서 실행하는 소프트웨어이다. 그러나 Python은 단조로운 학습곡선을 갖는 언어이다. Python은 기계학습과 인공지능을 다루기에 환상적인 도구이지만 의사소통 특성은 약한 면이 있다. 동일한 학습곡선을 갖는 R은 실행과 데이터 분석 사이의 좋은 보상관계에 있다.

데이터 시각화(data visualization, DataViz)와 관련해서 여러분은 tableau에 대해서 들어 봤을 것이다. Tableau는 의심의 여지없이 그래프와 차트를 통해 패턴을 발견하는 훌륭한 도구이다. 또한 Tableau 학습은 많은 시간이 소요되지 않는다. 데이터 시각화와 관련한 하나의 큰 문제는 패터의 발견 또는 단지 무수한 무용한 차트의 생성으로 결고 끝나지 않는다는 것이다. Tableau는 데이터의 빠른 시각화 또는 비즈니스 인텔리전스를 위한 훌륭한 도구이다. 통계적 분석과 의사결정을 위해서는 R이 가장 적절한 도구이다.

Stack Overflow는 프로그램 언어의 큰 커뮤니티이다. 코딩의 문제가 있거나 모델의 이해가 필요하다면 Stack Overflow는 많은 도움이 될 것이다. 수년간 다른 언어들과 비교하여 R에 대한 질문의견의 비율이 가파르게 증가하고 있다. 이러한 추세는 물론 데이터 과학의 호황기와 크게 관련이 있지만 데이터 과학을 위한 R 언어의 요구를 반영하고 있는 것이다.

[![img](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg8.png)](https://www.guru99.com/images/r_programming/032918_1002_WhatisRProg8.png)

데이터 과학에서는 서로 경쟁하고 있는 두 개의 도구가 있다. 그것은 R과 Python인데 이 언어들은 데이터 과학을 정의하는 언어라 할 수 있다.



## R을 선택해야만 하는가?

데이터 과학자들은 R과 Python이라는 두 개의 훌륭한 도구를 사용할 수 있다. 여러분이 데이터 과학을 학습하기 시작했다면 이 언어 두개 모두를 학습할 시간이 없을 수도 있다. **통계적 모형과 알고리즘을 학습**하는 것이 프로그램 언어를 학습하는 것보다 훨씬 더 중요하다. 프로그램 언어는 계산과 발견을 의사소통하는 도구이다. 데이터 과학에서 가장 중요한 일은 데이터를 다루는 방법(import, clean, prep, feature engineering, feature 선택)이다. 이것이 여러분의 가장 중요한 초점이 되어야 한다. 만일 통계학에 대한 든든한 선지식없이 동시에 R과 Python을 공부하고자 한다면, 어리석은 일이 아닐 수 없다. 데이터 과학자들은 프로그래머가 아니다. 그들의 직무는 데이터를 이해하고, 데이터를 조작하여 가장 훌륭한 접근방법을 제시하는 것이다. 만일 여러분이 어떤 언어를 공부할까 고민하고 있다면, 어떠한 언어가 여러분에게 가장 적절한지 살펴보자.

데이터 과학의 가장 중요한 대상은 기업 전문가들이다. 기업에서 하나의 큰 함의는 의사소통이다. 의사소통을 하는데에는 보고서, 웹 앱, 대시보드 등과 같은 많은 방법들이 있다. 여러분은 이러한 모든 것은 동시에 처리할 수 있는 도구를 필요로 한다.



## R은 어려운가?

여러 해 전에는 R은 마스터하기 워려운 언어였다. 이 언어는 혼란스럽고 다른 언어 도구들처럼 구조적이지도 못했다. 이러한 중요한 문제를 극복하기 위해 Hadley Wickham은 tidyverse라는 패키지 묶음을 개발하였다. 게임의 규칙이 결국에는 좋은 방향으로 바뀌었다. 데이터 조작은 사소하고 직관적인 것이 되었다. 그래프 작성은 더 이상 어렵지 않게 되었다.

기계학습을 위한 최선의 알고리즘이 R로 실행될 수 있다. Kera와 Tensorflow와 같은 패키지들은 최고의 기계학습기법의 생성을 가능케 하였다. R은 또한 Kaggle 경쟁을 위한 가장 최선의 알고리즘 중의 하나인 Xgboost를 수행하는 패키지를 가지고 있다.

R은 다른 언어와도 소통할 수 있다. R에서 Java, C++ 등을 호출할 수 있다. 빅데이터 분야도 R로 접근할 수 있다. 또한 Spark나 Hadoop 등과 같은 상이한 데이터베이스에 여러분은 R을 연결할 수 있다.

끝으로, R은 연산의 속도를 빠르게 하기 위해 병렬 연산을 위해 진화하고 허용하게 되었다. 사실 R은 한번에 하나의 CPU만을 사용하는 것으로 비난받기도 했다. 병렬 패키지가 컴퓨터의 다른 코어에서 태스크를 수행할 수 있게 해준다.



## 요약

한 마디로, R은 데이터를 검토하고 조사하기 위한 훌륭한 도구이다. 클러스터링, 상관분석, 그리고 데이터 축소 등과 같은 정교한 분석이 R로 처리된다. 이는 가장 중요한 부분인데 훌륭한 feature engineering과 모델없이 기계학습의 전개는 의미있는 결과를 주지 못할 것이다.

