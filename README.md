# Spatio-temporal analysis of the effects of management strategies on the abundance of marine organisms

This repository contains code and data needed to reproduce the exercise:

**Barneche DR**, Spatio-temporal analysis of the effects of management strategies on the abundance of marine organisms.  

## Instructions

All analyses were done in `R`. To compile the report, including figures and stats I use the [remake](https://github.com/richfitz/remake) package for R. You can install remake using the `devtools` package:

```r
devtools::install_github('richfitz/remake', dependencies = TRUE)
```
(run `install.packages('devtools')` to install devtools if needed.)

The `remake` package also depends on `storr`, install it like this:
```r
devtools::install_github('richfitz/storr', dependencies = TRUE)
```

Next you need to open an R session with working directory set to the root of the project.

I use a number of packages, missing packages can be easily installed by remake:

```r
remake::install_missing_packages()
```

Then, to generate all figures, analyses, and summary stats, simply run:

```r
remake::make()
```

All output will be automatically placed in a directory called `output` (it is going to be automatically created for you).

Also notice that all the Bayesian model in this exercise will take a few hours (approx. 3 to 4) to run on a regular computer.

If you find remake confusing and prefer to run plain R, you can use remake to build a script `build.R` that produces a given output, e.g.

```r
remake::make_script(filename = 'build.R')
```

### This exercise was produced using the following software and associated packages:
```
R version 3.6.0 (2019-04-26)
Platform: x86_64-apple-darwin15.6.0 (64-bit)
Running under: macOS Mojave 10.14.6

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib

locale:
[1] en_AU.UTF-8/en_AU.UTF-8/en_AU.UTF-8/C/en_AU.UTF-8/en_AU.UTF-8

attached base packages:
[1] grid      stats4    stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] LoLinR_0.0.0.9000 png_0.1-7         ggsci_2.9         dplyr_0.8.1       tidyr_0.8.3       ggplot2_3.1.1     effects_4.1-2     carData_3.0-2     brms_2.8.0       
[10] Rcpp_1.0.1        glmmTMB_0.2.3     bbmle_1.0.20      plyr_1.8.4        rmarkdown_1.12   

loaded via a namespace (and not attached):
 [1] nlme_3.1-139         matrixStats_0.54.0   xts_0.11-2           threejs_0.3.1        rstan_2.18.2         numDeriv_2016.8-1    tools_3.6.0         
 [8] TMB_1.7.15           backports_1.1.4      R6_2.4.0             DT_0.6               DBI_1.0.0            lazyeval_0.2.2       colorspace_1.4-1    
[15] nnet_7.3-12          withr_2.1.2          tidyselect_0.2.5     gridExtra_2.3        prettyunits_1.0.2    processx_3.3.1       Brobdingnag_1.2-6   
[22] compiler_3.6.0       cli_1.1.0            shinyjs_1.0          colourpicker_1.0     scales_1.0.0         dygraphs_1.1.1.6     lmtest_0.9-37       
[29] mvtnorm_1.0-10       ggridges_0.5.1       callr_3.2.0          stringr_1.4.0        digest_0.6.19        StanHeaders_2.18.1   minqa_1.2.4         
[36] base64enc_0.1-3      pkgconfig_2.0.2      htmltools_0.3.6      lme4_1.1-21          htmlwidgets_1.3      rlang_0.3.4          shiny_1.3.2         
[43] zoo_1.8-5            crosstalk_1.0.0      gtools_3.8.1         inline_0.3.15        magrittr_1.5         loo_2.1.0            bayesplot_1.6.0     
[50] Matrix_1.2-17        munsell_0.5.0        abind_1.4-5          stringi_1.4.3        MASS_7.3-51.4        pkgbuild_1.0.3       parallel_3.6.0      
[57] promises_1.0.1       crayon_1.3.4         miniUI_0.1.1.1       lattice_0.20-38      splines_3.6.0        knitr_1.23           ps_1.3.0            
[64] pillar_1.4.1         igraph_1.2.4.1       boot_1.3-22          markdown_0.9         shinystan_2.5.0      reshape2_1.4.3       rstantools_1.5.1    
[71] glue_1.3.1           evaluate_0.14        mitools_2.4          nloptr_1.2.1         httpuv_1.5.1         gtable_0.3.0         purrr_0.3.2         
[78] assertthat_0.2.1     xfun_0.7             mime_0.6             xtable_1.8-4         survey_3.36          coda_0.19-2          later_0.8.0         
[85] rsconnect_0.8.13     survival_2.44-1.1    tibble_2.1.2         shinythemes_1.1.2    bridgesampling_0.6-0
```

### How to download this project for people not familiar with GitHub:  
* on the project main page on GitHub, click on the green button `clone or download` and then click on `Download ZIP`  

## Bug reporting
* Please [report any issues or bugs](https://github.com/dbarneche/transectTask/issues).
