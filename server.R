
# server.R for path loss

# There needs to be a dataframe built that represents the cell phone performance,
# in essense, a look up table. The data below represents actual hand collected data
# from a single device in a lab environment.  The data frame is the reference for
# what speed (in Mbps) can be achieved based and received signal level and channel size
# for an isolated cell.  This only needs to be established once when entering the program.

rx <- c(-90,-91,-92,-93,-94,-95,-96,-97,-98,-99,-100,
        -101,-102,-103,-104,-105,-106,-107,-108,-109,-110,
        -111,-112,-113,-114,-115,-116,-117,-118,-119,-120,
        -121,-122,-123,-124,-125,-126,-127,-128,-129,-130)

ch1.4 <- c(7.1,7.1,7.1,7.1,7.1,7.1,7.1,7.1,7.1,7.1,7.1,
           7.1,7.1,7.1,7.1,7.1,6.4,6.4,5.7,5.7,4.9,
           4.9,4.2,4.2,4.2,3.4,3.4,3.0,2.4,1.9,1.5,
           1.1,0.8,0.5,0.3,0.2,0.2,0.2,0,0,0)

ch3 <- c(18.6,18.6,18.6,18.6,18.6,18.6,18.6,18.6,18.6,18.6,18.6,
         18.6,18.6,16.8,16.8,14.9,14.9,12.9,12.9,10.9,10.9,
         10.9,9.0,9.0,7.9,6.3,4.9,3.9,2.9,2.0,1.2,
         0.8,0.5,0.5,0.5,0,0,0,0,0,0)

ch5 <- c(31.7,31.7,31.7,31.7,31.7,31.7,31.7,31.7,31.7,31.7,31.7,
         28.6,28.6,25.3,25.3,21.9,21.9,18.6,18.6,18.6,15.3,
         15.3,13.5,10.7,8.3,6.6,4.9,3.4,2.1,1.3,0.9,
         0.9,0.9,0,0,0,0,0,0,0,0)

ch10 <- c(63.4,63.4,63.4,63.4,63.4,63.4,63.4,63.4,57.2,57.2,50.6,
          50.6,43.8,43.8,37.2,37.2,37.2,30.6,30.6,27.0,21.4,
          16.6,13.2,9.8,6.8,4.2,2.6,1.8,1.8,0,0,
          0,0,0,0,0,0,0,0,0,0)

ch15 <- c(95.1,95.1,95.1,95.1,95.1,95.1,85.8,85.8,75.9,75.9,65.7,
          65.7,55.8,55.8,55.8,45.9,45.9,40.5,32.1,24.9,19.8,
          14.7,10.2,6.3,3.9,2.7,2.7,2.7,0,0,0,
          0,0,0,0,0,0,0,0,0,0)

ch20 <- c(126.8,126.8,126.8,126.8,126.8,114.4,114.4,101.2,101.2,87.6,87.6,
          74.4,74.4,74.4,61.2,61.2,54.0,42.8,33.2,26.4,19.6,
          13.6,8.4,5.2,3.6,3.6,3.6,0,0,0,0,
          0,0,0,0,0,0,0,0,0,0)


speed <- data.frame(rx, ch1.4, ch3, ch5, ch10, ch15, ch20)

# rename the data.frame columns to more easily match inputs from the ui.R

library(data.table)
library(plyr)
library(dplyr)
setnames(speed, old = c("rx", "ch1.4", "ch3", "ch5", "ch10", "ch15", "ch20"),
         new = c("recieve", "1.4", "3", "5", "10", "15", "20"))

library(shiny)

shinyServer(
  function(input, output) {
  
# This calculates the path loss in dB between the tower and the mobile.
# This is a modifed version of the Egli propagation model.
# inputs to the model are distance between points, in miles, radio frequency in MHz
# and tower height in feet (above ground).  A traditional input is also height above 
# ground for the receiver, in this case the mobile, and is fixed at 5 feet for this program.
pathloss <- reactive(  round((
                     117 + 
                     40*log10(as.numeric(input$miles)) +
                     20*log10(as.numeric(input$frequency)) -
                     20*log10(as.numeric(input$tower)*5)
                    )*-1,1)
                  )


# Calculate the power, in dBm, per subcarrier, depending on channel size
# CRS is known as the "Cell Reference Signal".  This is what the base station
# transmits for the phone to use to make measurements of the tower being used.  
crs <- reactive(
                {
                   if(as.numeric(input$channel) == 1.4) {subcar = 75}
                   if(as.numeric(input$channel) == 3  ) {subcar = 150}
                   if(as.numeric(input$channel) == 5  ) {subcar = 300}
                   if(as.numeric(input$channel) == 10 ) {subcar = 600}
                   if(as.numeric(input$channel) == 15 ) {subcar = 900}
                   if(as.numeric(input$channel) == 20 ) {subcar = 1200}
                   
                   round(10*log10(((as.numeric(input$power)/2)/subcar)/.001),1)
                }   
               )

# The strength of the received reference signal (CRS) is dependent upon several things, 
# subcarrier power(the CRS) + antenna gain - pathloss.  The industry standard used to 
# measuere this is called "Reference Signal Recieve Power" or "RSRP" and is measured in 
# units of dBm.  dBm = 10*log10(watts/.001)
   
rsrp <- reactive(crs() + as.numeric(input$antenna) + pathloss()) 
    
maxspeed <- reactive(
                      {
                       rx <- round(rsrp(),0)               # make it an Int so it matches table
                       if(rx >  -90) {rx =  -90}
                       if(rx < -130) {rx = -130}
                       rx
                       max <- filter(speed, recieve == rx) # gives correct rx row
                       ch <- input$channel                 # pciks the correct column
                       max[ ,ch]
                      }
                    )

fastest <- reactive(  { maxspeed() }  )

worstspeed <- reactive(  
                        {  
                         people <- as.numeric(input$users)
                         round(maxspeed()/(people),3) 
                        }  
                       )

slowest <- reactive(  {  worstspeed()  }  )


graph <- reactive(
                  {
                    distance <- seq(.1, as.numeric(input$miles), by = .1)
                  
                    signal <- crs() + as.numeric(input$antenna) + 
                              round(117 + 40*log10(distance) + 
                                    20*log10(as.numeric(input$frequency)) - 
                                    20*log10(as.numeric(input$tower)*5))*-1
                    
                     data.frame(distance,signal)
                    
                  }
                 )

    output$frequency = renderPrint({input$frequency})
    output$tower     = renderPrint({input$tower})
    output$pathloss  = renderPrint(pathloss())
    output$crs     <- renderPrint(crs())
    output$rsrp      = renderPrint(rsrp())
    output$maxspeed  = renderPrint(maxspeed())
    output$fastest <-  renderPrint(fastest())
    output$worstspeed= renderPrint(worstspeed())
    output$slowest  <- renderPrint(slowest())
    output$graph    <- renderPlot({plot(graph(), xlab = "Distance from tower (miles)",
                                                 ylab = "RSRP (dBm) measured at phone", 
                                                 main = "Phone Signal (based on inputs)", 
                                                 type = "b", col = "blue")})
    
  }
)
