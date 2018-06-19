nmea <- read.table('nmea_in.txt',sep='\t',header=T)


write.table(nmea[1:500,],'nmea_out.txt',sep='\t',quote=F,row.names=F)

for(i in 501:nrow(nmea)) {
  Sys.sleep(0.1)
  try(write.table(nmea[i,],'nmea_out.txt',sep='\t',append=T,quote=F,row.names=F,col.names=F))
}
