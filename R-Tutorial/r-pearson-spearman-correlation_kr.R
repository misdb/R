library(dplyr)
PATH <-"https://raw.githubusercontent.com/guru99-edu/R-Programming/master/british_household.csv"
data <-read.csv(PATH)
head(data)

# data %>%
data1 <- filter(data, income < 500)

head(data1)
dim(data1)

# data %>%
  data2 <- mutate(data1, log_income = log(income),
         log_totexp = log(totexp),
         children_fac = factor(children, order = TRUE, labels = c("No", "Yes")))

str(data2)
dim(data2)

data %>%
# select(-c(X, X.1, children, totexp, income))
data3 <- select(data2, -c(X, children, totexp, income))

glimpse(data3)

# the last column of data is a factor level. We don't include it in the code
mat_1 <-as.dist(round(cor(data3[,1:9]),2))
mat_1

install.packages("Hmisc")
library("Hmisc")
data_rcorr <-as.matrix(data3[, 1:9])
mat_2 <-rcorr(data_rcorr)

str(mat_2)
mat_2[["r"]]
mat_2[["n"]]
mat_2[["P"]]

p_value <-round(mat_2[["P"]], 3)
p_value

install.packages("GGally")
library(GGally)
ggcorr(data3)

ggcorr(data3,
    nbreaks = 6,
    low = "steelblue",
    mid = "white",
    high = "darkred",
    geom = "circle")

ggcorr(data3,
    nbreaks = 6,
    label = TRUE,
    label_size = 3,
    color = "grey50")

library(ggplot2)
ggpairs(data3, columns = c("log_totexp", "log_income", "age", "wtrans"), title = "Bivariate analysis of revenue expenditure by the British household", upper = list(continuous = wrap("cor",
        size = 3)),
    lower = list(continuous = wrap("smooth",
        alpha = 0.3,
        size = 0.1)),
    mapping = aes(color = children_fac))

ggpairs(data3, columns = c("log_totexp", "log_income", "age", "wtrans"),
    title = "Bivariate analysis of revenue expenditure by the British household",
    upper = list(continuous = wrap("cor", size = 3),
                 mapping = aes(color = children_fac)),
    lower = list(continuous = wrap("smooth",
                 alpha = 0.3,
                 size = 0.1))
)