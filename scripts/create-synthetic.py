"""Invent ENFT examples from variable names only; never read respondent values."""
import json
from pathlib import Path
root = Path(__file__).resolve().parents[2]
out = root / "artifacts/enft-release"
symbols = set(json.loads((root / "enftr/inst/examples/synthetic-schema.json").read_text(encoding="utf-8"))["columns"])
out.mkdir(parents=True, exist_ok=True)
periods = [20001, 20002, 20041, 20051, 20071, 20072, 20081, 20091, 20112, 20141, 20152, 20162]
rows = []
for period in periods:
    year, semester = divmod(period, 10)
    for zone in (0, 1):
        for member in (1, 2, 3):
            row = dict.fromkeys(sorted(symbols), 0)
            row.update(EFT_PERIODO=f"{semester}/{year}", EFT_VIVIENDA=900000+zone,
                EFT_HOGAR=1, EFT_MIEMBRO=member, EFT_EDAD={1:40,2:32,3:10}[member],
                EFT_PROVINCIA=1 if zone == 0 else 25, EFT_ZONA=zone,
                EFT_SEXO=1 if member == 1 else 2, EFT_FACTOR_EXP=120, EFT_FACTOR_EXP_ANUAL=60,
                EFT_PARENTESCO_CON_JEFE=member, EFT_ULT_NIVEL_ALCANZADO=3 if member < 3 else 2,
                EFT_ULT_ANO_APROBADO=4, EFT_ALFABETISMO=1,
                EFT_TRABAJO_SEM_ANT=1 if member < 3 else 2,
                EFT_CATEGORIA_OCUP_PRINC=1 if member < 3 else 0,
                EFT_CANT_PERS_TRAB=3 if member < 3 else 0,
                EFT_OCUPACION_PRINC=241 if member < 3 else 0,
                EFT_PERIODO_ING_OCUP_PRINC=3, EFT_ING_OCUP_PRINC=(5000 if zone == 0 else 1000) if member < 3 else 0,
                EFT_HORAS_SEM_OCUP_PRINC=40 if member < 3 else 0, EFT_DIAS_SEM_OCUP_PRINC=5 if member < 3 else 0,
                EFT_TIENE_COND_JORNADA=1, EFT_BUSCO_TRAB_SEM_ANT=2, EFT_BUSCO_TRAB_MES_ANT=2,
                EFT_RECIBIO_REMESA=1 if member == 1 else 2, EFT_RECIBIO_ING_REMESA_SEM=1 if member == 1 else 2,
                EFT_MONTO_ING_REMESA_SEM=60 if member == 1 else 0)
            for key in row:
                if "MONEDA" in key or "FRECUENCIA" in key or "FREC_ING" in key: row[key] = 1
            for slot in ("SEP", "AGO", "JUL", "PER4", "PER5", "PER6"):
                row[f"EFT_MONTO_{slot}"] = 10 if member == 1 else 0
                row[f"EFT_MONEDA_{slot}"] = 1
                row[f"EFT_FRECUENCIA_{slot}"] = 1
            rows.append(row)
dest = root / "enftr/inst/examples"
dest.mkdir(parents=True, exist_ok=True)
(dest / "synthetic-members.json").write_text(json.dumps(rows, ensure_ascii=False, indent=2), encoding="utf-8")
report = {"rows":len(rows), "household_periods":24, "periods":periods, "columns":len(rows[0]),
          "source":"Invented constants and keys; only variable names read from package source."}
(out / "synthetic-provenance.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
print(json.dumps(report))
