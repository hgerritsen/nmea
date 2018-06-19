# nmea
Code developed to visualise NMEA strings with gear sensor data for WKINVITED 2018

Run stream.R in one instance of R; this will simulate a live stream of NMEA data coming into nmea_out.txt

Run app.R in another intance of R or RStudio. This is a shiny app that shows the doorspread over time. You can press a button to mark when the gear is on the bottom. You can then adjust the time of this event if neccesary.
The idea is that time, position and depth data will be recorded for the events marked (gear on bottom and end of trawl)
