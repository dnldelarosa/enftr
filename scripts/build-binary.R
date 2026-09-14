# Run after check-release.R; install and verify the exact Windows binary.
Sys.setenv(RENV_CONFIG_AUTOLOADER_ENABLED="false",LC_ALL="English_United States.utf8")
workspace <- normalizePath(".",winslash="/")
root <- file.path(workspace,"artifacts/enft-release/package")
.libPaths(c(file.path(workspace,"artifacts/dmisc-release/package/zip-installed"),
 file.path(workspace,"artifacts/dmisc-release/library"),file.path(workspace,"artifacts/labeler/bilingual/package/labeler.Rcheck"),.libPaths()))
Sys.setenv(R_LIBS=paste(.libPaths(),collapse=.Platform$path.sep))
lib <- file.path(root,"binary-library"); dir.create(lib,showWarnings=FALSE)
setwd(root)
r <- file.path(R.home("bin"),"R.exe")
status <- system2(r,c("CMD","INSTALL","--build",paste0("--library=",shQuote(lib)),"enftr_0.9.0.tar.gz"))
if (status != 0L) stop("Windows binary build failed")
installed <- file.path(root,"zip-installed");dir.create(installed,showWarnings=FALSE)
install.packages("enftr_0.9.0.zip",repos=NULL,type="win.binary",lib=installed)
.libPaths(c(installed,.libPaths()))
library(enftr)
stopifnot(normalizePath(find.package("enftr")) == normalizePath(file.path(installed,"enftr")))
x <- enft_like
result <- ft_pobreza_monetaria(x,.keep=TRUE)
stopifnot(nrow(result)==72,sum(result$pobreza_estado=="classified")==54,
 labeler::dict_revision(ft_dict())$version=="baseline-1",length(setdiff(names(ft_dict()),"metadata"))==120)
jsonlite::write_json(list(package="enftr",version=as.character(packageVersion("enftr")),
 library=find.package("enftr"),labeler=as.character(packageVersion("labeler")),
 rows=nrow(x),classified=54,outside_coverage=18,binary="enftr_0.9.0.zip",
 dictionary_hash=labeler::dict_revision(ft_dict())$content_hash),
 file.path(root,"binary-install-audit.json"),auto_unbox=TRUE,pretty=TRUE)
cat("Verified the installed Windows binary.\n")
