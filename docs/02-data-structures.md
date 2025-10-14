# Working with data structures

In our second lesson, we start to look at two **data structures**, **vectors** and **dataframes**, that can handle a large amount of data.

Before we jump into these bigger things, we introduce a new kind of operator:

## Comparison Operations

Sometimes, we want to make comparisons between data types, such as if one is bigger than the other, or whether they are the same.


``` r
age = 35

age > 18
```

```
## [1] TRUE
```

We asked whether `age` is greater than 18, and it is `TRUE` because `age` is 35. We can follow-up to ask if `age` is equal or less than 65:


``` r
age <= 65
```

```
## [1] TRUE
```

Besides comparing numbers, we can ask characters whether they are a specific value:


``` r
building_name = "Arnold"

building_name == "Weintraub"
```

```
## [1] FALSE
```

We asked whether `building_name` is "Weintraub" via the `==` comparison operator (extremely easy to confuse with `=`), and it is `FALSE` because `building_name` is "Arnold". We can follow-up to ask if `building_name` is *not equal* to "Weintraub".


``` r
building_name != "Weintraub"
```

```
## [1] TRUE
```

## Full list of Comparison Operations

`<` less than

`<=` less or equal than

`>` greater than

`>=` greater than or equal to

`==` equal to

`!=` not equal to

You can also write out multiple comparisons at once, which you will see more in your exercise this week...

## Vectors

In the first exercise, you started to explore **data structures**, which store information about data types. You played around with **vectors**, which is a ordered collection of a data type. Each *element* of a vector contains a data type, and all elements of a vector must be the same type, such as numeric, character, or logical.

We often create vectors using the combine function, `c()` :


``` r
staff = c("chris", "sonu", "sean")
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
chrNum = c(2, 3, 1)
chrNum = chrNum * 3
chrNum 
```

```
## [1] 6 9 3
```

All of `chrNum`'s elements tripled! Our multiplication operation, when used on a *numeric vector with a numeric*, has a *new* meaning: it multiplied all the elements by 3. Here's another example: numeric vector multiplied by another numeric vector:


``` r
chrNum * c(2, 2, 0)
```

```
## [1] 12 18  0
```

Or how about comparison operators?


``` r
chrNum > 2
```

```
## [1] TRUE TRUE TRUE
```

but there are also limits: a numeric vector added to a character vector creates an error:


``` r
#chrNum + staff
```

When we work with operations and functions, we must be mindful what inputs the operation or function takes in, and what outputs it gives, no matter how "intuitive" the operation or function name is.

Lastly, here's a function you can use on vectors: `length()` gives you the length of the vector:


``` r
length(chrNum)
```

```
## [1] 3
```

### Subsetting vectors explicitly

In the exercise this past week, you looked at a new operation to subset elements of a vector using brackets. Let's look at all the possible ways to subset vectors carefully:

We subset vectors using the bracket `[ ]` operation.

Inside the bracket can be:

1.  A single numeric value


``` r
staff[2]
```

```
## [1] "shasta"
```

which returns the second value of `staff`.

2.  A **numerical indexing vector** containing numerical values. They dictate which elements of the vector to subset.


``` r
staff[c(1, 2)]
```

```
## [1] "chris"  "shasta"
```

Alternatively, you can also store the subetted vector as a new variable:


``` r
small_staff = staff[c(1, 2)]
small_staff
```

```
## [1] "chris"  "shasta"
```

3.  A **logical indexing vector** with the same length as the vector to be subsetted. The `TRUE` values indicate which elements to keep, the `FALSE` values indicate which elements to drop.

If we want the first element:


``` r
staff[c(TRUE, FALSE, FALSE)]
```

```
## [1] "chris"
```

If we want the first and second elements:


``` r
staff[c(TRUE, TRUE, FALSE)]
```

```
## [1] "chris"  "shasta"
```

If we want the first and second elements and store the result as a variable:


``` r
small_staff = staff[c(TRUE, TRUE, FALSE)]
small_staff
```

```
## [1] "chris"  "shasta"
```

### A trick: When subsetting large vectors

Suppose you have a large vector `age` with 100 elements:


``` r
set.seed(123) #don't worry about this function
age = round(runif(100, 1, 100)) #don't worry about these functions
age
```

```
##   [1] 29 79 41 88 94  6 53 89 56 46 96 46 68 58 11 90 25  5 33 95 89 70 64 99 66
##  [26] 71 55 60 30 16 96 90 69 80  3 48 76 22 32 24 15 42 42 38 16 15 24 47 27 86
##  [51]  6 45 80 13 57 21 14 76 90 38 67 10 39 28 82 45 81 81 80 45 76 63 71  1 48
##  [76] 23 39 62 36 12 25 67 42 79 11 44 99 89 89 18 14 66 35 66 33 20 78 10 47 52
```

Suppose you want the first 20 elements of this vector using a numerical indexing vector. Writing out `c(1, 2, 3, 4, …` for the numerical indexing vector a pain. We can generate a numerical vector 1 to 20 via the following trick:


``` r
1:20
```

```
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20
```

Then, you just use it to help subset:


``` r
age[1:20]
```

```
##  [1] 29 79 41 88 94  6 53 89 56 46 96 46 68 58 11 90 25  5 33 95
```

## Dataframes

Before we dive into dataframes, check that the `tidyverse` package is properly installed by loading it in your R Console:


``` r
library(tidyverse)
```

Here is the data structure you have been waiting for: the **Dataframe**. A dataframe is a spreadsheet such that each column must have the same data type. Think of a bunch of vectors organized as columns, and you get a dataframe.

Below is some code to load in a Dataframe. Notice that the file extension here is in `.RData`, which is a format specifically for R. In the last week of class we will talk about how to load and save spreadsheets from CSVs or Excel.


``` r
load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

### Using functions and operations on Dataframes

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

The bracket operation `[ ]` on a dataframe can also be used for subsetting rows and columns at once. `dataframe[row_idx, col_idx]` subsets the dataframe by a row indexing vector `row_idx`, and a column indexing vector `col_idx`.


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
