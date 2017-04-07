#This calculates NDVI for a bunch of raster files with bands 3 and 4
#that are stored within a particular file
#The expansion of this is the reclassVegSoil
#I should have written documenation for this previously
#Updated from previous version so it only works  with tifs for now
createAllNDVIMasksFromLocation = function(fileLocation, j, k){
  #Required libraries
  require(utils)
  require(raster)
  
  #Deals withwhere to find the files and which files to include
  filesToAnalyze = list.files(fileLocation)
  numberOfFiles = length(filesToAnalyze)
  #Values for the reclassification of them to create a mask
  matrixValues = c(-1,.3, .9 , .3 ,.9, 1, 1,0, 1)
  categories = matrix(matrixValues, nrow = 3, ncol=3)
  colnames(categories) <- c('from', 'to', 'becomes')
  
  #This actually cycles through all the data to do the NDVI calculation and the mask
  for (i in 1:numberOfFiles) {
    ext = substr(filesToAnalyze[i], nchar(filesToAnalyze[i])-2, nchar(filesToAnalyze[i])) #This just gets the extension of the piece
    #Tests if its the file type we want
    if (ext == "tif" ||ext == "TIF") {
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
    } else {
      print ("It wasn't my type")
    }
  }  
  return("did the thing")  
}
