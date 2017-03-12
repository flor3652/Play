# parallel processing: trying it out ----
library(myStuff)

# PP ####
# parallel package ----
# kindof following along with this walkthrough: http://gforge.se/2015/02/how-to-go-parallel-in-r-basics-tips/
# another (probably nicer, but less in depth) intro is here: http://blog.aicry.com/r-parallel-computing-in-5-minutes/

grab(parallel)
no_cores <- detectCores() - 1 
cl <- makeCluster(no_cores)

parLapply(cl, 2:4, function(exp) 2^exp)

stopCluster(cl)

# note that clusters are almost "independent" entities from regular R, so packages and variables (outside of what is available in base R) will need to be loaded to them. The next chunk fails, as the "base" variable isn't loaded:
cl<-makeCluster(no_cores)
base <- 2

parLapply(cl, 
          2:4, 
          function(exponent) 
            base^exponent)

stopCluster

#while the following chunk succeeds, as base is loaded via "clusterExport"
cl<-makeCluster(no_cores)

base <- 2
clusterExport(cl, "base")

parLapply(cl, 
          2:4, 
          function(exponent) 
            base^exponent)


stopCluster(cl)

# have  to pass it packages, too: "clusterEvalQ(cl, packageName)".

### parSapply
# this gives simple output (aka output as a vector)
cl<-makeCluster(no_cores)

base <- 2
clusterExport(cl, "base")

parSapply(cl, 2:4, 
          function(exponent) 
            base^exponent)

stopCluster(cl)

#outputting a matrix:
cl<-makeCluster(no_cores)

base <- 2
clusterExport(cl, "base")

parSapply(cl, as.character(2:4), 
          function(exponent){
            x <- as.numeric(exponent)
            c(base = base^x, self = x^x)
          })

stopCluster(cl)

# foreach package ----
# this package combines for loops and apply
grab(foreach)
grab(doParallel)
cl<-makeCluster(no_cores)
registerDoParallel(cl) #or registerDoParallel(no_cores). Note that, to stop the cluster, use stopImplicitCluster() instead of stopCluster()

# foreach is like parSapply, but we can pick the output format with the ".combine" argument
# vector
foreach(exponent = 2:4, 
        .combine = c)  %dopar%  
  base^exponent

# matrix
foreach(exponent = 2:4, 
        .combine = rbind)  %dopar%  
  base^exponent

# list
foreach(exponent = 2:4, 
        .combine = list,
        .multicombine = TRUE)  %dopar%  
  base^exponent

### weird things about how variables are read... the following works:
base <- 2
cl<-makeCluster(2)
registerDoParallel(cl)
foreach(exponent = 2:4, 
        .combine = c)  %dopar%  
  base^exponent
stopCluster(cl)

# but not this one
base <- 2
cl<-makeCluster(2)
registerDoParallel(cl)
test <- function (exponent) {
  foreach(exponent = 2:4, 
          .combine = c)  %dopar%  
    base^exponent
}
test()
stopCluster(cl)

# as some asides: he recommends using tryCatch for error messaging etc. He also recommends using lists as output, and then stacking the lists with a clever command "do.call(rbind, listToBeStacked)"

#as an aside, there is just some really cool debugging options here that I like... He also does some cool cache stuff that is pretty interesting and useful.

# as a final aside, he recommends never using set.seed(), but using "clusterSetRNGStream()" instead (to set cluster seeds for reproducible results). 

# he also recommends the use of "ibind()" for using mice in parallel for computing imputations.

# also, there is a package called "snow" (that this package is derived from)



# testing ----
#if it hasn't been grabbed yet
library(myStuff)
grab(parallel)
no_cores <- detectCores() - 1 #may want to use -2, as it sounds like the R console uses 1 itself (so this process is using all of the cores)

tr <- 1:(5e6)#test range
system.time(lapply(tr, function(x) 2^x)) #takes around 18 seconds the first time (right after I restart the R session), but keeps going down each time I run it...

cl<-makeCluster(no_cores)
system.time(parLapply(cl,tr, function(x) 2^x)) #takes around 9.5 seconds, but doesnt go down each time I run it
stopCluster(cl)



