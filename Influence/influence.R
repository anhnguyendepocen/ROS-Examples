#' ---
#' title: "Regression and Other Stories: Influence"
#' author: "Andrew Gelman, Jennifer Hill, Aki Vehtari"
#' date: "`r format(Sys.Date())`"
#' output:
#'   html_document:
#'     theme: readable
#'     toc: true
#'     toc_depth: 2
#'     toc_float: true
#'     code_download: true
#' ---

#' Plot influence of individual points in a fitted regression. See
#' Chapter 8 in Regression and Other Stories.
#' 
#' -------------
#' 

#+ setup, include=FALSE
knitr::opts_chunk$set(message=FALSE, error=FALSE, warning=FALSE, comment=NA)
# switch this to TRUE to save figures in separate files
savefigs <- FALSE

#' #### Load packages
library("rprojroot")
root<-has_dirname("ROS-Examples")$make_fix_file()

#' #### Fake data
x <- seq(2, 12, 1)
n <- length(x)
a <- 1
b <- 2
sigma <- 5
y <- rnorm(n, a + b*x, sigma)
least_squares_fit <- lm(y ~ x)
a_hat <- coef(least_squares_fit)[1]
b_hat <- coef(least_squares_fit)[2]

#' #### Plot histogram of the data
#+ eval=FALSE, include=FALSE
if (savefigs) pdf(root("Influence/figs","influence1.pdf"), height=4, width=5)
#+
par(mar=c(3,3,1,1), mgp=c(1.7,.5,0), tck=-.01)
plot(x, y, ylim=c(a_hat + b_hat*min(x) - 2*sigma, a_hat + b_hat*max(x) + 2*sigma), pch=20, bty="l")
abline(a_hat, b_hat)
for (i in 1:n){
  lines(rep(x[i], 2), c(y[i], a_hat + b_hat*x[i]), lwd=0.5)
}
#+ eval=FALSE, include=FALSE
if (savefigs) dev.off()
