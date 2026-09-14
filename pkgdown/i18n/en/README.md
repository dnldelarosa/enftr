# enftr 0.9.0

Traditional ENFT in R: validated semesters and member keys, labour and education indicators, historical income and poverty, and versioned dictionaries. Includes only invented example records.


```r
library(enftr)
resultado <- ft_pobreza_monetaria(enft_like)
table(resultado$pobreza_estado)
```

Read [getting started](articles/enftr.html), [dictionary revisions](articles/diccionario.html), [historical poverty](articles/pobreza-monetaria.html), [indicators](articles/indicadores.html) and [deployment](articles/deployment.html). The English edition mirrors every Spanish guide and reference page.

Poverty covers 2005/1–2016/2 and has not been certified against the official ENFT production program. Dictionary coverage is 120 authored definitions; category labels for S3B_P10 remain undocumented.
