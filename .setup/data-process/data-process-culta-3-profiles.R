data_process_culta_3_profiles <- function(overwrite = FALSE) {
  root <- rprojroot::is_rstudio_project
  data_process_culta_3_profiles_out <- root$find_file(
    ".setup",
    "data-process",
    "data-process-culta-3-profiles.out"
  )
  if (!file.exists(data_process_culta_3_profiles_out)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    data_process <- root$find_file(
      ".setup",
      "data-process"
    )
    data_process_culta_3_profiles_inp <- root$find_file(
      ".setup",
      "data-process",
      "data-process-culta-3-profiles.inp"
    )
    results <- "data-process-culta-3-profiles.results"
    data <- "data.txt"
    con <- file(data_process_culta_3_profiles_inp)
    input <- readLines(con)
    close(con)
    input <- gsub(
      pattern = "__DATA__",
      replacement = data,
      x = input
    )
    input <- gsub(
      pattern = "__CORES__",
      replacement = parallel::detectCores(),
      x = input
    )
    input_fn_name <- tempfile(
      pattern = "input",
      tmpdir = tempdir(),
      fileext = ".inp"
    )
    input <- gsub(
      pattern = "__RESULTS__",
      replacement = results,
      x = input
    )
    on.exit(
      unlink(input_fn_name)
    )
    con <- file(input_fn_name)
    writeLines(input, con = con)
    close(con)
    if (!(Sys.which("mplus") == "")) {
      system(
        paste(
          "cd",
          data_process,
          "; ",
          "mplus",
          input_fn_name,
          data_process_culta_3_profiles_out
        )
      )
    } else {
      message("The `mplus` command is not available in the system.")
    }
  }
}
data_process_culta_3_profiles()
rm(data_process_culta_3_profiles)
