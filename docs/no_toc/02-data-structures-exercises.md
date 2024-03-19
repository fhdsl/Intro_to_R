# Working with Data Structures Exercises

If you need to clear your environment and start from the beginning, this code chunk will do that:


```r
rm(list = ls())
```

## Recap from class: subsetting explicitly and implicitly

In class, we looked at a numerical vector similar to this:


```r
age = c(89, 70, 64, 99, 66, 71, 55, 60, 30, 16)
```

We could subset `age` **explicitly** two ways. Suppose we want to subset the 1st and 5th, and 9th elements. One can do it with numerical indexing vectors:


```r
age[c(1, 5, 9)]
```

```
## [1] 89 66 30
```

or by **logical indexing vectors**:


```r
age[c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)]
```

```
## [1] 89 66 30
```

and you can do it in one step as we have done so, or two steps by storing the indexing vector as a variable. *Either ways is fine.*


```r
num_idx = c(1, 5, 9)
age[num_idx]
```

```
## [1] 89 66 30
```


```r
logical_idx = c(TRUE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, FALSE)
age[logical_idx]
```

```
## [1] 89 66 30
```

Now, let's subset this vector **implicitly**, in 3 steps:

1.  Come up with a criteria for subsetting: "I want to subset to values greater than 50".
2.  We can use a **comparison operator** to create a **logical indexing vector** that fits this criteria.


```r
age > 50
```

```
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```

3.  Use this logical indexing vector to subset.


```r
age[age > 50]
```

```
## [1] 89 70 64 99 66 71 55 60
```

And you are done.

Alternatively, you could have done this in two steps:


```r
another_idx = age > 50
age[another_idx]
```

```
## [1] 89 70 64 99 66 71 55 60
```

On to practicing yourself!

## Part 1: Comparison operators on data types

In class, we looked at comparison operators on vectors to create logical indexing vectors. We are going to first take a step back and see how comparison operators work on simpler data types. Here are the comparison operators common in R:

`<` less than

`<=` less or equal than

`==` equal to

`!=` not equal to

`>` greater than

`>=` greater than or equal to

Consider the following variables:


```r
chr1 = 2
chr2 = 3
chr3 = 1
staff1 = "chris"
staff2 = "shasta"
```

We saw how we used comparison operators on vectors, but they can be used for any singular data type:

Using comparison operators, write 3 expressions so that the returned value is `TRUE`. I'll give one example:


```r
staff1 != "jeff"
```

```
## [1] TRUE
```

Using comparison operators, write 3 expressions so that the returned value is `FALSE`:


```r
chr1 > 2
```

```
## [1] FALSE
```

We can combine comparison operators together to form more complex statements:

The "and" `&` operator returns `TRUE` if both inputs have values of `TRUE`, and `FALSE` otherwise:


```r
a = TRUE
b = TRUE
c = FALSE
d = FALSE
a & b
```

```
## [1] TRUE
```

```r
c & d
```

```
## [1] FALSE
```

```r
a & c
```

```
## [1] FALSE
```

```r
b & d
```

```
## [1] FALSE
```

Therefore, we can create compound comparison operations like this:


```r
chr1 > chr3 & chr1 < chr2
```

```
## [1] TRUE
```

Similarly, the "or" `|` operator returns `TRUE` if at least one of the inputs are `TRUE`. Otherwise it returns `FALSE`.


```r
a | b
```

```
## [1] TRUE
```

```r
c | d
```

```
## [1] FALSE
```

```r
a | c
```

```
## [1] TRUE
```

```r
b | d
```

```
## [1] TRUE
```

Create 2 compound comparison operations using `|` so that one returns `TRUE` and the other returns `FALSE`. I'll give you one example:


```r
chr1 > chr3 | chr1 < chr2
```

```
## [1] TRUE
```

You can extend these compound statements to contain multiple `&` and `|` operations mixed together, and parentheses should be used to clarify your order of operation.

**Now, let's use comparison operators on vectors.**

We create the `age` vector from our lesson.


```r
set.seed(123) #don't worry about this function
age = round(runif(20, 1, 100)) #don't worry about these functions
```

Create a compound comparison operation that looks returns a logical vector so that the elements are `TRUE` if `age` is between 18 *and* 65.



## Part 2: Subsetting vectors

Let's practice explicit subsetting. Can you subset for the first 10 elements of `age` explicitly?



We will now look at implicit subsetting using with a criteria of interest: "We want to subset `age` to have values less than 21 *or* greater than 40".

Then, the next step is to create the logical indexing vector via compound comparison operations. You should use the or `|` operation:



The final step is to use this logical indexing vector to subset:



Let's do another practice: Can you subset for all `age` greater than 65?



## Part 3: Dataframes


```r
library(tidyverse)
load(url("https://github.com/fhdsl/Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

Use the `colnames`, `dim`, `ncol`, and `nrow` functions to explore the basic properties of the dataframe `metadata`:



Using the `$` operator, subset `OncotreeLineage` column from the `metadata` dataframe and store the result as a character vector called `lineage`:



Then, subset for the first 10 elements of `lineage` explicitly:



Create a logical indexing vector that gives `TRUE` if an element of `lineage` is "Myeloid", and `FALSE` otherwise. You will need to use the `==` comparison operation. Store it as the variable `myeloid_idx`.



We can now use this logical indexing vector to subset on the *rows* of `metadata`. Take a look (you need to remove the # comments the code):


```r
#myeloid_metadata = metadata[myeloid_idx ,]
#View(myeloid_metadata)
```

## You are done!

Change the logical value of this variable to `TRUE`. That's all you need to know about **logicals** for now!


```r
finished_with_exercise1 = FALSE
```

## Feedback!

How many hours did you spend on this exercise?


```r
time_spent = 0 
```

If you worked with other peers, write their names down in the following character vector: each element is one person's name.


```r
peers = c("Myself")
```

