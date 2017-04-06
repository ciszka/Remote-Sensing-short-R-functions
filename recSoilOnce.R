recSoilOnce = function(scene, j, k){
  #ingest of data to analyze and setting of parameters that will be
  #used on all the files in the system
  matrixValues = c(-1,.2, .3, .2,.3, 1, 0, 1, 0) #creates the matrix to reclassify the data
  categories = matrix(matrixValues, nrow = 3, ncol=3) #turns that list into a matrix
  colnames(categories) <- c('from', 'to', 'becomes') #it names the  matrix from, to, and becomes for the reclassificaiton step
  img = brick(scene) #creates a raster brick set of the file
  noExt = strtrim(scene, nchar(scene)-4) #this removes the extension for later use
  print(noExt) #prints the name to make sure you're not failing
  newFileName = paste(noExt, "_NDVI", sep = "", collapse = "") #uses that just name to create a new file name for the NDVI file
  print(newFileName) #prints the new name to make sure you're not failing
  bj = img[[j]] #Sets the Red band to this parameter
  bk = img[[k]] #Sets the NIR band to this parameter
  NDVI = (bk-bj)/(bk+bj) #Executes and NDVI of these two parameters
  #Creates the raster of the NDVI with the new filename
  #It outputs at a geotiff using the original image's projection
  writeRaster(NDVI, filename = newFileName, format = 'GTiff', overwrite = TRUE)
  #creates a Raster file from the calculated NDVI
  NDVIFile = brick(NDVI)
  #new file name for the mask
  maskName = paste(noExt, "_SoilMask", sep = "", collapse = "")
  print(maskName) #prints the name of the mask so it's unmasked
  reclassedImage = reclassify(NDVIFile, categories) #reclassifies the NDVI
  #writes a new raster for the reclassified image
  return (reclassedImage) 
}