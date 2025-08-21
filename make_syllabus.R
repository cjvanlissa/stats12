txt <- readLines("statistics1.Qmd")
txt <- c("---", "format: docx", "prefer-html: true", "---", "", txt)
file_qmd <- "temp_syllabus.qmd"
file_word <- "temp_syllabus.docx"
writeLines(txt, file_qmd)
file_word_out <- quarto::quarto_render(file_qmd, output_format = "all", output_file = file_word)


library(officer)
file.remove("Syllabus_Statistis_1_2.docx")
doc <- read_docx("c:/gitbook_stats12/Syllabus_intro.docx")
doc <- officer::body_replace_all_text(doc, "XXyear", paste0(format(Sys.Date(), format = "%Y"), "-", as.integer(format(Sys.Date(), format = "%Y"))+1))
doc <- officer::body_add_docx(doc, file_word)
doc <- officer::body_add_docx(doc, "c:/gitbook_stats12/Syllabus_outro.docx")
print(doc, target="Syllabus_Statistis_1_2.docx")

file.remove(file_qmd, file_word)
