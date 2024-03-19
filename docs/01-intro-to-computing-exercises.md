# Intro to Computing Exercises

If you need to clear your environment and start from the beginning, this code chunk will do that:


```r
rm(list = ls())
```

## Part 1: Expressions on numerics, characters, and logical.

Recall that we have looked at the first two data types, and you will look at the third data type briefly today:

-   **Numeric**: Contains any numeric values, include decimals. For instance, `-123.2`.

-   **Character**: Contains a series of letters and symbols, contained in a quote. For instance, `"hello!"`

-   **Logical**: Contains only `TRUE` or `FALSE` values. It can be equivalently represented by `T` or `F`.

We will variables `chr1` and `chr2` to both have values of 2. This represents the number of chromosome copies you have in a cell for chromosomes 1 and 2, respectively.


```r
chr1 = 2
chr2 = 2
```

Use the function `class()` on either variables. What data type does it return, and what do you think it is telling you? The `class()` function is very useful to understand what data type your variable is. Also notice that the data type in the argument of the function does not have to be same data type as the returned value from the function!



Then, change the value of `chr1` to be 3, representing 3 chromosome copies for chromosome 1.



Then, create variable `chr3` to be assigned to `chr1`.



Change the value of `chr1` back to `2`. What happens to value of `chr3`?



Even though you have set `chr3` to be equal to `chr1` in the previous code chunk, `chr3` does not change. This illustrates an important point: when you make an assignment via `=`, the R Console makes a copy of the data type and store its value independently in the environment (This is not always true in every programming language!).

Now, do the following: triple the value of `chr1`, and divide the value of `chr3` by one half.

Tip: Is there a way of writing it by referencing the variable's current value? For instance, instead of `chr1 = 6`, consider the syntax `x = x * 3`. This way of referencing the variable's current value is extremely important in writing code that is flexible to a variety of inputs. You do not have to know what the value of `chr1` is to triple its value.



Write an expression that uses `chr1`, `chr2`, and `chr3` in one line of code, and store the resulting value in a new variable of your own choice. Think carefully about the order of operations or function you use and check that the R Console is interpreting it correctly.



Take what you just wrote above, and now add some parenthesizes to change the order of operation. Does the resulting value change as you expect?



Here is a weird expression:


```r
sqrt(chr1 * abs(-chr2 + chr1)) + nchar("chromosome")
```

```
## [1] 10
```

Explain in words how the R Console parse out this expression to give the resulting value. The `sqrt()` function computes the square root of a number, and `abs()` function computes the absolute value of a number. Try `?sqrt` and `?abs` in the R console for more information.

In your own words:

## Part 2: Brief introduction to vectors

Suppose you want to store information about the number of chromosome copies for chromosomes 1 to 22. Defining `chr4`, `chr5`, etc. seems repetitive. *A good rule of thumb in programming is Don't Repeat Yourself (DRY). If you do, find a way to automate it!*

We have so far looked at **data types**, which so far includes **numeric** and **character**. Here, we introduce **data structures**, which store information about data types.

The **vector** is a data structure that stores many elements of the *same data type*. Each *element* of a vector contains a single data type, and there is no limit on how big a vector can be, as long the memory use of it is within the computer's memory (RAM).

To create a vector, we use the combine `c()` function to combine individual data type elements together:


```r
chrNum = c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)
```

That was repetitive. Using DRY rule of thumb, we find a function to automate this:


```r
chrNum = rep(2, 22)
```

Use the `length()` function on `chrNum` to see what the length of this vector is.



Now, we introduce a new operation: accessing elements of a vector using **brackets**. We will talk about this in much more detail - the point of the exercise is to get a taste of what is coming up next.

If we want to access the 3rd element of this vector:


```r
chrNum[3]
```

```
## [1] 2
```

Now, modify the third element of this `chrNum` vector to be doubled. Also, modify `chrNum` so that the 21th element of `chrNum` is the sum of `chrNum[2]`, `chrNum[3]`, and `chrNum[4]`.



Last thing about vector for now: If we want to access multiple elements of `chrNum`, we first specify a numeric vector the elements we want to access. This is called the **indexing vector**. Then, we put the indexing vector within the brackets for `chrNum` to access it.

If we want the 2nd and 4th elements:


```r
indexing = c(2, 4)
chrNum[indexing]
```

```
## [1] 2 2
```

Often, we do it without storing the indexing vector as a variable.


```r
chrNum[c(2, 4)]
```

```
## [1] 2 2
```

Your turn: access the 10th and 11th elements of `chrNum` using an indexing vector:



Now try the following: access chromosomes 1 to 10. Instead of writing out 1 to 10 for your indexing vector, use the sequence `seq()` function: try `seq(1, 10)` to create your indexing vector. You could also use the operation `1:10` instead of `seq()` as an alternative:



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

