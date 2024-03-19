# Data Visualization





## Common Plots

### Univariate

-   Numeric: histogram

-   Character: bar plots

### Bivariate

-   Numeric vs. Numeric: Scatterplot, line plot

-   Numeric vs. Character: Box plot

Why do we focus on these common plots? Our eyes are better at distinguishing certain visual features more than others. All of these plots are focused on their position to depict data, which gives us the most effective visual scale.

![Source: <https://www.oreilly.com/library/view/visualization-analysis-and/9781466508910/K14708_C005.xhtml>](https://www.oreilly.com/api/v2/epubs/9781466508910/files/image/fig5-1.png)

## Grammar of Graphics

The syntax of the grammar of graphics breaks down into 4 sections.

[Data]{style="color:orange"}

[Mapping to data]{style="color:green"}

[Geometry]{style="color:blue"}

[Additional settings]{style="color:purple"}

### Histogram

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm)]{style="color:green"} + [geom_histogram()]{style="color:blue"} + [theme_bw()]{style="color:purple"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-3-1.png)<!-- -->

With options:

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm)]{style="color:green"} + [geom_histogram(binwidth = 5)]{style="color:blue"} + [theme_bw()]{style="color:purple"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-4-1.png)<!-- -->

### Bar plots

[ggplot(penguins)]{style="color:orange"} + [aes(x = species)]{style="color:green"} + [geom_bar()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-5-1.png)<!-- -->

### Scatterplot

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm)]{style="color:green"} + [geom_point()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-6-1.png)<!-- -->

### Multivaraite Scatterplot

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm, color = species)]{style="color:green"} + [geom_point()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-7-1.png)<!-- -->

### Multivaraite Scatterplot

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm)]{style="color:green"} + [geom_point()]{style="color:blue"} + [facet_wrap(\~species)]{style="color:purple"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-8-1.png)<!-- -->

### Line plot?

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm)]{style="color:green"} + [geom_line()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-9-1.png)<!-- -->

### Grouped Line plot?

[ggplot(penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm, group = species)]{style="color:green"} + [geom_line()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-10-1.png)<!-- -->

### Boxplot

[ggplot(penguins)]{style="color:orange"} + [aes(x = species, y = bill_depth_mm)]{style="color:green"} + [geom_boxplot()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-11-1.png)<!-- -->

### Grouped Boxplot

[ggplot(penguins)]{style="color:orange"} + [aes(x = species, y = bill_depth_mm, color = island)]{style="color:green"} + [geom_boxplot()]{style="color:blue"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-12-1.png)<!-- -->

### Some additional options

[ggplot(data = penguins)]{style="color:orange"} + [aes(x = bill_length_mm, y = bill_depth_mm, color = species)]{style="color:green"} + [geom_point()]{style="color:blue"} + [labs(x = "Bill Length", y = "Bill Depth", title = "Comparison of penguin bill length and bill depth across species") + scale_x_continuous(limits = c(30, 60))]{style="color:purple"}

![](05-data-visualization_files/figure-docx/unnamed-chunk-13-1.png)<!-- -->

## Summary of options

[data]{style="color:orange"}

\
[geom_point]{style="color:blue"}: [x, y, color, shape]{style="color:green"}

[geom_line]{style="color:blue"}: [x, y, group, color]{style="color:green"}

[geom_histogram]{style="color:blue"}: [x, y, fill]{style="color:green"}

[geom_bar]{style="color:blue"}: [x, fill]{style="color:green"}

[geom_boxplot]{style="color:blue"}: [x, y, fill, color]{style="color:green"}

\
[facet_wrap]{style="color:purple"}

\
[labs]{style="color:purple"}

[scale_x_continuous]{style="color:purple"}

[scale_y_continuous]{style="color:purple"}

[scale_x_discrete]{style="color:purple"}

[scale_y_discrete]{style="color:purple"}

Consider the `esquisse` package to help generate your ggplot code via drag and drop. 


