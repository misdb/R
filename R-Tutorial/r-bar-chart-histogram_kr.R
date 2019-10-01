library(ggplot2)
# Most basic bar chart
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar()

# Change the color of the bars
ggplot(mtcars, aes(x = factor(cyl))) +
    geom_bar(fill = "coral") +
    theme_classic()

grDevices::colors()	

# Change intensity
ggplot(mtcars,
        aes(factor(cyl))) +
    geom_bar(fill = "coral",
        alpha = 0.5) +
    theme_classic()

# Color by group
ggplot(mtcars, aes(factor(cyl),
        fill = factor(cyl))) +
    geom_bar()

# Add a group in the bars
library(dplyr)
# Step 1
data <- mtcars %>% 
#Step 2
mutate(am = factor(am, labels = c("auto", "man")),
    cyl = factor(cyl))
# Step 3
ggplot(data, aes(x = cyl, fill = am)) +
    geom_bar() +
    theme_classic()

# Bar chart in percentage
ggplot(data, aes(x = cyl, fill = am)) +
    geom_bar(position = "fill") +
    theme_classic()

# Histogram

# Step 1. Create a new variable
data_histogram <- mtcars %>%
mutate(cyl = factor(cyl)) %>%
group_by(cyl) %>%
summarize(mean_mpg = round(mean(mpg), 2))
# Step 2. Create a basic histogram
ggplot(data_histogram, aes(x = cyl, y = mean_mpg)) +
    geom_bar(stat = "identity")
# Step 3. Change the orientation
ggplot(data_histogram, aes(x = cyl, y = mean_mpg)) +
    geom_bar(stat = "identity") +
    coord_flip()
# Step 4. Change the color
ggplot(data_histogram, aes(x = cyl, y = mean_mpg, fill = cyl)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    theme_classic()
# Step 5. Change the size
graph <- ggplot(data_histogram, aes(x = cyl, y = mean_mpg, fill = cyl)) +
    geom_bar(stat = "identity", width = 0.5) +
    coord_flip() +
    theme_classic()
graph

# Step 6. Add labels to the graph
graph +
    geom_text(aes(label = mean_mpg),
        hjust = 1.5,
        color = "white",
        size = 3) +
    theme_classic()
