library(ggplot2)

path <- 'https://raw.githubusercontent.com/guru99-edu/R-Programming/master/women.csv'
df <-read.csv(path)

# Scatter Plot
ggplot(df,aes(x=height, y =  weight))+
geom_point()

# Estimation of beta1
beta1 <- cov(df$height, df$weight) / var (df$height)
beta

# Estimation of beta0
beta0 <- mean(df$weight) - beta * mean(df$height)
beta0

# Continuous variables
library(dplyr)
df <- mtcars %>%
select(-c(am, vs, cyl, gear, carb))
glimpse(df)

# Estimation of mpg
model <- mpg ~ disp + hp + drat + wt
fit <- lm(model, df)
fit

# More information
summary(fit) 

# ANOVA test
anova(fit)

par(mfrow=c(2,2))
plot(fit)

fit
fit$coefficients
fit$residuals
fit$fitted.values

# factor regression
model <- mpg ~ disp + hp + drat + wt + am
df <- mtcars %>%
mutate(cyl = factor(cyl),
        vs = factor(vs),
        am = factor(am),
       ear = factor(gear),
      carb = factor(carb))
summary(lm(model, df))

# stepwise regression
library(GGally)
df <- mtcars %>%
	select(-c(am, vs, cyl, gear, carb))
ggscatmat(df, columns = 1: ncol(df))
