.CheckReadLines <- function(x) {
  is.character(x) && length(x) > 0 && !all(is.na(x))
}
