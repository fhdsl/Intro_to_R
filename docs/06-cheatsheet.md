# Cheatsheet

Here is a summary of expressions we learned in class.

Recall that we focused on English \<-\> Programming Code for R Interpreter in this class. Many of the functions we learned require the "Tidyverse" library to run.

## Basic Data Types

| English   | R Language       |
|-----------|------------------|
| Numeric   | `2 + 3`          |
| Character | `"hello", "123"` |
| Logical   | `TRUE`, `FALSE`  |

## Vectors

+--------------------------------------+---------------------------------------------+
| English                              | R Language                                  |
+======================================+=============================================+
| Create a vector with some elements   | `vec = c(1, -4, -9, 12)`                    |
|                                      |                                             |
|                                      | `names = c("chris", "hannah", "chris", NA)` |
+--------------------------------------+---------------------------------------------+
| Compute length of a vector           | `length(vector)`                            |
+--------------------------------------+---------------------------------------------+
| Access the second element of `names` | `names[2]`                                  |
+--------------------------------------+---------------------------------------------+

## Conditional Operations

Often to create a logical indexing vector for subsetting

| English                                 | R Language             |
|-----------------------------------------|------------------------|
| `vec` is greater than 0                 | `vec > 0`              |
| `vec` is between 0 and 10               | `vec >= 0 & vec <= 10` |
| `vec` is between 0 and 10, exclusively  | `vec > 0 & vec < 10`   |
| `vec` is greater than 4 or less than -4 | `vec > 4 | vec < -4`   |
| `names` is "chris"                      | `names == "chris"`     |
| `names` is not "chris"                  | `names != "chris"`     |
| The non-missing values of `names`       | `!is.na(names)`        |

## Subsetting vectors 

+--------------------------------------+-----------------------------------+
| English                              | R Language                        |
+======================================+===================================+
| Subset `vec` to the first 3 elements | `vec[c(1, 2, 3)]`                 |
|                                      |                                   |
|                                      | or                                |
|                                      |                                   |
|                                      | `vec[1:3]`                        |
|                                      |                                   |
|                                      | or                                |
|                                      |                                   |
|                                      | `vec[c(TRUE, TRUE, TRUE, FALSE)]` |
+--------------------------------------+-----------------------------------+
| Subset `vec` to be greater than 0    | `vec[vec > 0]`                    |
+--------------------------------------+-----------------------------------+
| Subset `names` to have "chris"       | `vec[vec == "chris"]`             |
+--------------------------------------+-----------------------------------+

## Dataframes

+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| English                                                                                            | R Language                                                 |
+====================================================================================================+============================================================+
| Load a dataframe from CSV file "data.csv"                                                          | `dataframe = read_csv("data.csv")`                         |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Load a dataframe from Excel file "data.xlsx"                                                       | `dataframe = read_excel("data.xlsx")`                      |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Compute the dimension of `dataframe`                                                               | `dim(dataframe)`                                           |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Access a column "subtype" of dataframe as a vector                                                 | `dataframe$subtype`                                        |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Subset `dataframe` to columns "subtype", "diversity", "outcome"                                    | `select(dataframe, subtype, diversity, outcome)`           |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Subset `dataframe` to rows such that the outcome is greater than zero, and the subtype is "lung".  | `filter(dataframe, outcome > 0 & subtype == "lung"`)       |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+
| Create a new column "log_outcome" so that it is the log transform of "outcome" column              | `dataframe$log_outcome = log(dataframe$outcome)`           |
|                                                                                                    |                                                            |
|                                                                                                    | or                                                         |
|                                                                                                    |                                                            |
|                                                                                                    | `dataframe = mutate(dataframe, log_outcome = log(outcome)` |
+----------------------------------------------------------------------------------------------------+------------------------------------------------------------+

## Summary Statistics of a Dataframe's column

| English                                                      | R Language                              |
|--------------------------------------------------------------|-----------------------------------------|
| Mean of `dataframe`'s "outcome" column                       | `mean(dataframe$outcome)`               |
| Mean of `dataframe`'s "outcome" column, removing `NA` values | `mean(dataframe$outcome, na.rm = TRUE)` |
| Max of `dataframe`'s "outcome" column                        | `max(dataframe$outcome)`                |
| Min of `dataframe`'s "outcome" column                        | `min(dataframe$outcome)`                |
| Count of `dataframe`'s "subtype" column                      | `table(dataframe$subtype)`              |

## Dataframe transformations

+---------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------+
| English                                                                                                                                                       | R Language                                                                                       |
+===============================================================================================================================================================+==================================================================================================+
| Merge dataframe `df1` and `df2` by common column "id", using all common entities.                                                                             | `full_join(df1, df2, "id")`                                                                      |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------+
| Group `dataframe` by "subtype" column, and summarise the mean "outcome" value for each "subtype" value, and get the total elements for each "subtype" value.  | `dataframe_grouped = group_by(dataframe, subtype)`                                               |
|                                                                                                                                                               |                                                                                                  |
|                                                                                                                                                               | `dataframe_summary = summarise(dataframe_grouped, mean_outcome = mean(outcome), n_sample = n())` |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------------------------------------------------------------------------------------------+
