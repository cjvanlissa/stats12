# book-specific code to include on every page

answer <- function(x){
  cat('`r hide("Answer")`')
  cat(x)
  cat('`r unhide()`')
}

add_mcs <- function(filename){
  qs <- read.csv(filename, stringsAsFactors = FALSE, header = FALSE)
  cat('::: {.webex-check .webex-box}\n\n')
  for(i in 1:nrow(qs)){
    cat(paste0("**Question ", i, "**\n\n"))
    Args <- as.vector(unname(qs[i,]))
    Args <- Args[!(is.na(Args) | Args == "")]
    Args <- trimws(Args[-length(Args)])
    Args <- as.list(Args)
    do.call(mc, args = Args)
    cat("\n\n")
  }
  cat(":::\n\n")
  cat(hide("Show explanations"))
  for(i in 1:nrow(qs)){
    cat(paste0("**Question ", i, "**\n\n"))
    Args <- qs[i,]
    Args <- Args[!(is.na(Args) | Args == "")]
    Args <- as.character(Args)
    cat(tail(Args, 1))
    cat("\n\n")
  }
  cat(unhide())
  cat('\n\n')
}

mc <- function(question,
               answer,
               ...){
  opts <- c(answer = answer, list(...))
  opts <- opts[sample.int(length(opts))]
  cat(question, webexercises::longmcq(opts))
}

if (requireNamespace("knitr", quietly = TRUE)) {

  library(glossary)
  glossary::glossary_path("include/glossary.yml")
  glossary_popup("click") # "click", "hover" or "none"

  # default knitr options ----
  knitr::opts_chunk$set(
    echo       = TRUE,
    results    = "hold",
    out.width  = '100%',
    fig.width  = 8,
    fig.height = 5,
    fig.align  = 'center',
    dpi = 96
  )
}
