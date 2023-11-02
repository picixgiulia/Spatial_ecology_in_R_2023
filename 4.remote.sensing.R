install.packages("devtools") # install devtools

library(devtools) # use devtools
# CRA (comprehensive R archive packages)
# the one we need is not in CRA so we need devtools to obtain packages somewhere else


install_github("ducciorocchini/imageRy") # install imagery
library(imageRy) # to make a check
library(terra)

# now we will use a package
im.list()

# importing data
# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength
b2

# green band
b3 <- im.import("sentinel.dolomites.b3.tif") # b2 is the green wavelength
b3

# red band
b4 <- im.import("sentinel.dolomites.b4.tif") # b2 is the green wavelength
b4

# NIR band
b8 <- im.import("sentinel.dolomites.b8.tif") # b2 is the green wavelength
b8

2/11/23
# Remote sensing visualization

library(devtools)
library(imageRy)
library(terra)

im.list()
# importing data
# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength
b2
# coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632)

plot(b2) # blue

cl <- colorRampPalette(c("black", "grey", "light grey")) (100) # 100 is the amount of colours in the gradient
plot(b2, col=cl)

# green band
b3 <- im.import("sentinel.dolomites.b3.tif") # b3 is the green wavelength
b3
plot(b3, col=cl)

# red band
b4 <- im.import("sentinel.dolomites.b4.tif") # b4 is the red wavelength
b4
plot(b4, col=cl)

# NIR band
b8 <- im.import("sentinel.dolomites.b8.tif") # b2 is the green wavelength
b8
plot(b8, col=cl)

# create a multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl)

# create a stack of all the bands (images) together and than plot it
stacksent <- c(b2, b3, b4, b8)
stacksent
# number of layers is 4 -> dimensions  : 934, 1059, 4  (nrow, ncol, nlyr)
dev.off() #it closes devices
plot(stacksent, col=cl) # same as before but jut with one function

plot(stacksent[[4]], col=cl) # to plot a single band










