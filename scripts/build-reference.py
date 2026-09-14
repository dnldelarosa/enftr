"""Produce English Rd and paired API reference from the reviewed ENFT source."""
import json,re,inspect,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'endompy')); sys.path.insert(0,str(ROOT/'labelerpy'))
from endompy import enftr

src=json.loads((ROOT/'endompy/scripts/generated/enft-reference.json').read_text(encoding='utf-8'))
rules=json.loads((ROOT/'endompy/endompy/enftr/resources/survey-rules.json').read_text(encoding='utf-8'))
ast=json.loads((ROOT/'endompy/scripts/generated/enft-functions.json').read_text(encoding='utf-8'))
special_inputs={
 'peri_vars':['EFT_PERIODO or PERIALFA'],'version':['EFT_PERIODO or PERIALFA'],'zona':['EFT_PERIODO + EFT_ZONA or PERIALFA + S1_P4'],
 'ing_ext_pension':['EFT_PERIODO','EFT_VIVIENDA','EFT_HOGAR','EFT_MIEMBRO','EFT_MONTO_ING_PENSION_MES','EFT_MONEDA_ING_PENSION_MES'],
 'ing_ext_intereses_alquiler':['EFT_PERIODO','EFT_VIVIENDA','EFT_HOGAR','EFT_MIEMBRO','EFT_MONTO_ING_INTERES_MES','EFT_MONEDA_ING_INTERES_MES'],
 'ing_regalos_ext':['EFT_PERIODO','EFT_VIVIENDA','EFT_HOGAR','EFT_MIEMBRO','EFT_MONTO_EQUIV_REGALO'],
 'ing_imputado_vivienda_propia':['EFT_PERIODO','EFT_VIVIENDA','EFT_HOGAR','EFT_MIEMBRO','EFT_PARENTESCO_CON_JEFE','EFT_MONTO_PROBABLE_ALQ'],
 'ing_remesas_ext':['EFT_PERIODO','EFT_VIVIENDA','EFT_HOGAR','EFT_MIEMBRO','EFT_RECIBIO_REMESA']+
    ['EFT_'+part+'_'+slot for slot in ['SEP','AGO','JUL','PER4','PER5','PER6'] for part in ['MONTO','MONEDA','FRECUENCIA']]+
    ['EFT_RECIBIO_ING_REMESA_SEM','EFT_MONTO_ING_REMESA_SEM','EFT_MONEDA_ING_REMESA_SEM']}

def inputs(name,seen=None):
    if name in special_inputs:return special_inputs[name]
    if name not in rules:return []
    seen=set() if seen is None else seen
    if name in seen:return []
    seen.add(name); found=set()
    def walk(node):
        if isinstance(node,dict):
            if node.get('symbol','').startswith('EFT_'):found.add(node['symbol'])
            if node.get('op','').startswith('ft_'):found.update(inputs(node['op'][3:],seen))
            for v in node.values():walk(v)
        elif isinstance(node,list):
            for v in node:walk(v)
    walk(rules[name]['steps']);return sorted(found)

components=json.loads((ROOT/'endompy/endompy/enftr/resources/components.json').read_text())
all_inputs=sorted(set(c for name in components for c in inputs(name)))
for name in ['pobreza_monetaria','ing_total_pobreza_monetaria','ing_pc_pobreza_monetaria']:
    special_inputs[name]=sorted(set(all_inputs+['EFT_ZONA']))

titles={
 'alfabeta':'Literacy status','anos_educacion':'Years of education','pet':'Working-age population',
 'ocupado':'Employed population','desempleo_abierto':'Open unemployment','desempleo_ampliado':'Expanded unemployment',
 'desempleo_cesante_abierto':'Open unemployment among previous workers','desempleo_nuevo_abierto':'Open unemployment among new entrants',
 'desempleo_cesante_ampliado':'Expanded unemployment among previous workers','desempleo_nuevo_ampliado':'Expanded unemployment among new entrants',
 'pea_abierta':'Open economically active population','pea_ampliada':'Expanded economically active population',
 'poblacion_inactiva':'Inactive population','categoria_ocupacion_principal':'Harmonized main-job occupational category',
 'cantidad_personas_trabajan':'Harmonized workplace size','sector_ocupacion':'Occupational sector','grupo_ocupacion':'Occupational group',
 'grupo_rama':'Economic activity group','perceptores_ingresos':'Labour income recipients','horas_semanal':'Weekly hours worked',
 'dias_semana_ocupacion_principal':'Main-job working days per week','ingreso_laboral_mensual':'Monthly labour income',
 'dominios_inferencia':'Period-specific inference domains','dominios_inferencia1':'Inference domains for 2000/1 to 2003/1',
 'dominios_inferencia2':'Inference domains for 2003/2 to 2007/2','dominios_inferencia3':'Inference domains from 2008/1',
 'regiones_desarrollo_685_00':'Historical development regions: decree 685-00',
 'regiones_desarrollo_710_04':'Historical development regions: decree 710-04','zona_desarrollo_fronterizo':'Historical border-development area',
 'zona':'Residence zone','peri_vars':'Validate and extract the semiannual period','version':'Identify ENFT column structure',
 'db_connect':'Connect using the requested Dmisc database name','dict':'Select an immutable dictionary revision',
 'dict_versions':'List dictionary revisions','register_dict':'Register a dictionary edition with shared definitions',
 'set_Dict':'Apply dictionary metadata','with_Dict':'Use variable and value labels','browse_dict':'Browse a dictionary as a table or widget',
 'pobreza_monetaria':'Historical ENFT monetary poverty, 2005-2016','ing_total_pobreza_monetaria':'Monthly individual income for historical poverty',
 'ing_pc_pobreza_monetaria':'Monthly household income per capita'}
income_words={
 'ocup_prin':'main-job earnings','ocup_secun':'secondary-job earnings','comisiones':'commissions','propinas':'tips',
 'horas_extras':'overtime','vacaciones':'paid leave','dividendos':'dividends','bonificaciones':'bonuses',
 'regalia_pascual':'Christmas bonus','utilidades_empresariales':'business profits','beneficios_marginales':'fringe benefits',
 'especie_alimentos':'in-kind food','especie_viviendas':'in-kind housing','especie_transporte':'in-kind transport',
 'especie_vestido':'in-kind clothing','especie_otros':'other in-kind earnings','especie_celulares':'in-kind mobile phones',
 'especie_auto':'self-produced consumption','imputado_vivienda_propia':'owner-occupied imputed rent',
 'alqui_renta_propiedades':'domestic property rent','ext_intereses_alquiler':'external interest and rent',
 'intereses_dividendo':'domestic interest and dividends','pension_jubilacion':'domestic pension',
 'ext_pension':'external pension','ayuda_gobierno':'government assistance','remesas_nac':'domestic remittances',
 'remesas_ext':'external remittances','pension_anual':'annual pension converted to monthly',
 'interes_anual':'annual interest converted to monthly','alquiler_anual':'annual rent converted to monthly',
 'remesas_anual':'annual remittances converted to monthly','gobierno_anual':'annual government assistance converted to monthly',
 'especie_ayuda_ong':'family, employer, government and NGO assistance','regalos_ext':'external gifts'}
for suffix,title in income_words.items():titles['ing_'+suffix]='Income: '+title

def canonical(name):
    return {'compute_peri_vars':'peri_vars','compute_ano':'peri_vars','ano':'peri_vars','compute_zona':'zona',
      'regiones_desarrollo':'regiones_desarrollo_710_04','set_labels':'set_Dict','setLabels':'set_Dict',
      'use_labels':'with_Dict','useLabels':'with_Dict','dbConnect':'db_connect'}.get(name,name)

def desc(name):
    c=canonical(name)
    if c in ['pobreza_monetaria','ing_total_pobreza_monetaria','ing_pc_pobreza_monetaria']:
        return 'Use the historical 34-component monthly income model for 2005/1 to 2016/2. Unknown individual income leaves the household unclassified. Values outside coverage remain missing. This is not a certified reproduction of official ENFT production.'
    if c.startswith('ing_'):
        return 'Compute '+income_words.get(c[4:],c)+' using the traditional ENFT questionnaire. Amounts contribute to monthly income in Dominican pesos. See the displayed calculation rule for the treatment of questionnaire skips and missing values.'
    return titles.get(c,'Traditional ENFT calculation')+'. Preserve input rows and order. Use the original questionnaire codes; unsupported or out-of-population values follow the displayed rule. Column structure does not imply a dated questionnaire revision.'

def rd_escape(x):return str(x).replace('\\','\\\\').replace('%','\\%').replace('{','\\{').replace('}','\\}')
def rdfield(name,text):return '\\'+name+'{'+text+'}\n'
def arr(x):return x if isinstance(x,list) else [x]
params={'tbl':'Local data.frame or tibble with the required traditional ENFT columns.',
 'min_edad':'Nonnegative integer minimum age; default 15.', 'rm':'Remove the source period column when TRUE.',
 'ano':'Add or overwrite the year when TRUE.','semestre':'Add or overwrite the semester when TRUE.',
 'periodo':'Add or overwrite the YYYYS code when TRUE.','dict':'Explicit dictionary; NULL selects the bundled edition where documented.',
 'vars':'Optional selected column names, retained for positional compatibility.','subset':'Optional selected column names.',
 'version':'Exact immutable revision identifier.','at':'Optional ISO applicability date; requires documented revision intervals.',
 'con':'Caller-owned DBI/SQLite connection to a dictionary registry.','valid_from':'Inclusive ISO start date, or NULL when unknown.',
 'valid_to':'Inclusive ISO end date, or NULL when unknown.','db_name':'Requested configured database name; forwarded to Dmisc.',
 '.keep':'TRUE retains components; FALSE retains inputs and final outputs; a character vector selects components.',
 '.reuse':'FALSE recalculates components. TRUE trusts present components; a character vector requires those components.',
 'ing_ext':'External income transactions; multiple rows per member are allowed. Absent transactions mean zero; missing amounts remain unknown.',
 'remesas':'One row per member with six remittance slots; defaults to tbl.',
 '...':'Additional arguments passed to the documented labeling, registry or connection helper.'}
english=ROOT/'enftr/pkgdown/i18n/en/man';english.mkdir(parents=True,exist_ok=True)
aliases={}
for filename,doc in src['docs'].items():
    for alias in arr(doc.get('alias',[])):aliases[alias]=doc
    funcs=[a for a in arr(doc.get('alias',[])) if a in src['api']]
    name=funcs[0][3:] if funcs else doc['name']
    c=canonical(name)
    title=titles.get(c,{'dict':'Bundled legacy ENFT dictionary','enft_like':'Entirely invented traditional ENFT example',
      'ipc_oficial':'Bundled historical monthly CPI','tdc_oficial':'Bundled historical exchange rates','lineas_oficial_zona':'Bundled nominal poverty lines by zone and semester','poblacion_onaplan':'Historical population reference','pipe':'Pipe operator'}.get(name,'Traditional ENFT reference: '+name))
    text=rdfield('name',rd_escape(doc['name']))+''.join(rdfield('alias',rd_escape(a)) for a in arr(doc.get('alias',[])))+rdfield('title',rd_escape(title))
    if 'usage' in doc:text+=rdfield('usage',rd_escape(doc['usage']))
    if funcs:
        parameters=list(dict.fromkeys(p for f in funcs for p in arr(src['api'][f]['parameters'])))
        text+=rdfield('arguments','\n'+''.join('\\item{'+p+'}{'+params.get(p,'Argument forwarded to the documented implementation.')+'}\n' for p in parameters))
        text+=rdfield('description',rd_escape(desc(name)))
        text+=rdfield('value','A local table with calculated columns, or the dictionary, metadata table, structure identifier or connection specified by the function name.')
        required=inputs(c)
        details=('Required columns: '+', '.join(required)+'.\n\n' if required else '')+'Income and poverty use the traditional ENFT model, not the continuous ENCFT. See the income and dictionary guides for coverage, missing-value rules and revision applicability.'
        text+=rdfield('details',rd_escape(details))
        if c in rules:
            text+=rdfield('section','Calculation rule}{\\preformatted{'+rd_escape(src['api']['ft_'+c]['body'])+'}')
    else:
        text+=rdfield('description',rd_escape(title+'. Included for reproducible historical calculations; no live database connection is made. The enft_like dataset contains 72 invented people in 24 household-periods, with no respondent values.'))
    (english/filename).write_text(text,encoding='utf-8')

manifest=[]
for en in (False,True):
    text='# '+('ENFT API reference' if en else 'Referencia de la API ENFT')+'\n\n'
    text+=('All public R functions are mapped below. Database configuration and the pipe operator are native R interfaces. Python calculations require no R runtime.\n\n' if en else 'Aquí se relacionan todas las funciones públicas de R. La configuración de bases de datos y el operador pipe son interfaces propias de R. Los cálculos Python no requieren R en ejecución.\n\n')
    for rname,spec in sorted(src['api'].items()):
        name=rname[3:];c=canonical(name);mapped=hasattr(enftr,rname)
        if not en:manifest.append(dict(r=rname,python=('endompy.enftr.'+rname if mapped else None),kind='function' if mapped else 'R-specific database configuration',required_columns=inputs(c)))
        title=titles.get(c,c.replace('_',' ')) if en else aliases.get(rname,{}).get('title',name)
        text+='## '+rname+'\n\n'+title+'\n\n'
        if mapped:
            sig=str(inspect.signature(getattr(enftr,rname)))
            text+='```python\nft.'+rname+sig+'\n```\n\n'
        else:text+=('Use user-owned Python database tooling and provide a pandas DataFrame. No automatic Dmisc profile translation is performed.\n\n' if en else 'Use sus herramientas de base de datos de Python y proporcione un DataFrame pandas. Los perfiles Dmisc no se traducen automáticamente.\n\n')
        text+=(desc(name) if en else aliases.get(rname,{}).get('description','Consulte la guía correspondiente para contratos y cobertura.'))+'\n\n'
        required=inputs(c)
        if required:text+=('**Required columns:** ' if en else '**Columnas requeridas:** ')+', '.join('`'+p+'`' for p in required)+'.\n\n'
        if c in rules:text+=('<details><summary>Calculation rule in R notation</summary>\n\n' if en else '<details><summary>Regla de cálculo en notación R</summary>\n\n')+'```r\n'+src['api']['ft_'+c]['body']+'\n```\n\n</details>\n\n'
    text+=('The `EnftDataFrame` class exposes the same calculations as chainable methods. Use bracket column access when a column has the same name as a method.\n' if en else '`EnftDataFrame` expone los mismos cálculos como métodos encadenables. Use corchetes para leer columnas cuyo nombre coincida con un método.\n')
    (ROOT/'endompy/docs'/('en' if en else 'es')/'enft-reference.md').write_text(text,encoding='utf-8')
(ROOT/'enftr/inst/reference/api-parity.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
print(len(manifest),'R entries mapped;',sum(x['python'] is not None for x in manifest),'Python equivalents;',len(src['docs']),'English Rd topics.')
