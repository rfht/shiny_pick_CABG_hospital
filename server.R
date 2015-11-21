##########################
#
# shiny_pick_CABG_hospital - server.R
# --------------
#
# Author: Thomas Frohwein (thfr@)
# 
# This is the ui.R for use with the R package "shiny". The whole 
# shiny app 'shiny_pick_CABG_hospital' uses the dataset from
#
# "https://health.data.ny.gov/Health/Cardiac-Surgery-and-Percutaneous-Coronary-Interven/jtip-2ccj"
#
# It allows for picking a New York State hospital (among those who
# perform CABG (Coronary Artery Bypass Graft Surgery) and compare
# its performance to the overall distribution of performance.
# The parameters assessed are the overall case volume, 
# observed mortality, and 30-day risk adjusted mortality.
#
# The goal is to facilitate the use of this publicly available information
# for providers and patients. Providers may find easily which hospital best
# to refer to, while patients can make a more informed decision regarding
# where they want to receive their care.
#
# For more information, including the license (2-clause BSD license), 
# please refer to the source code webpage:
#
# https://github.com/thfrwn/shiny_pick_CABG_hospital
#
##########################

# First initialize the required library (shiny), load and trim the data.

library(shiny)

data_sr <- read.csv("Cardiac_Surgery_and_PCI_In-Hospital___30-Day_Risk_Adjusted_Mortality_Rate_by_Hospital__Beginning_2008.csv")
data_sr <- data_sr[-24,]		# Exclude the summary statistic "NYS - All Hospitals" from the analysis

# Start the shiny server which contains the reactive functions that process the input
# input$* and create the output (output$*).

shinyServer(function(input, output) {

	# The first two functions are relatively simple and return the name of the
	# selected hospital and the region that it belongs to.

	output$hospName <- renderText(as.character(data_sr[data_sr$Hospital.Name == input$hosp, 2]))
	output$hospReg <- renderText(as.character(data_sr[data_sr$Hospital.Name == input$hosp, 3]))
	
	# Now create the 3 plots. They are all created in the same way, as a histogram based on
	# one of the columns of the dataset. A red line ('abline') is added to each to indicate
	# where in the distribution the selected hospital is.

	output$casesPlot <- renderPlot({
		hist(data_sr[,7], col = 'darkgray', border = 'white', breaks = 20, xlab = "Number of Cases", ylab = "", yaxt='n', xlim=c(0, 800), main = "CABG procedures in 2011 (Histogram)")
		abline(v = data_sr[data_sr$Hospital.Name == input$hosp, 7], col = "red", lwd = 3)
	})
	output$mortaPlot <- renderPlot({
		hist(data_sr[,9], col = 'darkgray', border = 'white', breaks = 20, xlab = "Mortality in %", main = "Observed Mortality in 2011 (Histogram)", yaxt='n', ylab="", xlim=c(0.0,3.5))
		abline(v = data_sr[data_sr$Hospital.Name == input$hosp, 9], col = "red", lwd = 3)
	})
	output$RAMRPlot <- renderPlot({
		hist(data_sr[,11], col = 'darkgray', border = 'white', breaks = 20, xlab = "30-Day Risk-Adjusted Mortality Rate", main = "30-Day Risk-Adjusted Mortality in 2011 (Histogram)", yaxt='n', ylab="", xlim=c(0.0, 5.0))
		abline(v = data_sr[data_sr$Hospital.Name == input$hosp, 11], col = "red", lwd = 3)
	})
})
