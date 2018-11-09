require("parsedate")

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
     ylim = c(0, 81920),
     main = "Download Speed",
     xaxt = "n",
     panel.first = abline (h = seq(from = 10000, to = 80000, by = 10000), col = "LIGHTGREY")
     )

abline(a = 40960, b= 0, col = "RED")
axis.POSIXct(side = 1,
             at = pretty(data$Timestamp, 20),
             format = "%d.%m.%y (%H:%M)",
             las = 2)

plot(x = data$Timestamp, 
     y = data$Upload..kbps., 
     type = "l",
     xlab = "",
     ylab = "Upload Speed [kb/s]",
     ylim = c(0, 15360),
     main = "Upload Speed",
     xaxt = "n",
     panel.first = abline (h = seq(from = 2000, to = 15000, by = 2000), col = "LIGHTGREY")
)

abline(a = 10240, b= 0, col = "RED")
axis.POSIXct(side = 1,
             at = pretty(data$Timestamp, 20),
             format = "%d.%m.%y (%H:%M)",
             las = 2)

dev.off()