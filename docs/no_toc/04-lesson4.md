# Data Wrangling with Tidy Data, Part 2



Today, we will continue learning about common functions from the Tidyverse that is useful for Tidy data manipulations.

## Modifying and creating new columns in dataframes

The `mutate()` function takes in the following arguments: the first argument is the dataframe of interest, and the second argument is a *new or existing data variable* that is defined in terms of *other data variables*.

We create a new column `olderAge` that is 10 years older than the original `Age` column.


```r
metadata$Age[1:10]
```

```
##  [1] 60 36 72 30 30 64 63 56 72 53
```

```r
metadata2 = mutate(metadata, olderAge = Age + 10)
metadata2$olderAge[1:10]
```

```
##  [1] 70 46 82 40 40 74 73 66 82 63
```

Here, we used an operation on a column of `metadata`. Here's another example with a function:


```r
expression$KRAS_Exp[1:10]
```

```
##  [1] 4.634012 4.638653 4.032101 5.503031 3.713696 3.972693 3.235727 4.135042
##  [9] 9.017365 3.940167
```

```r
expression2 = mutate(expression, log_KRAS_Exp = log(KRAS_Exp))
expression2$log_KRAS_Exp[1:10]
```

```
##  [1] 1.533423 1.534424 1.394288 1.705299 1.312028 1.379444 1.174254 1.419498
##  [9] 2.199152 1.371223
```

### Alternative: Creating and modifying columns via `$`

Instead of `mutate()` function, we can also create a new or modify a column via the `$` symbol:


```r
expression2 = expression
expression2$log_KRAS_Exp = log(expression2$KRAS_Exp)
```

## Merging two dataframes together

Suppose we have the following dataframes:

`expression`

| ModelID      | PIK3CA_Exp | log_PIK3CA_Exp |
|--------------|------------|----------------|
| "ACH-001113" | 5.138733   | 1.636806       |
| "ACH-001289" | 3.184280   | 1.158226       |
| "ACH-001339" | 3.165108   | 1.152187       |

`metadata`

| ModelID      | OncotreeLineage | Age |
|--------------|-----------------|-----|
| "ACH-001113" | "Lung"          | 69  |
| "ACH-001289" | "CNS/Brain"     | NA  |
| "ACH-001339" | "Skin"          | 14  |

Suppose that I want to compare the relationship between `OncotreeLineage` and `PIK3CA_Exp`, but they are columns in different dataframes. We want a new dataframe that looks like this:

| ModelID      | PIK3CA_Exp | log_PIK3CA_Exp | OncotreeLineage | Age |
|--------------|------------|----------------|-----------------|-----|
| "ACH-001113" | 5.138733   | 1.636806       | "Lung"          | 69  |
| "ACH-001289" | 3.184280   | 1.158226       | "CNS/Brain"     | NA  |
| "ACH-001339" | 3.165108   | 1.152187       | "Skin"          | 14  |

We see that in both dataframes, the rows (observations) represent cell lines with a common column `ModelID`, so let's merge these two dataframes together, using `full_join()`:


```r
merged = full_join(metadata, expression, by = "ModelID")
```

The number of rows and columns of `metadata`:


```r
dim(metadata)
```

```
## [1] 1864   30
```

The number of rows and columns of `expression`:


```r
dim(expression)
```

```
## [1] 1450  536
```

The number of rows and columns of `merged`:


```r
dim(merged)
```

```
## [1] 1864  565
```

We see that the number of *columns* in `merged` combines the number of columns in `metadata` and `expression`, while the number of *rows* in `merged` is the larger of the number of rows in `metadata` and `expression` : `full_join()` keeps all observations common to both dataframes based on the common column defined via the `by` argument.

Therefore, we expect to see `NA` values in `merged`, as there are some cell lines that are not in `expression` dataframe.

There are variations of this function depending on your application:

![](images/join.png)

Given `xxx_join(x, y, by = "common_col")`,

-   `full_join()` keeps all observations.

-   `left_join()` keeps all observations in `x`.

-   `right_join()` keeps all observations in `y`.

-   `inner_join()` keeps observations common to both `x` and `y`.

## Grouping and summarizing dataframes

Also known as: "The rows I want is described by a column. The columns I want need to be summarized from other columns."

In a dataset, there may be multiple levels of observations, and which level of observation we examine depends on our scientific question. For instance, in `metadata`, the observation is cell lines. However, perhaps we want to understand properties of `metadata` in which the observation is the cancer type, `OncotreeLineage`. Suppose we want the mean age of each cancer type, and the number of cell lines that we have for each cancer type.

This is a scenario in which the *desired rows are described by a column*, `OncotreeLineage`, and the columns, such as mean age, need to be *summarized from other columns.*

As an example, this dataframe is transformed from:

| ModelID      | OncotreeLineage | Age |
|--------------|-----------------|-----|
| "ACH-001113" | "Lung"          | 69  |
| "ACH-001289" | "Lung"          | 23  |
| "ACH-001339" | "Skin"          | 14  |
| "ACH-002342" | "Brain"         | 23  |
| "ACH-004854" | "Brain"         | 56  |
| "ACH-002921" | "Brain"         | 67  |

into:

| OncotreeLineage | MeanAge | Count |
|-----------------|---------|-------|
| "Lung"          | 46      | 2     |
| "Skin"          | 14      | 1     |
| "Brain"         | 48.67   | 3     |

We use the functions `group_by()` and `summarise()` :


```r
metadata_by_type = metadata %>% 
                   group_by(OncotreeLineage) %>% 
                   summarise(MeanAge = mean(Age, rm.na=TRUE), Count = n())
```

Or, without pipes:


```r
metadata_by_type_temp = group_by(metadata, OncotreeLineage)
metadata_by_type = summarise(metadata_by_type_temp, MeanAge = mean(Age, rm.na=TRUE), Count = n())
```

The `group_by()` function returns the identical input dataframe but remembers which variable(s) have been marked as grouped:


```r
head(group_by(metadata, OncotreeLineage))
```

```
## # A tibble: 6 × 30
## # Groups:   OncotreeLineage [3]
##   ModelID    PatientID CellLineName StrippedCellLineName   Age SourceType
##   <chr>      <chr>     <chr>        <chr>                <dbl> <chr>     
## 1 ACH-000001 PT-gj46wT NIH:OVCAR-3  NIHOVCAR3               60 Commercial
## 2 ACH-000002 PT-5qa3uk HL-60        HL60                    36 Commercial
## 3 ACH-000003 PT-puKIyc CACO2        CACO2                   72 Commercial
## 4 ACH-000004 PT-q4K2cp HEL          HEL                     30 Commercial
## 5 ACH-000005 PT-q4K2cp HEL 92.1.7   HEL9217                 30 Commercial
## 6 ACH-000006 PT-ej13Dz MONO-MAC-6   MONOMAC6                64 Commercial
## # ℹ 24 more variables: SangerModelID <chr>, RRID <chr>, DepmapModelType <chr>,
## #   AgeCategory <chr>, GrowthPattern <chr>, LegacyMolecularSubtype <chr>,
## #   PrimaryOrMetastasis <chr>, SampleCollectionSite <chr>, Sex <chr>,
## #   SourceDetail <chr>, LegacySubSubtype <chr>, CatalogNumber <chr>,
## #   CCLEName <chr>, COSMICID <dbl>, PublicComments <chr>,
## #   WTSIMasterCellID <dbl>, EngineeredModel <chr>, TreatmentStatus <chr>,
## #   OnboardedMedia <chr>, PlateCoating <chr>, OncotreeCode <chr>, …
```

The `summarise()` returns one row for each combination of grouping variables, and one column for each of the summary statistics that you have specified.

Functions you can use for `summarise()` must take in a vector and return a simple data type, such as any of our summary statistics functions: `mean()`, `median()`, `min()`, `max()`, etc.

The exception is `n()`, which returns the number of entries for each grouping variable's value.

You can combine `group_by()` with other functions. See this [guide](https://dplyr.tidyverse.org/articles/grouping.html).

## How functions are built

As you become more independent R programmers, you will spend time learning about new functions on your own. We have gone over the basic anatomy of a function call back in the first lesson, but now let's go a bit deeper to understand how a function is built and how to call them.

Recall that a function has a **function name**, **input arguments**, and a **return value**.

*Function definition consists of assigning a **function name** with a "function" statement that has a comma-separated list of named **function arguments**, and a **return expression**. The function name is stored as a variable in the global environment.*

In order to use the function, one defines or import it, then one calls it.

Example:

```         
addFunction = function(num1, num2) {
  result = num1 + num2 
  return(result)
}
result = addFunction(3, 4)
```

With function definitions, not all code runs from top to bottom. The first four lines defines the function, but the function is never run. It is called on line 5, and the lines within the function are executed.

When the function is called in line 5, the variables for the arguments are reassigned to function arguments to be used within the function and helps with the modular form.

To see why we need the variables of the arguments to be reassigned, consider the following function that is *not* modular:

```         
x = 3
y = 4
addFunction = function(num1, num2) {
  result = x + y 
  return(result)
}
result = addFunction(10, -10)
```

Some syntax equivalents on calling the function:

```         
addFunction(3, 4)
addFunction(num1 = 3, num2 = 4)
addFunction(num2 = 4, num1 = 3)
```

but this *could* be different:

```         
addFunction(4, 3)
```

With a deeper knowledge of how functions are built, when you encounter a foreign function, you can look up its help page to understand how to use it. For example, let's look at `mean()`:

```         
?mean

Arithmetic Mean

Description:

     Generic function for the (trimmed) arithmetic mean.

Usage:

     mean(x, ...)
     
     ## Default S3 method:
     mean(x, trim = 0, na.rm = FALSE, ...)
     
Arguments:

       x: An R object.  Currently there are methods for numeric/logical
          vectors and date, date-time and time interval objects.
          Complex vectors are allowed for ‘trim = 0’, only.

    trim: the fraction (0 to 0.5) of observations to be trimmed from
          each end of ‘x’ before the mean is computed.  Values of trim
          outside that range are taken as the nearest endpoint.

   na.rm: a logical evaluating to ‘TRUE’ or ‘FALSE’ indicating whether
          ‘NA’ values should be stripped before the computation
          proceeds.

     ...: further arguments passed to or from other methods.
```

Notice that the arguments `trim = 0`, `na.rm = FALSE` have default values. This means that these arguments are *optional* - you should provide it only if you want to. With this understanding, you can use `mean()` in a new way:


```r
numbers = c(1, 2, NA, 4)
mean(x = numbers, na.rm = TRUE)
```

```
## [1] 2.333333
```

# Data Wrangling with Tidy Data, Part 2 Exercises

To erase your environment and start from scratch:


```r
rm(list = ls())
```


```r
library(tidyverse)
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

