from lxml import etree
import json
import jsonschema

def run_pipeline():
    # path files
    xml_file = 'XML/Artifacts.xml'
    xslt_file = 'Case scenarios/scenario_json.xsl'
    schema_file = 'XML/schemas/artefacts_schema.json'
    out_file = 'Case scenarios/resultat_artefacts.json'

    # part 1 transform xml to json
    xml_data = etree.parse(xml_file)
    xslt_style = etree.parse(xslt_file)
    
    transform = etree.XSLT(xslt_style)
    result = transform(xml_data)
    
    # save file
    with open(out_file, 'w', encoding='utf-8') as f:
        f.write(str(result))

    # part 2 validate schema
    with open(out_file, 'r', encoding='utf-8') as f:
        data = json.load(f)
        
    with open(schema_file, 'r', encoding='utf-8') as f:
        schema = json.load(f)
        
    jsonschema.validate(instance=data, schema=schema)
    print("json is valid")

if __name__ == "__main__":
    run_pipeline()