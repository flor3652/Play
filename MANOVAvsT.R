#library(myStuff)
grab(MASS)
grab(Hotelling)

#generate 4 correlated variables (for group 1), then 4 correlated variables with a higher mean (for group 2). use n=30, cor=.5 (change this to see how it effects stuff), and means... Maybe start means at 0, then move them (for convenience). Let all means move the same amount in the same direction (to start)

#parameters
n <- 30
nvar <- 4
mean1 <- 0
mean2 <- 1
cor <- .1

#making data
meanv1 <- rep(mean1,nvar)
meanv2 <- rep(mean2,nvar)
cor.mat <- matrix(cor, ncol = nvar, nrow = nvar)
diag(cor.mat) <- 1 #when this is not done, all of the columns are the same... very strange... ah, cause 100% correlated (the matrix would be a covariance matrix, as the diagonals aren't 1)
sam1 <- mvrnorm(n = n, mu = meanv1, Sigma = cor.mat)
sam2 <- mvrnorm(n = n, mu = meanv2, Sigma = cor.mat)
sam1 <- cbind(group = rep(1,n), sam1)
sam2 <- cbind(group = rep(2,n), sam2)
dat <- rbind(sam1, sam2)
dat[,1] <- as.factor(dat[,1])

#testing data
man.fit <- manova(dat[,-1]~dat[,1])
hot.fit <- hotelling.test(dat[,-1]~dat[,1])
summary(man.fit) #multivariate outcome
summary.aov(man.fit) #univariate outcomes
#t1.fit <- t.test(dat[,2]~dat[,1], var.equal=TRUE) #aligns perfectly with aov when var.equal=TRUE
#t2.fit <- t.test(dat[,3]~dat[,1], var.equal=TRUE) #aligns perfectly with aov when var.equal=TRUE
#t3.fit <- t.test(dat[,4]~dat[,1], var.equal=TRUE) #aligns perfectly with aov when var.equal=TRUE
#t4.fit <- t.test(dat[,5]~dat[,1], var.equal=TRUE) #aligns perfectly with aov when var.equal=TRUE




