server <- function(input, output, server) {
  movies_selected <- reactive({
    data_movie <- movies[, c(2, 8, 11, 3, 5, 9)] %>% filter(
      `地区` %in% if_area(input$area),
      `主类型` %in% if_genre(input$genre),
      `上映日期` >= input$daterange[1] & `上映日期` <= input$daterange[2]
      #TODO:douban rate
    ) %>% arrange(desc(`总票房（万）`))
  })
  
  output$dt_movies <- renderDataTable({
    data <- movies_selected()
    DT::datatable(data)
  })
}