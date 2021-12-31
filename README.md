
<!-- README.md is generated from README.Rmd. Please edit that file -->

# enftr <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R build
status](https://github.com/endomer/enftr/workflows/R-CMD-check/badge.svg)](https://github.com/endomer/enftr/actions)
[![Codecov test
coverage](https://codecov.io/gh/endomer/enftr/branch/main/graph/badge.svg)](https://codecov.io/gh/endomer/enftr?branch=main)
[![CRAN
status](https://www.r-pkg.org/badges/version/enftr)](https://CRAN.R-project.org/package=enftr)
<!-- badges: end -->

enftr es una interfaz para trabajar con la base de datos de la Encuesta
Nacional (tradicional) de Fuerza de Trabajo (ENFT) en R. Este paquete es
parte de [endomer](https://endomer.github.io/) un proyecto de código
abierto que busca ofrecer interfaces en R para las principales encuestas
de la República Dominicana.

## Instalación

enftr aun no está en CRAN.

<!-- You can install the released version of encftr from [CRAN](https://CRAN.R-project.org) with: -->
<!-- ``` r -->
<!-- install.packages("encftr") -->
<!-- ``` -->

Pero puedes intalar la versión de desarrollo desde
[GitHub](https://github.com/) con:

``` r
tryCatch(
  library(remotes),
  error = function(e){
    install.packages('remotes')
  }
)
remotes::install_github("endomer/enftr")
```

## Roadmap

1.  Completar el diccionario.

  <svg width="50%" height="25" xmlns="http://www.w3.org/2000/svg">
  <linearGradient id="a" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
  <stop offset="1" stop-opacity="0.1"/>
    </linearGradient>
    <rect rx="4" x="0" width="50%" height="25" fill="#555"/>
    <rect rx="4" x="0" width="10%" height="25" fill="#d9534f"/>
    <rect rx="4" width="50%" height="25" fill="url(#a)"/>
    <g fill="#fff" text-anchor="middle" font-family=DejaVu Sans,Verdana,Geneva,sans-serif font-size="14">
    <text x="5%" y="17.5">19%</text>
    </g>
    </svg>
    

2.  Agregar una función para calcular la pobreza monetaria.
3.  Agregar una función para el cálculo del ICV.
4.  Agregar validadores a las funciones para garantizar que las
    variables son del tipo y con el contenido esperado en los cálculos.
5.  Hacer que todas las funciones trabajen con conexiones a base de
    datos (Las que usan cut3 específicamente).

## Contribuye

Tienes comentarios o quieres contribuir?

Por favor, revisa las [guias de contribución (en
inglés)](https://endomer.github.io/enftr/CONTRIBUTING.html) antes de
iniciar un issue o pull request.

Por favor, observa que el proyecto `enftr` está sujeto a un [Código del
contribuyente](https://contributor-covenant.org/es/version/2/0/CODE_OF_CONDUCT.html).
Contribuyendo con el proyecto aceptas las términos y condiciones.

<hr/>

<a href="https://endomer.github.io/enftr/articles/enftr.html">
  <svg width="50%" height="30" xmlns="http://www.w3.org/2000/svg">
  <linearGradient id="a" x2="0" y2="100%">
    <stop offset="0" stop-color="#bbb" stop-opacity="0.2"/>
  <stop offset="1" stop-opacity="0.1"/>
    </linearGradient>
    <rect rx="4" x="0" width="50%" height="30" fill="#555"/>
    <rect rx="4" x="0" width="50%" height="30" fill="#00a65a"/>
    <rect rx="4" width="50%" height="30" fill="url(#a)"/>
    <g fill="#fff" text-anchor="middle" font-size="18">
    <text x="25%" y="21">Guía de inicio rápido</text>
    </g>
    </svg>
    </a>
