"""Author matching Spanish/English ENFT guides and prepare both site builds."""
from pathlib import Path
import re, shutil

ROOT = Path(__file__).resolve().parents[2]
PKG = ROOT/'enftr'
PY = ROOT/'endompy'
EN = PKG/'pkgdown/i18n/en'
EN.mkdir(parents=True,exist_ok=True)
sources_es = '''La cobertura implementada se fija en el código y las tablas incluidas. Como contexto metodológico, consulte los [códigos publicados por el MEPyD](https://mepyd.gob.do/vaes/codigos-de-pobreza/) y la [metodología de pobreza de 2012 de la ONE](https://www.one.gob.do/publicaciones/2013/metodologia-calculo-pobreza-monetaria-diagnostico-y-propuesta-para-la-estimacion-de-la-pobreza-2012/). Estas referencias no certifican la equivalencia numérica de este paquete con la producción oficial de la ENFT.'''
sources_en = '''Implemented coverage is defined by the code and bundled tables. For methodological context, see [MEPyD's published programs](https://mepyd.gob.do/vaes/codigos-de-pobreza/) and the [ONE 2012 poverty methodology](https://www.one.gob.do/publicaciones/2013/metodologia-calculo-pobreza-monetaria-diagnostico-y-propuesta-para-la-estimacion-de-la-pobreza-2012/). These references do not certify numerical equivalence with official ENFT production.'''

def code(text, lang): return '\n```'+lang+'\n'+text.strip()+'\n```\n'
def sample(py):
    return ('import json\nfrom importlib.resources import files\nimport pandas as pd\nfrom endompy import enftr as ft\nx = pd.DataFrame(json.loads(files("endompy.enftr").joinpath("resources/synthetic-members.json").read_text()))'
            if py else 'library(enftr)\nx <- enft_like')

def guide(key,en=False,py=False):
    lang = 'python' if py else '{r}'
    snippets = {
      'enftr': ('result = ft.peri_vars(x)\nresult = ft.ocupado(result)\nprint(result[["EFT_PERIODO", "ano", "semestre", "ocupado"]].head())' if py else 'resultado <- ft_peri_vars(x)\nresultado <- ft_ocupado(resultado)\nhead(resultado[c("EFT_PERIODO", "ano", "semestre", "ocupado")])'),
      'diccionario': ('import sqlite3\nbase = ft.get_dict()\nwith sqlite3.connect(":memory:") as con:\n    first = ft.register_dict(con, base.draft(), "example-1", valid_from="2005-01-01", valid_to="2005-12-31")\n    draft = first.draft()\n    draft["EFT_ZONA"].label = "Zona de residencia"\n    second = ft.register_dict(con, draft, "example-2", parent_version="example-1", valid_from="2006-01-01", valid_to="2006-12-31")\n    selected = ft.get_dict(con=con, at="2006-06-01")\n    print(selected.revision()["version"])\n    a, b = first.revision()["variable_refs"], second.revision()["variable_refs"]\n    print(sum(a[k]["definition_hash"] == b[k]["definition_hash"] for k in a))' if py else 'con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")\nbase <- ft_dict()\nprimera <- ft_register_dict(con, labeler::dict_draft(base), "example-1",\n  valid_from = "2005-01-01", valid_to = "2005-12-31")\nborrador <- labeler::dict_draft(primera)\nborrador$EFT_ZONA$label <- "Zona de residencia"\nsegunda <- ft_register_dict(con, borrador, "example-2", parent_version = "example-1",\n  valid_from = "2006-01-01", valid_to = "2006-12-31")\nlabeler::dict_revision(ft_dict(con = con, at = "2006-06-01"))$version\na <- labeler::dict_revision(primera)$variable_refs\nb <- labeler::dict_revision(segunda)$variable_refs\nsum(vapply(names(a), function(k) a[[k]]$definition_hash == b[[k]]$definition_hash, logical(1)))\nDBI::dbDisconnect(con)'),
      'pobreza-monetaria': ('result = ft.pobreza_monetaria(x, keep=True)\nprint(result["pobreza_estado"].value_counts())\nprint(result[["ing_total_pobreza_monetaria", "ing_pc_pobreza_monetaria", "pobreza_monetaria"]].tail())' if py else 'resultado <- ft_pobreza_monetaria(x, .keep = TRUE)\ntable(resultado$pobreza_estado)\ntail(resultado[c("ing_total_pobreza_monetaria", "ing_pc_pobreza_monetaria", "pobreza_monetaria")])'),
      'indicadores': ('result = ft.anos_educacion(x)\nresult = ft.alfabeta(result, min_edad=15)\nresult = ft.pea_ampliada(result, min_edad=15)\nresult = ft.dominios_inferencia(result)\nprint(result[["anos_educacion", "alfabeta", "pea_ampliada", "dominios_inferencia"]].head())' if py else 'resultado <- ft_anos_educacion(x)\nresultado <- ft_alfabeta(resultado, min_edad = 15)\nresultado <- ft_pea_ampliada(resultado, min_edad = 15)\nresultado <- ft_dominios_inferencia(resultado)\nhead(resultado[c("anos_educacion", "alfabeta", "pea_ampliada", "dominios_inferencia")])')}
    data = {
      'enftr': (
        'Primeros pasos con la ENFT', 'Getting started with the ENFT',
        '''`enftr 0.9.0` y `endompy.enftr 0.4.0` procesan la encuesta tradicional semestral. La ENCFT continua utiliza otro módulo y otros contratos.

El ejemplo contiene 72 personas completamente inventadas, agrupadas en 24 hogares-período de 2000 a 2016. No permite estimar cifras nacionales. La generación usa constantes y nombres de variables, sin valores de personas encuestadas.

## Estructura y períodos

`EFT_PERIODO` acepta `1/2005`, `2005/1` y `20051`, incluso mezclados por fila. `PERIALFA` identifica la estructura antigua. Solo la separación de período y la zona admiten ambas estructuras; los demás cálculos requieren las columnas `EFT_` que aparecen en la referencia. El paquete no infiere equivalencias entre cuestionarios.

La versión de estructura, la revisión del diccionario y el identificador metodológico de pobreza son conceptos independientes. La función de versión reconoce columnas; no fecha el cuestionario.

Trabaje con tablas locales y conserve las columnas requeridas. Materialice las consultas antes de calcular. Las funciones conservan filas y orden; Python también conserva el índice, incluso cuando se repite.''',
        '''`enftr 0.9.0` and `endompy.enftr 0.4.0` process the traditional semiannual survey. The continuous ENCFT has its own module and contracts.

The example contains 72 entirely invented people in 24 household-periods from 2000 to 2016. It cannot estimate national statistics. Generation uses constants and variable names, without respondent values.

## Structure and periods

`EFT_PERIODO` accepts `1/2005`, `2005/1` and `20051`, including mixed row formats. `PERIALFA` identifies the older structure. Only period extraction and zone conversion support both structures; other calculations require the `EFT_` columns listed in the reference. No questionnaire crosswalk is inferred.

Column structure version, dictionary revision and poverty method identifier are independent. The version function identifies columns; it does not date the questionnaire.

Use local tables and retain required columns. Materialize database queries before calculating. Functions preserve rows and order; Python also preserves duplicate indexes.'''),
      'diccionario': (
        'Diccionarios y revisiones', 'Dictionaries and revisions',
        '''La revisión incluida `baseline-1` registra las 120 definiciones disponibles. No afirma cobertura de todas las variables ni vigencia histórica. La selección por fecha requiere revisiones con intervalos documentados; una fecha desconocida o ambigua produce un error.

## Cambios parciales entre ediciones

Cada edición resuelve un diccionario completo. El registro reutiliza las definiciones que no cambian y añade únicamente las nuevas definiciones, conservando identificadores y hashes. Cambiar una etiqueta no obliga a duplicar las otras 119. Las revisiones publicadas son inmutables: para editar, cree un borrador y registre una nueva versión.

Las fechas del ejemplo siguiente son inventadas para mostrar la API. No representan cambios documentados de la ENFT. El registro SQLite pertenece al usuario.

## Pendiente identificado en el diccionario de origen

`S3B_P10` enlazaba con `EFT_SE_MATRICULO`, una definición inexistente. Se conserva la pregunta escrita por el autor y no se asignan códigos de categoría inventados. El detalle aparece en `metadata.unresolved_legacy_links`. También se normalizaron las tildes y los escapes Unicode heredados. Las advertencias de compatibilidad temporal siguen disponibles al etiquetar.''',
        '''Bundled revision `baseline-1` registers the 120 available definitions. It does not claim full variable coverage or historical applicability. Date selection requires documented intervals; an unknown or ambiguous date raises an error.

## Partial changes between editions

Each edition resolves a complete dictionary. The registry reuses unchanged definitions and adds only changed definitions, retaining stable identifiers and hashes. Changing one label does not duplicate the other 119 definitions. Registered revisions are immutable: create a draft and register a new version to edit them.

Dates in this example are invented API demonstrations, not documented ENFT questionnaire changes. The caller owns the SQLite registry.

## Identified gap in the source dictionary

`S3B_P10` linked to the nonexistent `EFT_SE_MATRICULO` definition. The author's question wording is preserved; no category codes are invented. Details are stored in `metadata.unresolved_legacy_links`. Legacy accents and Unicode escapes have also been normalized. Historical compatibility warnings remain available when labeling.

Survey labels are retained in their original Spanish in both documentation editions.'''),
      'pobreza-monetaria': (
        'Ingresos y pobreza histórica', 'Income and historical poverty',
        '''El identificador `enftr-historical-2005-2016-v2` corresponde a la implementación histórica del paquete, con correcciones de integridad y remesas. No se presenta como reproducción certificada del programa oficial.

## Unidades, claves y cobertura

Los 34 componentes suman ingreso individual mensual en pesos dominicanos. El ingreso per cápita es la suma de los ingresos individuales del hogar dividida entre todos sus miembros presentes. Proporcione hogares completos: la tabla no permite detectar personas omitidas por un filtro previo. Las claves son período, vivienda, hogar y miembro; deben ser únicas y no faltar. Cada hogar requiere exactamente un jefe para asignarle una sola vez la renta imputada. La zona debe ser constante dentro del hogar y usar 0/1.

La clasificación cubre exclusivamente 2005/1–2016/2. Las líneas incluidas abarcan 2000–2016, pero la disponibilidad de una línea no extiende la cobertura del modelo de ingreso. Se conserva el límite inclusivo: ingreso igual a la línea extrema pertenece a categoría 1; igual a la línea general pertenece a categoría 2.

| Salida | Significado |
|---|---|
| `1` | Pobreza extrema |
| `2` | Pobreza moderada |
| `3` | No pobre |
| `NA` + `outside_coverage` | Fuera del intervalo implementado |
| `NA` + `missing_income` | Al menos un miembro tiene ingreso total desconocido |

## Fuentes y faltantes

`ing_ext` admite múltiples transacciones por persona; un registro ausente representa ausencia de transacción, mientras que un importe `NA` conserva el ingreso desconocido. `remesas` requiere una fila por persona con seis casillas. La moneda y el IPC deben estar disponibles para todo importe positivo: una referencia desconocida detiene el cálculo. En otros componentes se mantienen las reglas históricas de recodificación de faltantes, documentadas en la referencia; no todo `NA` del cuestionario indica una respuesta faltante, pues también existen saltos.

En el primer semestre, las casillas PER4/PER5/PER6 corresponden a diciembre, noviembre y octubre del año anterior. Hasta 2007/1 se multiplica por frecuencia y se divide entre 12; desde 2007/2 se divide entre 6. Solo se leen las seis casillas, sin confundir otros campos cuyo nombre comienza por `EFT_MONTO`.

Por defecto se recalculan los componentes. `.reuse` en R y `reuse` en Python permiten reutilización explícita: quien los proporciona responde por sus unidades y vigencia. `.keep`/`keep` conserva componentes para auditoría. Las líneas se unen por período y zona, aunque la entrada ya contenga resultados anteriores.

'''+sources_es,
        '''Identifier `enftr-historical-2005-2016-v2` denotes the package's historical implementation with integrity and remittance corrections. It is not claimed to reproduce the official program with certified equivalence.

## Units, keys and coverage

The 34 components sum monthly individual income in Dominican pesos. Per capita income is household income divided by all members present. Supply complete households: omitted members cannot be detected from a filtered table. Period, dwelling, household and member form a unique, nonmissing key. Each household needs exactly one head so imputed rent is assigned once. Zone must be constant within a household and coded 0/1.

Classification covers only 2005/1–2016/2. Bundled lines cover 2000–2016, but available lines do not extend the income model. Boundaries are inclusive: income equal to the extreme line is category 1; income equal to the general line is category 2.

| Output | Meaning |
|---|---|
| `1` | Extreme poverty |
| `2` | Moderate poverty |
| `3` | Nonpoor |
| `NA` + `outside_coverage` | Outside the implemented interval |
| `NA` + `missing_income` | At least one member has unknown total income |

## Sources and missing values

`ing_ext` accepts multiple transactions per person. An absent record means no transaction; a missing amount preserves unknown income. `remesas` requires one row per person with six slots. Every positive amount needs valid exchange-rate and CPI references; unknown references stop calculation. Other components retain their historical missing-value recoding rules, documented in the reference. Questionnaire skips and missing responses are not interchangeable.

For semester 1, PER4/PER5/PER6 refer to December, November and October of the prior year. Through 2007/1, multiply by frequency and divide by 12; from 2007/2, divide by 6. Only the six defined slots are used, excluding unrelated `EFT_MONTO` columns.

Components are recalculated by default. R `.reuse` and Python `reuse` explicitly trust supplied components and their units/applicability. `.keep`/`keep` retains components for audit. Lines are matched by period and zone even if previous results are present.

'''+sources_en),
      'indicadores': (
        'Indicadores y compatibilidad', 'Indicators and compatibility',
        '''Los indicadores conservan las codificaciones del cuestionario tradicional. `min_edad` vale 15 por defecto y debe ser un entero no negativo; ajústelo solo si la definición analítica lo requiere. La población ocupada tiene prioridad sobre las preguntas de búsqueda de otro trabajo al clasificar desempleo.

Los años de educación conservan la estructura histórica: nivel 2 usa el grado aprobado; niveles 3 y 4 añaden 8; nivel 5 añade 12; nivel 6 añade 16. Menores de cuatro años y códigos no reconocidos producen `NA`. No se sustituye esta estructura por la de la ENCFT.

Las categorías ocupacionales cambian en 2005; los dominios de inferencia combinan los tramos 2000/1–2003/1, 2003/2–2007/2 y 2008/1–2016/2. La función compuesta calcula el período antes de elegir el tramo. Las funciones de mapeo regional por decreto son transformaciones de códigos históricos.

## R y Python

Python ofrece las funciones sin prefijo y los alias `ft_` de R, además de `EnftDataFrame`. Los alias antiguos de período, zona y etiquetado siguen disponibles. Los conectores `ft_db_connect` y `ft_dbConnect` son específicos de R y su configuración Dmisc; Python recibe tablas pandas cargadas por el usuario. El operador `%>%` pertenece a R. Los algoritmos privados no se convierten en API pública.

La paridad se verifica con 144 filas sintéticas que recorren ramas y 72 personas agrupadas para ingresos y pobreza. Es evidencia de consistencia del software, no validación de estimaciones nacionales.''',
        '''Indicators retain the traditional questionnaire codes. `min_edad` defaults to 15 and must be a nonnegative integer; change it only when the analytical definition requires it. Employed status takes precedence over questions about searching for another job when classifying unemployment.

Years of education retain the historical structure: level 2 uses approved grade; levels 3 and 4 add 8; level 5 adds 12; level 6 adds 16. Children younger than four and unrecognized levels produce missing values. The ENCFT structure is not substituted.

Occupational categories change in 2005. Combined inference domains use 2000/1–2003/1, 2003/2–2007/2 and 2008/1–2016/2. The combined function derives the period before selecting a segment. Decree-specific regional functions transform historical geographic codes.

## R and Python

Python provides unprefixed functions, R-style `ft_` aliases and `EnftDataFrame`. Older period, zone and labeling aliases remain available. `ft_db_connect` and `ft_dbConnect` belong to R's Dmisc configuration; Python receives user-loaded pandas tables. `%>%` is an R operator. Private algorithms are not promoted to public API.

Parity uses 144 invented branch cases and 72 grouped synthetic people for income and poverty. This establishes software consistency, not validation of national estimates.''')}
    title_es,title_en,body_es,body_en = data[key]
    title,body = (title_en,body_en) if en else (title_es,body_es)
    return title, body+'\n\n'+('## Runnable example' if en else '## Ejemplo ejecutable')+code(sample(py)+'\n'+snippets[key],lang)

deploy_es = '''La entrega separa el código instalable, las dependencias propias, la documentación y la evidencia de validación. Requiere R >= 4.1, labeler >= 0.11.0 y Dmisc >= 0.4.0; Python >= 3.9, pandas >= 1.5, numpy >= 1.21 y labelerpy >= 0.2.1. Las demás dependencias declaradas deben estar instaladas.

## Instalación desde la entrega

```r
install.packages("Dmisc_0.4.0.zip", repos = NULL, type = "win.binary")
install.packages("labeler_0.11.0.zip", repos = NULL, type = "win.binary")
install.packages("enftr_0.9.0.zip", repos = NULL, type = "win.binary")
```

En otros sistemas use los archivos fuente `.tar.gz` con `type = "source"`.

```text
python -m pip install labelerpy-0.2.1-py3-none-any.whl endompy-0.4.0-py3-none-any.whl
```

## Sitios estáticos

Publique el contenido de `sites/r` para pkgdown y de `sites/python` para Python, conservando la subcarpeta `en`. La página inicial está en español. El selector de idioma lleva a la página equivalente. Compruebe la ruta base y los enlaces canónicos antes de publicar bajo otro dominio. La compilación y la entrega local no publican nada.

Desde el workspace ENDOM se reproducen las verificaciones con `Rscript enftr/scripts/check-release.R`, `Rscript enftr/scripts/build-docs.R` y `python endompy/scripts/build-docs.py`. Los scripts de auditoría de sitios comprueban páginas equivalentes, recursos, enlaces, anclas y búsqueda. `python -m pytest endompy/tests` ejecuta también la regresión de ENCFT.

## Datos y límites

El paquete y la entrega pública incluyen únicamente ejemplos inventados. Los respaldos originales de desarrollo no forman parte de la entrega. Una revisión de diccionario sin fechas no debe seleccionarse por fecha. La falta de equivalencia certificada con el programa oficial de ENFT debe mantenerse visible en cualquier publicación del método.
'''
deploy_en = '''The delivery separates installable packages, first-party dependencies, documentation and validation evidence. Requires R >= 4.1, labeler >= 0.11.0 and Dmisc >= 0.4.0; Python >= 3.9, pandas >= 1.5, numpy >= 1.21 and labelerpy >= 0.2.1. Other declared dependencies must be installed.

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
'''

for en in (False,True):
    folder = EN if en else PKG
    (folder/'vignettes').mkdir(parents=True,exist_ok=True)
    for key in ('enftr','diccionario','pobreza-monetaria','indicadores'):
        title,body = guide(key,en)
        front = f'---\ntitle: "{title}"\noutput: rmarkdown::html_vignette\nvignette: >\n  %\\VignetteIndexEntry{{{title}}}\n  %\\VignetteEngine{{knitr::rmarkdown}}\n  %\\VignetteEncoding{{UTF-8}}\n---\n\n'
        (folder/'vignettes'/f'{key}.Rmd').write_text(front+body,encoding='utf-8')
        title,body = guide(key,en,True)
        (PY/'docs'/('en' if en else 'es')/('enft-'+key+'.md')).write_text('# '+title+'\n\n'+body,encoding='utf-8')
    deployment = deploy_en if en else deploy_es
    (folder/'DEPLOYMENT.md').write_text(deployment,encoding='utf-8')
    title = 'Deployment' if en else 'Despliegue'
    (folder/'vignettes/deployment.Rmd').write_text(f'---\ntitle: "{title}"\noutput: rmarkdown::html_vignette\nvignette: >\n  %\\VignetteIndexEntry{{{title}}}\n  %\\VignetteEngine{{knitr::rmarkdown}}\n  %\\VignetteEncoding{{UTF-8}}\n---\n\n'+deployment,encoding='utf-8')
    (folder/'README.md').write_text('# enftr 0.9.0\n\n'+('Traditional ENFT in R: validated semesters and member keys, labour and education indicators, historical income and poverty, and versioned dictionaries. Includes only invented example records.\n\n' if en else 'ENFT tradicional en R: períodos y claves validados, indicadores laborales y educativos, ingresos y pobreza histórica, y diccionarios versionados. Incluye únicamente registros de ejemplo inventados.\n\n')+
        code('library(enftr)\nresultado <- ft_pobreza_monetaria(enft_like)\ntable(resultado$pobreza_estado)','r')+'\n'+('Read [getting started](articles/enftr.html), [dictionary revisions](articles/diccionario.html), [historical poverty](articles/pobreza-monetaria.html), [indicators](articles/indicadores.html) and [deployment](articles/deployment.html). The English edition mirrors every Spanish guide and reference page.\n\n' if en else 'Consulte [primeros pasos](articles/enftr.html), [revisiones del diccionario](articles/diccionario.html), [pobreza histórica](articles/pobreza-monetaria.html), [indicadores](articles/indicadores.html) y [despliegue](articles/deployment.html). Cada guía y página de referencia tiene su edición en inglés.\n\n')+
        ('Poverty covers 2005/1–2016/2 and has not been certified against the official ENFT production program. Dictionary coverage is 120 authored definitions; category labels for S3B_P10 remain undocumented.\n' if en else 'La pobreza cubre 2005/1–2016/2 y no está certificada contra el programa oficial de producción ENFT. El diccionario incluye 120 definiciones de origen; siguen sin documentarse las categorías de S3B_P10.\n'),encoding='utf-8')
    config = '''url: https://endomer-py.github.io/enftr/'''+('en/' if en else '')+f'''\nlang: {'en' if en else 'es'}
template:
  bootstrap: 5
  bootswatch: flatly
navbar:
  structure:
    left: [intro, reference, articles, news]
    right: [search, github]
  components:
    intro:
      text: {'Home' if en else 'Inicio'}
      href: index.html
articles:
  - title: {'Guides' if en else 'Guías'}
    navbar: ~
    contents: [enftr, diccionario, pobreza-monetaria, indicadores, deployment]
'''
    (folder/'_pkgdown.yml').write_text(config,encoding='utf-8')
    (folder/'NEWS.md').write_text('# enftr 0.9.0\n\n'+(
        '- Validate mixed semester formats and member keys. Preserve unknown household income.\n- Fix prior-year remittance months and occupied/unemployed precedence.\n- Register 120 dictionary definitions with immutable revisions and shared definitions.\n- Replace respondent-derived example data with entirely invented records.\n- Add bilingual guides, reference, reproducible checks and endompy.enftr parity.\n- Keep the 2005–2016 historical poverty scope explicit; no official certification claimed.\n'
        if en else '- Valida formatos semestrales mezclados y claves; conserva ingresos desconocidos.\n- Corrige el año previo en remesas y la prioridad de ocupación frente a desempleo.\n- Registra 120 definiciones con revisiones inmutables y reutilización de definiciones.\n- Sustituye el ejemplo derivado de encuestados por registros enteramente inventados.\n- Añade guías y referencia bilingüe, verificación reproducible y paridad con endompy.enftr.\n- Explicita el alcance histórico 2005–2016 y la ausencia de certificación oficial.\n'),encoding='utf-8')

# Preserve the established publication address and reuse the checked site workflow.
for script in ('build-docs.R','check-release.R','check-sites.py'):
    source = (ROOT/'encftr/scripts'/script).read_text(encoding='utf-8')
    source = source.replace('encftr','enftr').replace('ENCFT','ENFT').replace('encft','enft').replace('artifacts/enftr-release','artifacts/enft-release')
    if not (PKG/'scripts'/script).exists(): (PKG/'scripts'/script).write_text(source,encoding='utf-8')
ignore = (PKG/'.Rbuildignore').read_text()
for pattern in (r'^scripts$',r'^renv$',r'^renv\.lock$',r'^\.Rprofile$',r'^\.git$',r'^DEPLOYMENT\.md$'):
    if pattern not in ignore: ignore += '\n'+pattern
(PKG/'.Rbuildignore').write_text(ignore+'\n',encoding='utf-8')

# Keep ENCFT content and add ENFT navigation; all package version labels are current.
for path in (PY/'scripts/build-docs.py',PY/'mkdocs.yml',PY/'README.md',PY/'DEPLOYMENT.md'):
    text = path.read_text(encoding='utf-8').replace('0.3.0','0.4.0')
    if path.name == 'build-docs.py' and 'enft-enftr.md' not in text:
        text = text.replace('{"ENCFT": "encftr.md"},','{"ENCFT": "encftr.md"},\n                {"ENFT": [{"Inicio" if lang == "es" else "Start": "enft-enftr.md"},\n                          {"Diccionario" if lang == "es" else "Dictionary": "enft-diccionario.md"},\n                          {"Pobreza" if lang == "es" else "Poverty": "enft-pobreza-monetaria.md"},\n                          {"Indicadores" if lang == "es" else "Indicators": "enft-indicadores.md"},\n                          {"API ENFT": "enft-reference.md"}]},')
    path.write_text(text,encoding='utf-8')
for lang in ('es','en'):
    path = PY/'docs'/lang/'index.md'
    text = path.read_text(encoding='utf-8').replace('0.3.0','0.4.0')
    if 'enft-enftr.md' not in text: text += '\n\n## ENFT\n\n'+('El módulo para la encuesta tradicional incluye períodos semestrales, indicadores e ingresos históricos, pobreza 2005–2016 y diccionarios versionados. Consulte la [guía ENFT](enft-enftr.md) y la [referencia](enft-reference.md).\n' if lang == 'es' else 'The traditional survey module provides semester contracts, indicators, historical income, 2005–2016 poverty and dictionary revisions. Read the [ENFT guide](enft-enftr.md) and [reference](enft-reference.md).\n')
    path.write_text(text,encoding='utf-8')
readme = PY/'README.md'
text = readme.read_text(encoding='utf-8')
if 'enftr 0.9.0' not in text: text += '\nThe traditional ENFT module matches enftr 0.9.0. See [Spanish](docs/es/enft-enftr.md) and [English](docs/en/enft-enftr.md) guides for semester contracts, historical income/poverty and dictionary revisions.\n'
readme.write_text(text,encoding='utf-8')
print('Authored five paired R guides and four paired Python ENFT guides; build workflows prepared.')
