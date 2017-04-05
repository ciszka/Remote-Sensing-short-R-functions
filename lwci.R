#This calculates the leaf relative water content index on an image that has multiple bands of imagery
#It should be given a rasterstack with the different bands and this formula is based on the formula
#in Jensen 2016
#i and k indicate the band numbers that should be use (almost always band 3 and 4 but 
#It may vary dependin gon the imagery
lwci = function(img, band1, band2){
  bi = img[[band1]]
  bk = img[[band2]]
  lwci = (-log(1-(bi-bk))/(-log(1-(bi-bk)) #the denominator has some transform to it. 
  return(lwci)
}
