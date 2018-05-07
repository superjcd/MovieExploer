#按类型做散点图（以后需要解决ggplot的参数问题，None standars evalution）
gg_by_genre<-function(data){
  ggplot(data,aes(x=`豆瓣评分`,y=`总票房（万）`,color=`主类型`))+
    geom_point()+
    scale_x_continuous(breaks = c(2,4,6,8))+
    geom_hline(yintercept = 45329)+
    geom_vline(xintercept = 6.9)+
    annotate(geom='text',x=7,y=200000,label='Medians:6.9e+05',color='red',fontface='italic')+
    annotate(geom='text',x=6,y=59000,label='Medians:4.54e+05',color='red',fontface='italic')+
    labs(x='豆瓣评分',y='总票房(万)')+
    theme_dark()+
    theme(text = element_text(family = 'STSong'),panel.grid.minor = element_blank(),
          panel.grid.major = element_blank())
  
}

gg_by_area<-function(data){
  ggplot(data,aes(x=`豆瓣评分`,y=`总票房（万）`,color=`地区`))+
    geom_point()+
    scale_x_continuous(breaks = c(2,4,6,8))+
    geom_hline(yintercept = 45329)+
    geom_vline(xintercept = 6.9)+
    annotate(geom='text',x=7,y=200000,label='Medians:6.9e+05',color='red',fontface='italic')+
    annotate(geom='text',x=6,y=59000,label='Medians:4.54e+05',color='red',fontface='italic')+
    labs(x='豆瓣评分',y='总票房(万)')+
    theme_dark()+
    theme(text = element_text(family = 'STSong'),panel.grid.minor = element_blank(),
          panel.grid.major = element_blank())
  
}
