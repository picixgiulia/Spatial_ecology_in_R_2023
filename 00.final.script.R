## 01.begin.R

# What is R? 
# R is a programming language and free software environment for statistical computing and graphics.
# Here I can write anything I want! In this way R cannot run this line, it is just a comment to explain what is happening.

# R as a calculator
2 + 3

# I can assign to an object
zima <- 2 + 3
zima

giulia <- 5 + 3
giulia

final <- zima * giulia
final

final^2

# I can create an array with the function c(), c stands for concatenate.
sophi <- c(10, 20, 30, 50, 70) # microplastics 
# fcuntions have parentheses and inside them there are arguments

paula <- c(100, 500, 600, 1000, 2000) # people
# I can create a plot
plot(paula, sophi)

# I can insert labels for the variables in the plot
plot(paula, sophi, xlab="number of people", ylab="microplastics")

people <- paula
microplastics <- sophi

plot(people, microplastics)
# https://www.google.com/search?client=ubuntu-sn&hs=yV6&sca_esv=570352775&channel=fs&sxsrf=AM9HkKknoSOcu32qjoErsqX4O1ILBOJX4w:1696347741672&q=point+symbols+in+R&tbm=isch&source=lnms&sa=X&ved=2ahUKEwia9brkm9qBAxVrQvEDHbEYDuMQ0pQJegQIChAB&biw=1760&bih=887&dpr=1.09#imgrc=lUw3nrgRKV8ynM
plot(poeple, microplastics, psh=19) #to change the type of points, look up number on internet
plot(poeple, microplastics, psh=19, cex=2) #to change the dimensions of the points
plot(poeple, microplastics, psh=19, cex=2, col="blue") #to change the colour of the points

# With the function 
inctall.package("")
# we can install new packages

## 02.population.density

# Code related to population ecology
# How to create a plot
# A package is needed for point pattern analysis
install.packages("spatstat")
library(spatstat)

# let's use the bei data
# data description: https://CRAN.R-project.org/package=spatstat

bei
# plotting the data
plot(bei)

# changing dimension - cex
plot(bei, cex=.2)

# density map, passing from points to continuous surface
densitymap <- density(bei)
# The following info will appear:
# real-valued pixel image
# 128 x 128 pixel array (ny, nx)
# enclosing rectangle: [0, 1000] x [0, 500] metres
plot(densitymap) # image representing the density of the trees in your area

# we want to add the points of bei on top of the density map
points(bei, cex = .2)

# we want to change the colours, because not all people are able to see the rainbow colour palette
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100) # how many colors we want to see passing through the ones listed
plot(densitymap, col=cl)
# why yellow color as maximum? Because is the first one recognized by the eye

#let's try a lower number
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4) 
plot(densitymap, col=cl) # there is no continuity

# how to know the names of colors in R: look up online
# no green and red or blue and red together

cl2 <- colorRampPalette(c("chartreuse3", "darkorchid3", "darkorange1", "black"))(100)
plot(densitymap, col=cl2)
plot(bei.extra) # with 2 variables
# we want to select only one of the variables
elev <- bei.extra[[1]] # [[]] bevause we are in 2 dimensions (image)
plot(elev)

# another way is using the name
bei.extra
bei.extra$elev

# multiframe: create plot with multiple variables, big frame with more than one plot inside
par(mfrow = c (1,2)) # 1 row and 2 columns
plot(densitymap)
plot(elev)

# we can change position of the plots
par(mfrow = c (2,1)) # 2 rows and 1 column
plot(densitymap)
plot(elev)
par(mfrow = c (1,3))
plot(bei, cex = .2)
plot(densitymap, col = cl2)
plot(elev)

# usefule to compare data and find relations

## 02.population.distribution

# Species Distribution Modelling

# install.packages("sdm")
# install.packages("rgdal", dependencies=T)

library(sdm)
library(terra) # predictors
library(rgdal) # species

file <- system.file("external/species.shp", package="sdm") 
species <- vect(file)

# looking at the set
species

# plot
plot(species)

# when this appears: Error in plot.new() : figure margins too large
# use this function: to adjust plot margins
par(mar = c(1, 1, 1, 1))

# looking at the occurrences
species$Occurrence

# copy and then write:
plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)

presence <- species[species$Occurrence == 1]

# predictors: look at the path
path <- system.file("external", package="sdm") 

# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# stack
elev <- rast("/usr/local/lib/R/site-library/sdm/external/elevation.asc")
prec <- rast("/usr/local/lib/R/site-library/sdm/external/precipitation.asc")
temp <- rast("/usr/local/lib/R/site-library/sdm/external/temperature.asc")
vege <- rast("/usr/local/lib/R/site-library/sdm/external/vegetation.asc")

# stack
preds <- c(elev, prec, temp, vege)

# plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl) 

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Another way of doing the same
# Try find relations between presence of frogs and
# elevation, precipitation, temperature and vegetation
file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)
rana$Occurrence

plot(rana)

# Selecting presences
pres <- rana[rana$Occurrence==1,]
plot(pres)

# select absence and call them abse
abse <- rana[rana$Occurrence==0,]
plot(abse)

# plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(pres)
plot(abse)

# your new friend in case of graphical nulling:
dev.off()

# plot pres and abse altogether with two different colours
plot(pres, col="dark blue")
points(abse, col="light blue")

# predictors: environmental variables
# file <- system.file("external/species.shp", package="sdm")
# rana <- vect(file)

# elevation predictor
elev <- system.file("external/elevation.asc", package="sdm") 
elevmap <- rast(elev) # from terra package
plot(elevmap)
points(pres, cex=.5)

# temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <- rast(temp) # from terra package
plot(tempmap)
points(pres, cex=.5)

# vegetation predictor
vege <- system.file("external/vegetation.asc", package="sdm") 
vegemap <- rast(vege) # from terra package
plot(vegemap)
points(pres, cex=.5)

# vprecipitation predictor
prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) # from terra package
plot(precmap)
points(pres, cex=.5)

# final multiframe

par(mfrow=c(2,2))

# elev
plot(elevmap)
points(pres, cex=.5)

# temp
plot(tempmap)
points(pres, cex=.5)

# vege
plot(vegemap)
points(pres, cex=.5)

# prec
plot(precmap)
points(pres, cex=.5)

## 03.communities.multivariate

# Communities: Multivariate analysis
# (numerical ecology https://shop.elsevier.com/books/numerical-ecology/legendre/978-0-444-53868-0)
library(vegan)

data(dune)
dune
# head () is a function that shows you only the first few rows of a dataset
head(dune)
# tail () is a function that shows you only the last few rows of a dataset
tail(dune)

# principal components analysis (PCA)
# detrended correspondence analysis (DCA) -> decorana
ord <- decorana(dune)
ord
summary(ord)
# Detrended correspondence analysis with 26 segments.
# Rescaling of axes with 4 iterations.
# what we need to know is the length of the new axis, how log is the range inside each axies,
# we can use this data to scale the analysis
# To obtain the range and percentage of data in each axis (graph on note)

#                   DCA1   DCA2
# Eigenvalues     0.5117 0.3036
# Decorana values 0.5360 0.2869
# Axis lengths    3.7004 3.1166
#                    DCA3    DCA4
# Eigenvalues     0.12125 0.14267
# Decorana values 0.08136 0.04814
# Axis lengths    1.30055 1.47888

Idc1 = 3.7004
Idc2 = 3.1166
Idc3 = 1.30055
Idc4 = 1.47888

total = Idc1 + Idc2 + Idc3 + Idc4

pIdc1 = Idc1*100/total
pIdc2 = Idc2*100/total
pIdc3 = Idc3*100/total
pIdc4 = Idc4*100/total

pIdc1
pIdc2
pIdc3
pIdc4

pIdc1 + pIdc2

plot(ord)
# plot with axis of multivariate analysis (since we cannot visualize multiple dimensions)

## 03.communities.overlap

# Communities overlap
# relation among species in time

install.packages("overlap")
library(overlap)
# https://cran.r-project.org/web/packages/overlap/vignettes/overlap.pdf

# Data from Kerinci-Seblat national park (Indonesia)
data(kerinci)
head(kerinci)
# The unit of time is the day, so values range from 0 to 1.
summary(kerinci) # abstract of the dataset

# tiger
timeRad <- kerinci$Time * 2 * pi # pass from linear to circular time, multiply orginal time to 2*pi
timeRad
# select lines of the data only about tigers
tig <- timeRad[kerinci$Sps == 'tiger'] # the column Sps has to contain only tigers, time sightings of tigers
densityPlot(tig, rug=TRUE)

# overlap
mac <- timeRad[kerinci$Sps == 'macaque'] # time sightings of macaque
overlapPlot(tig, mac) # overlap represents when both species present 
# the grey part is when there is the highest probability to see tiger and macaque together
legend('topright', c("Tigers", "Macaques"), lty=c(1,2), col=c("black","blue"), bty='n')       

# species
kerinci$Sps
summary(kerinci$Sps)

# tapir
tap <- timeRad[kerinci$Sps == 'tapir'] # time sightings of tapir
overlapPlot(mac, tap)
legend('topright', c("Macaques", "Tapirs"), lty=c(1,2), col=c("black","blue"), bty='n')    



# Another way of doing the same thing
# select lines of the dataset only about tigers
tiger <- kerinci[kerinci$Sps=="tiger",] # the column Sps has to contain only tigers
tiger
summary(tiger)

# pass from linear to circular time, multiply orginal time to 2*pi
# add new column to the data with this time
kerinci$Ttimerad <- kerinci$Time*2*pi
summary(kerinci)
head(kerinci)

tiger <- kerinci[kerinci$Sps=="tiger",]
head(tiger)

plot(tiger$Ttimerad)

timetiger <- tiger$Ttimerad
densityPlot(timetiger, rug = TRUE) # shows amount of times you have seen a specie in time

# select only data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
macaque
head(macaque)

timemacaque <- macaque$Ttimerad
densityPlot(timemacaque, rug = TRUE)

# Is there a moment when tiger and macaque are around together?
overlapPlot(timetiger, timemacaque) # grey part is when there is the highest probability to see tiger and macaque together

## 04.Remote.sensing

# Ecosystems and remote sensing
Ecosystems are very big, hard to collect enough data:
- Establish plots of the same dimensions and take samples
- Use remote sensing -> satelite images
The european state agency (Europe) and Nasa (US) own the satelites around the globe.
Remote sensing record colours, measure the reflectance of objects at different wavelenghts (nanometers).
Every number represents a colour (legend), amount of reflectance in each unit (pixel = smallest unit of an image).

Colours are actially waves (light).
Newton born in 1642, same year Galileo died.
Newton described light as different wavelenghts. The visible light is just a small part.
Remote sensing can detect other wavelenghts as well.
Gamma ray - xray - ultraviolet (insect see the world through this) - VISIBLE - infrared - microwave - radio
[Blue smaller wavelenght, red bigger wavelenghts]

We can take a sensor put it on a drone/satelite and make it fly through a landscape, 
obtaining an image of different bands (many layers of reflectance of different wavelenghts).
Than you can add the different layers together obtaining images.

Leaves absorb in the blue ang red to do photosinthesys (calvin cycle), 
whereas reflect a lot in the green (the mesophyll), which we can see, and eve more in the NIR, which we can't.

# Data
There is a difference between satellite images (scanner) and photographs.
The earth is not a sphere, it's a Geoid: the surface is always perpendicular to the gravity force and is approximately as the sea level.
Since it is not a geometrical shape, the Geoid cannot be used to do measurements, instead we use an ellipsoid.
We use different ellipsoid based on the region of the world considered, to be the most similar as possible to the real surface.
Example: NAD27 for USA, ED50 for Italy.
Why there are deserts in subtropical regions? Plants need light and water.
Due to the global circulation the water vapor rising from the equator goes up and with the decreasing temp precipitates,
so when it arrives at higher latutudes the air is dry.
Latitude: angle between perpendicular line from point P and the equator (not the center of the earth).
If you start from the same point on the planet and consider different ellipsoids, you will obtain different latitudes. 
When using latitudes and longitudes we need to specify the Datum (ellipsoid).
WGS84 matches in most cases the planet, adjusted by satellites.

From ellipsoid to planar system
Universal Transverse Mercator (UTM) = Gauss projection, frangmentation of the planet system, divide the surface in the meridians (12).
Every zone is 6 degrees, 60 zones. We start counting zones from the antimeridian of Greenwhich (Hawaii).
Italy is in 32 and 33 zone.
Knowing the starting reference system, you can pass to another (6 parameters transformation).

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
# seems black and white, is actually dark green, this is what we see woth our eyes, 
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

## 05.Spectral.indices

INDICES
Mounting bands together you obtain indices
Difference between NIR and RED
an healthy plant has an high reflectance in the NIR and a low reflectance in the red
NIR - RED is high
when the index is low (NIR reflectance is a bit lower while red is higher) the leaf is not healthy 

THEORY
Bits -> 0 or 1, on or off: binary code
if you have 2 lights we can have 0 0 or 0 1 or 1 0 or 1 1. This are 2bits that represent 4 info. 
With 3 bits we have 8 info.
4 bits = 16 info. 
the rule is: nbits equals to 2 at the power of n info.
with 8 bits you have 255 info.
the bits represent radiometric resolution: how many values you have in a range (0-255 is 8 bits)
what happens when you have images with  different bits?
The calculation of DVI also is affected by the amount of bits, so images with different bits and ranges cannot be compared
to resolve this issue we can standardize the DVI
NDVI = (NIR - RED)/(NIR + RED)
NDVI values range between -1 to +1
Whereas the DVI range depends on the amount of bits


R script
library(imageRy)
library(terra)

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3) # soil is teal
im.plotRGB(m1992, r=2, g=1, b=3) # soil is violet
im.plotRGB(m1992, r=2, g=3, b=1) # soil is yellow

# import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

# build a multiframe with m1992 and m2006 
par(mfrow=c(1,2))
plot(m1992)
plot(m2006)

par(mfrow=c(1,2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

dev.off()

# let's create indices about this situation to identify the health of this vegetation
plot(m1992[[1]]) # plot of NIR band
# range is between 0 and 255, why? With 8 bits you have 255 info

# Difference vegetation index (DVI)
# If the NIR decreases and RED increases the vegetation is no longer healthy
# we need the difference between the first band and the second band of m1992
# bands: 1=NIR, 2=RED, 3=GREEn
dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992) # for each pixel the difference between NIR and RED
# green is healthy forest, whereas from 0 and below is bare soil or damaged forest

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl) # dark red is healthy

dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl) # yellow is not healthy

# NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]]) 
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]]) # if you already calculated the dvi
plot(ndvi1992, col=cl)

ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
par(mfrow = c(1,2))
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

# speediing up calculation
im.ndvi() # gave image and number of bands and calculates ndvi by itself
ndvi2006a <- im.ndvi(m2006, 1, 2)
plot(ndvi2006a, col = clvir)

## 06.Multi.temporal.analysis

# Time series analysis
# Covid-19 lockdown effect on GHGs emissions (multi-temporal analisys)
library(imageRy)
library(terra)
im.list()
# level of NO2
EN01 <- im.import("EN_01.png") # January
EN13 <- im.import("EN_13.png") # March

par(mfrow = c(2,1))
im.plotRGB.auto(EN01) # automatically shows in 3 bands of RGB
im.plotRGB.auto(EN13)

dev.off()
# plot different between the 2 maps
dif = EN01[[1]] - EN13[[1]] # difference between the first bands of the 2 images
plot(dif) # (8 bit image)
# chnage color palette

cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dif, col=cldif) # blue is higher in march, red is higher in january


# Greenland data
# website of the data = Copernicus Global Land Service
# example: temperature in Greenland
im.list()
g2000 <- im.import("greenland.2000.tif") # image of 16 bits
# temperature of the surface (not air)
clg <- colorRampPalette(c("black","blue", "white", "red")) (100)
plot(g2000, col=clg) # blue is cold, black is the coldest

g2005 <- im.import("greenland.2005.tif")                                
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif") 

plot(g2005, col=clg)
plot(g2010, col=clg)
plot(g2015, col=clg)

# compare change in temperature from 2000 to 2015
par(mfrow = c(2, 1)) 
plot(g2000, col=clg)
plot(g2015, col=clg)

# visualize all images together
stackg <- c(g2000, g2005, g2010, g2015) # great difference between 2000 and 2005
plot(stackg, col=clg)

# find difference between first and final elements of the stack
diftemp <- g2000 - g2015
plot(diftemp, col=clg)
# an other way is using the stack created prior
difg <- stackg[[1]] - stackg[[4]]
plot(difg, col=cldif)

# we can use 3 of the 4 images to build an RGB
# g2000 = R, high values are red, 2005 = G, high values are green, 2010 = B, high values are blue

# create an RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3) # black central part (blue/black-ish) means in the final year the temp is higher

# take on message: we have the possibilities of seeing changes in landscapes, going in the field is complicated, satellite images makes it easier.
# most simple site to get data is the Earth observatory

## 07.external.data.R

# Importing external data
# Import data from NASA's Earth observatory (there is also the ESA, Copernicus programme)
# first go to the website and decide which data to use
# download the images on your computer
library(terra)
# set working directory, based on the path to the folder with the images (look up on properties of the folder)
setwd("C:/Users/PCSUPER/iCloudDrive/UniBo/Spatial ecology in R/images") # in windows you need to substitute this \ with /

# We'll use the rast() from terra
naja <- rast("najafiraq_etm_2003140_lrg.jpg") # like in im.import()
naja
plot(naja)
plotRGB(naja, r=1, g=2, b=3)
# Download the other image
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow = c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

# Create multi temporal change detection
najadif = naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl) # orange has higher difference

# Download other images
iberian2022 <- rast("iberian_tmo_2022130_lrg.jpg") # keep the same name to be able to track down the file on the internet
iberian2023 <- rast("iberian_tmo_2023131_lrg.jpg")

par(mfrow = c(2,1)) # visualization of the browning on the peninsula iberica
plotRGB(iberian2022, r=1, g=2, b=3)
plotRGB(iberian2023, r=1, g=2, b=3)

plotRGB(iberian2022, r=2, g=3, b=1) # play around

ibedif = iberian2022[[1]] - iberian2023[[1]]
plot(ibedif, col=cl) # using only the visible bands we don't see much difference, using the NIR would be more noticable

## 08.Copernicus.data

# How to import data from satellite Copernicus
install.packages("ncdf4")
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)
library(terra)

setwd("C:/Users/PCSUPER/iCloudDrive/UniBo/Spatial ecology in R") # in W*****s \ means /

soilm2018 <- rast("SWI1km_example_20180826_Europe.png")
plot(soilm2018)

# there are two elements, let's use the first one!
plot(soilm2018[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2018[[1]], col=cl)

ext <- c(22, 26, 55, 57) # minlong, maxlong, minlat, maxlat
soilm2018c <- crop(soilm2018, ext)

plot(soilm2018c[[1]], col=cl)

plotRGB(soilm2018)

## 09.classification

Pass from original image to classes

We take a picture with vegetation, agriculture and water. 
We build a graph with the red band on the x axis and the nir band in the y axis. 
We consider a pixel of the image where is present vegetation, 
the coordinates of the point in the graph depend on the amount of reflectance of each band.
The pixels with vegetation will form a cluster of points in a certain region,
and the onew of agriculture and water will form other clusters in other regions of the graph.
How do we classify a pixel that is not in any cluster?
Based on the distance from each class/cluster, we'll choose the one closest to it.
In this way we can classify any single pixel in the picture.

On R
# Classify satellite images and estimate the amount of change

library(terra)
library(devtools)
library(htmltools)
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)

im.list()
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# we can see 3 level of energy: yellow is the higher, black is the lowest
sunc <- im.classify(sun, num_clusters = 3)
plot(sunc)

# how can i state which class is the one with the highest energy?
# comparing with the original image 
# class number 1 is the highest in this case

# classify satellite data
im.list()
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")                    
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# difficult to distinguish soil and water, water should be black on NIR but since is full of soil in appears the same
m1992c <- im.classify(m1992, num_clusters=2) # we see the image in 2 colors: vegetation yellow, soil violet; same number of classes/clusters
plot(m1992c) # vegetation white, soil green
# classes: forest = 2, human = 1
m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)

# create multiframe to visualize difference
par(mfrow=c(1,2))
plot(m1992c)
plot(m2006c)

# now we can caluclate the percentage of pixels present in the classes (forest, human)
# and quantify the loss of vegetation

# claculate the frequence
f1992 <- freq(m1992c)
f1992
tot1992 <- ncell(m1992c)
# percentage
p1992 <- f1992*100 / tot1992
p1992
# forest: 83.1%; human: 16.9%

# same for other image
f2006 <- freq(m2006c)
f2006
tot2006 <- ncell(m2006c)
# percentage
p2006 <- f2006 * 100 / tot2006 
p2006
# forest: 45.3%%; human: 54.7%

# building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 

tabout <- data.frame(class, y1992, y2006)
tabout


# We can create a graph representing the data we analyzed
library(ggplot2)
library(patchwork)
# final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p2
p1 + p2 

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2
p1 + p2

## 10.variability

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
# change legend
viridisc <- colorRampPalette(viridis(7))(255) # use 7 colors of viridis
plot(sd3, col=viridisc) # represent variability of NIR in the image
# NW area has an abrupt change in elevation that causes change in amount of vegetation

## 11.PCA.R

# PCA (Principal Component Analysis): to extract data with many variables and create visualizations to display that data
library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

pairs(sent)

# perform PCA on sent
sentpc <- im.pca(sent)
pc1 <- sentpc$PC1

viridisc <- colorRampPalette(viridis(7))(255)
plot(pc1, col=viridisc)

# standard deviation values
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
sd7 <- focal(nir, matrix(1/49, 3, 3), fun=sd)

# calculating standard deviation ontop of pc1
pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/49, 7, 7), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2,3))
im.plotRGB(sent, 2, 1, 3)

# sd from the variability script:
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

# stack all the standard deviation layers
sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)

## RMarkdown
# How to create a RMarkdown
# on Rstudio we click on the + in the top left corner and scroll down to R Markdown to create a new file

---
title: "test"
author: "Giulia Pici"
output: html_document
date: "2024-01-11"
---

# My first markdown document!

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

# Using proper packages 
```{r, eval=T}
library(imageRy)
```

# Let's import some data, starting with a list of data
```{r, eval=T} 
im.list()
```
we put T instead of F to obtain the list of files

```{r, eval=T}
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
```
# info of the image
just type the name of the object
```{r, eval=T}
mato1992
```

# How to plot the image putting the NIR on top of the green component in the RGB space
```{r, eval=T}
im.plotRGB(mato1992, r=2, g=1, b=3)
```
how to remove the warning about the unknown extent 
we can use function -> echo
if we type s it will copy paste something else we want
we state to the program to not use echo to write the warning 

# importing the image without the warning
```{r, eval=T, warining=F}
mato1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
```

# plotting several images all together
```{r, eval=T}
par(mfrow=c(2,2))
im.plotRGB(mato1992, r=1, g=2, b=3)
im.plotRGB(mato1992, r=2, g=1, b=3)
im.plotRGB(mato1992, r=3, g=2, b=1)
im.plotRGB(mato1992, r=1, g=3, b=1)
```
# Calculating spectral indices
```{r, eval=T}
library(viridis)
library(terra)
dvi <- mato1992[[1]] - mato1992[[2]]
viridisc <- colorRampPalette(viridis(7))(255)
plot(dvi, col = viridisc)
```
# when done with the code click on knit
# calculating variability
```{r, eval=T}
sd5 <- focal(mato1992[[1]], matrix(1/25, 5,5), fun=sd)
plot(sd5, col=viridisc)
```

## Colorblind vision
                       
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
# use function to visualize the plot like people with different vision deficiencies (cvd = color vision deficiency)
cvd_grid(fig)

# new plot with sepal width
fig2 <- ggplot(iris, aes(Sepal.Width, fill = Species)) + geom_density(alpha=0.7)
fig2
cvd_grid(fig2)
