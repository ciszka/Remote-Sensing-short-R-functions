lwci = function(img, band1, band2){
  bi = img[[band1]]
  bk = img[[band2]]
  #lwci = (-log(1-(bi-bk))/(-log(1-(bi-bk))
  #the denominator has some transform to it. 
  return(lwci)
}