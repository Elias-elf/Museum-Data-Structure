from lxml import etree
import sys

def process_xml_pipeline():
    xml_file = 'XML/Artifacts.xml'
    xsd_file = 'XML/schemas/Artifacts.xsd'
    xsl_file = 'Case scenarios/Artifacts.xsl' 
    output_file = 'Case scenarios/artifact_details_output.html'

    print("Démarrage du traitement XML...")

    try:
        xml_doc = etree.parse(xml_file)
        print("[-] XML chargé et parsé avec succès.")

        xml_schema_doc = etree.parse(xsd_file)
        xml_schema = etree.XMLSchema(xml_schema_doc)
        
        if xml_schema.validate(xml_doc):
            print("[-] Validation XSD réussie.")
        else:
            print("[!] Échec de la validation XSD :")
            print(xml_schema.error_log)
            sys.exit(1)

        xsl_doc = etree.parse(xsl_file)
        transform = etree.XSLT(xsl_doc)
        result_tree = transform(xml_doc)
        print("[-] Transformation XSLT appliquée avec succès.")

        with open(output_file, 'wb') as f:
            f.write(result_tree)
        print(f"[SUCCÈS] Résultat sauvegardé dans : {output_file}")

    except Exception as e:
        print(f"[ERREUR] Un problème est survenu : {e}")

if __name__ == "__main__":
    process_xml_pipeline()