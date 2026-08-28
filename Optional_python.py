import xml.dom.minidom
import sys

def process_xml_dom():
    xml_file = 'XML/Artifacts.xml'
    output_file = 'Case scenarios/artifact_details_output_dom.html'

    print("Starting XML processing using DOM API...")

    try:
        # load, parse the XML tree into memory (DOM)
        dom_tree = xml.dom.minidom.parse(xml_file)
        print("[-] XML successfully loaded and parsed via DOM.")

        # get target elements
        artifacts = dom_tree.getElementsByTagName('Artifact')
        print(f"[-] {len(artifacts)} artifact(s) found.")
        
        # build HTML content
        html_content = "<html>\n<head><title>Artifact Details</title></head>\n<body>\n"
        html_content += "<h1>Museum Artifacts List</h1>\n<table border='1'>\n"
        html_content += "<tr><th>ID</th><th>Description</th></tr>\n"

        # Loop to extract data
        for artifact in artifacts:
            art_id = artifact.getAttribute('id')
            
            desc_nodes = artifact.getElementsByTagName('Description')
            if desc_nodes and desc_nodes[0].firstChild:
                description = desc_nodes[0].firstChild.nodeValue
            else:
                description = "No description"

            # HTML row
            html_content += f"<tr><td>{art_id}</td><td>{description}</td></tr>\n"

        html_content += "</table>\n</body>\n</html>"

        # save the result in HTML
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(html_content)
            
        print(f"[SUCCESS] HTML file generated via DOM saved to: {output_file}")

    except Exception as e:
        print(f"[ERROR] An issue occurred: {e}")

if __name__ == "__main__":
    process_xml_dom()