Logical: TradeItem
Id: TradeItem
Title: "Trade Item"
Description: "Trade items are manufacturer-specific branded health products that are identifiable and unique to a particular brand or manufacturer (WHO DTH Product Catalogue Handbook, Ch 2, p. 28; Fig. 9, p. 29). Models the WHO Product Catalogue narrow sense of Trade Item (broadMatch GS1 Trade Item per litlfred/smart-ra#142). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/trade-item."
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
* countryOfOrigin from http://smart.who.int/refmart/ValueSet/COUNTRYISO3 (example)
* shelfLife 0..1 SimpleQuantity "The shelf life of the trade item"
* associatedGenericProduct 0..* BackboneElement "The generic product this trade item packages"
  * genericProduct 1..1 Reference(GenericProduct or Product) "The generic product"
  * quantity 1..1 Quantity "How many units of use of the generic product are in the trade item"
* contains 0..* BackboneElement "The trade items packed inside this one (Packaging Hierarchy)"
  * tradeItem 1..1 Reference(TradeItem or DthPcTradeItem) "The contained trade item"
  * quantity 1..1 Quantity "How many of the contained trade item"
* attribute 0..* BackboneElement "Attributes or characteristics of the trade item"
  * type 1..1 CodeableConcept "The attribute type"
  * type from AttributeType (extensible)
  * value[x] 1..1 string or integer or decimal or boolean or url or dateTime or Range or Ratio or Annotation or Address or Duration or CodeableConcept "The value of the attribute"
