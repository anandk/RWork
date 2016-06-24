library(data.table)
library(digest)

#Load dataset into a data table. Please enter file name within quotes below
unmaskedDT <- fread("...")

#masking function defined
maskingFunc <- function(dt, algo="sha1"){
  hashes <- vapply(unique(dt), #Get unique values
                   function(val) digest(val,algo), FUN.VALUE = "",USE.NAMES = TRUE)
  unname(hashes[dt])
}

#Pick the columns to mask. First 11 columns? Ok!
columnsToMask <- c(colnames(unmaskedDT)[1:11])

#Run the masking routine
maskedDT <- initialDataTable[, columnsToMask := lapply(.SD, maskingFunc),
                 .SDcols=columnsToMask, with=FALSE
                 ][]


write.csv(maskedDT, file = "MaskedVolumesData.csv", row.names = FALSE)

