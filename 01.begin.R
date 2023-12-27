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
