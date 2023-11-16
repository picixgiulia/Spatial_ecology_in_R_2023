# 16/11/23
# Import data from NASA's Earth observatory (there is also the ESA, Copernicus programme)
# first go to the website and decide which data to use
# download the images on your computer
library(terra)
# set working directory, based on the path to the folder with the images (look up on properties of the folder)
setwd("C:/Users/PCSUPER/iCloudDrive/UniBo/Spatial ecology in R") # in windows you need to substitute this \ with /

# We'll use the rast() from terra
naja <- rast("najafiraq_etm_2003140_lrg.jpg") # like in im.import()
naja
plot(naja)
plotRGB(naja, r=1, g=2, b=3)
# Exercise: Download the other image
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow = c(2,1))
plotRGB(naja, r=1, g=2, b=3)
plotRGB(najaaug, r=1, g=2, b=3)

# Exercise: create multi temporal change detection
najadif = naja[[1]] - najaaug[[1]]
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl) # orange has higher difference

# Exercize: download your own image
iberian2022 <- rast("iberian_tmo_2022130_lrg.jpg") # keep the same name to be able to track down the file on the internet
iberian2023 <- rast("iberian_tmo_2023131_lrg.jpg")

par(mfrow = c(2,1)) # visualization of the browning on the peninsula iberica
plotRGB(iberian2022, r=1, g=2, b=3)
plotRGB(iberian2023, r=1, g=2, b=3)

plotRGB(iberian2022, r=2, g=3, b=1) # play around

ibedif = iberian2022[[1]] - iberian2023[[1]]
plot(ibedif, col=cl) # using only the visible bands we don't see much difference, using the NIR would be more noticable
