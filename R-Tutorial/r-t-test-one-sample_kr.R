set.seed(123) 
sugar_cookie <- rnorm(30, mean = 9.99, sd = 0.04)
head(sugar_cookie)

# one-sample t-test
# H0 : mu = 10
t.test(sugar_cookie, mu = 10)

# paired t-test
set.seed(123)
# sales before the program
sales_before <- rnorm(7, mean = 50000, sd = 50)
# sales after the program.This has higher mean
sales_after <- rnorm(7, mean = 50075, sd = 50)
# draw the distribution
t.test(sales_before, sales_after,var.equal = TRUE)