# Data Wrangling with Tidy Data, Part 2 Exercises

To erase your environment and start from scratch:


```r
rm(list = ls())
```


```r
library(tidyverse)
```

```
## Warning: package 'tidyverse' was built under R version 4.0.3
```

```
## Warning: package 'purrr' was built under R version 4.0.5
```

```
## Warning: package 'stringr' was built under R version 4.0.3
```

```r
library(palmerpenguins)
load(url("https://github.com/fhdsl/Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

## Part 1: Creating new columns

Consider the following dataframe:


```r
simple_df = data.frame(id = c("AAA", "BBB", "CCC", "DDD", "EEE"),
                       case_control = c("case", "case", "control", "control", "control"),
                       measurement1 = c(2.5, 3.5, 9, .1, 2.2),
                       measurement2 = c(0, 0, .5, .24, .003),
                       measurement3 = c(80, 2, 1, 1, 2))

simple_df
```

```
##    id case_control measurement1 measurement2 measurement3
## 1 AAA         case          2.5        0.000           80
## 2 BBB         case          3.5        0.000            2
## 3 CCC      control          9.0        0.500            1
## 4 DDD      control          0.1        0.240            1
## 5 EEE      control          2.2        0.003            2
```

Create a new column, named `sum_measurements`, via `mutate` or `$`, which is the sum of `measurement1`, `measurement2`, and `measurement3` columns.



Filter simple_df to samples that have "case" in `case_control` column, and look at the **mean** of the `sum_measurements` column. Do the same for samples that have the "control" in `case_control` column. How do they compare?



Let's return back to the `metadata` dataframe. Here is a custom function `medicaid_eligible()` that takes a numeric vector `age` and makes some transformations: it returns 0 if `age` is less than 65 and 1 if `age` is equal or greater than 65. You don't need to understand how the function is defined, but you should understand the example usages of the `medicaid_eligible()` function on a numeric vector.


```r
medicaid_eligible = function(age) {
  age[age < 65] = 0
  age[age >= 65] = 1
  return(age)
}

#example usage:
medicaid_eligible(c(24, 95))
```

```
## [1] 0 1
```

```r
#another example:
my_family_ages = c(3, 64, 32, 35, 76)
medicaid_eligible(my_family_ages)
```

```
## [1] 0 0 0 0 1
```

Create a new column named `medicaid` that is the output of the `medicaid_eligible` function with input argument of the `Age` column.



## Part 2: Joining multiple dataframes

Consider another dataframe related to `simple_df`, called `simple2_df`.


```r
simple2_df = data.frame(id = c("AAA", "EEE", "FFF", "GGG", "HHH"),
                        measurement4 = c(25, 23, 56, 23, 9),
                        measurement5 = c(TRUE, TRUE, TRUE, FALSE, FALSE))
```

We want to join `simple_df` and `simple2_df` together using a common identifier column `id`. The function `full_join()` will keeps all observations common to both dataframes based on the common column defined via the `by` argument via a character.


```r
dim(simple_df)
```

```
## [1] 5 5
```

```r
dim(simple2_df)
```

```
## [1] 5 3
```

```r
simple_joined_df = full_join(simple_df, simple2_df, by = "id")
dim(simple_joined_df)
```

```
## [1] 8 7
```

```r
simple_joined_df
```

```
##    id case_control measurement1 measurement2 measurement3 measurement4
## 1 AAA         case          2.5        0.000           80           25
## 2 BBB         case          3.5        0.000            2           NA
## 3 CCC      control          9.0        0.500            1           NA
## 4 DDD      control          0.1        0.240            1           NA
## 5 EEE      control          2.2        0.003            2           23
## 6 FFF         <NA>           NA           NA           NA           56
## 7 GGG         <NA>           NA           NA           NA           23
## 8 HHH         <NA>           NA           NA           NA            9
##   measurement5
## 1         TRUE
## 2           NA
## 3           NA
## 4           NA
## 5         TRUE
## 6         TRUE
## 7        FALSE
## 8        FALSE
```

Notice that it is `by = "id"`, not `by = id` when referring to the `id` column common to both dataframes. In my opinion, this function's design was not great, as it runs against the form we are used to.

We see `NA` in some of our data, because not every entry in `simple_df` is in `simple2_df`, and vice versa.

There are other variations of `full_join():`

-   `full_join(x, y, by = "common_col")` keeps all observations.

-   `left_join(x, y, by = "common_col")` keeps all observations in `x`.

-   `right_join(x, y, by = "common_col")` keeps all observations in `y`.

-   `inner_join(x, y, by = "common_col")` keeps observations common to both `x` and `y`.

Try some of the other join functions out yourself:



Now, let's apply what we learned here to our genomics dataframes.

Using `full_join` twice, create a dataframe that has columns from `metadata`, `expression`, and `mutation`. You should use column `ModelID` that is common to all three dataframes as your identifier. How will you check your work to know that you did the join correctly?



## Part 3: Pipes

Often, in data analysis, we want to transform our dataframe in multiple steps via different functions. This leads to nested function calls, like this:


```r
breast_metadata = select(filter(metadata, OncotreeLineage == "Breast"), ModelID, Age, Sex)
```

This is a bit hard to read. A computer doesn't care how difficult it is to read this line of code, but there is a lot of instructions going on in one line of code. This multi-step function composition will lead to an unreadable pattern such as:

```         
result = function3(function2(function1(dataframe)))
```

To untangle this, you have to look into the middle of this code, and slowly step out of it.

To make this more readable, programmers came up with an alternative syntax for function composition via the **pipe** metaphor. The ideas is that we push data through a chain of connected pipes, in which the output of a pipe becomes the input of the subsequent pipe.

Instead of a syntax like `result = function3(function2(function1(dataframe)))`,

we linearize it with the `%>%` symbol: `result2 = dataframe %>% function1 %>% function2 %>% function3`.

In the previous example,


```r
breast_metadata = metadata %>% 
  filter(OncotreeLineage == "Breast") %>%
  select(ModelID, Age, Sex) 
```

This looks much easier to read. Notice that we have broken up one expression in to three lines of code for readability. If a line of code is incomplete (the first line of code is piping to somewhere unfinished), the R will treat the next line of code as part of the current line of code.

Your turn: write the following the code in the pipe form and check that it gets the same result:


```r
analysis = select(filter(metadata, Age > 18 & Age < 45), Age, OncotreeLineage, PrimaryOrMetastasis)
```



Challenge!!! Make this 3-nested function call into the pipe format.


```r
analysis = mutate(select(filter(metadata, Age > 18 & Age < 45), Age, OncotreeLineage, PrimaryOrMetastasis), medicaid = medicaid_eligible(Age))
```



In the world of R data analysis, you will see some people analyzing their data using the `%>%` symbol, and some will just use nested functions. You should decide what you prefer, but just want you to be aware of people's styles.

## Feedback!

How many hours did you spend on this exercise?


```r
time_spent = 0 
```

If you worked with other peers, write their names down in the following character vector: each element is one person's name.


```r
peers = c("myself")
```

