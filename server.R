# This is the server logic of a Shiny web application. It is the 
# code needed to create all the necessary plots and also to 
# do all the calculations on the data.  The code creates
# plots of trigonometric waves and performs a calculation
# of the mean amplitude of that wave, both from the
# wave data produced by a slider and with wave data selected
# by the user.  



library(shiny)

# Define server logic required to plot the waves
shinyServer(function(input, output) {
  

# Create a plot of the wave with the option to show a sine wave,
# cosine wave, or both.
output$waveplot <- renderPlot({   
    
    
    #Generate the time, sine wave and cosine wave vector data.
    time <- seq(0,1,length.out = 1000) 
    sinewavevalues <- input$amp*sin(2*pi*input$freq*time)
    cosinewavevalues <- input$amp*cos(2*pi*input$freq*time)
    
    
    #Generate just the sine plot.
    if((input$sinplot==1) & (input$cosplot==0)){
    plot(time, sinewavevalues, main="Wave", xlim=c(0,1), ylim=c(-10,10), type = "l",
         xlab="Time(s)", ylab="Amplitude", col=input$color, lwd=3,
         cex.lab=1.6, cex.axis=1.6, cex.main=1.6)
    }
    
    
    #Generate just the cosine plot.
    else if((input$cosplot==1) & (input$sinplot==0)){
    plot(time, cosinewavevalues, main="Wave", xlim=c(0,1), ylim=c(-10,10), type = "l",
    xlab="Time(s)", ylab="Amplitude", col=input$color, lwd=3,
    cex.lab=1.6, cex.axis=1.6, cex.main=1.6) 
    }
    
    
    #Generate both the sine and cosine waves on the same plot.
    else if((input$cosplot==1) & (input$sinplot==1)){
    plot(time, sinewavevalues, main="Wave", xlim=c(0,1), ylim=c(-10,10), 
    xlab="Time(s)", ylab="Amplitude", col=input$color, lwd=3,
    cex.lab=1.6, cex.axis=1.6, cex.main=1.6, type="l") 
    lines(time, cosinewavevalues, xlim=c(0,1), ylim=c(-10,10), 
    col=input$color, lwd=3, lty = 2)
     }
  
    
    #If no wave plot is selected by the user, don't show anything.
    else {
    plot(0,type='n',axes=FALSE,ann=FALSE)
    }
    
  })
  
  
#Reactive function to calculate the mean of the sine wave amplitude.
#This result will change in response to changes in frequency 
#and amplitude from the sliders.
mean_sine <- reactive({
    time   <- seq(0,1,length.out = 1000) 
    sinewavevalues <- input$amp*sin(2*pi*input$freq*time)
    mean(sinewavevalues)
  })

#Reactive function to calculate the mean of the cosinewave 
#amplitude. This result will change in response to changes in 
#frequency and amplitude from the sliders.
mean_cos <- reactive({
  time   <- seq(0,1,length.out = 1000) 
  coswavevalues <- input$amp*cos(2*pi*input$freq*time)
  mean(coswavevalues)
  })

#Reactive function to calculate the mean of the sine wave amplitude
#selected by the user.
mean_brushed_sine <- reactive({
    
    time   <- seq(0,1,length.out = 1000) 
    sinewavevalues <- input$amp*sin(2*pi*input$freq*time)
    df <- data.frame(time, sinewavevalues)
    
    brushed_data <- brushedPoints(df,input$brush1, xvar = "time",
                                  yvar="sinewavevalues")
    if(nrow(brushed_data) <2){
      return(NULL)
    }
    else{
    mean(brushed_data[,2])
    }
  })

#Reactive function to calculate the mean of the cosine wave amplitude
#selected by the user.
mean_brushed_cos <- reactive({
  
  time   <- seq(0,1,length.out = 1000) 
  cosinewavevalues <- input$amp*cos(2*pi*input$freq*time)
  dfcos <- data.frame(time, cosinewavevalues)
  
  brushed_data_cos <- brushedPoints(dfcos,input$brush1, xvar = "time",
                                yvar="cosinewavevalues")
  if(nrow(brushed_data_cos) <2){
    return(NULL)
  }
  else{
    mean(brushed_data_cos[,2])
  }
})

  
  
#Print the mean of the sine wave amplitude output
#calculated from sliders manipulated by the user.
output$sinOut <- renderText({ 
  if(input$sinplot == 0){
    "No sine wave on the plot yet"
    }
  else{
    mean_sine()
    }
  })


#Print the mean of the sine wave amplitude output
#calculated from sliders manipulated by the user.
output$cosOut <- renderText({ 
  if(input$cosplot == 0){
    "No cosine wave on the plot yet"
  }
  else{
    mean_cos()
  }
})    
    
#Print the mean of the sine wave amplitude points
#that were selected by the user using the brush tool.
output$brushedmeansine <- renderText({
  if((is.null(mean_brushed_sine())) | (input$sinplot==0)){
    "No sine wave data selected or on plot yet"
    }
  else{    
    mean_brushed_sine()
    }
  })


#Print the mean of the cosine wave amplitude points
#that were selected by the user using the brush tool.
output$brushedmeancos <- renderText({
  if((is.null(mean_brushed_cos())) | (input$cosplot==0)){
    "No cosine wave data selected or on plot yet"
    }
  else{    
    mean_brushed_cos()
    }
})  
  
})

