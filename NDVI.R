NDVI = function(img, i, k){
  bi = img[[i]]
  bk = img[[k]]
  NDVI = (bk-bi)/(bk+bi)
  return(NDVI)
  }