#This calculates NDVI on an image that has multiple bands of imagery
#It should be given a rasterstack with the different bands
#i and k indicate the band numbers that should be use (almost always band 3 and 4 but 
#It may vary dependin gon the imagery
NDVI = function(img, i, k){
  bi = img[[i]]
  bk = img[[k]]
  NDVI = (bk-bi)/(bk+bi)
  return(NDVI)
  }
