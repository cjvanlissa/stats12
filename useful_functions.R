clean_file <- function(f){
# f <- "quiz1-10.qmd"
tmp <- readLines(f)
these <- tmp == "Move To...This element is a more accessible alternative to drag & drop reordering. Press Enter or Space to move this question."
if(any(these)) tmp <- tmp[-which(these)]
these <- grepl("^Question \\d{1,} ptsEdit this question Delete this question$", tmp)
if(any(these)) tmp <- tmp[-which(these)]
tmp <- gsub("LaTeX: ", "$", tmp, fixed = TRUE)
tmp <- gsub("General answer comments", '`r hide("Explanation")`', tmp, fixed = TRUE)
#tmp <- gsub("General answer comments", '`r hide("Explanation")`', tmp, fixed = TRUE)
tmp <- gsub("Correct answer", 'answer = ', tmp, fixed = TRUE)
writeLines(tmp, paste0("clean_", f))
}

clean_file("quiz1-10.qmd")
