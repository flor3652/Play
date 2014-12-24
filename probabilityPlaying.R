# In a game show, it has been shown that, after chosing one option out of three, if you are shown a door that you didn't choose (that was a "bust" option), you should switch -

# Trying to model the above phenomenon ----
rm(list=ls())

# How often do you want to repeat this experiment?
rep=100000

# Defining the output logical vectors (about whether it was right or not): same, switch, or randomly pick between the two...
sa = sw = ran = logical(length=rep)

for(i in 1:rep)
{

# Setting door 1, 2, and 3 (TRUE is the "car", FALSE is the "goat" or "bust")
# Looks good
door.contents <- logical(length=3)
door.contents[sample(3,1)] <- TRUE
door.contents

# Now the guess (the "door number" of the guess)
guess <- sample(3,1)
guess

# Now revealing the empty door
# Using logic to select the "empty door" that will be revealed
if (length(which(door.contents==FALSE)[which(door.contents==FALSE)!=guess]) == 1) 
{
  revealed.door <- which(door.contents==FALSE)[which(door.contents==FALSE)!=guess]
} else 
{
  revealed.door <- sample(which(door.contents==FALSE)[which(door.contents==FALSE)!=guess], 1)
}

# Revealing the door...
#cat("Just so you know, door number", revealed.door, "is a bust!")

# Keeping the guess the same, did you get it right? (it will be TRUE if you got it right, it will be FALSE if you got it wrong)
sa[i] <- door.contents[guess]

# If you switched, did you get it right?
switched.guess <- (1:length(door.contents))[-c(guess,revealed.door)]
sw[i] <- door.contents[switched.guess]

# If you randomly picked between them (the second time), did you get it right?
ran[i] <- door.contents[sample(c(guess,switched.guess),1)]

}

cat("The probability of getting the car by staying with the same guess are ", mean(sa)*100, "%", sep="")
cat("The probability of getting the car by switching your guess are ", mean(sw)*100, "%", sep="")
cat("The probability of getting the car by randomly deciding are ", mean(ran)*100, "%", sep="")
