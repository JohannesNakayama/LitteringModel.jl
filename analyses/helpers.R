theme_thesis <- function(plot_margin = 15, design = 0) {
  specs <- theme_minimal() +
    theme(
      plot.title = element_text(size = 14, margin = margin(b = 10)),
      plot.margin = margin(t = plot_margin, b = plot_margin, l = plot_margin, r = plot_margin),
      panel.grid.minor = element_blank(),
      axis.line = element_line(color = "black", size = 0.3),
      axis.title.x = element_text(size = 11, margin = margin(t = 10, b = 10)),
      axis.title.y = element_text(size = 11, margin = margin(r = 10)),
      axis.text.x = element_text(size = 8),
      axis.text.y = element_text(size = 8),
      panel.spacing = unit(1.2, "lines")
    )
  if (design == 1) {
    specs <- specs +
    theme(
      plot.background = element_rect(fill = "grey98", color = "transparent"),
      panel.background = element_rect(fill = "grey93", color = "transparent"),
      panel.grid.major = element_line(color = "grey89")
    )
  } else if (design == 2) {
    specs <- specs +
    theme(
      plot.background = element_rect(fill = "grey98", color = "transparent"),
      panel.grid.major = element_line(color = "grey89")
    )
  } else if (design == 3) {
    specs <- specs +
    theme(
      panel.background = element_rect(fill = "grey98", color = "transparent"),
      panel.grid.major = element_line(color = "grey89")
    )
  }
  return(specs)
}

theme_thesis_arrange <- function(plot_margin = 15, design = 0) {
  specs <- theme(
    plot.margin = margin(t = plot_margin, b = plot_margin, l = plot_margin, r = plot_margin)
  )
  if (design == 1 | design == 2) {
    specs <- specs +
      theme(
        plot.background = element_rect(fill = "grey98", color = "transparent")
      ) 
  }
  return(specs)
}

strip_varname <- function(x) {return(sub("X[0-9]+.", "", x))}

standard_error <- function(x) {return(sd(x) / sqrt(n()))}

save_plot <- function(filename = "default", width = 8, height = 5, dpi = 50) {
    ggsave(
      file.path("graphics", "pdf", paste0(filename, ".pdf")), 
      width = width, height = height, units = "in", dpi = dpi
    )  
    ggsave(
      file.path("graphics", "png", paste0(filename, ".png")), 
      width = width, height = height, units = "in", dpi = dpi
    )  
}