
path_d3_format_js <- function() {
  system.file("assets/d3-format/d3-format.min.js", package = "d3.format")
}
path_utils_js <- function() {
  system.file("assets/utils.js", package = "d3.format")
}

path_locales_js <- function() {
  system.file("assets/d3-format/locale", package = "d3.format")
}


get_context <- function() {
  if (!is.null(.globals$ctx)) {
    return(.globals$ctx)
  } else {
    ctx <- V8::new_context()
    ctx$source(file = path_d3_format_js())
    ctx$source(file = path_utils_js())
    return(ctx)
  }
}

list1 <- function (x) {
  if (length(x) == 1) {
    list(x)
  } else {
    x
  }
}

check_locale <- function(x) {
  json <- list.files(path = path_locales_js())
  njson <- gsub("\\.json", "", json)
  if (!x %in% njson) {
    stop(paste(
      "Invalid locale, must be one of:",
      paste(njson, collapse = ", ")
    ), call. = FALSE)
  }
}

read_locale <- function(locale) {
  check_locale(locale)
  path <- file.path(path_locales_js(), paste0(locale, ".json"))
  jsonlite::read_json(path = path)
}

