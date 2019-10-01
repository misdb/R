library(dplyr)

# Step 1
data <- read.csv("https://raw.githubusercontent.com/guru99-edu/R-Programming/master/lahman-batting.csv") %>%
# Step 2
select(c(playerID, yearID, AB, teamID, lgID, G, R, HR, SH))  %>% 
# Step 3
arrange(playerID, teamID, yearID)

# Structure of the data
glimpse(data)

summarise(data, mean_run = mean(R))

summarise(data, mean_games = mean(G), 
          mean_SH = mean(SH, na.rm = TRUE))

data %>%
	group_by(lgID) %>%
	summarise(mean_run = mean(HR))

library(ggplot2)
# Step 1
data %>% 
#Step 2
group_by(lgID) %>% 
#Step 3
summarise(mean_home_run = mean(HR)) %>% 
#Step 4
ggplot(aes(x = lgID, y = mean_home_run, fill = lgID)) +
    geom_bar(stat = "identity") +
    theme_classic() +
    labs(
        x = "baseball league",
        y = "Average home run",
        title = paste(
            "Example group_by() with summarise()"
        )
    )


## Mean
ex1 <- data %>%
	group_by(yearID) %>%
	summarise(mean_game_year = mean(G))
head(ex1)

# Plot the graph
ggplot(ex1, aes(x = yearID, y = mean_game_year)) +
    geom_line() +
    theme_classic() +
    labs(
        x = "Year",
        y = "Average games played",
        title = paste(
            "Average games played from 1871 to 2016"
        )
    )

## Subsetting + Median
data %>%
group_by(lgID) %>%
summarise(median_at_bat_league = median(AB), 
	   #Compute the median without the zero 
	    median_at_bat_league_no_zero = median(AB[AB > 0]))

## Sum
data %>%
	group_by(lgID) %>%
	summarise(sum_homerun_league = sum(HR))

# Spread
data %>%
	group_by(teamID) %>%
	summarise(sd_at_bat_league = sd(HR))

# Min and max
data %>%
	group_by(playerID) %>%
	summarise(min_G = min(G),
    max_G = max(G))

# count observations
data %>%
	group_by(playerID) %>%
	summarise(number_year = n()) %>%
	arrange(desc(number_year))

# first and last
data %>%
	group_by(playerID) %>%
	summarise(first_appearance = first(yearID),
		last_appearance = last(yearID))

# min and max
data %>%
	group_by(playerID) %>%
	summarise(first_appearance = min(yearID),
		last_appearance = max(yearID))

# nth
data %>%
	group_by(teamID) %>%
	summarise(second_game = nth(yearID, 2)) %>%
	arrange(second_game)

# distinct values
data %>%
	group_by(teamID) %>%
	summarise(number_player = n_distinct(playerID)) %>%
	arrange(desc(number_player))

# Multiple groups 1.
data %>%
	group_by(teamID, yearID) %>%
	summarise(number_player = n_distinct(playerID)) %>%
	arrange(teamID, yearID)

# Multiple groups 2.
data %>%
	group_by(yearID, teamID) %>%
	summarise(mean_games = mean(G)) %>%
	arrange(desc(yearID, teamID))

# Filter
data %>%
	filter(yearID > 1980) %>%
	group_by(yearID) %>%
	summarise(mean_game_year = mean(G))

# Ungroup the data
data %>%
	filter(HR > 0) %>%
	group_by(playerID) %>%
	summarise(average_HR_game = sum(HR) / sum(G)) %>%
	ungroup() %>%
	summarise(total_average_homerun = mean(average_HR_game))

