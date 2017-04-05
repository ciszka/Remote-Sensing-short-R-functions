#This calculates the Visible atmospherically resistant Index for green
#on an image that has multiple bands of imagery
#It should be given a rasterstack with the different bands
#band1, band2, band3 indicate the band numbers that should be used 
#In this example band1 is generally blue band2 is usually green
#then band3 is usually red no matter what the imagery is

vari_g = function(img, band1, band2, band3){
  bi = img[[band1]]
  bj = img[[band2]]
  bk = img[[band3]]
  vari = (bj-bk)/(bj+bk-bi)
  retrun(vari)
}
