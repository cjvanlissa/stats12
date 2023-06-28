lm_spss <- function(formula, data, ...){
  cl <- match.call()
  cl[[1L]] <- quote(lm)
  res <- eval.parent(cl)
  cl[["data"]] <- data.frame(scale(data))
  res_std <- eval.parent(cl)
  sums <- summary(res)
  tab_coefficients <- data.frame(Model = names(res$coefficients),
                                 sums$coefficients,
                                 Beta = res_std$coefficients)
  names(tab_coefficients) <- c("Model", "B", "Std. Error", "t", "Sig.", "Beta")
  tab_coefficients <- tab_coefficients[c("Model", "B", "Std. Error", "Beta", "t", "Sig.")]
  tab_coefficients$Model[1] <- gsub("(Intercept)", "(Constant)", tab_coefficients$Model[1], fixed = TRUE)
  
  tab_anova <- anova(res)
  tab <- data.frame(Model = c("Regression", "Residual", "Total"))
  tab[["Sum of Squares"]] = c(sum(tab_anova$`Sum Sq`[-nrow(tab_anova)]),
                              tab_anova$`Sum Sq`[nrow(tab_anova)],
                              sum(tab_anova$`Sum Sq`))
  
  tab[["df"]] = c(sum(tab_anova$Df[-nrow(tab_anova)]),
                  tab_anova$Df[nrow(tab_anova)],
                  sum(tab_anova$Df))
  tab[["Mean square"]] <- c(tab$`Sum of Squares`[1:2]/tab$df[1:2], NA)
  tab[["F"]] <- c(tab$`Mean square`[1]/tab$`Mean square`[2], NA, NA)
  tab[["Sig"]] <- c(pf(tab$F[1], tab$df[1], tab$df[2], lower.tail = FALSE)
    , NA, NA)
  tab_anova <- tab
  tab_summary <- data.frame(Model = "1", R = cor(res$fitted.values, res$model[,1]), "R square" = sums$r.squared, "Adjusted R square" = sums$adj.r.squared, "Std. Error of the Estimate" = sqrt((tab_anova[["Sum of Squares"]][1]/nrow(res$model))), check.names = F)
  rownames(tab_summary) <- NULL
  rownames(tab_anova) <- NULL
  rownames(tab_coefficients) <- NULL
  return(list(
    Summary = tab_summary,
    ANOVA = tab_anova,
    Coefficients = tab_coefficients
  ))
}

makefunction <- function(x, wrap = 40){
  nams <- names(x$model)
  nams <- paste0(nams, "_i")
  out <- paste0(nams[1], "=", 
         paste0(formatC(x$coefficients[-1], digits =2, format = "f"), "*", nams[-1], collapse = "+"),
         "+\\epsilon_i")
  if(is.numeric(wrap)){
    out <- strsplit(out, "+", fixed = TRUE)[[1]]
    lens <- nchar(out)
    out <- paste0(
      paste0(out[1:(which(cumsum(lens) > wrap)[1]-1)], collapse = "+"),
      "+\n",
      paste0(out[((which(cumsum(lens) > wrap)[1])):length(out)], collapse = "+"))
    
  }
  out
}
