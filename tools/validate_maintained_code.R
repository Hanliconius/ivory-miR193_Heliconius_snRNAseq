# Parse maintained code without executing analyses; report dependency availability.
args <- commandArgs(TRUE)
root <- if (length(args)) normalizePath(args[1], mustWork=TRUE) else normalizePath(".")
files <- sort(unique(unlist(lapply(c("scripts", "tools"), function(d)
  list.files(file.path(root, d), pattern="\\.[Rr]$", recursive=TRUE, full.names=TRUE)))))
if (!length(files)) stop("No maintained R files found; check repository root")
packages <- character()
walk <- function(x) {
  if (is.call(x)) {
    op <- if (is.symbol(x[[1]])) as.character(x[[1]]) else ""
    if (op %in% c("library", "require", "requireNamespace", "::", ":::") && length(x) >= 2L) {
      p <- x[[2]]
      if ((is.symbol(p) && op != "requireNamespace") || (is.character(p) && length(p) == 1L))
        packages <<- union(packages, as.character(p))
    }
  }
  if (is.call(x) || is.expression(x) || is.pairlist(x))
    for (i in seq_along(x)) {
      if (identical(x[[i]], quote(expr=))) next
      if (!is.symbol(x[[i]])) walk(x[[i]])
    }
}
failed <- 0L
for (p in files) {
  tryCatch(walk(parse(file=p)), error=function(e) {
    failed <<- failed + 1L
    cat("PARSE_FAIL", substring(p, nchar(root)+2L), conditionMessage(e), "\n")
  })
}
cat("MAINTAINED_R_FILES", length(files), "PARSE_FAILURES", failed, "\n")
# SCTransform's backend is an analysis requirement even without a direct library call.
packages <- sort(union(packages, "sctransform"))
missing <- character()
for (p in packages) {
  available <- requireNamespace(p, quietly=TRUE)
  if (!available) missing <- c(missing, p)
  cat("PACKAGE", p, if (available) as.character(packageVersion(p)) else "MISSING", "\n")
}
print(sessionInfo())
cat("FULL_DATA_REPRODUCTION NOT_RUN\n")
quit(status=if (failed) 1L else if (length(missing)) 2L else 0L)
