# Purrr tutorial
# 
# Use of type-specific NAs when doing setup
# Use of L to explictly request integer. this looks weird but is a nod 
# to short versus long integer

big_plans<- rep(NA_integer_,4)
str(big_plans)
big_plans[3]<- 5L
str(big_plans) 
big_plans[1]<- 10
str(big_plans) ###note that omitting L results in coercion of big_plan to double

as.character(c(T,F))
as.numeric(c('a','b'))
NA_character_
