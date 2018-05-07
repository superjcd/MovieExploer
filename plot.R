#按类型做散点图（以后需要解决ggplot的参数问题，None standars evalution）
gg_by_genre <- function(data,xintercept,yintercept) {
  ggplot(data, aes(x = `豆瓣评分`, y = `总票房（万）`, color = `主类型`)) +
    geom_point() +
    scale_x_continuous(breaks = c(2, 4, 6, 8)) +
    geom_hline(yintercept = yintercept) +
    geom_vline(xintercept = xintercept) +
    annotate(
      geom = 'text',
      x = 0.7*xintercept,
      y = 1.3*yintercept,
      label = paste0('Medians of Rates:',xintercept),
      color = 'blue',
      fontface = 'italic',
      size = 5
    ) +
    annotate(
      geom = 'text',
      x = xintercept,
      y = 3.5*yintercept,
      label = paste0('Medians of Box-office:',yintercept),
      color = 'red',
      fontface = 'italic',
      size = 5
    ) +
    labs(x = '豆瓣评分', y = '总票房(万)') +
    theme_dark() +
    theme(
      text = element_text(family = 'STSong'),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank()
    )
  
}

gg_by_area <- function(data,xintercept,yintercept) {
  ggplot(data, aes(x = `豆瓣评分`, y = `总票房（万）`, color = `地区`)) +
    geom_point() +
    scale_x_continuous(breaks = c(2, 4, 6, 8)) +
    geom_hline(yintercept = yintercept) +
    geom_vline(xintercept = xintercept) +
    annotate(
      geom = 'text',
      x = 0.7*xintercept,
      y = 1.3*yintercept,
      label = paste0('Medians of rates:',xintercept),
      color = 'blue',
      fontface = 'italic',
      size = 5
    ) +
    annotate(
      geom = 'text',
      x = xintercept,
      y = 3.5*yintercept,
      label = paste0('Medians of Box-office:',yintercept),
      color = 'red',
      fontface = 'italic',
      size =5
    ) +
    labs(x = '豆瓣评分', y = '总票房(万)') +
    theme_dark() +
    theme(
      text = element_text(family = 'STSong'),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank()
    )
  
}

#动图，暂不使用
gg_motion <- function(data, area) {
  ggplot(data[data$地区  %in% as.vector(area),],
         mapping = aes(x = `豆瓣评分`, y = `总票房（万）`)) +
    geom_point(aes(frame = `上映年份`, ids = `影片名`)) +
    scale_x_continuous(breaks = c(2, 4, 6, 8)) +
    #scale_color_brewer() +
    theme(text = element_text(family = 'STSong'),
          legend.position = 'bottom') +
    theme_dark()
}

#全部
gg_all_lm <- function(data,model_info) {
  ggplot(data,
         mapping = aes(x = `豆瓣评分`, y = `总票房（万）`)) +
    geom_point(aes(color = `地区`)) +
    geom_text(data = model_info, aes(
       x = 6,
      y = 4.5e+05,
       label = paste0('P.value:', round(p.value, 3))
    ),color='blue') +
    geom_text(data = model_info, aes(
      x = 6,
      y = 4.2e+05,
      label = paste0('R^2:', round(r.squared, 2))
    ),color='blue') +
    geom_smooth(method = 'lm',
                se = F) +
    scale_x_continuous(breaks = c(2, 4, 6, 8)) +
    scale_color_brewer(palette = 'Set1') +
    theme(text = element_text(family = 'STSong'),
          legend.position = 'bottom') +
    theme_dark()
  
}

#按年份
gg_by_year <- function(data) {
  ggplot(data,
         mapping = aes(x = `豆瓣评分`, y = `总票房（万）`)) +
    geom_point(aes(color = `地区`)) +
    geom_smooth(method = 'lm', se = F) +
    facet_wrap(~ `上映年份`, nrow = 3, ncol = 4,scales = 'free') +
    scale_x_continuous(breaks = c(2, 4, 6, 8)) +
    scale_color_brewer(palette = 'Set1',guide=FALSE) +
    theme(text = element_text(family = 'STSong'),legend.position = 'none') +
    theme_dark()
}