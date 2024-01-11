# Simulating color blind vision
library(devtools)
devtools::install_github("clauswilke/colorblindr")
library(colorblindr)
library(ggplot2)

iris
head(iris)
# data about different flowers and corresponding properties

# create plot about sepal length of the different species 
fig <- ggplot(iris, aes(Sepal.Length, fill = Species)) + geom_density(alpha=0.7)
fig
# ColorRampPalette used is not colorblind-friendly
# use function to resolve this problem (cvd = color vision deficiency)
cvd_grid(fig)
# shows use how people with different vision deficiency see the plot 

# new plot with sepal width
fig2 <- ggplot(iris, aes(Sepal.Width, fill = Species)) + geom_density(alpha=0.7)
fig2
cvd_grid(fig2)
