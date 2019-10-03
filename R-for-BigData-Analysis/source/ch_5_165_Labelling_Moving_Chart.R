# ch_5_165_Labelling_Moving_Chart

install.packages("animation")
library(animation)
ani.options(interval = 1)
 
while(TRUE) {
    y <- runif(5, 0, 1)
    bp <- barplot(y, ylim = c(0, 1), col=rainbow(5))
    
    text(x=bp, y=y, 
         labels=round(y,2),       # ¶óº§ y
         pos=1)   
    
    ani.pause()
}