#This calculates NDVI for a bunch of raster files with bands 3 and 4
#that are stored within a particular file
#The expansion of this is the reclassVegSoil
#I should have written documenation for this previously
#fileLocation should be the full file path from drive to folder
#Please make sure that the correct slashes are used \ need to be changed to /
#For the program to interpret it correctly
createAllNDVIMasksFromLocation = function(fileLocation, j, k){
  filesToAnalyze = list.files(fileLocation) # lists the files in the location given to be used in the analysis
  numberOfFiles = length(filesToAnalyze) #Lists the number of files so the for loop doesn't go past it for iterations
  
  #This is the most confusing part for reclassification in R a matrix of the values needs to be created
  #This is not the most elegant version to solve this but its what I ended up using
  #All values for the matrix are stored in this vector in a column sequential format
  #All values from column, followed by all the values for column 2 etc.
  matrixValues = c(-1,.3, .9 , .3 ,.9, 1, 1,0, 1)
  
  #This actually turns the vecor into a matrix, in this case a 3x3 since I'm separating the vegetation and non
  #Vegetation around the value, these may be changed to separate into whatever NDVI class values you have listed
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
