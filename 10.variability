# Measure of RS based variability
install.packages("viridis")
library(terra)
library(imageRy)
library(viridis)

im.list()
sent <- im.import("sentinel.png")
# band1 = NIR
# band2 = red
# band3 = green
im.plotRGB(sent, r=1, g=2, b=3) # rocks are green, vegetation red
im.plotRGB(sent, r=2, g=1, b=3) # rocks are violet, vegetation green

nir <- sent[[1]]
plot(nir) # the green is vegetation, orange is bare soil (8bit, 256 values)

# Moving window (method to measure variability)
# It measure the standard deviation in a window of 9 pixels, considering the  central pixel as the mean,
# than it moves by one, it goes on till it has covered all the image

# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # how many pixels and in which dimensions
plot(sd3)
# chnage legend
viridisc <- colorRampPalette(viridis(7))(255) # use 7 colors of viridis
plot(sd3, col=viridisc) # represent variability of NIR in the image
# NW area has an abrupt change in elevation that causes change in amount of vegetation
