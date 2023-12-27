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
