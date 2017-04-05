#This calculates NDVI for a bunch of raster files with bands 3 and 4
#that are stored within a particular file
#The expansion of this is the reclassVegSoil
#I should have written documenation for this previously
createAllNDVIMasksFromLocation = function(fileLocation, j, k){
  filesToAnalyze = list.files(fileLocation)
  numberOfFiles = length(filesToAnalyze)
  matrixValues = c(-1,.3, .9 , .3 ,.9, 1, 1,0, 1)
  categories = matrix(matrixValues, nrow = 3, ncol=3)
  colnames(categories) <- c('from', 'to', 'becomes')
  
  
  for (i in 1:numberOfFiles) {
    fullFileName = paste(fileLocation, filesToAnalyze[i], sep = "/", collapse = "")
    img = brick(fullFileName)
    noExt = strtrim(fullFileName, nchar(fullFileName)-4)
    newFileName = paste(noExt, "_NDVI", sep = "", collapse = "")
    print(newFileName)
    bj = img[[j]]
    bk = img[[k]]
    NDVI = (bk-bj)/(bk+bj)
    writeRaster(NDVI, filename = newFileName, format = 'GTiff', overwrite = TRUE)
    NDVIFile = brick(NDVI)
    maskName = paste(newFileName, "_mask", sep = "", collapse = "")
    reclassedImage = reclassify(NDVIFile, categories)
    writeRaster(reclassedImage, filename = maskName, format = 'GTiff', overwrite = TRUE)
  }  
  return("did the thing")  
}