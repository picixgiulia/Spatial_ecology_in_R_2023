# Here i can write anything i want. In this way R cannot run this line, it is just a comment to explain what is happening.

# R as a calculator 
2 + 3 # if you copy paste this in R it will calculate the result

# you can assign a subpart of the code to an object 
Zima <- 2 + 3
# now if you write Zima in R and run the code it will appear 5
Duccio <- 5 + 3 
# zima*duccio will calculate 48, and we can save it as an object
final <- zima*duccio

# array
sophi <- c(10, 20, 30, 50, 70) #microplastic 
# functions have parenthesis which inside have arguments
paula <- c(100, 500, 600, 1000, 2000) #people
plot(paula, sophi) # to find relation between veariables
# how to chnage label on plot
plot(paula, sophi, xlab ="number of people", "microplastic")
# or we can reassign the onject paula to people and spphi to microplastics
plot(poeple, microplastics)
plot(poeple, microplastics, psh=19) #to change the type of points, look up number on internet
plot(poeple, microplastics, psh=19, cex=2) #to change the dimensions of the points
plot(poeple, microplastics, psh=19, cex=2, col="blue") #to change the colour of the points

# how to install a package 
install.packages
