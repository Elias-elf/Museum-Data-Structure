# Museum-Data-Structure
This project is about designing structured Museum database platform based on XML.

## Global Architecture
The modeled Museum institution integrates 5 different entities:
> **Themes**\
> **Collections**\
> **Artifacts**\
> **Exhibitions**\
> **Restoration**

## IDs and IDRefs
The instances in each entity are uniquely identified with IDs and links across the entities are referenced with IDrefs.

A comprehensive model graph showing the dependencies between the entities is available in the [Deliverables directory](/Delivrables/).

## Tree Structure
Each entity is provided in a separate `.xml` file and all entities can be merged in a single global `Museum.xml` file by running the `merge_museum.ps1` script.

## Use cases 
The list of the use cases that are studied in this project is detailed below:
- [x] Use case #1
- [ ] Use case #2
- [x] Use case #3
