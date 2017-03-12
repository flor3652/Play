# Chi-Squared Normality Test ----
# This is to create a chi-squared normality test by creating "bins" with a true normal, and comparing it to a set of data. It looks like it may be appropriate to create seperate functions for discreet and continuous data.

# For categorical
# making a binary sample
binsam <- rbinom(100,9,.5)

# finding the sample size
n <- length(binsam)

# standardizing the sample
stdbinsam <- (binsam - mean(binsam))/sd(binsam)

