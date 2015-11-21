##########################
#
# shiny_pick_CABG_hospital - ui.R
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

# This first part is the "header." It initializes the required library (shiny), loads the dataset
# from file, and performs preprocessing of the data (in this case only the row with the
# summary statistic needs to be removed.)

library(shiny)
data_ui <- read.csv("Cardiac_Surgery_and_PCI_In-Hospital___30-Day_Risk_Adjusted_Mortality_Rate_by_Hospital__Beginning_2008.csv")
data_ui <- data_ui[-24,]	# Exclude the summary statistic "NYS - All Hospitals" from the analysis

# Start the shinyUI code block that contains everything that is displayed by shiny. Note that
# the corresponding "backend" code is in the server.R file in the same directory. 

shinyUI(fluidPage(

	# This shiny app has 3 panels: titlePanel, the sidebar, and the mainPanel. The
	# latter two are located inside the sidebarLayout() function.

	titlePanel(
		h1("Coronary Artery Bypass Graft surgery (CABG): Volume and Outcomes at New York Hospitals in 2011")
	),

	sidebarLayout(
		sidebarPanel(

			# This creates radio buttons based on a list of all the hospitals in the
			# dataset. The graphs will be automatically updated by server.R when a 
			# button is clicked.

			radioButtons("hosp", "Hospital", as.character(unique(data_ui[, 2])))	
		),

		mainPanel(

			# The main panel contains two text fields with information on the selected
			# hospital and where it is located, as well as the three plots, and below
			# them some text with further explanation and the references and disclaimer.

			h3("Selected hospital:"),
			verbatimTextOutput("hospName"),
			h3("Region:"),
			verbatimTextOutput("hospReg"),
			plotOutput("casesPlot"),
			plotOutput("mortaPlot"),
			plotOutput("RAMRPlot"),
			p("The red lines indicate the number of cases (upper graph) and the mortality rate (lower graph) of the selected hospital compared to the overall distribution in New York State in 2011."),
			h4("Risk-Adjusted Mortality Rate (RAMR)"),
			p("This is the observed mortality rate adjusted for the predicted mortality. It is a better comparison of the performance of institutions because of differences of the predicted risk in different groups of patients."),
			a(href="https://en.wikipedia.org/wiki/Risk_adjusted_mortality_rate", "Wikipedia article with definition of RAMR"),
			h4("Source of the Underlying Data"),
			p("Cardiac Surgery and Percutaneous Coronary Interventions by Hospital: Beginning 2008. New York State Department of Health."),
			a(href="https://health.data.ny.gov/Health/Cardiac-Surgery-and-Percutaneous-Coronary-Interven/jtip-2ccj", "Permalink"),
			p("(The version of the dataset used for this presentation was accessed on November 20th, 2015.)"),
			h4("Disclaimer"),
			p("Provider results should be compared to the NYS result. It is important to look at the “Comparison Result” data when assessing outcomes, this data indicates which results are statistically different from the statewide results. Some providers may have made important changes in the time period since the data were collected. Historical results may not reflect current performance.")
		)
	)
))
