// The Trade Item and Regulated Trade Item classes of the WHO Digital
// transformation handbook for health product catalogues (2025), Fig. 9, p. 29.
// Its Generic Product class is this IG's Product. Element names and
// cardinalities are the figure's own. The figure gives no types: where an
// element shares a name with Product, it takes Product's type, and the
// others take the type their name implies.

Logical: DthPcTradeItem
Title: "Trade Item (DTH product catalogue handbook, Fig. 9)"
Description: "A packaged, identified unit of a Generic Product as traded, as drawn in Fig. 9 of the WHO Digital transformation handbook for health product catalogues (2025). One Generic Product has zero or more Trade Items."
Characteristics: #can-be-target

* identifier 1..* Identifier "Trade item identifier, e.g. a GTIN or a Country Trade Item Identifier"
* status 1..1 code "Trade item status"
* status from Status (extensible)
* tradeItemName 0..* BackboneElement "The name of the trade item"
  * nameType 1..1 code "The type of name"
  * nameType from NameType (extensible)
  * name 1..1 string "The name"
* description 0..1 string "The description of the trade item"
* classification 0..* CodeableConcept "A classification of the trade item"
* manufacturer 0..1 Reference(IHE.mCSD.Organization) "Manufacturer"
* countryOfOrigin 1..1 CodeableConcept "The country of origin"
* shelfLife 0..1 SimpleQuantity "The shelf life of the trade item"
* associatedGenericProduct 0..* BackboneElement "The generic product this trade item packages"
  * genericProduct 1..1 Reference(Product) "The generic product"
  * quantity 1..1 Quantity "How many units of use of the generic product are in the trade item"
* contains 0..* BackboneElement "The trade items packed inside this one"
  * tradeItem 1..1 Reference(DthPcTradeItem) "The contained trade item"
  * quantity 1..1 Quantity "How many of the contained trade item"
* attribute 0..* BackboneElement "Attributes or characteristics of the trade item"
  * type 1..1 CodeableConcept "The attribute type"
  * type from AttributeType (extensible)
  * value[x] 1..1 string or integer or decimal or boolean or url or dateTime or Range or Ratio or Annotation or Address or Duration or CodeableConcept "The value of the attribute"

Logical: DthPcRegulatedTradeItem
Title: "Regulated Trade Item (DTH product catalogue handbook, Fig. 9)"
Description: "A trade item as authorised in a jurisdiction, as drawn in Fig. 9 of the WHO Digital transformation handbook for health product catalogues (2025). One Trade Item has zero or more Regulated Trade Items. This IG's ProductAuthorization carries a related but different set of elements."
Characteristics: #can-be-target

* identifier 1..* Identifier "Authorisation identifier, e.g. a marketing authorisation or product registration number"
* status 1..1 code "Authorisation status"
* status from Status (extensible)
* jurisdiction 1..* CodeableConcept "The jurisdiction where the trade item is authorised"
* authorisationHolder 1..1 Reference(IHE.mCSD.Organization) "The holder of the authorisation"
* validityPeriod 0..1 Period "Validity period of the authorisation"
* authorisedTradeItem 1..1 Reference(DthPcTradeItem) "The trade item that is authorised"
* attribute 0..* BackboneElement "Attributes of the regulated trade item"
  * type 1..1 CodeableConcept "The attribute type"
  * type from AttributeType (extensible)
  * value[x] 1..1 string or integer or decimal or boolean or url or dateTime or Range or Ratio or Annotation or Address or Duration or CodeableConcept "The value of the attribute"
* associatedProduct 0..* BackboneElement "Associations with other products"
  * product 1..1 Reference(Product) "The associated product"
  * relationship 1..* Coding "The relationship"
  * relationship from ProductRelationship (extensible)
  * quantity 1..1 Quantity "How many"
