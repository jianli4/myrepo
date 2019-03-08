
###continue learning NSE and also learn environment in R
library(dplyr)
library(rlang)
#the equivalent to enexprs() is an undocumented feature of substitute()
f<- function(...) as.list(substitute(...()))
f(x=1,y=10*z)



#You'll most often see substitute() used to capture unevaulated arguments. however, as well as quoting,
#substitute() also does "substitution": if you give it an expression, rather than a symbol, it will
#substitute in the values of symbols defined in the current environment.
f4<- function(x) substitute(x*2)
f4(a+b+c)

###I think this makes code hard to understand, because if it is taken out of context, you can't tell if the goal 
#of substitute(x+y) is to replace x, y or both. If you do want to use substitute() for substitution, I recommend
#that you use the second argumetn to make your goal clear:
substitute(x*y*z,list(x=10,y=quote(a+b)))
expr<- substitute(iris %>% arrange(by),env = list(by=c("Species","desc(Sepal.length)")))
eval_tidy(expr)
