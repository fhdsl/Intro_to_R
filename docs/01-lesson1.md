# Intro to Computing

## Goals of the course

-   Fundamental concepts in high-level programming languages (R, Python, Julia, WDL, etc.) that is transferable: *How do programs run, and how do we solve problems using functions and data structures?*

-   Beginning of data science fundamentals: *How do you translate your scientific question to a data wrangling problem and answer it?*

    ![Data science workflow](https://d33wubrfki0l68.cloudfront.net/571b056757d68e6df81a3e3853f54d3c76ad6efc/32d37/diagrams/data-science.png){width="450"}

-   Find a nice balance between the two throughout the course: we will try to reproduce a figure from a scientific publication using new data.

## What is a computer program?

-   A sequence of instructions to manipulate data for the computer to execute.

-   A series of translations: English \<-\> Programming Code for Interpreter \<-\> Machine Code for Central Processing Unit (CPU)

We will focus on English \<-\> Programming Code for R Interpreter in this class.

More importantly: **How we organize ideas \<-\> Instructing a computer to do something**.

## A programming language has following elements: {#a-programming-language-has-following-elements}

-   Grammar structure to construct expressions

-   Combining expressions to create more complex expressions

-   Encapsulate complex expressions via functions to create modular and reusable tasks

-   Encapsulate complex data via data structures to allow efficient manipulation of data 


## Posit Cloud Setup

Posit Cloud/RStudio is an Integrated Development Environment (IDE). Think about it as Microsoft Word to a plain text editor. It provides extra bells and whistles to using R that is easier for the user.

Today, we will pay close attention to:

-   Script editor: where sequence of instructions are typed and saved as a text document as a R program. To run the program, the console will execute every single line of code in the document.

-   Console (interpreter): Instead of giving a entire program in a text file, you could interact with the R Console line by line. You give it one line of instruction, and the console executes that single line. It is what R looks like without RStudio.

-   Environment: Often, code will store information *in memory*, and it is shown in the environment. More on this later.

## Using Quarto for your work

Why should we use Quarto for data science work?

-   Encourages reproducible workflows

-   Code, output from code, and prose combined together

-   Extensions to Python, Julia, and more.

More options and guides can be found in [Introduction to Quarto](https://quarto.org/docs/get-started/hello/rstudio.html) .

## Grammar Structure 1: Evaluation of Expressions

-   **Expressions** are be built out of **operations** or **functions**.

-   Operations and functions combine **data types** to return another data type.

-   We can combine multiple expressions together to form more complex expressions: an expression can have other expressions nested inside it.

For instance, consider the following expressions entered to the R Console:


```r
18 + 21
```

```
## [1] 39
```

```r
max(18, 21)
```

```
## [1] 21
```

```r
max(18 + 21, 65)
```

```
## [1] 65
```

```r
18 + (21 + 65)
```

```
## [1] 104
```

```r
nchar("ATCG")
```

```
## [1] 4
```

Here, our input **data types** to the operation are **numeric** in lines 1-4 and our input data type to the function is **character** in line 5.

Operations are just functions in hiding. We could have written:


```r
sum(18, 21)
```

```
## [1] 39
```

```r
sum(18, sum(21, 65))
```

```
## [1] 104
```

Remember the function machine from algebra class? We will use this schema to think about expressions.

![Function machine from algebra class.](https://cs.wellesley.edu/~cs110/lectures/L16/images/function.png)

If an expression is made out of multiple, nested operations, what is the proper way of the R Console interpreting it? Being able to read nested operations and nested functions as a programmer is very important.


```r
3 * 4 + 2
```

```
## [1] 14
```

```r
3 * (4 + 2)
```

```
## [1] 18
```

Lastly, a note on the use of functions: a programmer should not need to know how the function is implemented in order to use it - this emphasizes [abstraction and modular thinking](#a-programming-language-has-following-elements), a foundation in any programming language.


### Data types

Here are some data types that we will be using in this course:

-   **Numeric**: 18, 21, 65, 1.25

-   **Character**: "ATCG", "Whatever", "948-293-0000"

-   **Logical**: TRUE, FALSE


## Grammar Structure 2: Storing data types in the environment

To build up a computer program, we need to store our returned data type from our expression somewhere for downstream use. We can assign a variable to it as follows:


```r
x = 18 + 21
```

If you enter this in the Console, you will see that in the Environment, the variable `x` has a value of `39`.

### Execution rule for variable assignment

> Evaluate the expression to the right of `=`.
>
> Bind variable to the left of `=` to the resulting value.
>
> The variable is stored in the environment.
>
> `<-` is okay too!

The environment is where all the variables are stored, and can be used for an expression anytime once it is defined. Only one unique variable name can be defined.

The variable is stored in the working memory of your computer, Random Access Memory (RAM). This is temporary memory storage on the computer that can be accessed quickly. Typically a personal computer has 8, 16, 32 Gigabytes of RAM. When we work with large datasets, if you assign a variable to a data type larger than the available RAM, it will not work. More on this later.

Look, now `x` can be reused downstream:


```r
x - 2
```

```
## [1] 37
```

```r
y = x * 2
```

## Grammar Structure 3: Evaluation of Functions

A function has a **function name**, **arguments**, and **returns** a data type.

### Execution rule for functions:

> Evaluate the function by its arguments, and if the arguments are functions or contains operations, evaluate those functions or operations first.
>
> The output of functions is called the **returned value**.


```r
sqrt(nchar("hello"))
```

```
## [1] 2.236068
```

```r
(nchar("hello") + 4) * 2
```

```
## [1] 18
```


## Tips on writing your first code

`Computer = powerful + stupid`

Even the smallest spelling and formatting changes will cause unexpected output and errors!

-   Write incrementally, test often

-   Check your assumptions, especially using new functions, operations, and new data types. 

-   Live environments are great for testing, but not great for reproducibility. 

-   Ask for help!



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

