library(shiny)
data_ui <- read.csv("Cardiac_Surgery_and_PCI_In-Hospital___30-Day_Risk_Adjusted_Mortality_Rate_by_Hospital__Beginning_2008.csv")
data_ui <- data_ui[-24,]	# Exclude the summary statistic "NYS - All Hospitals" from the analysis

shinyUI(fluidPage(

	titlePanel(
		h1("Coronary Artery Bypass Graft surgery (CABG): Volume and Outcomes at New York Hospitals in 2011")
	),

	sidebarLayout(
		sidebarPanel(
			radioButtons("hosp", "Hospital", as.character(unique(data_ui[, 2])))	
		),

		mainPanel(
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
