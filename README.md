# Museum-Data-Structure
This project is about designing structured Museum database platform based on XML.

## Global Architecture
The modeled Museum institution integrates 5 different entities:
> **Themes**\
> **Collections**\
> **Artifacts**\
> **Exhibitions**\
> **Restoration**

## Museum data model
A comprehensive model graph showing the dependencies between the entities is available in the [Deliverables directory](/Delivrables/).

And here below a diagram with the principal entities, attributes and relationships defined by the Museum XML schemas.

<p align="center">
  <a href="/Delivrables/Museum-Data-Model.png">
    <img
      src="/Delivrables/Museum-Data-Model.png"
      alt="Museum XML data model showing collections, artifacts, themes, exhibitions and restoration projects"
      width="850">
  </a>
</p>

## Data Format & Structure
Each entity is provided in a separate `.xml` file for better readability.<br>
All entities should be merged in a single global <code>Museum_merged.xml</code> file by running the `merge_museum.ps1` script.<br>
The global `Museum_merged.xml` file validates against `Museum.xsd` and is considered for the different XSL transformations which produce the use cases enumerated below.

## Use cases 
The list of the use cases that are studied in this project is detailed below:
- [x] Use case #1: Find the top 5 Collections having the highest restoration workload.
- [x] Use case #2: Find the top 10 artifacts under restoration, which have the highest public exposure across all exhibitions.
- [x] Use case #3: Top 5 exhibitions attracts the highest average number of visitors per day.
- [x] Use case #4: Which exhibitions display artifacts made of more than five different materials?
- [x] Use case #5: Top 5 exhibitions have the longest duration.
- [x] Use case #6: Find the artifacts from from "3rd century AD".
- [x] Use case #7: List all responsibles with their restoration domains and expertise, sorted alphabetically by name.
- [ ] Use case #8: 
- [x] Use case #9: Extract artifact details, materials, and restoration status to JSON.
- [x] Use case #10: List of all the Restoration projects over €200k.

## Python Scripts

Two Python scripts are provided to process the Museum XML data.

### Dependencies

The `Python_pipeline.py` script requires the `lxml` library. The `Optional_python.py` script uses Python's built-in `xml.dom.minidom` module, so no additional dependency is required.
Install the required dependency with:

```bash
pip install lxml
```

### Python Pipeline

The `Python_pipeline.py` script validates the `Artifacts.xml` file against its XSD schema and then applies the corresponding XSLT transformation.

To run it from the project root directory:

```bash
python Python_pipeline.py
```

### Optional Python Script

The `Optional_python.py` script uses Python's DOM API to parse `Artifacts.xml` and generate an HTML file containing the artifact details.

To run it:

```bash
python Optional_python.py
```
