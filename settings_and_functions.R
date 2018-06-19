settings <- list(
  refresh=1           # time in s to check for new data
  ,towdur=30          # expected duration of the tow
)

IsThereNewFile <- function() file.info('nmea_out.txt')$mtime


# this is the function that reads the nmea data
# it will be specific to each institute
# it needs to produce a dataframe with a POSIXct field called datetime
# and columns X1 - X10 that have the NMEA values, separated into columns
ReadAllData <- function() {
  raw <- read.table('nmea_out.txt',header=T,sep='\t',stringsAsFactors=F)
  raw$datetime <- as.POSIXct(raw$update_utcdate)
  raw1 <- separate(raw,nmea_telegram,into=paste0('X',1:10),sep=',',fill='right')
  return(raw1)
}


makeplot <- function(nmea,input) {
          xmax <- max(nmea$datetime)
          xlim <- c(xmax-settings$towdur*60,xmax)
          with(subset(nmea,X4=='DST'&X5<2), plot(datetime,X7,xlim=xlim,ylim=c(0,150)))
          abline(v=input$start_slider) 
}