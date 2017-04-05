vari_g = function(img, band1, band2, band3){
  bi = img[[band1]]
  bj = img[[band2]]
  bk = img[[band3]]
  vari = (bj-bk)/(bj+bk-bi)
  retrun(vari)
}