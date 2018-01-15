#
# This is the UI code to display a sine wave and/or a cosine
# wave on a plot.  The user can adjust the color, amplitude
# and frequency of the waves with a slider and radio buttons.
# Options are given to select which wave(s) to show.
# The mean amplitude of the wave(s) is calculated and shown
# under the plot and this value will update automatically
# with changes in frequency and amplitude.  Also, the user
# has the option of selecting part of either or both waves   
# and the application will calculate the mean amplitude of
# of the selected wave data and display it below the plot.

library(shiny)

# Define UI for application that draws the wave plots
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Playing with Waves"),
  
  # Sidebar with with sliders for wave amplitude and frequency,
  # radio buttons to select the wave color and checkbox to display
  # either or both waves.
  sidebarLayout(
    sidebarPanel(
      h2("Change the Wave Amplitude"),
      sliderInput("amp",
                  "Wave Amplitude",
                  min = 0,
                  max = 10,
                  value = 5,
                  step = 0.1),
      
      h2("Change the Wave Frequency"),
      sliderInput("freq",
                  "Wave Frequency(Hz)",
                  min = 0,
                  max = 10,
                  value = 1,
                  step = 0.1),
      
      h2("Select Wave Color"),
      radioButtons("color", "Wave Color:",
                   c("Red" ="red",
                     "Blue" = "blue",
                     "Green" = "darkgreen")),
      
      h2("Select Wave Type:"),
      checkboxInput("sinplot","Sine Wave"),
      checkboxInput("cosplot","Cosine Wave")
      
      
      
    ),
    
    # Show a plot of the sine and/or cosine wave and show the 
    # calculations of the mean wave amplitude, both of the full
    # wave(s) and the wave(s) portions selected by the user, if
    # any were selected.
    mainPanel(
      
      
      h1("Wave Plot"),
      h4("(Instructions for use provided below)"),
      plotOutput("waveplot", brush = brushOpts(id="brush1")),
      h3("Mean Amplitude of Selected Sine Wave Data:"),
      textOutput("brushedmeansine"),
      h3("Mean Amplitude of Full Sine Wave:"),
      textOutput("sinOut"),
      h3("Mean Amplitude of Selected Cosine Wave Data:"),
      textOutput("brushedmeancos"),
      h3("Mean Amplitude of Full Cosine Wave:"),
      textOutput("cosOut"),
      h2("Documentation Section and Instructions for Use"),
      h3("Author: JB"),
      h3("Date:  Jan 12, 2018"),
      
      #Paragraphs of documentation providing instructions on how to use the app.
      p("The following app was designed to introduce, and demonstrate in a very visual way, 
        some basic prinicples of trigonometry for people who might not be familiar with it.  
        The app shows what basic sin and cosine trigonometric functions are, which are basically
        periodic wave signals of a specific amplitude and frequency.  In this app, these waves are
        shown as functions of time, but the independent variable does not necessarily have to be 
        time exclusively for these kinds of functions.  The amplitude of a wave is its strength
        (or signal magnitude), while the frequency is how many times a full cycle of the wave 
        repeats itself per unit of time."),
      p(" "),
      p("In the app, in the the side panel above, under the label
        'Select Wave Type:', the user has the option to select to display
         either a sine wave, cosine wave, both or none, by selecting the check boxes
         as desired.  Upon doing this either one of or both of the waves will be shown
         in a plot in the top half area of the main panel in the app.  The user can then 
         select the desired color of the waves (either red, blue or green) by selecting 
         one of the radio buttons under the heading 'Select Wave Color' in the side panel.
         The amplitude or frequency of the displayed waves can be automatically changed 
         by clicking and dragging the slider bars under the headings 'Change the Wave
         Amplitude' or 'Change the Wave Frequency' headings in the side panel.
         In the main panel above, the mean amplitudes of either a full sine wave, full 
         cosine wave, or both are calculated and shown, and these values will update 
         automatically if the user changes the frequency and amplitudes of the waves 
         using the sliders in the side panel.  The user also has the option to select part
         of a wave in the plot using the mouse.  Simply click on a region
         of the plot and drag a box covering the part of the wave(s) of interest.  The mean 
         amplitudes of the selected region of the wave(s) will then automatically be 
         calculated and shown in the the main panel above.  To remove the 
         selection box from the plot, click once outside the box but on the 
         plot somewhere.  The user can then select a different wave region if desired 
         and get new mean amplitude values in the newly selected region."),
       p(" "),
       p("The ui.R and server.R code files for this app are available on github at the following
         link:"),
      
      #Link to the ui.R and server.R files for this Shiny app.
      tags$a(href="https://github.com/JohnBracken/ShinyApp_Trigonometry", "R code for this app")
      
    )
  )
))