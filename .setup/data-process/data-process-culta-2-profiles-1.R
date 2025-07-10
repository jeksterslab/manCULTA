data_process_culta_2_profiles_1 <- function(overwrite = FALSE) {
  wd <- getwd()
  on.exit(
    setwd(wd)
  )
  root <- rprojroot::is_rstudio_project
  data_process_culta_2_profiles_1_out <- root$find_file(
    ".setup",
    "data-process",
    "data-process-culta-2-profiles-1.out"
  )
  if (!file.exists(data_process_culta_2_profiles_1_out)) {
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
    data_process_culta_2_profiles_1_inp <- root$find_file(
      ".setup",
      "data-process",
      "data-process-culta-2-profiles-1.inp"
    )
    data <- "data.txt"
    estimates <- "data-process-culta-2-profiles-1.estimates"
    results <- "data-process-culta-2-profiles-1.results"
    tech3 <- "data-process-culta-2-profiles-1.tech3"
    tech4 <- "data-process-culta-2-profiles-1.tech4"
    cprob <- "data-process-culta-2-profiles-1.cprob"
    con <- file(data_process_culta_2_profiles_1_inp)
    input <- readLines(con)
    close(con)
    input <- gsub(
      pattern = "__DATA__",
      replacement = data,
      x = input
    )
    input <- gsub(
      pattern = "__ESTIMATES__",
      replacement = estimates,
      x = input
    )
    input <- gsub(
      pattern = "__RESULTS__",
      replacement = results,
      x = input
    )
    input <- gsub(
      pattern = "__TECH3__",
      replacement = tech3,
      x = input
    )
    input <- gsub(
      pattern = "__TECH4__",
      replacement = tech4,
      x = input
    )
    input <- gsub(
      pattern = "__CPROB__",
      replacement = cprob,
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
    on.exit(
      unlink(input_fn_name)
    )
    con <- file(input_fn_name)
    writeLines(input, con = con)
    close(con)
    mplus_bin <- Sys.which("mplus")
    if (!(mplus_bin == "")) {
      setwd(data_process)
      if (.Platform$OS.type == "windows") {
        nullfile <- "NUL"
      } else {
        nullfile <- "/dev/null"
      }
      system2(
        command = mplus_bin,
        args = c(
          input_fn_name,
          data_process_culta_2_profiles_1_out
        ),
        stdout = nullfile,
        stderr = nullfile
      )
    } else {
      message("The `mplus` command is not available in the system.")
    }
  }
}
data_process_culta_2_profiles_1()
rm(data_process_culta_2_profiles_1)
