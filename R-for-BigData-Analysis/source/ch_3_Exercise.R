# ch_3_Exercise

# 1.
url <- "https://vincentarelbundock.github.io/Rdatasets/csv/datasets/AirPassengers.csv"
x <- read.csv(url)

str(x)
head(x)

# 2.
setwd("C:/Temp")
write.table(x, "AirPassengers.txt", sep=",")

list.files(pattern="AirPassengers.txt")
dir(pattern="AirPassengers.txt")

# 3.

# 3-1.
x1 <- x$time
head(x1)

# 3-2.
x2 <- x$value
head(x2)

# 3-3.
y <- cbind(x1, x2)
head(y)

# 3-4.
names <- c("time", "value")
colnames(y) <- names
head(y)

# 4.

sum(y[,"value"])

length(y[,"value"])

mean(y[,"value"])

sd(y[,"value"])

summary(y[,"value"])


