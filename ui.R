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
        value = 0
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
      tabPanel(title = '散点图',
               radioButtons('plot_select',
                            label = '请选择：',
                            choices = c('类型','地区'),
                            selected = '类型',inline = T),
               plotlyOutput('plotly_by_selecet')),
      tabPanel(title = '评分VS票房(线性回归分析)',
               radioButtons('analysis_select',
                            label = '请选择',
                            choices = c('动图',
                                        '全部',
                                        '按年份')),
               plotlyOutput('plotly_analysis'))
      
    ))
  )
)

