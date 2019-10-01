library(dplyr)
library(ggplot2)
# Step 1
data_air <- airquality %>%

#Step 2
select(-c(Solar.R, Temp)) %>%

#Step 3
mutate(Month = factor(Month, order = TRUE, 
               labels = c("May", "June", "July", "August", "September")), 
       
#Step 4 
day_cat = factor(ifelse(Day < 10, "Begin", ifelse(Day < 20, "Middle", "End"))))

glimpse(data_air)

# Step 5
data_air_nona <-data_air %>% na.omit()	

head(data_air_nona)

# Store the graph
box_plot <- ggplot(data_air_nona, aes(x = Month, y = Ozone))
# Add the geometric object box plot
box_plot +
    geom_boxplot()

box_plot +
  geom_boxplot()+
  coord_flip()

box_plot +
    geom_boxplot(outlier.colour = "red",
        outlier.shape = 2,
        outlier.size = 3) +
    theme_classic()

box_plot +
    geom_boxplot() +
    stat_summary(fun.y = mean,
        geom = "point",
        size = 3,
        color = "steelblue") +
    theme_classic()

box_plot +
    geom_boxplot() +
    geom_dotplot(binaxis = 'y',
        dotsize = 1,
        stackdir = 'center') +
    theme_classic()

ggplot(data_air_nona, aes(x = Month, y = Ozone, color = Month)) +
    geom_boxplot() +
    theme_classic()

ggplot(data_air_nona, aes(Month, Ozone)) +
    geom_boxplot(aes(fill = day_cat)) +
    theme_classic()

box_plot +
    geom_boxplot() +
    geom_jitter(shape = 15,
        color = "steelblue",
        position = position_jitter(width = 0.21)) +
    theme_classic()

box_plot +
    geom_boxplot() +
    geom_point(shape = 5,
        color = "steelblue") +
    theme_classic()


box_plot +
    geom_boxplot(notch = TRUE) +
    theme_classic()
