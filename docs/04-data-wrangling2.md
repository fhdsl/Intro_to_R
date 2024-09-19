# Data Wrangling with Tidy Data, Part 2


```
## 
## The downloaded binary packages are in
## 	/var/folders/pq/18p2fl6n49dfgzd03mtszm6r0000gn/T//RtmpMVSXo7/downloaded_packages
```

Today, we will continue learning about common functions from the Tidyverse that is useful for Tidy data manipulations.

## Modifying and creating new columns in dataframes

The `mutate()` function takes in the following arguments: the first argument is the dataframe of interest, and the second argument is a *new or existing data variable* that is defined in terms of *other data variables*.

We create a new column `olderAge` that is 10 years older than the original `Age` column.


``` r
metadata$Age[1:10]
```

```
##  [1] 60 36 72 30 30 64 63 56 72 53
```

``` r
metadata2 = mutate(metadata, olderAge = Age + 10)
metadata2$olderAge[1:10]
```

```
##  [1] 70 46 82 40 40 74 73 66 82 63
```

Here, we used an operation on a column of `metadata`. Here's another example with a function:


``` r
expression$KRAS_Exp[1:10]
```

```
##  [1] 4.634012 4.638653 4.032101 5.503031 3.713696 3.972693 3.235727 4.135042
##  [9] 9.017365 3.940167
```

``` r
expression2 = mutate(expression, log_KRAS_Exp = log(KRAS_Exp))
expression2$log_KRAS_Exp[1:10]
```

```
##  [1] 1.533423 1.534424 1.394288 1.705299 1.312028 1.379444 1.174254 1.419498
##  [9] 2.199152 1.371223
```

### Alternative: Creating and modifying columns via `$`

Instead of `mutate()` function, we can also create a new or modify a column via the `$` symbol:


``` r
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


``` r
merged = full_join(metadata, expression, by = "ModelID")
```

The number of rows and columns of `metadata`:


``` r
dim(metadata)
```

```
## [1] 1864   30
```

The number of rows and columns of `expression`:


``` r
dim(expression)
```

```
## [1] 1450  536
```

The number of rows and columns of `merged`:


``` r
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


``` r
metadata_by_type = metadata %>% 
                   group_by(OncotreeLineage) %>% 
                   summarise(MeanAge = mean(Age, rm.na=TRUE), Count = n())
```

Or, without pipes:


``` r
metadata_by_type_temp = group_by(metadata, OncotreeLineage)
metadata_by_type = summarise(metadata_by_type_temp, MeanAge = mean(Age, rm.na=TRUE), Count = n())
```

The `group_by()` function returns the identical input dataframe but remembers which variable(s) have been marked as grouped:


``` r
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

## Appendix: How functions are built

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


``` r
numbers = c(1, 2, NA, 4)
mean(x = numbers, na.rm = TRUE)
```

```
## [1] 2.333333
```

## Exercises

You can find [exercises and solutions on Posit Cloud](https://posit.cloud/content/8245357), or on [GitHub](https://github.com/fhdsl/Intro_to_R_Exercises).
