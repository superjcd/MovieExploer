ui <- fluidPage(
  includeCSS('www/style.css'),
  theme = shinytheme("darkly"),
  titlePanel('Movie Explorer'),
  sidebarLayout(
    sidebarPanel(
      width = 4,
      selectInput(
        'area',
        '地区',
        choices = c('全部', area),
        selected = '全部'
      ),
      selectInput('genre', '类型', choices = c('全部',genre), selected = '全部'),
      sliderInput(
        'rating',
        '豆瓣评分',
        min = 0,
        max = 10,
        value = 6
      ),
      dateRangeInput(
        'daterange',
        '时间跨度',
        start = daterange[1],
        end = daterange[2],
        min = daterange[1],
        max = daterange[2],
        format = 'yyyy-mm-dd',
        language = 'zh-CN'
      ),
      downloadButton('download', '下载数据')
      
    ),
    mainPanel(tabsetPanel(
      tabPanel(title = '电影信息',
               DT::dataTableOutput('dt_movies')),
      tabPanel(title = '口碑vs票房',
               plotOutput('plot_vs')),
      tabPanel(title = '分析')
      
    ))
  )
)

