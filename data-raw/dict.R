dict0 <- list(
  EFT_ACEPTARIA_TRAB_SEM_ANT = list(
    lab = "¿Pudiera haber aceptado un trabajo la semana pasada si le hubieran ofrecido uno?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_AGUA_RED_PUBLICA = list(
    lab = "¿Tiene esta vivienda instalación para agua corriente por tubería conectada a la red pública?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_ALFABETISMO = list(
    lab = "¿Sabe leer y escribir?",
    labs = c("No aplica" = 0, "Sí" = 1, "No" = 2)
  ),
  EFT_CANT_PERS_TRAB = list(
    lab = "¿Cuántas personas trabajan o trabajaban en ese negocio, actividad económica o empresa?",
    labs = c(
      "1 persona" = 1,
      "2 a 4 personas" = 2,
      "5 a 10 personas" = 3,
      "11 a 19 personas" = 4,
      "20 a 30 personas" = 5,
      "31 a 50 personas" = 6,
      "51 y más personas" = 7
    )
  ),
  EFT_CATEGORIA_OCUP_PRINC = list(
    lab = "En esa ocupación, ¿usted es? (o usted era, para los desempleados)",
    labs = c(
      "Empleado u obrero del Gobierno general" = 1,
      "Empleado u obrero de empresas públicas" = 2,
      "Empleado u obrero de empresas privadas" = 3,
      "Trabajador por cuenta propia profesional" = 4,
      "Trabajador por cuenta propia no profesional" = 5,
      "Patrón de empresas no constituidas en sociedades" = 6,
      "Ayudante familiar o no familiar no remunerado" = 7,
      "Servicio doméstico" = 8
    )
  ),
  EFT_EDAD = list(
    lab = "Edad de la persona"
  ),
  EFT_PROVINCIA = list(
    lab = "Provincia",
    labs = c(
      "Distrito Nacional" = 1, "Azua" = 2, "Bahoruco" = 3, "Barahona" = 4,
      "Dajabón" = 5, "Duarte" = 6, "Elías Piña" = 7,
      "El Seibo" = 8, "Espaillat" = 9, "Independencia" = 10,
      "La Altagracia" = 11, "La Romana" = 12, "La Vega" = 13,
      "María Trinidad Sánchez" = 14, "Monte Cristi" = 15,
      "Pedernales" = 16, "Peravia" = 17, "Puerto Plata" = 18, "Salcedo" = 19,
      "Samaná" = 20, "San Cristóbal" = 21, "San Juan" = 22,
      "San Pedro de Macorís" = 23, "Sánchez Ramírez" = 24,
      "Santiago" = 25, "Santiago Rodríguez" = 26, "Valverde" = 27,
      "Monseñor Nouel" = 28, "Monte Plata" = 29, "Hato Mayor" = 30,
      "San José de Ocoa" = 31, "Santo Domingo" = 32
    )
  ),
  EFT_TRABAJO_SEM_ANT = list(
    lab = "¿Trabajó o realizó una actividad económica por lo menos una hora la semana pasada?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_TUVO_ACT_ECON_SEM_ANT = list(
    lab = "Aunque no trabajó la semana pasada ¿tenía algún empleo, negocio o actividad?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_CULTIVO_SEM_ANT = list(
    lab = "¿La semana pasada, ¿Cultivó, cosechó, o cuidó ganado?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_ELAB_PROD_SEM_ANT = list(
    lab = "¿La semana pasada, ¿Elaboró algún producto (artesanía,comida) para la venta?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_AYUDO_FAM_SEM_ANT = list(
    lab = "¿La semana pasada, ¿Ayudó algún familiar en su negocio,empresa o finca?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_BUSCO_TRAB_SEM_ANT = list(
    lab = "¿La semana pasada, ¿Buscaría un trabajo?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_COSIO_LAVO_SEM_ANT = list(
    lab = "¿Buscó trabajo la semana pasada o estuvo tratando de establecer su propio negocio, actividad económica o empresa?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_OCUPACION_PRINC = list(
    lab = "¿Cuál es el oficio u ocupación principal que realiza o realizó en su último trabajo?"
  ),
  EFT_SEXO = list(
    lab = "Sexo de la persona",
    labs = c("Hombre" = 1, "Mujer" = 2)
  ),
  EFT_TIENE_COND_JORNADA = list(
    lab = "¿La semana pasada habría tenido el tiempo y las condiciones necesarias para salir a trabajar?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  EFT_TRABAJO_ANTES = list(
    lab = "¿Ha trabajado antes?",
    labs = c("Sí" = 1, "No" = 2)
  ),
  S1B_P2 = list(
    lab = "link::EFT_PROVINCIA",
    labs = "link::EFT_PROVINCIA"
  ),
  S1B_P4 = list(
    lab = "Zona de residencia",
    labs = c("Zona urbana" = 0, "Zona rural" = 1)
  ),
  S2_P2A = list(
    lab = "Material predominante en las paredes",
    labs = c(
      "Asbesto" = 1, "Block" = 2, "Cartón" = 3, "Concreto Armado" = 4,
      "Ladrillo" = 5, "Madera" = 6, "Mixto (block y madera)" = 7, "Plywood" = 8,
      "Tabla de Palma" = 9, "Tejamanil" = 10, "Yagua" = 11, "Zinc" = 12,
      "Materiales de desecho" = 13, "Otro" = 99
    )
  ),
  S2_P2C = list(
    lab = "Material predominante en el techo",
    labs = c(
      "Asbesto" = 1, "Concreto Armado" = 2, "Yagua" = 3,
      "Zinc" = 4, "Materiales de desecho" = 5, "Otro" = 99
    )
  ),
  S2_P2D = list(
    lab = "Material predominante en el piso",
    labs = c(
      "Cemento" = 1, "Cerámica" = 2, "Granito" = 3, "Ladrillo" = 4,
      "Madera" = 5, "Mármol" = 6, "Mosaico" = 7, "Parquet" = 8,
      "Tierra" = 9, "Otro" = 99
    )
  ),
  S2_P7A = list(
    lab = "¿Qué tipo de alumbrado se utiliza principalmente en esta vivienda?",
    labs = c(
      "Electricidad de las empresas (CDEE/EDES)" = 1, "Generación privada" = 2,
      "Planta eléctrica" = 3, "Lámpara de gas kerosén" = 4,
      "Lámpara de gas propano" = 5, "Panel solar" = 6, "Otro" = 99
    )
  ),
  S2_P9 = list(
    lab = "¿La vivenda posee?",
    labs = c(
      "Inodoro conectado a alcantarillado" = 1,
      "Inodoro conectado a pozo séptico" = 2, "Letrina" = 3, "No tiene" = 4
    )
  ),
  S3B_P4 = list(
    lab = "¿Qué edad tiene en años cumplidos?"
  ),
  S3B_P8 = list(
    lab = "¿Cuál es el último año o curso que aprobó?"
  ),
  S3B_P9 = list(
    lab = "¿A que nivel corresponde ese último año o curso que aprobó?",
    labs = c(
      "Preprimario" = 1, "Primario" = 2, "Secundario" = 3, "Vocacional" = 4,
      "Universitario" = 5, "Post-universitario" = 6, "Ninguno" = 7,
      "No aplica" = 96
    )
  ),
  S3B_P10 = list(
    lab = "¿En qué nivel se matriculó este año?",
    labs = c(
      "Preprimario" = 1, "Primario" = 2, "Secundario" = 3, "Vocacional" = 4,
      "Universitario" = 5, "Post-universitario" = 6, "Ninguno" = 7,
      "No aplica" = 96
    )
  )
)


dict1 <- list(
  ano = list(
    lab = "Año (YYYY)"
  ),
  desempleo_abierto = list(
    lab = "Población en condiciones de desempleo abierto",
    labs = c("Sí" = 1, "No" = 0)
  ),
  desempleo_ampliado = list(
    lab = "Población en condiciones de desempleo ampliado",
    labs = c("Sí" = 1, "No" = 0)
  ),
  desempleo_cesante_abierto = list(
    lab = "Población cesante en condición de desempleo abierto",
    labs = c("Sí" = 1, "No" = 0)
  ),
  desempleo_cesante_ampliado = list(
    lab = "Población cesante en condición de desempleo ampliado",
    labs = c("Sí" = 1, "No" = 0)
  ),
  desempleo_nuevo_abierto = list(
    lab = "Población nueva en condición de desempleo abierto",
    labs = c("Sí" = 1, "No" = 0)
  ),
  desempleo_nuevo_ampliado = list(
    lab = "Población nueva en condición de desempleo ampliado",
    labs = c("Sí" = 1, "No" = 0)
  ),
  grupo_ocupacion = list(
    lab = "Grupo ocupacional del empleo",
    labs = c(
      "Gerentes y Administradores" = 1,
      "Profesionales e Intelectuales" = 2,
      "Técnicos del Nivel Medio" = 3,
      "Empleados de oficina" = 4,
      "Trabajadores de los Servicios" = 5,
      "Agricultores y Ganaderos Calificados" = 6,
      "Operarios y Artesanos" = 7,
      "Operarios y Conductores" = 8,
      "Trabajadores no Calificados" = 9,
      "Población sin Grupo Ocupacional" = 10
    )
  ),
  horas_semanal = list(
    lab = "Horas trabajadas a la semana",
    labs = c("Sí" = 1, "No" = 0)
  ),
  ingreso_laboral_mensual = list(
    lab = "Ingreso laboral mensual de la población ocupada perceptora de ingresos"
  ),
  ocupado = list(
    lab = "Población ocupada",
    labs = c("Sí" = 1, "No" = 0)
  ),
  pea_abierta = list(
    lab = "Población Económicamente Activa (PEA) abierta",
    labs = c("Sí" = 1, "No" = 0)
  ),
  pea_ampliada = list(
    lab = "Población Económicamente Activa (PEA) ampliada",
    labs = c("Sí" = 1, "No" = 0)
  ),
  perceptores_ingresos = list(
    lab = "Población ocupada perceptora de ingresos",
    labs = c("Sí" = 1, "No" = 0)
  ),
  periodo = list(
    lab = "Periodo (YYYYS)"
  ),
  pet = list(
    lab = "Población en edad de trabajar",
    labs = c("Sí" = 1, "No" = 0)
  ),
  poblacion_inactiva = list(
    lab = "Población inactiva",
    labs = c("Sí" = 1, "No" = 0)
  ),
  regiones_desarrollo = list(
    lab = "Regiones de desarrollo",
    labs = c(
      "Cibao Norte" = 1, 
      "Cibao Sur" = 2, 
      "Cibao Nordeste" = 3, 
      "Cibao Noroeste" = 4, 
      "Valdesia" = 5, 
      "Enriquillo" = 6, 
      "El Valle" = 7, 
      "Yuma" = 8, 
      "Higuamo" = 9, 
      "Ozama o Metropolitana" = 10
    )
  ),
  sector_ocupacion = list(
    lab = "Sector de la ocupación",
    labs = c("Formal" = 1, "Informal" = 0)
  ),
  semestre = list(
    lab = "Semestre en el año (S)"
  ),
  zona = list(
    lab = "Zona de residencia",
    labs = c("Zona urbana" = 1, "Zona rural" = 2)
  ),
  zona_desarrollo_fronterizo = list(
    lab = "Zona de desarrollo fronterizo",
    labs = c(
      "Zona de desarrollo fronterizo" = 1,
      "Resto país" = 0
    )
  )
)

dict <- append(dict0, dict1)

dict <- labeler::parse_dict(dict)

usethis::use_data(dict, overwrite = TRUE)
# rm(dict, dict0, dict1)