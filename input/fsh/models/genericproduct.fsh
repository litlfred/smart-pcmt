Logical: GenericProduct
Id: GenericProduct
Title: "Generic Product"
Description: "In this handbook, the terms ‘generic product,’ ‘product,’ or ‘product information’ pertain to the general identifying details of a health product, excluding any manufacturer-specific information (WHO DTH Product Catalogue Handbook, p. 8; Ch 2, p. 28; Fig. 9, p. 29). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/generic-product."
Characteristics: #can-be-target

* identifier 0..* Identifier "Identifier for the generic product (e.g. National Product Code)"
* status 1..1 code "Product status"
* status from Status (extensible)
* name 1..* BackboneElement "The name of the generic product"
  * nameType 1..1 code "The type of name"
  * nameType from NameType (extensible)
  * nameValue 1..1 string "The name of the generic product"
* description 0..1 string "The description of the generic product"
* classification 0..* CodeableConcept "A categorization or classification of the generic product (e.g. ATC/DDD, ICD-11)"
* dosageForm 0..1 CodeableConcept "The physical form of the medication"
* dosageForm from http://terminology.hl7.org/ValueSet/v3-DispensableDrugForm (example)
* strength 0..1 SimpleQuantity "The strength of the generic product (e.g. 500 mg)"
* routeOfAdministration 0..* CodeableConcept "The route of administration of the medication"
* routeOfAdministration from http://terminology.ehdsi.eu/ValueSet/eHDSIRouteofAdministration (example)
* unitOfUse 1..1 CodeableConcept "The unit in which the generic product is used or counted"
* doseQuantity 0..1 SimpleQuantity "The number of doses"
* attribute 0..* BackboneElement "Attributes or characteristics of the generic product"
  * type 1..1 CodeableConcept "The attribute type"
  * type from AttributeType (extensible)
  * value[x] 1..1 string or integer or decimal or boolean or url or dateTime or Range or Ratio or Annotation or Address or Duration or CodeableConcept "The value of the attribute"
* associatedProduct 0..* BackboneElement "Associations with other products"
  * product 1..1 Reference(GenericProduct or Product) "The associated product"
  * relationship 1..* Coding "The relationship"
  * relationship from ProductRelationship (extensible)
  * quantity 1..1 Quantity "How many"
