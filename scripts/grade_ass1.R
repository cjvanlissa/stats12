f <- list.files(path = "C:/Users/vanlissa/OneDrive - Tilburg University/TU/Statistics 1 and 2 (LAS) - documenten/2023/Stats12-graded", full.names = T, pattern = "^Ass.+xlsx$")

out <- lapply(f, xlsx::read.xlsx, sheetIndex = 1)
nam <- basename(f)

grades <- sapply(out, `[`, 10, 2)
grades <- as.numeric(grades)
names(grades) <- nam

df <- data.frame(name = nam[grepl("_cj.", nam, fixed = T)], cas = grades[nam[grepl("_cj.", nam, fixed = T)]])
df$name <- gsub("_cj", "", df$name)
df$tra <- grades[df$name]
cor(df$cas, df$tra)
double_codes <- table(gsub("_cj", "", nam))
any(double_codes < 2)
double_codes[double_codes < 2]
colSums(df[, 2:3] < 5.5)
sum(rowMeans(df[, 2:3] < 5.5) == .5)
sum(df$cas < 5.5)



# Prepare grades -------------------------------------------------------------

students <- read.csv("C:/Users/vanlissa/OneDrive - Tilburg University/TU/Statistics 1 and 2 (LAS) - documenten/2023/portfolio1.csv", stringsAsFactors = FALSE)

f <- list.files(path = "C:/Users/vanlissa/OneDrive - Tilburg University/TU/Statistics 1 and 2 (LAS) - documenten/2023/Stats12-graded", full.names = T, pattern = "_cj")

out <- lapply(f, xlsx::read.xlsx, sheetIndex = 1, header = FALSE)
nam <- basename(f)
grades <- do.call(rbind, lapply(out, function(i){
  #i = out[[14]]
  tab <- data.frame(t(i[4:11,2]))
  names(tab) <- c("Select suitable variables",
                  "Describe dataset", "Probability calculus on continuous variable",
                  "Hypothesis test", "Discuss results", "APA Style", "MC Questions",
                  "Final grade")
  fbk <- i[4:10, 3:ncol(i)]
  fbk <- apply(fbk, 1, tidySEM::paste2, collapse = ",")
  fbk[which(fbk == "")] <- "None"
  fbk <- paste0(paste0(c("Select suitable variables",
                             "Describe dataset", "Probability calculus on continuous variable",
                             "Hypothesis test", "Discuss results", "APA Style", "MC Questions"), ", grade: ", tab[1, -ncol(tab)], ", feedback: ", fbk), collapse = "\n")
  tab$fbk <- fbk
  tab["Final grade"] <- formatC(as.numeric(tab["Final grade"]), digits = 1, format = "f")
  ids <- na.omit(as.character(i[2, -1]))
  tab <- tab[rep(1, length(ids)), ]
  tab$`SIS.User.ID` <- ids
  tab$group = i[1,2]

  tab
}))

grades$SIS.User.ID[grades$SIS.User.ID == "858314"] <- 2091754
all(grades$SIS.User.ID %in% students$SIS.User.ID)

df_comb <- merge(grades, students, by = "SIS.User.ID")
write.csv(df_comb, "C:/Users/vanlissa/OneDrive - Tilburg University/TU/Statistics 1 and 2 (LAS) - documenten/2023/portfolio1_grades.csv", row.names = F)
# Email students ----------------------------------------------------------
library("RDCOMClient")
OutApp <- COMCreate("Outlook.Application")

for(i in 1:nrow(df_comb)){
  thisrow <- df_comb[i, ]
  outMail = OutApp$CreateItem(0)
  outMail[["subject"]] = "Grades Portfolio 1, and: register NOW for Portfolio 2!"

  outMail[["To"]] = thisrow[1,"email"]

  outMail[["body"]] =
    paste0(c(paste0("Dear ", thisrow["Name"], ","),
             "Please find the grade and feedback for portfolio assignment 1.",
             paste0("Group name: ", thisrow["group.y"]),
             paste0("Final grade: ", thisrow["Final grade"]),
             c("Good job on the assignment!", "I regret to inform you that the assignment did not yet meet the minimum standards for a passing grade. Your group will have the opportunity to revise the portfolio to receive a maximum grade of 6. If you wish to make use of this opportunity, please send me the revised document before October 13th.")[(as.numeric(thisrow["Final grade"]) < 5.5)+1],
             "URGENT: Note that the registration deadline for Assignment 2 is tomorrow; please sign up your group at http://tiny.cc/stats12_portfolio.",
             "All the best,",
             "Caspar",
             "",
             "",
             thisrow["fbk"]

             ), collapse = "\n"
    )

  ## send it
  outMail$Send()
  Sys.sleep(2)

}

# Tot hier ----------------------------------------------------------------



all(exclude_students %in% df$id)
df <- df[!df$id %in% exclude_students, ]

group_size <- 4
ngroup <- nrow(df) %/% group_size
leftovers <- (nrow(df) %% group_size)

if(leftovers > 2){
  df$group <- sample(c(rep(1:ngroup, each = group_size), rep(ngroup+1, leftovers)))
} else {
  df$group <- sample(c(rep(1:ngroup, each = group_size), sample(1:ngroup, leftovers)))
}

tuts <- rep(c("McCool", "Schuurman"), each = floor(ngroup/2))
if((ngroup %% 2) > 0){
  tuts <- c(tuts, sample(c("McCool", "Schuurman"), 1))
}

df$tutorial <- sample(tuts, ngroup)[df$group]
colSums(table(df$group, df$tutorial))

openxlsx::write.xlsx(df, "C:/Users/lissa102/surfdrive/Shared/TCSM_2020/Exams_2020/groups.xlsx")

