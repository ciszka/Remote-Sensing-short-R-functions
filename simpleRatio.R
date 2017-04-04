simpleRatio = function(img, band1, band2){
  bi = img[[band1]]
  bk = img[[band2]]
  simRat = bi/bk
  return(simRat)
}