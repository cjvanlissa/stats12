tmp = readClipboard()
nam <- gsub("^.+?\\((.+?)\\).*$", "\\1", grep("Candidate:", tmp, value = T))

tmp <- tmp[tmp %in% c("Correct", "Incorrect", "Not answered", "Excluded for everyone")]
fbk <- c("measurement level", "measures of central tendency (descriptive statistics)",
         "calculating with the normal distribution", "calculating with the normal distribution",
         "calculating with the sampling distribution", "sampling distribution",
         "central limit theorem", "difference between Z and t-distribution",
         "type I / type II errors", "one sided t-test", "independent samples t-test",
         "ANOVA", "F-test", "sums of squares", "correlation test", "correlation interpretation",
         "regression - predicted value", "regression - sums of squares",
         "regression - coefficient test", "regression - predicted value",
         "regression - standardized regression coefficient", "regression - dummies",
         "regression - nested models", "direction of causality", "regression - hierarchical regression test",
         "CN: post-hoc tests", "CN: contrasts", "CN: ANOVA model formula",
         "CN: ANOVA F-test", "CN: Adjusted means (not graded for everyone because the answer was ambiguous)",
         "CN: ANOVA partial eta squared", "CN: ANCOVA Adjusted means",
         "CN: ANCOVA causality", "CN: paired samples t-test", "CN: repeated measures ANOVA",
         "BE: regression - predicted value", "BE: regression - interaction term",
         "BE: regression - interaction simple slopes", "BE: logistic regression - predicted value in probability scale",
         "BE: logistic regression - predicted value in odds scale", "BE: logistic regression - predicted value in probability scale",
         "BE: logistic regression - test using confidence interval", "BE: logistic regression - interpret coefficient from multiple logistic regression",
         "BE: calculate using the normal distribution", "BE: confidence interval from one-sample t-test",
         "SS: regression - predicted value", "SS: regression - interaction term",
         "SS: regression - interaction simple slopes", "SS: reliability - item-total correlation",
         "SS: reliability", "SS: factor analysis counter-indicative items",
         "SS: factor analysis unicity", "SS: factor analysis model-implied item correlation",
         "SS: factor analysis determining number of components", "SS: determine what type of data reduction technique is used here"
)

report <- paste0("Dear ", nam, ",\n\nHere is a breakdown of your answers per question, and the topic addressed in those questions: \n\n",
                 paste0(c(paste0("General Q", 1:25), paste0("Major-specific Q", 1:10)),
                        ": ",
                        tmp[tmp %in% c("Correct", "Incorrect")],
                        ", topic: ",
                        fbk[tmp %in% c("Correct", "Incorrect")], collapse = "\n"), "\n\nBest\nCaspar")

writeClipboard(report)




# 18-1 --------------------------------------------------------------------

tmp = readClipboard()
nam <- gsub("^.+?\\((.+?)\\).*$", "\\1", grep("Candidate:", tmp, value = T))

tmp <- tmp[tmp %in% c("Correct", "Incorrect", "Not answered", "Excluded for everyone")]
fbk <- c("measurement level", "measures of central tendency (descriptive statistics)",
         "calculating with the normal distribution", "calculating with the normal distribution",
         "calculating with the sampling distribution", "sampling distribution",
         "central limit theorem", "difference between Z and t-distribution",
         "type I / type II errors", "one sided t-test", "independent samples t-test",
         "ANOVA", "F-test", "sums of squares", "correlation test", "correlation interpretation",
         "regression - predicted value", "regression - sums of squares",
         "regression - coefficient test", "regression - predicted value",
         "regression - standardized regression coefficient", "regression - dummies",
         "regression - nested models", "direction of causality", "regression - hierarchical regression test",
         "CN: post-hoc tests", "CN: contrasts", "CN: ANOVA model formula",
         "CN: ANOVA F-test", "CN: Adjusted means (not graded for everyone because the answer was ambiguous)",
         "CN: ANOVA partial eta squared", "CN: ANCOVA Adjusted means",
         "CN: ANCOVA causality", "CN: paired samples t-test", "CN: repeated measures ANOVA",
         "BE: regression - predicted value", "BE: regression - interaction term",
         "BE: regression - interaction simple slopes", "BE: logistic regression - predicted value in probability scale",
         "BE: logistic regression - predicted value in odds scale", "BE: logistic regression - predicted value in probability scale",
         "BE: logistic regression - test using confidence interval", "BE: logistic regression - interpret coefficient from multiple logistic regression",
         "BE: calculate using the normal distribution", "BE: confidence interval from one-sample t-test",
         "SS: regression - predicted value", "SS: regression - interaction term",
         "SS: regression - interaction simple slopes", "SS: reliability - item-total correlation",
         "SS: reliability", "SS: factor analysis counter-indicative items",
         "SS: factor analysis unicity", "SS: factor analysis model-implied item correlation",
         "SS: factor analysis determining number of components", "SS: determine what type of data reduction technique is used here"
)

report <- paste0("Dear ", nam, ",\n\nHere is a breakdown of your answers per question, and the topic addressed in those questions: \n\n",
                 paste0(c(paste0("General Q", 1:25), paste0("Major-specific Q", 1:10)),
                        ": ",
                        tmp[tmp %in% c("Correct", "Incorrect")],
                        ", topic: ",
                        fbk[tmp %in% c("Correct", "Incorrect")], collapse = "\n"), "\n\nBest\nCaspar")

writeClipboard(report)

