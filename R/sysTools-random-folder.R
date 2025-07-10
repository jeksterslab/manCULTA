.RandomFolder <- function() {
  paste0(
    "fl_",
    paste(
      sample(
        c(letters, LETTERS, 0:9),
        size = 20,
        replace = TRUE
      ),
      collapse = ""
    )
  )
}
