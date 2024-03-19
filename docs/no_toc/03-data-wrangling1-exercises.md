# Data Wrangling with Tidy Data, Part 1 Exercises

If you need to clear your environment and start from the beginning, this code chunk will do that:


```r
rm(list = ls())
```

## Part 1: Warm-up/a remark on subsetting vectors

Consider the following vector:


```r
age = c(10, 35, 24, 70, 84)
```

Subset `age` to be greater than 65 and store it as `age_over_65`.



Another use of subsetting is to modify part of a vector that satisfy a particular criteria. Instead of having the bracket `[ ]` notation on the right hand side of the equation, if it is on the left hand side of the equation, then we can modify a subset of the vector.

To demonstrate it, let's create a new variable, `medicaid_eligible` so that it is identical as `age`.


```r
medicaid_eligible = age
```

We can modify `medicaid_eligible` so that all elements of `medicaid_eligible` that is equal or lesss than 65 is assigned to a value of 0.


```r
medicaid_eligible[medicaid_eligible <= 65] = 0
medicaid_eligible
```

```
## [1]  0  0  0 70 84
```

Now, modify `medicaid_eligible` so that all elements of `medicaid_eligible` that is greater than 65 is assigned to a value of 1.



Just to be aware of: Here is a new data type that we should be aware of: missing values, which are seen when there is missing data in a spreadsheet. It has the value of `NA`, and you can check whether a variable has `NA` values using the `is.na()` function. Try using `is.na()` function on the following variables:


```r
missing_val = NA
vec_with_NA = c(2, 4, NA, NA, 3, NA)
```



## Part 2: Subsetting dataframes


```r
library(tidyverse)
load(url("https://github.com/fhdsl/Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

Using `select()`, subset `expression` dataframe to keep only the following columns: "KRAS_Exp", "NRAS_Exp", and "HRAS_Exp".



Then, using `filter()`, subset the result of your previous dataframe to keep rows that have "KRAS_Exp" values between 2 and 6.



Now, formulate a new scientific question for the `metadata` dataset: which rows would you filter for and columns would you select that relate to a scientific question?

For instance: "I want to filter for rows such that the subtype is breast cancer, and select for columns age, sex, and the subtype."

Your turn now:

Then, use `filter()` and `select()` to subset your dataframe so that it address your scientific question.



## Part 3: Summary statistics

Let's take a short break from looking at cancer cell lines for the moment. Let's consider a sample of penguins.

Let's load it in, and take a look.


```r
library(tidyverse)
library(palmerpenguins)
head(penguins)
```

```
## # A tibble: 6 × 8
##   species island    bill_length_mm bill_depth_mm flipper_length_mm body_mass_g
##   <fct>   <fct>              <dbl>         <dbl>             <int>       <int>
## 1 Adelie  Torgersen           39.1          18.7               181        3750
## 2 Adelie  Torgersen           39.5          17.4               186        3800
## 3 Adelie  Torgersen           40.3          18                 195        3250
## 4 Adelie  Torgersen           NA            NA                  NA          NA
## 5 Adelie  Torgersen           36.7          19.3               193        3450
## 6 Adelie  Torgersen           39.3          20.6               190        3650
## # ℹ 2 more variables: sex <fct>, year <int>
```

Let's examine some summary statistics of this dataset: **pick a few columns of interest, and summarize the column via the following functions**:

If the columns of interest are numeric, then you can try functions such as `mean()`, `median()`, `min()`, or `max()`.

If the columns of interest is character or logical, then you can try the `table()` function.

Within the column, if there are `NA` (a special value indicating "Not Available") elements present, some of these functions will return with a value of `NA`. To remove the `NA` value before computing, some of these function have a `na.rm` argument that you can set to `TRUE`.

All of these functions take in a vector as input and not a dataframe, so you have to access the column as a vector via the `$` operation.


```r
mean(penguins$body_mass_g, na.rm=TRUE) #example
```

```
## [1] 4201.754
```

```r
#compute the summary statistics of a few columns below:
```

Then, **compare the mean body mass between the three penguin species** (Adelie, Chinstrap, Gentoo).

In order to do so, you have to subset the `penguins` dataframe three times, so that each dataframe contains one of the three species (the code below subsets the first species for you). Then, you will analyze each species' dataframe separately using the `mean()` function. Do you see any difference of mean penguin mass across species?


```r
adelie = filter(penguins, species == "Adelie")
#your code here
```

## Feedback!

How many hours did you spend on this exercise?


```r
time_spent = 0 
```

If you worked with other peers, write their names down in the following character vector: each element is one person's name.


```r
peers = c("myself")
```

