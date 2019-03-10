subset2 <- function(data, rows) {
  rows <- enquo(rows)
  rows_val <- eval_tidy(rows, data)
  stopifnot(is.logical(rows_val))
  
  data[rows_val, , drop = FALSE]
}
stopifnot



###base::transform
transform(iris,Species2=Species)
###replica of base::transform by using eval_tidy
###what you can take away from this function is the usage of enquos and evaluate within
###a for loop
transform2 <- function(.data, ...) {
  dots <- enquos(...)
  
  for (i in seq_along(dots)) {
    name <- names(dots)[[i]]
    dot <- dots[[i]]
    
    .data[[name]] <- eval_tidy(dot, .data)
  }
  
  .data
}

select(iris,1:2)
select(iris,Sepal.Length:Sepal.Width)
select2<- function(.data,...){
  dots<- enquos(...)
  
  vars<- as.list(setNames(seq_along(.data),names(.data)))
  cols<- unlist(map(dots,eval_tidy,vars))
  .data[,cols,drop=FALSE]
}
select2(iris,1:3)
select2(iris,Species)
