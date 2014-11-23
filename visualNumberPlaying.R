# A file for just messing around, trying to make pictures with numbers... In RStudio, Ctrl-Alt-t will run a section. Though it takes more time, rm(list=ls()) is added to the end of each section to clear each section individually (to ensure the next section has no dependencies)

#### Making a number pyramid with "repeat" ----
#user set
height.of.number.tower <- 12

#for loop use
nt <- height.of.number.tower - 1
i=1
repeat {
  cat(1:i,"\n")
  i=i+1
  if(i>nt) 
  {
    repeat {
      cat(1:i, "\n")
      i=i-1
      if(i<1){break}
    }
    break
  }
}
rm(list=ls())



#### Creating a vertical number hourglass with "repeat" ----
#user set (less than 10, to keep spacing)
middle.number.of.hourglass <- 9

#for loop use
m <- middle.number.of.hourglass
i=1
repeat {
  cat(rep(" ",(i)),rep(i,((m*2-1)-2*(i-1))),rep(" ",(i)),"\n")
  i=i+1
  if(i>m) {
    i=i-1
    repeat {
      i=i-1
      cat(rep(" ",(i)),rep(i,((m*2-1)-2*(i-1))),rep(" ",(i)),"\n")
      if(i<2){break}
    }
    break
  }
}
rm(list=ls())



#### Creating a horizontal number hourglass with "repeat" ----
#user set (for now, single digits only)
middle.number.of.hourglass <- 9

#for loop use
m <- middle.number.of.hourglass
i <- 1
repeat {
  cat(1:i,rep(" ",((m*2-1)-2*(length(1:i)))),i:1, "\n")
  i=i+1
  if(i>(m-1)) {
    cat(1:i,(i-1):1,"\n")
    repeat {
      i=i-1
      cat(1:i,rep(" ",((m*2-1)-2*(length(1:i)))),i:1, "\n")
      if(i<2) {break}
    }
    break
  }
}
rm(list=ls())



#### Number diamond with "repeat" ----
#user set (single digits)
middle.number.of.diamond <- 6

#for loop use
m <- middle.number.of.diamond
i = 1
repeat {
  cat(rep(" ",(m-i+1)),rep(i,(2*i-1)),"\n")
  i=i+1
  if(i>=(m)){
    repeat {
      cat(rep(" ",(m-i+1)),rep(i,(2*i-1)),"\n")
      i=i-1
      if(i<1) {break}
    }
    break
  }
}




#### Trying to create a circle of numbers with "repeat"----
#User set
center.number <- 6

#for loop use
cn <- center.number
i=1
#setting the diameter of the circle
diam <- cn*2-1

repeat {
  
}


#Trying to piece this thing together (work)
cat("1"); cat("@")
for(i in 1:10) cat(i)
cat(rep(" ",(cn-1)),1,"\n"); cat(rep(cn,diam))
for(i in 1:cn)cat(rep(" ",(cn-i+1)),rep(i,(2*i-1)),"\n")




