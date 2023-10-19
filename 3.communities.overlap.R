# Communities overlap
# relation among species in time

install.packages("overlap")
library(overlap)
# data from Kerinci-Seblat national park (Indonesia)
data(kerinci)
head(kerinci)
# The unit of time is the day, so values range from 0 to 1.
summary(kerinci) # abstract of the dataset

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


# Excercise: select only data on macaque individuals
macaque <- kerinci[kerinci$Sps=="macaque",]
macaque
head(macaque)

timemacaque <- macaque$Ttimerad
densityPlot(timemacaque, rug = TRUE)

# Is there a moment when tiger and macaque are around together?
overlapPlot(timetiger, timemacaque) # grey part is when there is the highest probability to see tiger and macaque together
