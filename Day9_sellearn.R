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
    title = md("*S&P 500*"),
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
  ) %>%
  cols_merge(col_1=vars(open),
             col_2=vars(high),
             pattern="{1}&mdash;{2}"
             ) %>%
  cols_label(
    open="Open to Close",
    date="Date",
    low="Low",
    close="Close",
    volume="Volume"
  ) %>% 
  cols_align(
    align='center',
    columns=vars(open)
  ) %>% 
  tab_options(
    # table.background.color = NULL,
    # heading.background.color = NULL,
    # table.border.top.width = 0, #remove top border

    table.font.size = px(14),            # Entire table's font size
    table.background.color = NULL,       # Entire table's background color
    table.width = px(720),               # Entire table's width
    table.border.top.style = NULL,    # Top line of table - style
    table.border.top.width = px(0),      # Top line of table - width
    table.border.top.color = NULL,   # Top line of table - color
    heading.background.color = NULL,   # Heading background color
    heading.title.font.size = px(18),    # Title of heading font size
    heading.subtitle.font.size = px(14), # Subtitle font size
    heading.border.bottom.style = "solid",     # Bottom line of heading - style
    heading.border.bottom.width = px(2),       # Bottom line of heading - width
    heading.border.bottom.color = "black",    # Bottom line of heading - color
    column_labels.font.size = px(16),                # Column labels - font size
    column_labels.font.weight = "normal",            # Column labels - font weight
    column_labels.background.color = "white",    # Column labels - background color
    stub_group.background.color = "white",     # Stub group background color
    stub_group.font.size = px(14),             # Stub group labels - font size
    stub_group.font.weight = "800",            # Stub group labels - font weight
    stub_group.border.top.style = "solid",     # Top line of stub group - style
    stub_group.border.top.width = px(2),       # Top line of stub group - width
    stub_group.border.top.color = "black",      # Top line of stub group - color
    stub_group.border.bottom.style = "solid",     # Bottom line of stub group - style
    stub_group.border.bottom.width = px(2),       # Bottom line of stub group - width
    stub_group.border.bottom.color = "black",    # Bottom line of stub group - color
    field.border.top.style = "solid",          # Top line of field - style
    field.border.top.width = px(2),            # Top line of field - width
    field.border.top.color = "black",      # Top line of field - color
    field.border.bottom.style = "solid",       # Bottom line of field - style
    field.border.bottom.width = px(2),         # Bottom line of field - width
    field.border.bottom.color = "black",   # Bottom line of field - color
    row.padding = px(8),                       # Padding of all data rows (stub & field)
    summary_row.background.color = "black", # -- background color of all summary rows (stub & field)
    summary_row.padding = px(3),               # padding of all summary rows (stub & field)
    summary_row.text_transform = "lowercase",  # text transform on all summary row labels
    footnote.font.size = px(12),               # text size of the footnotes block
    footnote.padding = px(3),                  # padding of the footnotes block
    sourcenote.font.size = px(12),             # text size of the source notes block
    sourcenote.padding = px(3)                 # padding of the source note block
  )
  # tab_style(
  #   style = cells_styles(
  #     bkgd_color = "lightcyan",
  #     text_weight = "bold")
  # ) 


cells_styles()
###play around with tableby() function
tableby(arm ~ sex + age, data = mockstudy) %>%
  as.data.frame() %>%
  gt(
    groupname_col = "variable",
    rowname_col = "term"
  )
