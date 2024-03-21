# Project 1: Exploring KRAS Expression

## Motivation

In the paper ["Tumor RAS Gene Expression Levels Are Influenced by the Mutational Status of RAS Genes and Both Upstream and Downstream RAS Pathway Genes"](https://journals.sagepub.com/doi/pdf/10.1177/1176935117711944), the authors studied relationship between RAS gene mutational status and messenger RNA expression. They saw higher levels of KRAS expression for samples that have KRAS mutation relative to samples without KRAS mutation for several cancer subtypes. The analysis was conducted using patient data from the [The Cancer Genome Atlas (TCGA)](https://www.cancer.gov/ccg/research/genome-sequencing/tcga) project, and we are curious whether similar trends hold via cell line models.

![KRAS expression is elevated in KRAS-mutant samples from lung, pancreatic, and colon adenocarcinomas relative to WT samples.](https://raw.githubusercontent.com/fhdsl/S1_Intro_to_R/main/images/kras.png){width="450"}

The cell line models we use is from the [Dependency Map Project](https://depmap.org/portal/home/) (DepMap), where over a thousand cancer cell lines were profiled for various genomic features, including mutational status and RNA expression.

You will write code to recreate this figure using the DepMap data. Below are some suggestions on how to analyze it, but you can do it your own way!

Clears the environment.


```r
rm(list = ls())
```

## Analysis 1

### Load analysis package and DepMap data in


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
library(knitr)
load(url("https://github.com/fhdsl/S1_Intro_to_R/raw/main/classroom_data/CCLE.RData"))
```

### Examine the number of cell lines profiled for `metadata`, `expression`, `mutation`



### Examine the frequency of cancer subtypes in `metadata`


```r
kable(table(metadata$OncotreePrimaryDisease))
```



|Var1                                                                                                | Freq|
|:---------------------------------------------------------------------------------------------------|----:|
|Acute Leukemias of Ambiguous Lineage                                                                |    1|
|Acute Myeloid Leukemia                                                                              |   52|
|Adenosquamous Carcinoma of the Pancreas                                                             |    2|
|Adrenocortical Carcinoma                                                                            |    1|
|Ampullary Carcinoma                                                                                 |    4|
|Anaplastic Thyroid Cancer                                                                           |    9|
|B-Lymphoblastic Leukemia/Lymphoma                                                                   |   32|
|Bladder Squamous Cell Carcinoma                                                                     |    2|
|Bladder Urothelial Carcinoma                                                                        |   35|
|Breast Ductal Carcinoma In Situ                                                                     |    6|
|Breast Neoplasm, NOS                                                                                |    4|
|Cervical Adenocarcinoma                                                                             |    7|
|Cervical Squamous Cell Carcinoma                                                                    |   15|
|Chondrosarcoma                                                                                      |    8|
|Chordoma                                                                                            |    1|
|Colorectal Adenocarcinoma                                                                           |   85|
|Cutaneous Squamous Cell Carcinoma                                                                   |    6|
|Diffuse Glioma                                                                                      |   93|
|Embryonal Tumor                                                                                     |   25|
|Endometrial Carcinoma                                                                               |   34|
|Epithelioid Sarcoma                                                                                 |    2|
|Esophageal Squamous Cell Carcinoma                                                                  |   29|
|Esophagogastric Adenocarcinoma                                                                      |   66|
|Ewing Sarcoma                                                                                       |   47|
|Extra Gonadal Germ Cell Tumor                                                                       |    1|
|Fibrosarcoma                                                                                        |    3|
|Gastrointestinal Stromal Tumor                                                                      |    1|
|Gestational Trophoblastic Disease                                                                   |    3|
|Glassy Cell Carcinoma of the Cervix                                                                 |    1|
|Head and Neck Carcinoma, Other                                                                      |    1|
|Head and Neck Squamous Cell Carcinoma                                                               |   79|
|Hepatoblastoma                                                                                      |    3|
|Hepatocellular Carcinoma                                                                            |   24|
|Hepatocellular Carcinoma plus Intrahepatic Cholangiocarcinoma                                       |    1|
|Hereditary Spherocytosis                                                                            |    1|
|Hodgkin Lymphoma                                                                                    |    9|
|Intracholecystic Papillary Neoplasm                                                                 |    7|
|Intraductal Papillary Neoplasm of the Bile Duct                                                     |   33|
|Invasive Breast Carcinoma                                                                           |   76|
|Leiomyosarcoma                                                                                      |    3|
|Liposarcoma                                                                                         |   11|
|Lung Neuroendocrine Tumor                                                                           |   81|
|Medullary Thyroid Cancer                                                                            |    1|
|Melanoma                                                                                            |  105|
|Meningothelial Tumor                                                                                |    4|
|Merkel Cell Carcinoma                                                                               |    7|
|Mixed Cervical Carcinoma                                                                            |    1|
|Mucosal Melanoma of the Vulva/Vagina                                                                |    3|
|Myelodysplastic Syndromes                                                                           |    1|
|Myeloproliferative Neoplasms                                                                        |   19|
|Nerve Sheath Tumor                                                                                  |    6|
|Neuroblastoma                                                                                       |   49|
|Non-Cancerous                                                                                       |  105|
|Non-Hodgkin Lymphoma                                                                                |  146|
|Non-Seminomatous Germ Cell Tumor                                                                    |    4|
|Non-Small Cell Lung Cancer                                                                          |  159|
|Ocular Melanoma                                                                                     |   10|
|Osteosarcoma                                                                                        |   19|
|Ovarian Cancer, Other                                                                               |    1|
|Ovarian Epithelial Tumor                                                                            |   70|
|Ovarian Germ Cell Tumor                                                                             |    1|
|Pancreatic Adenocarcinoma                                                                           |   62|
|Pancreatic Neuroendocrine Tumor                                                                     |    1|
|Pleural Mesothelioma                                                                                |   35|
|Poorly Differentiated Thyroid Cancer                                                                |    1|
|Prostate Adenocarcinoma                                                                             |   10|
|Prostate Small Cell Carcinoma                                                                       |    1|
|Renal Cell Carcinoma                                                                                |   55|
|Retinoblastoma                                                                                      |    2|
|Rhabdoid Cancer                                                                                     |    6|
|Rhabdomyosarcoma                                                                                    |   21|
|Salivary Carcinoma                                                                                  |    1|
|Sarcoma, NOS                                                                                        |    1|
|Sex Cord Stromal Tumor                                                                              |    1|
|Small Bowel Cancer                                                                                  |    2|
|Small Cell Carcinoma of the Cervix                                                                  |    1|
|Squamous Cell Carcinoma of the Vulva/Vagina                                                         |    2|
|Synovial Sarcoma                                                                                    |    9|
|T-Lymphoblastic Leukemia/Lymphoma                                                                   |   22|
|Undifferentiated Pleomorphic Sarcoma/Malignant Fibrous Histiocytoma/High-Grade Spindle Cell Sarcoma |    3|
|Urethral Cancer                                                                                     |    2|
|Uterine Sarcoma/Mesenchymal                                                                         |    4|
|Well-Differentiated Thyroid Cancer                                                                  |    7|

### Alternatively, you could create a barplot to show the frequency of cancer subtypes in `metadata`:



Need to display the text more clearly? Consider [this discussion on StackOverflow](https://stackoverflow.com/questions/1330989/rotating-and-spacing-axis-labels-in-ggplot2).

### Filter `metadata` so that it contains the cancer subtype want to analyze.



### Join `metadata`, `expression`, and `mutation` together.



### Select the columns you want to analyze.



### Create the boxplot figure!



### Consider a different way to visualize this data: Create a histogram of KRAS expression for non-KRAS mutated cell lines, and a different histogram of KRAS expression for KRAS mutated cell lines.



## Analysis 2

Three well-established genes that are activated by KRAS are PI3K, RAF, and RAL. We will use correlation analysis to see how the expression of KRAS, PI3K, RAF, and RAL are related linearly.

### Create scatterplots of `KRAS` expression vs. `PIK3CA`, `RAF1`, and `RALB`. What does the trend look like?



### We can measure the correlation of two continuous variables via the `cor` function. What's the correlation of `KRAS` vs. `RAF1`?


```r
#for example,
#cor(c(1, 2, 3), c(-1, 2, 0))
#cor(dataframe$colA, dataframe$colB)
```

### Can you put the correlation in the title of your scatterplot?


