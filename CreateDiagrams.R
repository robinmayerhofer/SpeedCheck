# you can start this script with: 'R < CreateDiagrams.R --no-save'
require("parsedate")

downloadMax <- 81920
downloadDesired <- 40960

uploadMax <- 15360
uploadDesired <- 10240

# write to file Diagrams.pdf that needs to be in the same folder as the R script
pdf("Diagramme.pdf")

data <- read.csv("SpeedMeasurements.csv", 
                 sep = ";", 
                 header = TRUE,
                 dec = ".")

data$Timestamp <- parse_iso_8601(data$Timestamp)

par(mar = c(8, 4.1, 4.1, 2.1))

plot(x = data$Timestamp, 
     y = data$Download..kbps., 
     type = "l",
     xlab = "",
     ylab = "Download Speed [kb/s]",
     ylim = c(0, downloadMax),
     main = "Download Speed",
     xaxt = "n",
     # complex grids need to be done with ablines, as grid does not support customizing where exactly the lines are placed
     # use panel.first to get the grid behind the data
     panel.first = abline (h = seq(from = 10000, 
                           to = round(downloadDesired, 
                                      digits = -4), 
                           by = 10000), 
                           col = "LIGHTGREY")
     )

abline(a = downloadDesired, b = 0, col = "RED")
axis.POSIXct(side = 1,
             at = pretty(data$Timestamp, 20),
             format = "%d.%m.%y (%H:%M)",
             las = 2)

plot(x = data$Timestamp, 
     y = data$Upload..kbps., 
     type = "l",
     xlab = "",
     ylab = "Upload Speed [kb/s]",
     ylim = c(0, uploadMax),
     main = "Upload Speed",
     xaxt = "n",
     panel.first = abline (h = seq(from = 2000, 
                                   to = round(uploadDesired, 
                                              digits = -3), 
                                   by = 2000), 
                                   col = "LIGHTGREY")
    )

abline(a = uploadDesired, b = 0, col = "RED")

# make a pretty date/time axis with 20 labels 
axis.POSIXct(side = 1,
             at = pretty(data$Timestamp, 20),
             format = "%d.%m.%y (%H:%M)",
             las = 2)

dev.off()