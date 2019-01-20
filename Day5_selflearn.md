Day5\_selflearn
================
Jian Li
1/19/2019

Relationship to base and plyr functions
---------------------------------------

``` r
library(purrr)
library(repurrrsive)
```

lapply() vs. purrr::map() These are the core mapping functions of base and purrr,respectively. They are "list in,list out". The main(only?) difference is access to purrr's shortcuts for indexing by name or position and for creating anonymous functions.

**base**

``` r
lapply(got_chars[1:3],function(x) x[["name"]])
```

    ## [[1]]
    ## [1] "Theon Greyjoy"
    ## 
    ## [[2]]
    ## [1] "Tyrion Lannister"
    ## 
    ## [[3]]
    ## [1] "Victarion Greyjoy"

**purrr**

``` r
map(got_chars[1:3],"name")
```

    ## [[1]]
    ## [1] "Theon Greyjoy"
    ## 
    ## [[2]]
    ## [1] "Tyrion Lannister"
    ## 
    ## [[3]]
    ## [1] "Victarion Greyjoy"

``` r
map_dfr(got_chars[23:25],`[`,c("name","playedBy"))
```

    ## # A tibble: 3 x 2
    ##   name            playedBy     
    ##   <chr>           <chr>        
    ## 1 Jon Snow        Kit Harington
    ## 2 Aeron Greyjoy   Michael Feast
    ## 3 Kevan Lannister Ian Gelder

``` r
tibble::tibble(
  name=map_chr(got_chars[23:25],"name"),
  id=map_int(got_chars[23:25],"id")
)
```

    ## # A tibble: 3 x 2
    ##   name               id
    ##   <chr>           <int>
    ## 1 Jon Snow          583
    ## 2 Aeron Greyjoy      60
    ## 3 Kevan Lannister   605
