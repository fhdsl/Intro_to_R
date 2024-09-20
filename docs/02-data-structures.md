# Working with data structures

In our second lesson, we start to look at two **data structures**, **vectors** and **dataframes**, that can handle a large amount of data.

## Slides


``` r
knitr::include_url("https://hutchdatascience.com/Intro_to_R/slides/lesson1_slides.html")
```

<iframe src="https://hutchdatascience.com/Intro_to_R/slides/lesson1_slides.html" width="100%" height="400px" data-external="1"></iframe>


## Vectors

In the first exercise, you started to explore **data structures**, which store information about data types. You played around with **vectors**, which is a ordered collection of a data type. Each *element* of a vector contains a data type, and there is no limit on how big a vector can be, as long the memory use of it is within the computer's memory (RAM).

We can now store a vast amount of information in a vector, and assign it to a single variable. We can now use operations and functions on a vector, modifying many elements within the vector at once! This fits with the feature of "encapsulate complex data via data structures to allow efficient manipulation of data" described in the first lesson!

We often create vectors using the combine function, `c()` :


``` r
staff = c("chris", "shasta", "jeff")
chrNum = c(2, 3, 1)
```

If we try to create a vector with mixed data types, R will try to make them be the same data type, or give an error:


``` r
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


``` r
chrNum = chrNum * 3
chrNum 
```

```
## [1] 6 9 3
```

All of `chrNum`'s elements tripled! Our multiplication operation, when used on a *numeric vector with a numeric*, has a *new* meaning: it multiplied all the elements by 3. Multiplication is an operation that can be used for multiple data types or data structures: we call this property **operator overloading**. Here's another example: *numeric vector multiplied by another numeric vector*:


``` r
chrNum * c(2, 2, 0)
```

```
## [1] 12 18  0
```

but there are also limits: a numeric vector added to a character vector creates an error:


``` r
#chrNum + staff
```

When we work with operations and functions, we must be mindful what inputs the operation or function takes in, and what outputs it gives, no matter how "intuitive" the operation or function name is.

### Subsetting vectors explicitly

In the exercise this past week, you looked at a new operation to subset elements of a vector using brackets.

Inside the bracket is either a single numeric value or an a **numerical indexing vector** containing numerical values. They dictate which elements of the vector to return.


``` r
staff[2]
```

```
## [1] "shasta"
```

``` r
staff[c(1, 2)]
```

```
## [1] "chris"  "shasta"
```

``` r
small_staff = staff[c(1, 2)]
```

In the last line, we created a new vector `small_staff` that is a subset of the staff given the indexing vector `c(1, 2)`. We have three vectors referenced in one line of code. This is tricky and we need to always refer to our rules step-by-step: evaluate the expression right of the `=`, which contains a vector bracket. Follow the rule of the vector bracket. Then store the returning value to the variable left of `=`.

Alternatively, instead of using numerical indexing vectors, we can use a **logical indexing vector**. The logical indexing vector must be the *same length* as the vector to be subsetted, with `TRUE` indicating an element to keep, and `FALSE` indicating an element to drop. The following block of code gives the same value as before:


``` r
staff[c(TRUE, FALSE, FALSE)]
```

```
## [1] "chris"
```

``` r
staff[c(TRUE, TRUE, FALSE)]
```

```
## [1] "chris"  "shasta"
```

``` r
small_staff = staff[c(TRUE, TRUE, FALSE)]
```

### Subsetting vectors implicitly

Here are two applications of subsetting on vectors that need distinction to write the correct code:

1.  **Explicit subsetting**: Suppose someone approaches you a length 10 vector of people's ages, and say that they want to subset to the 1st, 3rd, and 9th elements.

2.  **Implicit subsetting**: Suppose someone approaches you a length 10 vector of people's ages, and say that they want to subset to elements \>50 age.

Consider the following vector.


``` r
age = c(89, 70, 64, 90, 66, 71, 55, 60, 30, 16)
```

We could subset `age` **explicitly** two ways. Suppose we want to subset the 1st and 5th, and 9th elements. One can do it with numerical indexing vectors:


``` r
age[c(1, 5, 9)]
```

```
## [1] 89 66 30
```

or by **logical indexing vectors**:


``` r
age[c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)]
```

```
## [1] 89 66 30
```

and you can do it in one step as we have done so, or two steps by storing the indexing vector as a variable. *Either ways is fine.*


``` r
num_idx = c(1, 5, 9)
age[num_idx]
```

```
## [1] 89 66 30
```


``` r
logical_idx = c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)
age[logical_idx]
```

```
## [1] 89 66 30
```

For implicit subsetting, we don't know which elements to select off the top of our head! (We could count, but this method does not scale up.)

Rather, we can figure out which elements to select by using a **comparison operator**, which returns a logical indexing vector.


``` r
age > 50
```

```
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

The comparison operator `>` compared the numeric value of `age` to see which elements of age is greater than 50, and then returned a logical vector that has `TRUE` if age is greater than 50 at that element and `FALSE` otherwise.

Then,


``` r
indexing_vector = age > 50
age[indexing_vector]
```

```
## [1] 89 70 64 90 66 71 55 60
```

``` r
#or
age[age > 50]
```

```
## [1] 89 70 64 90 66 71 55 60
```

To summarize:

Subset a vector **implicitly**, in 3 steps:

1.  Come up with a criteria for subsetting: "I want to subset to values greater than 50".
2.  We can use a **comparison operator** to create a **logical indexing vector** that fits this criteria.


``` r
age > 50
```

```
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

3.  Use this logical indexing vector to subset.


``` r
age[age > 50]
```

```
## [1] 89 70 64 90 66 71 55 60
```

``` r
#or
idx = age > 50
age[idx]
```

```
## [1] 89 70 64 90 66 71 55 60
```

And you are done.

### Comparison Operators

We have the following comparison operators in R:

`<` less than

`<=` less or equal than

`==` equal to

`!=` not equal to

`>` greater than

`>=` greater than or equal to

You can also put these comparison operators together to form more complex statements, which you will explore in this week's exercise.

Another example:


``` r
age_90 = age[age == 90]
age_90
```

```
## [1] 90
```

``` r
age_not_90 = age[age != 90]
age_not_90
```

```
## [1] 89 70 64 66 71 55 60 30 16
```

For most of our subsetting tasks on vectors (and dataframes below), we will be encouraging implicit subsetting. The power of implicit subsetting is that you don't need to know what your vector contains to do something with it! This technique is related to *abstraction* in programming mentioned in the first lesson: by using expressions to find the specific value you are interested instead of *hard-coding* the value explicitly, it generalizes your code to handle a wider variety of situations.

## Dataframes

Before we dive into dataframes, check that the `tidyverse` package is properly installed by loading it in your R Console:


``` r
library(tidyverse)
```

Here is the data structure you have been waiting for: the **dataframe**. A dataframe is a spreadsheet such that each column must have the same data type. Think of a bunch of vectors organized as columns, and you get a dataframe.

For the most part, we load in dataframes from a file path (although they are sometimes created by combining several vectors of the same length, but we won't be covering that here):


``` r
load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

### Using functions and operations on dataframes

We can run some useful functions on dataframes to get some useful properties, similar to how we used `length()` for vectors:


``` r
nrow(metadata)
```

```
## [1] 1864
```

``` r
ncol(metadata)
```

```
## [1] 30
```

``` r
dim(metadata)
```

```
## [1] 1864   30
```

``` r
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


``` r
metadata$OncotreeLineage[1:5]
```

```
## [1] "Ovary/Fallopian Tube" "Myeloid"              "Bowel"               
## [4] "Myeloid"              "Myeloid"
```

``` r
metadata$Age[1:5]
```

```
## [1] 60 36 72 30 30
```

We treat the resulting value as a vector, so we can perform implicit subsetting:


``` r
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

The bracket operation `[ ]` on a dataframe can also be used for subsetting. `dataframe[row_idx, col_idx]` subsets the dataframe by a row indexing vector `row_idx`, and a column indexing vector `col_idx`.


``` r
metadata[1:5, c(1, 3)]
```

```
##      ModelID CellLineName
## 1 ACH-000001  NIH:OVCAR-3
## 2 ACH-000002        HL-60
## 3 ACH-000003        CACO2
## 4 ACH-000004          HEL
## 5 ACH-000005   HEL 92.1.7
```

We can refer to the column names directly:


``` r
metadata[1:5, c("ModelID", "CellLineName")]
```

```
##      ModelID CellLineName
## 1 ACH-000001  NIH:OVCAR-3
## 2 ACH-000002        HL-60
## 3 ACH-000003        CACO2
## 4 ACH-000004          HEL
## 5 ACH-000005   HEL 92.1.7
```

We can leave the column index or row index empty to just subset columns or rows.


``` r
metadata[1:5, ]
```

```
##      ModelID PatientID CellLineName StrippedCellLineName Age SourceType
## 1 ACH-000001 PT-gj46wT  NIH:OVCAR-3            NIHOVCAR3  60 Commercial
## 2 ACH-000002 PT-5qa3uk        HL-60                 HL60  36 Commercial
## 3 ACH-000003 PT-puKIyc        CACO2                CACO2  72 Commercial
## 4 ACH-000004 PT-q4K2cp          HEL                  HEL  30 Commercial
## 5 ACH-000005 PT-q4K2cp   HEL 92.1.7              HEL9217  30 Commercial
##   SangerModelID      RRID DepmapModelType AgeCategory GrowthPattern
## 1     SIDM00105 CVCL_0465           HGSOC       Adult      Adherent
## 2     SIDM00829 CVCL_0002             AML       Adult    Suspension
## 3     SIDM00891 CVCL_0025            COAD       Adult      Adherent
## 4     SIDM00594 CVCL_0001             AML       Adult    Suspension
## 5     SIDM00593 CVCL_2481             AML       Adult         Mixed
##   LegacyMolecularSubtype PrimaryOrMetastasis               SampleCollectionSite
## 1                                 Metastatic                            ascites
## 2                                    Primary haematopoietic_and_lymphoid_tissue
## 3                                    Primary                              Colon
## 4                                    Primary haematopoietic_and_lymphoid_tissue
## 5                                                                   bone_marrow
##      Sex SourceDetail  LegacySubSubtype CatalogNumber
## 1 Female         ATCC high_grade_serous        HTB-71
## 2 Female         ATCC                M3       CCL-240
## 3   Male         ATCC                          HTB-37
## 4   Male         DSMZ                M6        ACC 11
## 5   Male         ATCC                M6       HEL9217
##                                     CCLEName COSMICID PublicComments
## 1                            NIHOVCAR3_OVARY   905933               
## 2    HL60_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE   905938               
## 3                      CACO2_LARGE_INTESTINE       NA               
## 4     HEL_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE   907053               
## 5 HEL9217_HAEMATOPOIETIC_AND_LYMPHOID_TISSUE       NA               
##   WTSIMasterCellID EngineeredModel TreatmentStatus OnboardedMedia PlateCoating
## 1             2201                                     MF-001-041         None
## 2               55                                     MF-005-001         None
## 3               NA                         Unknown     MF-015-009         None
## 4              783                  Post-treatment     MF-001-001         None
## 5               NA                                     MF-001-001         None
##   OncotreeCode                  OncotreeSubtype    OncotreePrimaryDisease
## 1        HGSOC High-Grade Serous Ovarian Cancer  Ovarian Epithelial Tumor
## 2          AML           Acute Myeloid Leukemia    Acute Myeloid Leukemia
## 3         COAD             Colon Adenocarcinoma Colorectal Adenocarcinoma
## 4          AML           Acute Myeloid Leukemia    Acute Myeloid Leukemia
## 5          AML           Acute Myeloid Leukemia    Acute Myeloid Leukemia
##        OncotreeLineage
## 1 Ovary/Fallopian Tube
## 2              Myeloid
## 3                Bowel
## 4              Myeloid
## 5              Myeloid
```


``` r
head(metadata[, c("ModelID", "CellLineName")])
```

```
##      ModelID CellLineName
## 1 ACH-000001  NIH:OVCAR-3
## 2 ACH-000002        HL-60
## 3 ACH-000003        CACO2
## 4 ACH-000004          HEL
## 5 ACH-000005   HEL 92.1.7
## 6 ACH-000006   MONO-MAC-6
```

The bracket operation on a dataframe can be difficult to interpret because multiple expression for the row and column indicies is a lot of information for one line of code. You will see easier-to-read functions for dataframe subsetting in the next lesson.

Lastly, try running `View(metadata)` in RStudio Console...whew, a nice way to examine your dataframe like a spreadsheet program!

## Exercises

You can find [exercises and solutions on Posit Cloud](https://posit.cloud/content/8245357), or on [GitHub](https://github.com/fhdsl/Intro_to_R_Exercises).
