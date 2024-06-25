# Remote sensing on R
# This is a script to visualize satellite data

install.packages("devtools") # install devtools
library(devtools) # use devtools
# CRA (comprehensive R archive packages)
# the one we need is not in CRA so we need devtools to obtain packages somewhere else
devtools::install_github("ducciorocchini/imageRy") # install imagery
library(imageRy) # to make a check
library(terra)

# now we will use a function from the package imageRy (all the functions in this package are preceded by im.)
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

# exercise: plot in multiframe the bands with dfferent color ramps
cl2 <- colorRampPalette(c("lightblue", "blue", "darkblue")) (100)
cl3 <- colorRampPalette(c("lightgreen", "darkgreen", "black")) (100)
cl4 <- colorRampPalette(c("pink", "red", "darkred")) (100)
cl8 <- colorRampPalette(c("yellow", "orange", "darkorange")) (100)

par(mfrow=c(2,2))
plot(b2, col=cl2)
plot(b3, col=cl3)
plot(b4, col=cl4)
plot(b8, col=cl8)

# stackent: 
# band2 blue element1, stacksent[[1]]
# b3 green el2, stacksent[[2]]
# b4 red el3, stacksent[[3]]
# b8 nir el4, stacksent[[4]]
dev.off()
im.plotRGB(stacksent, r=3, g=2, b=1) # bands in the visible for humans
# seems black and white, is actually dark green, this is what we see with our eyes, 
# we need other wavelenghts to see it in a meaningful manner (now is very low resolution)
# the NIR wavelenght

# we can add NIR to obtain a clearer image, but we need to sacrifice a previous band
# we remove blue and shift by one the bands 
im.plotRGB(stacksent, r=4, g=3, b=2)
# epidermis of healthy leaves reflect a lot in the NIR, everything that will appear red is vegetation.
# NIR is on top of the red component
# there are two kinds of vegetation, bright red is pastures whereas the darker one is woods
# we receive additional info compared to the previous one
im.plotRGB(stacksent, r=3, g=4, b=2) # now the NIR is on top of the red, so everithing green is going to appear fluorescent
# light green pastures, dark green woods, violet is soil
im.plotRGB(stacksent, r=3, g=2, b=4) # NIR is on top of blue, vegetation will be blue
# soil is yellow

# We are not deciding the colors, this are the colors coming out of the reflectance of certain wavelengths

# you want to see the correlation between different bands
# confronting the values of each pixel in the bands
# there is a function to do that for you
# not just geographical data, you can use it for any table
pairs(stacksent)
# graph of correlation between each band with relative coefficient
#the histogram is the frequency of the reflectance







