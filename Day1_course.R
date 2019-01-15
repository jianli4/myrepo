.Library ###search for the default path for libraries
.libPaths()


use_course("rstd.io/wtf-explore-libraries")


installed.packages() %>% as_tibble() %>% count(Built) 
list.files(.Library)
