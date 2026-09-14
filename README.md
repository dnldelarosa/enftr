# enftr 0.9.0

ENFT tradicional en R: períodos y claves validados, indicadores laborales y educativos, ingresos y pobreza histórica, y diccionarios versionados. Incluye únicamente registros de ejemplo inventados.


```r
library(enftr)
resultado <- ft_pobreza_monetaria(enft_like)
table(resultado$pobreza_estado)
```

Consulte [primeros pasos](articles/enftr.html), [revisiones del diccionario](articles/diccionario.html), [pobreza histórica](articles/pobreza-monetaria.html), [indicadores](articles/indicadores.html) y [despliegue](articles/deployment.html). Cada guía y página de referencia tiene su edición en inglés.

La pobreza cubre 2005/1–2016/2 y no está certificada contra el programa oficial de producción ENFT. El diccionario incluye 120 definiciones de origen; siguen sin documentarse las categorías de S3B_P10.
