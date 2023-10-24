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
