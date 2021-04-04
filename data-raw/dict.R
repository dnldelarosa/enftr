dict0 <- list(
   S1B_P2 = list(
     lab = "Provincia",
     labs = c("Distrito Nacional" = 1, "Azua" = 2, "Bahoruco" = 3, "Barahona" = 4,
              "Dajab\\u00f3n" = 5, "Duarte" = 6, "El\\u00EDas Pi\\u00f1a" = 7, "El Seibo" = 8,
              "Espaillat" = 9, "Independencia" = 10, "La Altagracia" = 11, "La Romana" = 12,
              "La Vega" = 13, "Mar\\u00EDa Trinidad S\\u00E1nchez" = 14, "Monte Cristi" = 15,
              "Pedernales" = 16, "Peravia" = 17, "Puerto Plata" = 18, "Salcedo" = 19,
              "Saman\\u00E1" = 20, "S\\u00E1n Crist\\u00F3bal" = 21, "San Juan" = 22,
              "San Pedro de Macor\\u00EDs" = 23, "S\\u00E1nchez Ram\\u00EDrez" = 24,
              "Santiago" = 25, "Santiago Rodr\\u00EDguez" = 26, "Valverde" = 27,
              "Monse\\u00f1or Nouel" = 28, "Monte Plata" = 29, "Hato Mayor" = 30,
              "San Jos\\u00E9 de Ocoa" = 31, "Santo Domingo" = 32)
   ),
   S1B_P4 = list(
     lab = "Zona de residencia",
     labs = c("Zona urbana" = 0, "Zona rural" = 1)
   ),
   S2_P2A = list(
     lab = "Material predominante en las paredes",
     labs = c("Asbesto" = 1, "Block" = 2, "Cart\\u00F3n" = 3, "Concreto Armado" = 4,
              "Ladrillo" = 5, "Madera" = 6, "Mixto (block y madera)" = 7, "Plywood" = 8,
              "Tabla de Palma" = 9, "Tejamanil" = 10, "Yagua" = 11, "Zinc" = 12,
              "Materiales de desecho" = 13, "Otro" = 99)
   ),
   S2_P2C = list(
     lab = "Material predominante en el techo",
     labs = c("Asbesto" = 1, "Concreto Armado" = 2, "Yagua" = 3, "Zinc" = 4, "Materiales de desecho" = 5, "Otro" = 99)
   ),
   S2_P2D = list(
     lab = "Material predominante en el piso",
     labs = c("Cemento" = 1, "Cer\\u00E1mica" = 2, "Granito" = 3, "Ladrillo" = 4,
              "Madera" = 5, "M\\u00E1rmol" = 6, "Mosaico" = 7, "Parquet" = 8, "Tierra" = 9, "Otro" = 99)
   ),
   S2_P7A = list(
     lab = "¿Qu\u00E9 tipo de alumbrado se utiliza principalmente en esta vivienda?",
     labs = c( "Electricidad de las empresas (CDEE/EDES)" = 1, "Generaci\\u00F3n privada" = 2,
               "Planta el\\u00E9ctrica" = 3, "L\\u00E1mpara de gas keros\\u00E9n" = 4, "L\\u00E1mpara de gas propano" = 5, "Panel solar" = 6, "Otro" = 99)
   ),
   S2_P8 = list(
     lab = "¿Tiene esta vivienda instalaci\u00F3n para agua corriente por tuber\u00EDa conectada a la red p\u00FAblica?",
     labs = c("Si" = 1, "No" = 2)
   ),
   S2_P9 = list(
     lab = "¿La vivenda posee?",
     labs = c( "Inodoro conectado a alcantarillado" = 1, "Inodoro conectado a pozo s\\\u00E9ptico" = 2, "Letrina" = 3, "No tiene" = 4)
   ),
   EFT_MONTO_PROBABLE_ALQ = list(
     lab = "¿Si usted tuviera que alquilar esta vivienda, en cuanto RD\\$ la alquilaria por mes?"
   ),
   S2_P14P = list(
      lab = "link::EFT_MONTO_PROBABLE_ALQ"
   ),
   S3B_P4 = list(
     lab = "¿Que edad tiene en años cumplidos?"
   ),
   S3B_P2A = list(
     lab = "¿Cuantos miembros en total tiene este hogar?"
   ),
   EFT_PARENTESCO_CON_JEFE = list(
     lab = "¿Cuál es la relación de parentesco que tiene con el jefe del hogar?",
     labs = c("Jefe" = 1, "Cónyuge" = 2, "Hijo/a" = 3, "Hijastro/a" = 4, "Nieto" = 5, "Yerno o nuera" = 6, "Padre o madre" = 7, "Suegro/a" = 8, "Hermano/a" = 9, "Abuelo/a" = 10, "Otro pariente" = 11, "No pariente" = 12, "No aplica" = 99)
   ),
   S3B_P5 = list(
      lab = "link::EFT_PARENTESCO_CON_JEFE"
   ),
   EFT_AGUA_RED_PUBLICA = list(
     lab = "link::S2_P8",
     labs = "link::S2_P8"
   ),
   S3B_P8 = list(
     lab = "Cual es el \u00FAltimo año o curso que aprob\u00F3?"
   ),
   S3B_P9 = list(
     lab = "A que nivel corresponde ese \u00FAltimo año o curso que aprob\u00F3?",
     labs = c( "Preprimario" = 1, "Primario" = 2, "Secundario" = 3, "Vocacional" = 4, "Universitario" = 5, "Post-universitario" = 6, "Ninguno" = 7, "No aplica" = 96)
   ),
   S3B_P10 = list(
     lab = "¿En que nivel se matriculo este año?",
     labs = c( "Preprimario" = 1, "Primario" = 2, "Secundario" = 3, "Vocacional" = 4, "Universitario" = 5, "Post-universitario" = 6, "Ninguno" = 7, "No aplica" = 96)
   ),
   EFT_HORAS_SEM_OCUP_PRINC = list(
     lab = "¿Cuantas horas trabaja regularmente por semana en su ocupación principal?"
   ),
   S4_P22 = list(
      lab = "link::EFT_HORAS_SEM_OCUP_PRINC"
   ),
   EFT_ING_OCUP_SECUN = list(
     lab = "En su ocupacion secundaria, ¿Cuanto ganó por concepto de sueldo, salario, jornal o ganancia?"
   ),
   S4_P27A = list(
      lab = "link::EFT_ING_OCUP_SECUN"
   ),
   EFT_ING_OCUP_PRINC = list(
     lab = "En su ocupación principal, ¿Cuanto ganó por concepto de sueldo, salario, jornal o ganancia?"
   ),
   S4_P28 = list(
      lab = "link::EFT_ING_OCUP_PRINC"
   ),
   EFT_DIAS_SEM_OCUP_PRINC = list(
     lab = "¿Cuantos días trabaja regularmente por semana?"
   ),
   S4_P28A = list(
      lab = "link::EFT_DIAS_SEM_OCUP_PRINC"
   ),
   EFT_MES_PASADO_COMISIONES = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de comisiones?"
   ),
   S4_P28B1 = list(
      lab = "link::EFT_MES_PASADO_COMISIONES"
   ),
   EFT_MES_PASADO_PROPINAS = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de propinas?"
   ),
   S4_P28B2 = list(
      lab = "link::EFT_MES_PASADO_PROPINAS"
   ),
   EFT_MES_PASADO_HORAS_EXTRAS = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de horas extras?"
   ),
   S4_P28B3 = list(
      lab = "link::EFT_MES_PASADO_HORAS_EXTRAS"
   ),
   EFT_ULT_DOCE_VACACIONES_PAGAS = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de vacaciones pagadas?"
   ),
   S4_P28B4 = list(
      lab = "link::EFT_ULT_DOCE_VACACIONES_PAGAS"
   ),
   EFT_ULT_DOCE_DIVIDENDOS = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de dividendos?"
   ),
   S4_P28B5 = list(
      lab = "link::EFT_ULT_DOCE_DIVIDENDOS"
   ),
   EFT_ULT_DOCE_BONIFICACION = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de bonificación?"
   ),
   S4_P28B6 = list(
      lab = "link::EFT_ULT_DOCE_BONIFICACION"
   ),
   EFT_ULT_DOCE_REGALIA_PASCUAL = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de regalia pascual?"
   ),
   S4_P28B7 = list(
      lab = "link::EFT_ULT_DOCE_REGALIA_PASCUAL"
   ),
   EFT_ULT_DOCE_UTILIDADES_EMP = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de utilidades empresariales?"
   ),
   S4_P28B8 = list(
      lab = "link::EFT_ULT_DOCE_UTILIDADES_EMP"
   ),
   EFT_ULT_DOCE_BENEFICIOS_MARG = list(
     lab = "¿Cuanto ganó en todas sus ocupaciones por concepto de beneficios marginales?"
   ),
   S4_P28B9 = list(
      lab = "link::EFT_ULT_DOCE_BENEFICIOS_MARG"
   ),
   EFT_PERIODO_ING_OCUP_PRINC = list(
     lab = "Periodo de ingreso ocupación principal",
     labs = c("Hora" = 1, "Día" = 2, "Semana" = 3, "Quincena" = 4, "Mes" = 5)
   ),
   S4_P28P = list(
      lab = "link::EFT_PERIODO_ING_OCUP_PRINC",
      labs = "link::EFT_PERIODO_ING_OCUP_PRINC"
   ),
   EFT_PAGO_ALIMENTOS_MONTO = list(
     lab = "Monto recibido en pago de alimentos"
   ),
   S4_P29AM = list(
      lab = "link::EFT_PAGO_ALIMENTOS_MONTO"
   ),
   EFT_PAGO_VIVIENDAS_MONTO = list(
     lab = "Monto recibido en pago de viviendas"
   ),
   S4_P29BM = list(
      lab = "link::EFT_PAGO_VIVIENDAS_MONTO"
   ),
   EFT_PAGO_TRANSPORTE_MONTO = list(
     lab = "Monto recibido en pado de transporte"
   ),
   S4_P29CM = list(
      lab = "link::EFT_PAGO_TRANSPORTE_MONTO"
   ),
   EFT_PAGO_VESTIDO_MONTO = list(
     lab = "Monto recibido en pago de celulares (hasta octubre 2006 corresponde a vestido)"
   ),
   S4_P29DM = list(
      lab = "link::EFT_PAGO_VESTIDO_MONTO"
   ),
   EFT_PAGO_OTROS_MONTO = list(
     lab = "Monto recibido en otros pagos"
   ),
   S4_P29EM = list(
      lab = "link::EFT_PAGO_OTROS_MONTO"
   ),
   EFT_MONTO_ALQUILER_ING_NAC = list(
     lab = "Monto recibido por alquileres o renta de propiedades nacional"
   ),
   S4_P30CM = list(
      lab = "link::EFT_MONTO_ALQUILER_ING_NAC"
   ),
   EFT_BIENES_CONSUMO_ANUAL = list(
     lab = "En el último año. De los bienes producidos o comprados por el hogar para fines de comercio, utilizó alguno para consumo del hogar? (Monto)"
   ),
   S4_P33A = list(
      lab = "link::EFT_BIENES_CONSUMO_ANUAL"
   ),
   EFT_BIENES_CONSUMO_MENSUAL = list(
     lab = "En el último mes. De los bienes producidos o comprados por el hogar para fines de comercio, utilizó alguno para consumo del hogar? (Monto)"
   ),
   S4_P33M = list(
      lab = "link::EFT_BIENES_CONSUMO_MENSUAL"
   )
)


dict1 <- list(
  zona = list(
    lab = "Zona de residencia",
    labs = c("Zona urbana" = 1, "Zona rural" = 2)
  )
)

dict <- append(dict0, dict1)


usethis::use_data(dict, overwrite = TRUE)
#rm(dict, dict0, dict1)
