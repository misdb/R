install.packages("tidyr")
library(tidyr)

# Example 1
data_table <- read.csv(file.choose(), header=T)
head(data_table, 15)

wide_table <- spread(data_table, 항목, X2019..03.월)
head(wide_table)

long_table <- gather(wide_table, '시도간전입[명]':'총전출[명]', key="항목", value="X2019..03.월")
head(long_table)


# Example 2
data_table <- read.csv(file.choose(), header=T)
data_table

wide_table <- spread(data_table, 항목, X2019..03.월)
wide_table

# Example 3
data_table <- read.csv(file.choose(), header=T)
head(data_table)

wide_table <- spread(data_table, 항목, X2019..03.월)
head(wide_table)

long_table <- gather(wide_table, '시도간전입[명]':'총전출[명]', key="항목", value="X2019..03.월")
head(long_table)