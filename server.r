#source plot.R
source('plot.R')

server <- function(input, output, server) {
  movies_selected <- reactive({
    data_movie <- movies[, c(2, 8, 11, 3, 5, 9, 10)] %>% filter(
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
  plot_lists <- reactive({
    data <- movies_selected()
    xintercept <- median(data$`豆瓣评分`)
    yintercept <- median(data$`总票房（万）`)
    p1 <- ggplotly(gg_by_genre(data, xintercept, yintercept))
    p2 <- ggplotly(gg_by_area(data, xintercept, yintercept))
    plot_lists <- list('类型' = p1,
                       '地区' = p2)
    plot_lists
  })
  
  #render Plotly
  output$plotly_by_selecet <- renderPlotly({
    plot_lists <- plot_lists()
    input_selected <- input$plot_select
    if (input_selected == '类型') {
      plot_lists[[1]]
    } else{
      plot_lists[[2]]
    }
  })
  
  
  #tab3
  model_info<-reactive({
    data <- movies_selected()
    LM <- lm(`总票房（万）` ~ `豆瓣评分`, data = data)
    model_info<-glance(LM)
    model_info
    })
  
  plot_lists2 <- reactive({
    area <- input$area
    data <- movies_selected()
    #model_info <- model_info()
    p1 <- ggplotly(gg_all_lm(data,model_info()))
    p2 <- ggplotly(gg_by_year(data)) %>% hide_legend()
    plot_lists2 <- list(p1, p2)
  })
  
  output$plotly_analysis <- renderPlotly({
    plot_lists <- plot_lists2()
    input_selected <- input$analysis_select
    if (input_selected == '全部') {
      plot_lists[[1]]
    } else{
      plot_lists[[2]]
    }
    
  })
  
  output$download<-download_csv(movies,'movies')
  
}