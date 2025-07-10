.RandomFile <- function() {
  paste0(
    "fn_",
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
