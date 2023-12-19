library(imageRy)
library(terra)
im.list()

# blue band
b2 <- im.import("sentinel.dolomites.b2.tif") # b2 is the blue wavelength

# green band
b3 <- im.import("sentinel.dolomites.b3.tif") # b3 is the green wavelength

# red band
b4 <- im.import("sentinel.dolomites.b4.tif") # b4 is the red wavelength

# NIR band
b8 <- im.import("sentinel.dolomites.b8.tif") # b2 is the green wavelength

stacksent <- c(b2, b3, b4, b8)

plot(stacksent)

# RGB colour model: we can add together red, blue and green to see all the colours
im.plotRGB(stacksent, r=3, g=2, b=1)
# the image obtained is represented with the colours visible to humans
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
