# Working with data structures

## Vectors

In the first exercise, you started to explore **data structures**, which store information about data types. You played around with **vectors**, which is a ordered collection of a data type. Each *element* of a vector contains a data type, and there is no limit on how big a vector can be, as long the memory use of it is within the computer's memory (RAM).

We can now store a vast amount of information in a vector, and assign it to a single variable. We can now use operations and functions on a vector, modifying many elements within the vector at once! This fits with the *theme of abstraction and modular organization* described in the first lesson!

We often create vectors using the combine function, `c()` :


```r
staff = c("chris", "shasta", "jeff")
chrNum = c(2, 3, 1)
```

If we try to create a vector with mixed data types, R will try to make them be the same data type, or give an error:


```r
staff = c("chris", "shasta", 123)
staff
```

```
## [1] "chris"  "shasta" "123"
```

Our numeric got converted to character so that the entire vector is all characters.

### Using operations on vectors

Recall from the first class:

-   Expressions are be built out of **operations** or **functions**.

-   Operations and functions combine **data types** to return another data type.

Now that we are working with data structures, the same principle applies:

-   Operations and functions combine **data structures** to return another data structure (or data type!).

What happens if we use some familiar operations we used for numerics on a numerical vector? If we multiply a numerical vector by a numeric, what do we get?


```r
chrNum = chrNum * 3
chrNum 
```

```
## [1] 6 9 3
```

All of `chrNum`'s elements tripled! Our multiplication operation, when used on a *numeric vector with a numeric*, has a *new* meaning: it multiplied all the elements by 3. Multiplication is an operation that can be used for multiple data types or data structures: we call this property **operator overloading**. Here's another example: *numeric vector multiplied by another numeric vector*:


```r
chrNum * c(2, 2, 0)
```

```
## [1] 12 18  0
```

but there are also limits: a numeric vector added to a character vector creates an error:


```r
#chrNum + staff
```

When we work with operations and functions, we must be mindful what inputs the operation or function takes in, and what outputs it gives, no matter how "intuitive" the operation or function name is.

### Subsetting vectors explicitly

In the exercise this past week, you looked at a new operation to subset elements of a vector using brackets.

Inside the bracket is either a single numeric value or an a **numerical indexing vector** containing numerical values. They dictate which elements of the vector to return.


```r
staff[2]
```

```
## [1] "shasta"
```

```r
staff[c(1, 2)]
```

```
## [1] "chris"  "shasta"
```

```r
small_staff = staff[c(1, 2)]
```

In the last line, we created a new vector `small_staff` that is a subset of the staff given the indexing vector `c(1, 2)`. We have three vectors referenced in one line of code. This is tricky and we need to always refer to our rules step-by-step: evaluate the expression right of the `=`, which contains a vector bracket. Follow the rule of the vector bracket. Then store the returning value to the variable left of `=`.

Alternatively, instead of using numerical indexing vectors, we can use a **logical indexing vector**. The logical indexing vector must be the *same length* as the vector to be subsetted, with `TRUE` indicating an element to keep, and `FALSE` indicating an element to drop. The following block of code gives the same value as before:


```r
staff[c(TRUE, FALSE, FALSE)]
```

```
## [1] "chris"
```

```r
staff[c(TRUE, TRUE, FALSE)]
```

```
## [1] "chris"  "shasta"
```

```r
small_staff = staff[c(TRUE, TRUE, FALSE)]
```

### Subsetting vectors implicitly

Here are two applications of subsetting on vectors that need distinction to write the correct code:

1.  **Explicit subsetting**: Suppose someone approaches you a 100-length vector of people's ages, and say that they want to subset to the first 10 elements.

2.  **Implicit subsetting**: Suppose someone approaches you a 100-length vector of people's ages, and say that they want to subset to elements \< 18 age.

We already know how to explicitly subset:


```r
set.seed(123) #don't worry about this function
age = round(runif(100, 1, 100)) #don't worry about these functions
first_ten_age = age[1:10]
```

For implicit subsetting, we don't know which elements to select off the top of our head! If we know which elements have less than 18, then we can give the elements for an explicit subset. Therefore, we need to create a logical indexing vector using a **comparison operator**:


```r
indexing_vector = age < 18
indexing_vector
```

```
##   [1] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [13] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
##  [25] FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE  TRUE FALSE
##  [37] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE
##  [49] FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE
##  [61] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
##  [73] FALSE  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE
##  [85]  TRUE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
##  [97] FALSE  TRUE FALSE FALSE
```

The comparison operator `<` compared the numeric value of `age` to see which elements of age is less than 18, and then returned a logical vector that has `TRUE` if age is less than 18 at that element and `FALSE` otherwise.

Then,


```r
age_young = age[indexing_vector]
age_young
```

```
##  [1]  6 11  5 16  3 15 16 15  6 13 14 10  1 12 11 14 10
```

We could have done this all in one line without storing the indexing vector as a variable in the environment:


```r
age_young = age[age < 18]
```

We have the following comparison operators in R:

`<` less than

`<=` less or equal than

`==` equal to

`!=` not equal to

`>` greater than

`>=` greater than or equal to

You can also put these comparison operators together to form more complex statements, which you will explore in this week's exercise.

Another example:


```r
age_90 = age[age == 90]
age_90
```

```
## [1] 90 90 90
```

```r
age_not_90 = age[age != 90]
age_not_90
```

```
##  [1] 29 79 41 88 94  6 53 89 56 46 96 46 68 58 11 25  5 33 95 89 70 64 99 66 71
## [26] 55 60 30 16 96 69 80  3 48 76 22 32 24 15 42 42 38 16 15 24 47 27 86  6 45
## [51] 80 13 57 21 14 76 38 67 10 39 28 82 45 81 81 80 45 76 63 71  1 48 23 39 62
## [76] 36 12 25 67 42 79 11 44 99 89 89 18 14 66 35 66 33 20 78 10 47 52
```

For most of our subsetting tasks on vectors (and dataframes below), we will be encouraging implicit subsetting. The power of implicit subsetting is that you don't need to know what your vector contains to do something with it! This technique is related to *abstraction* in programming mentioned in the first lesson: by using expressions to find the specific value you are interested instead of *hard-coding* the value explicitly, it generalizes your code to handle a wider variety of situations.

## Dataframes

Before we dive into dataframes, check that the `tidyverse` package is properly installed by loading it in your R Console:


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

Here is the data structure you have been waiting for: the **dataframe**. A dataframe is a spreadsheet such that each column must have the same data type. Think of a bunch of vectors organized as columns, and you get a dataframe.

For the most part, we load in dataframes from a file path (although they are sometimes created by combining several vectors of the same length, but we won't be covering that here):


```r
load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

### Using functions and operations on dataframes

We can run some useful functions on dataframes to get some useful properties, similar to how we used `length()` for vectors:


```r
nrow(metadata)
```

```
## [1] 1864
```

```r
ncol(metadata)
```

```
## [1] 30
```

```r
dim(metadata)
```

```
## [1] 1864   30
```

```r
colnames(metadata)
```

```
##  [1] "ModelID"                "PatientID"              "CellLineName"          
##  [4] "StrippedCellLineName"   "Age"                    "SourceType"            
##  [7] "SangerModelID"          "RRID"                   "DepmapModelType"       
## [10] "AgeCategory"            "GrowthPattern"          "LegacyMolecularSubtype"
## [13] "PrimaryOrMetastasis"    "SampleCollectionSite"   "Sex"                   
## [16] "SourceDetail"           "LegacySubSubtype"       "CatalogNumber"         
## [19] "CCLEName"               "COSMICID"               "PublicComments"        
## [22] "WTSIMasterCellID"       "EngineeredModel"        "TreatmentStatus"       
## [25] "OnboardedMedia"         "PlateCoating"           "OncotreeCode"          
## [28] "OncotreeSubtype"        "OncotreePrimaryDisease" "OncotreeLineage"
```

The last function, `colnames()` returns a character vector of the column names of the dataframe. This is an important property of dataframes that we will make use of to subset on it.

We introduce an operation for dataframes: the `dataframe$column_name` operation selects for a column by its column name and returns the column as a vector. For instance:


```r
metadata$OncotreeLineage[1:5]
```

```
## [1] "Ovary/Fallopian Tube" "Myeloid"              "Bowel"               
## [4] "Myeloid"              "Myeloid"
```

```r
metadata$Age[1:5]
```

```
## [1] 60 36 72 30 30
```

We treat the resulting value as a vector, so we can perform implicit subsetting:


```r
metadata$OncotreeLineage[metadata$OncotreeLineage == "Myeloid"]
```

```
##  [1] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
##  [8] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [15] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [22] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [29] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [36] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [43] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [50] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [57] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [64] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
## [71] "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid" "Myeloid"
```

Lastly, try running `View(metadata)` in RStudio Console...whew, a nice way to examine your dataframe like a spreadsheet program!

### "What do you want to do with this dataframe"?

Before diving into the technical part of subsetting dataframes, we will use different mindset to think about what we want to do with this dataframe as scientists.

Remember that a major theme of the course is about: **How we organize ideas \<-\> Instructing a computer to do something.**

Until now, we haven't focused too much on how we organize our scientific ideas to interact with what we can do with code. Let's write our code driven by our scientific curiosity.

Here's a starting prompt:

> In the dataframe you have here, which rows would you filter for and columns would you select that relate to a scientific question?

Use the implicit subsetting mindset here: ie. "I want to filter for rows such that the subtype is breast cancer and look at the Age and Sex." and *not* "I want to filter for rows 20-50 and select columns 2 and 8".

*Notice that when we filter for rows in an implicitly way, we often formulate criteria about the columns.*

(This is because we are guaranteed to have column names in dataframes. Some dataframes have row names, but because the data types are not guaranteed to have the same data type, it makes describing by row properties difficult.)

Let's convert this into code!


```r
metadata_filtered = filter(metadata, OncotreeLineage == "Breast")
breast_metadata = select(metadata_filtered, ModelID, Age, Sex)
head(breast_metadata)
```

```
##      ModelID Age    Sex
## 1 ACH-000017  43 Female
## 2 ACH-000019  69 Female
## 3 ACH-000028  69 Female
## 4 ACH-000044  47 Female
## 5 ACH-000097  63 Female
## 6 ACH-000111  41 Female
```

Here, `filter()` and `select()` are functions from the `tidyverse` package.

### Filter rows

Let's carefully a look what how the R Console is interpreting the `filter()` function:

-   We evaluate the expression right of `=`.

-   The first argument of `filter()` is a dataframe, which we give `metadata`.

-   The second argument is strange: the expression we give it looks like a logical indexing vector built from a comparison operator, but the variable `OncotreeLineage` does not exist in our environment! Rather, `OncotreeLineage` is a column from `metadata`, and we are referring to it as a **data variable** in the context of the dataframe `metadata`. So, we make a comparison operation on the column `OncotreeLineage` from `metadata` and its resulting logical indexing vector is the input to the second argument.

    -   How do we know when a variable being used is a variable from the environment, or a data variable from a dataframe? It's not clear cut, but here's a rule of thumb: most functions from the `tidyverse` package allows you to use data variables to refer to columns of a dataframe. We refer to documentation when we are not sure.

    -   This encourages more *readable* code at the expense of consistency of referring to variables in the environment. The authors of this package [describes this trade-off](https://dplyr.tidyverse.org/articles/programming.html#data--and-env-variables).

-   Putting it together, `filter()` takes in a dataframe, and an logical indexing vector described by data variables as arguments, and returns a data frame with rows that match condition described by the logical indexing vector.

-   Store this in `metadata_filtered` variable.

### Select columns

Let's carefully a look what how the R Console is interpreting the `select()` function:

-   We evaluate the expression right of `=`.

-   The first argument of `filter()` is a dataframe, which we give `metadata`.

-   The second and third arguments are data variables referring the columns of `metadata`.

    -   For certain functions like `filter()`, there is no limit on the number of arguments you provide. You can keep adding data variables to select for more column names.

-   Putting it together, `select()` takes in a dataframe, and as many data variables you like to select columns, and returns a dataframe with the columns you described by data variables.

-   Store this in `breast_metadata` variable.
