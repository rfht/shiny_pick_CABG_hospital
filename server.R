library(shiny)

data_sr <- read.csv("Cardiac_Surgery_and_PCI_In-Hospital___30-Day_Risk_Adjusted_Mortality_Rate_by_Hospital__Beginning_2008.csv")
data_sr <- data_sr[-24,]		# Exclude the summary statistic "NYS - All Hospitals" from the analysis

shinyServer(function(input, output) {

	output$hospName <- renderText(as.character(data_sr[data_sr$Hospital.Name == input$hosp, 2]))
	output$hospReg <- renderText(as.character(data_sr[data_sr$Hospital.Name == input$hosp, 3]))
	#output$hospLoc <- renderPrint(as.character(data_sr[data_sr$Hospital.Name == input$hosp, 2]), "	", as.character(data_sr[data_sr$Hospital.Name == input$hosp, 3]))
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
