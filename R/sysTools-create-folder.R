.CreateFolder <- function(x) {
  if (!dir.exists(x)) {
    stop(
      paste(
        x,
        "does not exist."
      )
    )
  }
  out <- file.path(
    x,
    .RandomFolder()
  )
  if (
    !(
      dir.create(
        path = out,
        showWarnings = FALSE
      )
    )
  ) {
    stop(
      "Could not create folder."
    )
  }
  out
}
