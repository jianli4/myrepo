#learn gt package options

##changes:
#column_labels_background_color, stub_group_border_top_color, stub_group_border_bottom_color,
#table_border_top_color changed to "#FFFFFF"


#heading_border_bottom_color, field_border_bottom_color, field_border_top_color changed to "#000000"

gt_options_default <- function() {
  
  dplyr::tribble(
    ~parameter,                           ~scss, ~category,             ~value,
    "table_font_size",                    TRUE,  "table",               "16px",
    "table_background_color",             TRUE,  "table",               "#FFFFFF",
    "table_width",                        TRUE,  "table",               "auto",
    "table_border_top_style",             TRUE,  "table",               "solid",
    "table_border_top_width",             TRUE,  "table",               "2px",
    "table_border_top_color",             TRUE,  "table",               "#FFFFFF",
    "heading_background_color",           TRUE,  "heading",             NA_character_,
    "heading_title_font_size",            TRUE,  "heading",             "125%",
    "heading_subtitle_font_size",         TRUE,  "heading",             "85%",
    "heading_border_bottom_style",        TRUE,  "heading",             "solid",
    "heading_border_bottom_width",        TRUE,  "heading",             "2px",
    "heading_border_bottom_color",        TRUE,  "heading",             "#000000",
    "column_labels_background_color",     TRUE,  "columns",             NA_character_,
    "column_labels_font_size",            TRUE,  "columns",             "16px",
    "column_labels_font_weight",          TRUE,  "columns",             "initial",
    "stub_group_background_color",        TRUE,  "stub_group",          NA_character_,
    "stub_group_font_size",               TRUE,  "stub_group",          "16px",
    "stub_group_font_weight",             TRUE,  "stub_group",          "initial",
    "stub_group_border_top_style",        TRUE,  "stub_group",          "solid",
    "stub_group_border_top_width",        TRUE,  "stub_group",          "2px",
    "stub_group_border_top_color",        TRUE,  "stub_group",          "#FFFFFF",
    "stub_group_border_bottom_style",     TRUE,  "stub_group",          "solid",
    "stub_group_border_bottom_width",     TRUE,  "stub_group",          "2px",
    "stub_group_border_bottom_color",     TRUE,  "stub_group",          "#FFFFFF",
    "field_border_top_style",             TRUE,  "field",               "solid",
    "field_border_top_width",             TRUE,  "field",               "2px",
    "field_border_top_color",             TRUE,  "field",               "#000000",
    "field_border_bottom_style",          TRUE,  "field",               "solid",
    "field_border_bottom_width",          TRUE,  "field",               "2px",
    "field_border_bottom_color",          TRUE,  "field",               "#000000",
    "row_padding",                        TRUE,  "row",                 "10px",
    "row_striping_include_stub",          TRUE,  "row",                 "TRUE",
    "row_striping_include_field",         TRUE,  "row",                 "TRUE",
    "summary_row_background_color",       TRUE,  "summary_row",         NA_character_,
    "summary_row_padding",                TRUE,  "summary_row",         "6px",
    "summary_row_text_transform",         TRUE,  "summary_row",         "inherit",
    "footnote_sep",                      FALSE,  "footnote",            "<br />",
    "footnote_glyph",                    FALSE,  "footnote",            "numbers",
    "footnote_font_size",                 TRUE,  "footnote",            "90%",
    "footnote_padding",                   TRUE,  "footnote",            "4px",
    "sourcenote_font_size",               TRUE,  "sourcenote",          "90%",
    "sourcenote_padding",                 TRUE,  "sourcenote",          "4px") %>%
    as.data.frame()
}

tab1<- sp500 %>%
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
  ) 
attr(tab1, "opts_df") <- gt_options_default() 
tab1
tab1 %>% as_rtf() %>% write_lines("tab1_gt_options.rtf")
tab1 %>% as_raw_html() %>% write_lines("tab1_gt_options.html")



###try this code
library(arsenal)
library(tidyverse)


mylabels <- list(sex = "SEX", age ="Age, yrs")
tab1 <- tableby(arm ~ sex + age, data=mockstudy)


write2word(tab1,
           "test.xtable.docx", quiet = TRUE,
           comment = FALSE, # passed to print.xtable to turn off the default message about xtable version
           include.rownames = FALSE, # passed to print.xtable
           caption.placement = "top" # passed to print.xtable
) 

write2pdf(tab1,
           "test.xtable.pdf", quiet = TRUE,
           comment = FALSE, # passed to print.xtable to turn off the default message about xtable version
           include.rownames = FALSE, # passed to print.xtable
           caption.placement = "top" # passed to print.xtable
) 





###this if for univariate function
###list of data frames
rslt9  <- univariate(lew,c("y"),basic=TRUE, 
                     moments=TRUE, ci=TRUE, quant=TRUE, norm=TRUE, quantlvl=c(.01, 0.05, 0.1, 0.25, 0.75, 0.90, 0.95, 0.99))
rslt10  <- univariate(lottery,c("y"),basic=TRUE, 
                      moments=TRUE, ci=TRUE, quant=TRUE, norm=TRUE, quantlvl=c(.01, 0.05, 0.1, 0.25, 0.75, 0.90, 0.95, 0.99))

list_data<- list(lew,lottery,numacc2,numacc3,numacc4)
map(list_data,univariate,basic=TRUE,
    moments=TRUE, ci=TRUE, quant=TRUE, norm=TRUE, quantlvl=c(.01, 0.05, 0.1, 0.25, 0.75, 0.90, 0.95, 0.99))
# invoke_map(list_func,list_data,basic=TRUE, 
#            moments=TRUE, ci=TRUE, quant=TRUE, norm=TRUE, quantlvl=c(.01, 0.05, 0.1, 0.25, 0.75, 0.90, 0.95, 0.99))

##supply with a tibble and invoke_map() will do the job!
df <- tibble::tibble(
  f = c("univariate", "univariate"),
  params = list(
    list(lew,"y",basic=TRUE, 
         moments=TRUE, ci=TRUE, quant=TRUE, norm=TRUE, quantlvl=c(0.05, 0.25, 0.75, 0.99)),
    list(Iowa_salary_book,c("total_salary_paid"),basic=TRUE, 
         moments=TRUE, ci=TRUE, quant=TRUE, norm=FALSE, quantlvl=c(.01, 0.05, 0.1, 0.25, 0.75, 0.90, 0.95, 0.99))
  )
)
df
invoke_map(df$f, df$params)





# Split into pieces, fit model to each piece, then predict
by_cyl <- mtcars %>% split(.$cyl)
mods <- by_cyl %>% map(~ lm(mpg ~ wt, data = .))
map2(mods, by_cyl, predict)
#another way using nest()
###map2() is used because predict function takes two arguments, model and data respectively
mtcars %>% group_by(cyl) %>% nest() %>% mutate(model=map(data,~lm(mpg ~ wt, data=as.data.frame(.)))) %>% mutate(rslt=map2(model,data,predict)) %>%
  unnest(rslt) 
