SHELL := /bin/bash
LIBDIR=${HOME}/Rlibs/lib
PACKAGE=knobs
VERSION=$(shell grep Version DESCRIPTION |awk '{print $$2}')
TARBALL=${PACKAGE}_${VERSION}.tar.gz
PKGDIR=.

all:
	make doc
	make build
	make install

spelling:
	Rscript -e 'spelling::spell_check_package(".")'

pkgdown:
	Rscript "inst/maintenance/pkgdown.R"
	cp -r DOCS/ ../../mrgsolve/docs/
	touch ../../mrgsolve/docs/.nojekyll

cran:
	make house
	make doc
	make build
	export _MRGSOLVE_SKIP_MODLIB_BUILD_=false
	R CMD CHECK --as-cran ${TARBALL}

readme:
	Rscript -e 'rmarkdown::render("README.Rmd")'

.PHONY: doc
doc:
	Rscript -e "roxygen2::roxygenize()"

build:
	R CMD build --md5 $(PKGDIR) --no-manual

install:
	R CMD INSTALL --install-tests ${TARBALL} -l ~/Rlibs

check:
	make house
	make doc
	make build
	R CMD check ${TARBALL} --no-manual
	make unit
