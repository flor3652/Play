#### Creating column names with a given prefix ----

# Creating test datasets
x <- matrix(1:12,3)
y <- data.frame(x)

# To assign letters in the alphabet to the rows
colnames(x) <- letters[1:ncol(x)]
colnames(y) <- letters[1:ncol(y)]

# To assign a "name" with a sequence of numbers afterwards
#for a matrix
name <- character()
for(i in 1:ncol(x)) name[i] <- paste("variable",i,sep="")
colnames(x) <- name
#for a data frame
for(i in 1:ncol(y)) colnames(y)[i] <- paste("variable",i,sep="")

# There is a much easier way to do this, using built in pieces of the colnames() function
#for a matrix
colnames(x) <- colnames(x, do.NULL=FALSE, prefix="variable")
#for a data frame
colnames(y) <- NULL
colnames(y) <- colnames(y, do.NULL=FALSE, prefix="variable")