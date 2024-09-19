library(here)
library(purrr)

top_dir <- here::here()
slide_files <- list.files("slides", pattern="qmd", full.names = TRUE)
file.copy(slide_files, top_dir,overwrite = TRUE)
image_files <- list.files("slides/images", full.names=TRUE)
file.copy(image_files, "images", overwrite = TRUE)

slides_top <- list.files(".", pattern="qmd")

map(slides_top, quarto::quarto_render)

all_files <- list.files(".", "lesson")
file.copy(all_files, "slides", overwrite = TRUE)

file.remove(all_files)
