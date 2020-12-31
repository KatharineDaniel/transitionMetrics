
<!-- README.md is generated from README.Rmd. Please edit that file -->

# transitionMetrics

<!-- badges: start -->

<!-- badges: end -->

Companion functions for Daniel, Moulder, Teachman, and Boker (under
review). These functions convert multivariate binary time series data
into individual transition matrices. The number of observations
comprising each transition matrix is of a length determined by the
researcher, with a default window of 5 samples. Three metrics are
calculated for each transition matrix: stability, spread, and symmetry.
**Stability** is the proportion of observations along the trace of a
transition matrix relative to all observed elements within that matrix,
which indicates the number of times the variable is selected at
consecutive time points relative to all observed transitions within and
between time series. **Spread** is the proportion of all non-zero
elements in a transition matrix relative to all possible elements in
that matrix, which indicates the number of unique transitions observed
in multivariate time series data relative to all possible transitions
within and between those time series. **Symmetry** is a measure of how
alike the upper and lower triangle of a matrix are to each other.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("KatharineDaniel/transitionMetrics")
```

<!--
``` r
install.packages("transitionMetrics")
```
-->

## Example

### load in example data

`exampleTransitionData` is a simulated dataset of 100 individuals at 50
time points for 10 binary time series. For all analyses to run, data
must be in a similar format.

``` r
library(transitionMetrics)
data(exampleTransitionData)
```

### calculate transition array for example data with a window size of 5

`buildTransArray()`takes binary time series data with at least two time
series and returns an array of transition matrices for each participant.
W is the number of observations the researcher sets to be included in
each transition matrix.

``` r
myArray <- buildTransArray(exampleTransitionData, W=5)
```

### get transition metrics

`myArray()` takes the results of `buildTransArray()` and returns
stability, spread, and symmetry metrics for each transition matrix for
each person. Results can be used for repeated measures analyses.

``` r
results <- transStats(myArray)
```
