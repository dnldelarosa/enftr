Sys.setenv(RENV_CONFIG_AUTOLOADER_ENABLED="false",LC_ALL="English_United States.utf8")
.libPaths(c("artifacts/dmisc-release/package/zip-installed","artifacts/dmisc-release/library",
  "artifacts/labeler/bilingual/package/labeler.Rcheck",.libPaths()))
roxygen2::roxygenise("enftr")
pkgload::load_all("enftr",quiet=TRUE)
plain <- function(x) paste(unlist(x),collapse="")
docs <- list()
for (file in list.files("enftr/man","\\.Rd$",full.names=TRUE)) {
  parsed <- tools::parse_Rd(file)
  fields <- list()
  for (node in parsed) {
    tag <- attr(node,"Rd_tag")
    if (!is.null(tag) && tag %in% c("\\name","\\alias","\\title","\\description","\\usage","\\value","\\details","\\format","\\examples")) {
      fields[[substring(tag,2)]] <- c(fields[[substring(tag,2)]],plain(node))
    }
  }
  docs[[basename(file)]] <- fields
}
api <- list()
for (name in getNamespaceExports("enftr")) if (startsWith(name,"ft_")) {
  fn <- get(name,asNamespace("enftr"))
  api[[name]] <- list(parameters=names(formals(fn)),body=paste(deparse(body(fn),width.cutoff=100),collapse="\n"))
}
jsonlite::write_json(list(docs=docs,api=api),"endompy/scripts/generated/enft-reference.json",auto_unbox=TRUE,pretty=TRUE)
cat(length(api),"exported R functions documented.\n")
