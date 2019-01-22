devtools::install_github("thomasp85/gganimate")
library(gganimate)
library(ggplot2)

ggplot(mtcars,aes(factor(cyl),mpg))+geom_boxplot()+
  transition_states(
    gear,
    transition_length=2,
    state_length=1
  )+
  enter_fade()+
  exit_shrink()+
  ease_aes('sine-in-out')

library(gapminder)
ggplot(gapminder,aes(gdpPercap,lifeExp,size=pop,colour=country))+
  geom_point(alpha=0.7,show.legend=FALSE)+
  scale_colour_manual(values=country_colors)+
  scale_size(range=c(2,12))+
  scale_x_log10()+
  facet_wrap(~continent)+
  labs(title='Year:{frame_time}',x='GDP per capita',y='life expectancy')+
  transition_time(year)+
  ease_aes('linear')


