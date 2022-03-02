#library(d3heatmap)
library(RColorBrewer)
library(shiny)
library(shinythemes)
library(reprex)
library(dplyr)
library(rgl)
library(grimon)
library(shinyWidgets)

data<-read.csv('fpkm_pca_combined_ALL_SMALL_2_with_GO.txt',
               header=TRUE,sep='\t',row.names=1)

data_col <- as.matrix(data[,ncol(data)]) #gets the color column!!!
data_col
rownames(data_col) <- c()

col_group <- data.frame(
  group = c("GO_types","SS_vs_WW_B73_field","SS_vs_WW_FR697_field","SS_vs_WW_FR697_lab",
            "SS_vs_MS_FR697_lab","MS_vs_WW_FR697_lab"),
  min_col = c(1, 3, 5, 7, 9, 11),
  max_col = c(2, 4, 6, 8, 10, 12)
)

####ui####
ui<-fluidPage(
  #titlePanel("example_heatmap"), 
  theme=shinytheme("cerulean"),
  
  sidebarPanel(
    sliderInput("obs",
                "Number of observations:",
                min = 1,
                max = nrow(data),
                value = nrow(data)),
    tableOutput("values"),
    
    #group of checkboxes
    checkboxGroupInput("checkGroup", 
                       label = h3("columns to select"),
                       choices = col_group[, "group"],
                       selected = col_group[, "group"])
  ),
  
  mainPanel(
    # Output: Table summarizing the values entered ----
    rglwidgetOutput("myWebGL",  width = 800, height = 600)
  ),
  
  
  fluidRow(column(3, verbatimTextOutput("value")))
)

####server####
server <- function(input, output) 
{
  new_data_matrix <- reactive({
    col_ranges <- col_group %>% 
      filter(group %in% input$checkGroup)
    
    all_cols <- unlist(Map(`:`, col_ranges$min_col, col_ranges$max_col))
    
    data[1:input$obs, all_cols]
  })
  
  output$myWebGL <- renderRglwidget({
    # validate(
    #   need(input$checkGroup, 'Check at least one group!'),
    #   need(input$obs >= 2, 'Need at least 2 groups to cluster!')
    # )
    rgl.open(useNULL=T)
    grimon(x = new_data_matrix(),
           #x = fpkm_pca_combined_Matr,
           # label = c("GO_types","SS_vs_WW_B73_field","SS_vs_WW_FR697_field",
           #           "SS_vs_WW_FR697_lab","SS_vs_MS_FR697_lab","MS_vs_WW_FR697_lab"),
           label = input$checkGroup,
           col = data_col[1:input$obs], 
           optimize_coordinates = TRUE, #maxiter = 1e3,
           score_function = "angle",
           segment_alpha = 0.5,
           plot_2d_panels = TRUE)
    bg3d(color = "white",smooth = TRUE,)
    #saveWidget(rglwidget(),background = "white")
    rglwidget()
  })
}

shinyApp(ui, server)
