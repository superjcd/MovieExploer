#source plot.R
source('plot.R')

server <- function(input, output, server) {
  movies_selected <- reactive({
    data_movie <- movies[, c(2, 8, 11, 3, 5, 9)] %>% filter(
      `地区` %in% if_area(input$area),
      `主类型` %in% if_genre(input$genre),
      `上映日期` >= input$daterange[1] & `上映日期` <= input$daterange[2],
      `豆瓣评分` >= input$rating[1] 
    ) %>% arrange(desc(`总票房（万）`))
  })
  
  #tab1,datatable
  output$dt_movies <- renderDataTable({
    data <- movies_selected()
    DT::datatable(data)
  })
  
  #tab2,ggplot
  plot_lists<-reactive({
    data <- movies_selected()
    p1 <- ggplotly(gg_by_genre(data))
    p2 <- ggplotly(gg_by_area(data))
    plot_lists<-list('类型'=p1,
                     '地区'=p2)
    plot_lists
  })
  
  #render Plotly
  output$plotly_by_selecet<-renderPlotly({
    plot_lists <- plot_lists()
    input_selected <- input$plot_select
    if(input_selected == '类型'){
      plot_lists[[1]]
    }else{plot_lists[[2]]}
  })
  
  #tab3
  
  
  
}