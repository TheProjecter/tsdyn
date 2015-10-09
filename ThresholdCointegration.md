#tsDyn: a Threshold cointegration software package for R.

# Introduction #

This page shows the features for threshold cointegration and threshold vector error correction model in package tsDyn. These functions will be released in the next version of package tsDyn, currently work is done on their correct class implementation but the functions can already be used. To see how to access and compile the unreleased working sources, see this [page](HowToInstall.md). For bugs and comments, please contact Matthieu _dot_ Stigler (at) "gmail dot com"

# Working paper/vignette #
A working paper offering an overview of thresholod cointegration and presenting the functions implemented is available: [Threshold Cointegration: overview and implementation in R](http://groups.google.com/group/tsdyn/web/ThCointOverview.pdf)

# What is threshold cointegration? #
Cointegration analysis is an indispensable tool/step for considering relationships between multivariate time series, when the variables are not stationary. If in the case of non-stationary variables, there exists a linear combination between these variables which is nevertheless stationary, the variables are said to be cointegrated (which means that they exhibit a common long-term relationship). The interest is that Engle and Granger (1987) have shown that in that case they can be represented in an error-correction model (VECM).

Threshold cointegration extends the usual linear cointegration to cases where the adjustment towards long-run equilibrium does not occur after each small deviation but more realistically only when the deviations exceed some critical thresholds, thus taking transaction costs and asymmetries in price transmission into account .

Threshold cointegration can improve significantly the estimation and forecast accuracy and has been widely applied to study the relationship between interest rates, exchange rates, oil prices, international agricultural markets, and to test the purchasing power parity theory and the law of one price.
# Features #

## Long-run relationship analysis ##
  * Estimation of TAR, SETAR and MTAR models with OLS, AIC and pooled AIC. Two or three regimes are available, intercept and/or trends can be added in each regime or be common to the system, possibility of differents lags in each regime. Function **setar()**

  * Unit root tests with stationary SETAR as alternative. **BBCTest()** and **KapShinTest()**

  * Linearity tests against SETAR. Test of Hansen (2001) **setarTest()** with bootstrap replications (and a test on arranged autoregression of Tsay (1989): **TsayTest()**, still not included)

  * Simulating or bootstraping a SETAR: **setar.sim()**

## Threshold Error correction Model (TVECM) ##

  * Estimation of TVECM by OLS (Seo 2007). Function **TVECM()**.

  * Estimation of TVECM by MLE (Hansen and Seo 2002). Function: **tsDyn:::HanSeo\_TVECM()**.

  * Estimation of threshold vector autoregressive model (TVAR) by OLS (Hansen and Seo 2002). Function: **TVAR()**.

  * Estimation of linear VAR and VECM models. Function **lineVar()**.

  * Linear vs threshold cointegration test with bootstrap distribution by Hansen and Seo (2002). Contained in  **tsDyn:::HanSeo\_TVECM()**.

  * No cointegration against threshold cointegration test with bootstrap distribution by Seo (2006). Function **TVECM.SeoTest()**

  * Linearity test with bootstrap distribution by Hansen (1997) extended to multivariate case TVAR as in Lo and Zivot (2002): **TVAR.LRtest()**

  * Function to simulate and bootstrap TVAR: **TVAR.sim()** and a TVECM: **TVECM.sim()**


## Raw functions ##
These functions are already written but not end-user ready (no help page and hence not exported).
  * Simple Wald test for the coefficients.

  * Heteroskedastic covariance matrix estimator

  * Test of structural break in cointegration relationship by Gregory and Hansen (1996)

## Under project ##
Some tests and functions could easily be implemented from<the already written functions: threshold unit roots tests, inference for thresholds parameter. And VECM and TVECm simulation/bootstrap procedure. Impulse response function are also under project.


# Method implementation #
Following the method oriented programming from R, classes are written for the functions (currently TVAR, TVECM and linear2) and entails following methods:
  * print(),
  * fitted(),
  * coef(),
  * summary(),
  * AIC(),
  * BIC(),
  * residuals(),
  * deviance(),
  * logLik(),
  * and a nice toLatex() export function.

# References #
Bec, F.; Salem, M. B. & Carrasco, M. (2004), 'Tests for Unit-Root versus Threshold Specification With an Application to the Purchasing Power Parity Relationship', Journal of Business & Economic Statistics 22, 382-395.

Gregory, A. & Hansen, B. (1996), 'Test for cointegration in models with regime shifts', Oxford bulletin of economic and statistics 58(3), 555-560.

Hansen, B. (1999), 'Testing for Linearity', Journal of economic Surveys 13(5), 551-576.

Hansen, B. & Seo, B. (2002), 'Testing for two-regime threshold cointegration in vector error-correction models', Journal of Econometrics 110, 293 318.

Kapetanios, G. & Shin, Y. (2006), 'Unit root tests in three-regime SETAR models', Econometrics Journal 9(2), 252-278.

Lo, M. C. & Zivot, E. (2001), 'Threshold Cointegration and Nonlinear Adjustment to the Law of One Price', macroeconomic Dynamics 5, 533-576.

Seo, B. (2007), 'Estimation of non linear error-correction models', Working Paper,

Seo, M. (2006), 'Bootstrap testing for the null of no cointegration in a threshold vector error correction model', Journal of Econometrics 127(1), 129-150.

Tsay, R. S. (1989), 'Testing and Modeling Threshold Autoregressive Processes', Journal of the American Statistical Association 84(405), 231--240.





[Back](Intro.md) to package description here.