library(dplyr) 
PATH <- "https://raw.githubusercontent.com/guru99-edu/R-Programming/master/travel_times.csv"
df <- read.csv(PATH)
glimpse(df)

sum(df$Comments =="")

step_1_df <- select(df, -Comments)
dim(df)

dim(step_1_df)

table(step_1_df$GoingTo)

# Select observations
if GoingTo == Home
select_home <- filter(df, GoingTo == "Home")
dim(select_home)

# Select observations
if GoingTo == Work
select_work <- filter(df, GoingTo == "GSK")
dim(select_work)

# pipeline
# Step 1
step_1 <- read.csv(PATH)
# Step 2 
step_2 <- select(step_1, GoingTo, DayOfWeek)
# Step 3 
step_3 <- filter(step_2, GoingTo == "Home", DayOfWeek == "Wednesday")
head(step_3)

# Create the data frame filter_home_wed.It will be the object return at the end of the pipeline
filter_home_wed <- 
#Step 1
read.csv(PATH) %>% 
#Step 2
select(GoingTo, DayOfWeek) %>% 
#Step 3
filter(GoingTo == "Home",DayOfWeek == "Wednesday")
identical(step_3, filter_home_wed)

# Sort by destination and distance
step_2_df <-step_1_df %>%
	arrange(GoingTo, Distance)
head(step_2_df)
