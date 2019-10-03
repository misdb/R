# ch_13_flipping_coins

# 동전 한번 던지기
iteration <- 1

plot(0, 0, xlab="동전을 던진 회수", ylab="앞면이 나오는 비율", xlim=c(0, iteration), ylim=c(0, 1)) 
abline(a=0.5, b=0, col="red")

sum <- 0

for (x in 1:iteration) {
    coin <- sample(c("앞면", "뒷면"), 1, replace=T)
    if (coin == "앞면")
        sum = sum + 1 
    prob <- sum / x
    points(x, prob)
}

# 동전 열번 던지기
iteration <- 10           # 동전 던지기 횟수를 수정하면 그 만큼 동전 던지기를 하게 됨. (10 -> 5,000)

plot(0, 0, xlab="동전을 던진 회수", ylab="앞면이 나오는 비율", xlim=c(0, iteration), ylim=c(0, 1)) 
abline(a=0.5, b=0, col="red")

sum <- 0
for (x in 1:iteration) {
    coin <- sample(c("앞면", "뒷면"), 1, replace=T)
    if (coin == "앞면")
        sum = sum + 1 
    prob <- sum / x
    points(x, prob)
}