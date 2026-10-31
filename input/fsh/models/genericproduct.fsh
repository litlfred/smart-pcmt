Logical: GenericProduct
Id: GenericProduct
Title: "Generic Product"
Description: "In this handbook, the terms ‘generic product,’ ‘product,’ or ‘product information’ pertain to the general identifying details of a health product, excluding any manufacturer-specific information (WHO DTH Product Catalogue Handbook, p. 8; Ch 2, p. 28: ‘Generic products can be described as generic items that conceal the brand or manufacturer information’). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/generic-product (handbook Ch 2, Fig. 9, p. 29)."
Characteristics: #can-be-target

* identifier 0..* Identifier "Product Identifier(s)" "General identifier(s) for the generic health product (e.g., WHO or compendium generic product code), excluding manufacturer-specific GTINs."
* status 1..1 code "Status" "The publication/lifecycle status of the generic product entry in the catalogue (handbook Fig. 9, p. 29)."
* status from PublicationStatus (required)
* genericName 1..1 string "Generic Name" "Canonical non-proprietary / generic name of the health product (e.g., INN description such as Amoxicillin 250mg dispersible tablet)."
* name 0..* ProductName "Additional Product Name(s)" "Multilingual or synonym generic product names (handbook Fig. 9, p. 29)."
* description 0..1 markdown "Description" "General description of the generic health product, excluding brand or manufacturer details (handbook Fig. 9, p. 29)."
* productType 1..1 CodeableConcept "Product Type" "High-level health product category (e.g., medicinal product, vaccine, pharmaceutical product)."
* classification 0..* ProductClassification "Product Classification(s)" "Classifications under product classification systems such as INN, ATC, ICD-11, GMDN, EMDN, or UNSPSC (handbook Fig. 9, p. 29; Table 1, p. 19)."
* dosageForm 0..1 CodeableConcept "Dosage Form" "Physical form in which the product is produced and dispensed (e.g., tablet, capsule, injectable solution; PCMTGlossary#dosageForm)."
* routeOfAdministration 0..* CodeableConcept "Route of Administration" "Path by which the product is taken into the body (e.g., oral, intravenous, topical; PCMTGlossary#routeOfAdministration)."
* strength 0..* string "Strength" "Amount of active ingredient per unit of use (e.g., 500mg per tablet, 10mg/mL; PCMTGlossary#strength)."
* unitOfUse 1..1 CodeableConcept "Unit of Use" "Smallest unit of a product that can be administered or dispensed to a patient (handbook Fig. 9, p. 29; Fig. 11, p. 31; PCMTGlossary#unit-of-use)."
* attribute 0..* ProductAttribute "Additional Attribute(s)" "Additional standardized attributes of the generic product (handbook Fig. 9, p. 29)."
