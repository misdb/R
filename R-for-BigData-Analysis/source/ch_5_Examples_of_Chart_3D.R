# ch_5_Examples_of_Chart_3D

install.packages("latticeExtra")
library(latticeExtra)

# 데이터 변수 d 생성하기
d <- read.table(text='x  y  z
                     t1   5   high
                     t1   2   low
                     t1   4   med
                     t2   8   high
                     t2   1   low
                     t2   3   med
                     t3  50   high
                     t3  12   med
                     t3  35   low', 
                 header=TRUE)
d

# 차트 그리기 예제 4
cloud(y ~ x + z, 
      d, 
      panel.3d.cloud = panel.3dbars, 
      col.facet='grey',       
      xbase=0.4, 
      ybase=0.4, 
      scales=list(arrows=FALSE, col=1),       
      par.settings = list(axis.line = list(col = "transparent")))

# 차트 그리기 예제 5
cloud(prop.table(Titanic, margin = 1:3),
      type = c("p", "h"), 
      strip = strip.custom(strip.names = TRUE),
      scales = list(arrows = FALSE, distance = 2), 
      panel.aspect = 0.7,
      zlab = "Proportion")[, 1]

# 차트 그리기 예제 6
# volcano 
# 87 x 61 matrix

wireframe(volcano, 
          shade = TRUE,
          aspect = c(61/87, 0.4),
          light.source = c(10,0,10)
          )

# 설명서 3쪽의 예제 :  화산 (예제 7)

install.packages("plot3D")
library(plot3D)

image2D(Hypsometry, 
        xlab = "longitude", 
        ylab = "latitude",
        contour = list(levels = 0, col = "black", lwd = 2),
        shade = 0.1, 
        main = "Hypsometry data set", 
        clab = "m")

rect(-50, 10, -20, 40, lwd = 3)

ii <- which(Hypsometry$x > -50 & Hypsometry$x < -20)
jj <- which(Hypsometry$y > 10 & Hypsometry$y < 40)

zlim <- c(-10000, 0)


