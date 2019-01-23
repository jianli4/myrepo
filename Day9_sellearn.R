###today I am gonna learn gt package

###first let's learn some basics about glue package
library(glue)
name<- "Fred"
age<- 50
anniversary<- as.Date("1992-10-05")
glue('My name is {name},',
     'my age next year is {age+1},',
     'my anniversary is {format(anniversary,"%A, %B %d, %Y")}')

#single braces can be inserted by doubling them
glue("My name is {name}, not {{name}}.")

#named arguments can be used to assign temporary variables
glue('My name is {name},',
     ' my age next year is {age+1},',
     ' my anniversary is {format(anniversary, "%A, %B %d, %Y")}.',
     name="Joe",
     age=40,
     anniversary= as.Date("2019-01-23")
     )

#within dplyr pipelines
library(dplyr)
head(iris) %>% mutate(description=glue("This {Species} has a petal length of {Petal.Length}"))

#`glue_data()` is useful in magrittr pipes
library(magrittr)
mtcars %>% glue_data("{rownames(.)} has {hp} hp")

###tableby function from arsenal package
library(arsenal)
data(mockstudy)
tab1 <- tableby(arm ~ sex + age, data=mockstudy)
summary(tab1, text=TRUE)
#cosmetic changes
mylabels <- list(sex = "SEX", age ="Age, yrs")
summary(tab1, labelTranslations = mylabels, text=TRUE)

tab3<- tableby(arm ~ sex + age, data=mockstudy, test=FALSE,total=FALSE,
               numeric.stats=c("median","q1q3"),numeric.test="kwt")
summary(tab3,text=TRUE)

#multiple LHS
summary(tableby(list(arm,sex) ~ chisq(age), data=mockstudy, strata=ps,numeric.stats=c("mean","range","q1q3")),text=TRUE)
###now it's time to work on GT package
library(gt)
library(tidyverse)
library(glue)

# Define the start and end dates for the data range
start_date <- "2010-06-07"
end_date <- "2010-06-14"

# Create a gt table based on preprocessed
# `sp500` table data
sp500 %>%
  dplyr::filter(date >= start_date & date <= end_date) %>%
  dplyr::select(-adj_close) %>%
  mutate(date=as.character(date)) %>%
  gt() %>%
  tab_header(
    title = "S&P 500",
    subtitle = glue::glue('{format(as.Date(start_date),"%B %d, %Y")} to {format(as.Date(end_date),"%B %d, %Y")}')
  ) %>%
  fmt_date(
    columns = vars(date),
    date_style = 3
  ) %>%
  fmt_currency(
    columns = vars(open, high, low, close),
    currency = "USD"
  ) %>%
  fmt_number(
    columns = vars(volume),
    scale_by = 1 / 1E9,
    pattern = "{x}B"
  )

###play around with tableby() function
tableby(arm ~ sex + age, data = mockstudy) %>%
  as.data.frame() %>%
  gt(
    groupname_col = "variable",
    rowname_col = "term"
  )
