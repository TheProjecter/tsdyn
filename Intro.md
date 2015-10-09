## Actual features of version 0.6 ##

TsDyn is a R package designed to modeling nonlinearities in time series. It entails following **nonlinear regression models**:

  * Smooth transition regression model. Function **star()**
  * Logistic smooth transition regressions models. **lstar()**
  * Threshold autoregressive models **setar()**
  * Neural Network nonlinear autoregressive model **nnet()**
  * Additive nonlinear autoregressive model **aar()**

It has also various **nonlinearity and independence tests** like:

  * Casdagli test of nonlinearity via locally linear forecasts **llar()**
  * Generic NLAR linearity test **isLinear()**

And finally the usual methods implemented in R, especially a nice function to export to LateX format the regression output (see **toLatex()**).


## Documentation ##
A short guide is bundled, once installed type

> vignette('tsDyn')

at the R prompt.

## Next release 0.7 ##

The next release will entail new models and nonlinearities tests:
  * The extension of the treshold autoregressive model setar() for two threshold and MTAR adjustment
  * The extension of the TAR model to multivariate case TVAR,
  * A bootstrap univariate and multivariate linearity test against TAR or TVAR
  * A bunch of threshold cointegration estimation and tests procedures, see dedicated page: [threshold cointegration](ThresholdCointegration.md)
  * A flexible coefficient smooth transition regression model which also allows for linearity testing.

## Working papers ##
Some [working papers](WorkingPapers.md) of the contributors are avalaible here.