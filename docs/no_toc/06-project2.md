# Project 2: Exploring CO2 Emissions Over Time



Clears the environment.


```r
rm(list = ls())
```

## Introduction

This data analysis project is based on [Open Case Studies on Exploring CO2 Emissions Over Time](https://www.opencasestudies.org/ocs-bp-co2-emissions/). This case study explores how different countries have contributed to Carbon Dioxide (CO2) emissions over time.

### Load the packages and data in.


```r
library(readxl)
library(tidyverse)
CO2_emissions = read_xlsx("classroom_data/yearly_co2_emissions_1000_tonnes.xlsx")
```

#### Examine the data.


```r
dim(CO2_emissions)
```

```
## [1] 192 265
```

```r
head(CO2_emissions)
```

```
## # A tibble: 6 × 265
##   country  `1751` `1752` `1753` `1754` `1755` `1756` `1757` `1758` `1759` `1760`
##   <chr>     <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
## 1 Afghani…     NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## 2 Albania      NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## 3 Algeria      NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## 4 Andorra      NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## 5 Angola       NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## 6 Antigua…     NA     NA     NA     NA     NA     NA     NA     NA     NA     NA
## # ℹ 254 more variables: `1761` <dbl>, `1762` <dbl>, `1763` <dbl>, `1764` <dbl>,
## #   `1765` <dbl>, `1766` <dbl>, `1767` <dbl>, `1768` <dbl>, `1769` <dbl>,
## #   `1770` <dbl>, `1771` <dbl>, `1772` <dbl>, `1773` <dbl>, `1774` <dbl>,
## #   `1775` <dbl>, `1776` <dbl>, `1777` <dbl>, `1778` <dbl>, `1779` <dbl>,
## #   `1780` <dbl>, `1781` <dbl>, `1782` <dbl>, `1783` <dbl>, `1784` <dbl>,
## #   `1785` <dbl>, `1786` <dbl>, `1787` <dbl>, `1788` <dbl>, `1789` <dbl>,
## #   `1790` <dbl>, `1791` <dbl>, `1792` <dbl>, `1793` <dbl>, `1794` <dbl>, …
```

```r
CO2_emissions[1:5, 200:205]
```

```
## # A tibble: 5 × 6
##   `1949` `1950` `1951` `1952` `1953` `1954`
##    <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
## 1   14.7   84.3   91.7   91.7    106    106
## 2 1020    297    403    374      414    502
## 3  909   3790   4140   3890     4000   4160
## 4   NA     NA     NA     NA       NA     NA
## 5   NA    187    249    312      275    348
```

Recall the definition of **Tidy Data**:

1.  Each variable is a column; each column is a variable.

2.  Each observation is a row; each row is an observation.

3.  Each value is a cell; each cell is a single value.

This dataset is **not** **tidy**, because the value of the cells describe the variable Emissions, but they don't correspond back to the column names. Also, it seems that the column names belong to a variable Year.

To fix this, we use the `pivot_longer` function:


```r
CO2_emissions =  pivot_longer(CO2_emissions, cols = -country, names_to = "Year", values_to = "Emissions")
CO2_emissions$Year = as.numeric(CO2_emissions$Year)
head(CO2_emissions)
```

```
## # A tibble: 6 × 3
##   country      Year Emissions
##   <chr>       <dbl>     <dbl>
## 1 Afghanistan  1751        NA
## 2 Afghanistan  1752        NA
## 3 Afghanistan  1753        NA
## 4 Afghanistan  1754        NA
## 5 Afghanistan  1755        NA
## 6 Afghanistan  1756        NA
```

The dataset is now **tidy**. The previous column names are now values of the column Year, and all previous cells are under the column Emissions.

#### Make a plot to show how the CO2 emission of United States changed over time. You will need to filter your dataset to the appropriate country of interest.



#### Compare CO2 emissions of United States with other countries. You can either filter for a few countries of interest and make the comparison. Or use the `group` aesthetic to create a line or point for each country.



#### What is the aggregrate CO2 emission of the world changing over time? Use `group_by` and `summarise` to create this aggregate dataframe, then make a plot out of it. You would need to use `sum` function within `summarise` to total up the CO2 emission across all countries.



#### We load in a second dataset, `US_temperature`, that gives the average temperature of the United States every year.


```r
US_temperature = read.csv("classroom_data/temperature.csv", skip = 4)
US_temperature = mutate(US_temperature, Year = as.numeric(str_sub(Date, start = 1, end = 4)))
US_temperature = US_temperature %>% mutate(country = "United States", temperature = Value) %>% select(-Anomaly, -Value)
```

#### Using `filter` and a `join` function (ie. `full_join`, `inner_join`, `left_join`, or `right_join`), merge the two datasets together.



#### Make a plot to see whether there is any relationship between temperature and CO2 emissions in the United States.



#### Anything else you want to explore?


