## 제12장 네크워크 분석 : 중심성 / 중심화



### 네트워크 분석

1. 각 **노드 관점**에서 특정 네트워크 분석 => **중심성(centrality)** : 노드별로 각 수치가 계산됨

​    1-1) 연결 중심성(degree)

​    1-2) 근접 중심성(closenee)

​    1-3) 중개 중심성(betweenness)



2. **네트워크 관점**에서 네트워크 분석 => **중심화(centralization)** : 네트워크별로 수치가 계산됨.

​    2-1) 네트워크의 연결 중심화

​    2-2) 근접 중심화

​    2-3) 중개 중심화



### 1. 각 노드 관점에서 특정 네트워크 분석 

=> **중심성(centrality)** : **노드별**로 각 수치가 계산됨

------

1-1) 연결 중심성(degree)

1-2) 근접 중심성(closenee)

1-3) 중개 중심성(betweenness)

-------------





\# 1) g <- g_star



g <- g_star



\# 1-1) 연결 중심성(degree)

degree(g, normalized=FALSE)

degree(g, normalized=TRUE)



\# 1-2) 근접 중심성

closeness(g, normalized=FALSE)

closeness(g, normalized=TRUE)



\# 1-3) 중개 중심성

betweenness(g, normalized=FALSE)

betweenness(g, normalized=TRUE)





\# 2) g <- g_Y



g <- g_Y



\# 2-1) 연결 중심성(degree)

degree(g, normalized=FALSE)

degree(g, normalized=TRUE)



\# 2-2) 근접 중심성

closeness(g, normalized=FALSE)

closeness(g, normalized=TRUE)



\# 2-3) 중개 중심성

betweenness(g, normalized=FALSE)

betweenness(g, normalized=TRUE)





\# 3) g <- g_ring



g <- g_ring



\# 3-1) 연결 중심성(degree)

degree(g, normalized=FALSE)

degree(g, normalized=TRUE)



\# 3-2) 근접 중심성

closeness(g, normalized=FALSE)

closeness(g, normalized=TRUE)



\# 3-3) 중개 중심성

betweenness(g, normalized=FALSE)

betweenness(g, normalized=TRUE)





### 2. 네트워크 관점에서 네트워크 분석 

=> **중심화(centralization)** : **네트워크별**로 수치가 계산됨.

------

2-1) 네트워크의 연결 중심화

2-2) 근접 중심화

2-3) 중개 중심화

------------

\# 1) g <- g_star



g <- g_star



\# 1-1) 연결 중심화

tmax <- centr_degree_tmax(g)

centralization.degree(g, normalized=FALSE)$centralization / tmax



\# 1-2) 근접 중심화

tmax <- centralization.closeness.tmax(g)

centralization.closeness(g, normalized=FALSE)$centralization / tmax 



\# 1-3) 중개 중심화

tmax <- centralization.betweenness.tmax(g)

centralization.betweenness(g, normalized=FALSE)$centralization / tmax



\# 2) g <- g_Y



g <- g_Y



\# 2-1) 연결 중심화

tmax <- centr_degree_tmax(g)

centralization.degree(g, normalized=FALSE)$centralization / tmax



\# 2-2) 근접 중심화

tmax <- centralization.closeness.tmax(g)

centralization.closeness(g, normalized=FALSE)$centralization / tmax 



\# 2-3) 중개 중심화

tmax <- centralization.betweenness.tmax(g)

centralization.betweenness(g, normalized=FALSE)$centralization / tmax



\# 3) g <- g_ring



g <- g_ring



\# 3-1) 연결 중심화

tmax <- centr_degree_tmax(g)

centralization.degree(g, normalized=FALSE)$centralization / tmax



\# 3-2) 근접 중심화

tmax <- centralization.closeness.tmax(g)

centralization.closeness(g, normalized=FALSE)$centralization / tmax 



\# 3-3) 중개 중심화

tmax <- centralization.betweenness.tmax(g)

centralization.betweenness(g, normalized=FALSE)$centralization / tmax





### 3. 분석결과 정리



![img](http://cyber.mokwon.ac.kr/lmsdata/business/course/2018_1_2161333_11/COMF_1805211033413bb70dae.gif)


