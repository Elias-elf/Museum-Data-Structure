from lxml import etree
import sys

def process_xml_pipeline():
    xml_file = 'XML/Artifacts.xml'
    xsd_file = 'XML/schemas/Artifacts.xsd'
    xsl_file = 'Case scenarios/Python_artifact_details.xsl' 

    print("Starting XML processing...")

    try:
        # load, parse the XML
        xml_doc = etree.parse(xml_file)
        print("[-] XML successfully loaded and parsed.")

        # load XSD schema, validate
        xml_schema_doc = etree.parse(xsd_file)
        xml_schema = etree.XMLSchema(xml_schema_doc)

        if xml_schema.validate(xml_doc):
            print("[-] XSD validation successful.")
        else:
            print("[!] XSD validation failed:")
            print(xml_schema.error_log)
            sys.exit(1)

        # load stylesheet, apply XSLT transformation
        xsl_doc = etree.parse(xsl_file)
        transform = etree.XSLT(xsl_doc)

        # apply the transformation
        result_tree = transform(xml_doc)
        print("[-] XSLT transformation successfully applied in memory.")

        # print the result to console
        print(str(result_tree))

    except Exception as e:
        print(f"[ERROR] An issue occurred: {e}")

if __name__ == "__main__":
    process_xml_pipeline()