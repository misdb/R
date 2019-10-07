# ch_03_01_Function

# 내장함수 예제
a <- 1:5	
sqrt(a)	
exp(a)	

out <- (a + sqrt(a))/(exp(2)+1); out	
	
x1 <- seq(-2, 4, by = .5); x1	
	
floor(x1)	
	
trunc(x1)	
	
a <- c(1,-2,3,-4)	
b <- c(-1,2,-3,4)	
	
min(a,b)	
	
pmin(a,b)

# 정규분포
dnorm(x, mean=0, sd=1) # 확률밀도함수	
x <- seq(-3,3, length=30)	
y <- dnorm(x)	
plot(x, y, type='l', main="N(0,1)", ylab="f(x)")	
	
# pnorm(q, mean=0, sd=1)   # 누적분포함수P(Z≤1.96)=?, whereZ∼N(0,12)	
pnorm(1.96)	
	
# rnorm(n, mean=0, sd=1)    # 난수(랜덤넘버)생성	
rnorm(10)

# print() : 객체의 값을 화면에 출력
a <- c(5,3,6,2,4)	
print(a)	

# cat()
cat("mean of a is ",mean(a), "variance of a is ", var(a),"\n")	

# unique() : 서로 다른 원소값들
x <- c(1,5,1,3,5,7,5)	
unique(x)

# substr(x, start, stop) : 문자열에서 일부 추출	
x <- c("노무현","이명박", "박근혜", "문재인") 	
substr(x, 1, 1) 

# paste()
paste("x",1:3,sep="")	
paste("x",1:3,sep="M")	
paste("Today is", date())

# 예제 1

f <- function(x1, x2) {	
y <- x1 ^2 + x2 ^2	
return(y)	
}

f(x1=1, x2=2)	
f(3, 4)	
f(x1=c(1,2), x2=c(3,4))

# 예제 2
normal_hist <- function(m, s, n) {	
  x <-  rnorm(n, mean=m, sd=s)	
  hist(x, main=paste0("N(",m, ",", s^2, ")"))	
}
normal_hist(m=5, s=3, n=100)
