###today i am learning Rmarkdown 


###read Yihui's book

rmarkdown::render("day11_selflearn.Rmd",'pdf_document')

#if you are not sure if a string should be quoted or not, test it with the yaml package, e.g.,
cat(yaml::as.yaml(list(
  title='A Wondferful Day',
  subtitle='hygge: a quality of coziness'
)))
#note that the subtitle in the above examplke is quoted because of the colon

#sub-options in YAML
output:
  html_document
    toc:true
    includes:
        in_header:header.html
        before_body: before.html
        
output:
    pdf_document:
      toc:TRUE
      pandoc_args:

        
        
        
        
library(arsenal)
library(ggplot2)
data(mockstudy)
p <- ggplot(mockstudy, aes(x = age, y = bmi)) + geom_point()
saveRDS(p, file = "myplot.rds")
write2pdf(list(
yaml(classoption="landscape"),
code.chunk(
  print(readRDS("myplot.rds")),
  chunk.opts = "r, echo=FALSE, warning=FALSE, fig.height=6, fig.width=6"
)
), file = "myreport2.pdf")

        