
library(shiny)

ui <- basicPage(
  plotOutput("plot1",
             click = "plot_click",
             dblclick = "plot_dblclick",
             hover = "plot_hover",
             brush = "plot_brush"
  )
)

server <- function(input, output) {
  prev_vals <- NULL
  structures <- reactiveValues(data = data.frame(box_id = numeric(), xmin = numeric(), ymin = numeric(), xmax = numeric(), xmax = numeric()))

  output$plot1 <- renderPlot({
    #img <- readJPEG("street_1.jpg", native = TRUE)
    img <- png::readPNG("images/regression_correlation.png")
    img <- grDevices::as.raster(img)
    base::plot(x = c(1, dim(img)[2]), y = c(1, dim(img)[1]), type='n', axes=FALSE, frame.plot=FALSE,ylab="", xlab = "")
    graphics::rasterImage(img,xleft = 1,ybottom = 1,xright = dim(img)[2], ytop = dim(img)[1])
    if (nrow(structures$data) > 0) {
      r <- structures$data
      rect(r$xmin, r$ymin, r$xmax, r$ymax, border = "red", lwd = 3)
    }
  }, height = dim(img)[1], width = dim(img)[2])

  observe({
    e <- input$plot_brush
    if (!is.null(e)) {
      vals <- data.frame(xmin = round(e$xmin, 1), ymin = round(e$ymin, 1), xmax = round(e$xmax, 1), ymax = round(e$ymax, 1))
      if (identical(vals,prev_vals)) return() #We dont want to change anything if the values havent changed.
      structures$data <- rbind(structures$data,cbind(data.frame(box_id = nrow(structures$data)+1),vals))
      prev_vals <<- vals
    }
  })

  output$info <- renderText({

    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", round(e$x, 1), " y=", round(e$y, 1), "\n")
    }


    xy_range_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("xmin=", round(e$xmin, 1), " xmax=", round(e$xmax, 1),
             " ymin=", round(e$ymin, 1), " ymax=", round(e$ymax, 1))
    }

    paste0(
      "click: ", xy_str(input$plot_click),
      "dblclick: ", xy_str(input$plot_dblclick),
      "hover: ", xy_str(input$plot_hover),
      "brush: ", xy_range_str(input$plot_brush)
    )

  })
}

shinyApp(ui, server)
