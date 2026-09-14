The delivery separates installable packages, first-party dependencies, documentation and validation evidence. Requires R >= 4.1, labeler >= 0.11.0 and Dmisc >= 0.4.0; Python >= 3.9, pandas >= 1.5, numpy >= 1.21 and labelerpy >= 0.2.1. Other declared dependencies must be installed.

## Install from the delivery

```r
install.packages("Dmisc_0.4.0.zip", repos = NULL, type = "win.binary")
install.packages("labeler_0.11.0.zip", repos = NULL, type = "win.binary")
install.packages("enftr_0.9.0.zip", repos = NULL, type = "win.binary")
```

On other operating systems use the source `.tar.gz` files with `type = "source"`.

```text
python -m pip install labelerpy-0.2.1-py3-none-any.whl endompy-0.4.0-py3-none-any.whl
```

## Static sites

Publish `sites/r` for pkgdown and `sites/python` for Python, retaining the `en` subdirectory. Spanish is the default edition. The language switch opens the equivalent page. Check base paths and canonical links before publishing at a different domain. Local builds and packaging do not publish anything.

From the ENDOM workspace reproduce validation with `Rscript enftr/scripts/check-release.R`, `Rscript enftr/scripts/build-docs.R` and `python endompy/scripts/build-docs.py`. Site auditors verify language counterparts, assets, links, anchors and search targets. `python -m pytest endompy/tests` also runs ENCFT regression tests.

## Data and limits

The package and public delivery contain only invented examples. Original development backups are excluded. Undated dictionary revisions cannot be selected by date. Any publication of this method should preserve the distinction between software validation and certified equivalence with official ENFT production.
