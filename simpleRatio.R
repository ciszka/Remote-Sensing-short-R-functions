#This calculates a simple ratio on an image that has multiple bands of imagery
#It should be given a rasterstack with the different bands and is basd on the Simple
#Ratio formula in Jensen 2016. 
#Any band number can be used in this function but be aware of what sort of information
#it actually produces at the end and what properties are being tested

simpleRatio = function(img, band1, band2){
  bi = img[[band1]]
  bk = img[[band2]]
  simRat = bi/bk
  return(simRat)
}
