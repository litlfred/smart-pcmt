Logical: RegulatedTradeItem
Id: RegulatedTradeItem
Title: "Regulated Trade Item"
Description: "A Regulated Trade Item represents an authorization of a Trade item within a given jurisdiction under a Product Authorization (WHO DTH Product Catalogue Handbook, Ch 2, p. 28; Fig. 9, p. 29). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/regulated-trade-item."
Characteristics: #can-be-target

* identifier 1..* Identifier "Authorisation identifier, e.g. a marketing authorisation or product registration number"
* status 1..1 code "Authorisation status"
* status from Status (extensible)
* jurisdiction 1..* CodeableConcept "The jurisdiction where the trade item is authorised"
* authorisationHolder 1..1 Reference(IHE.mCSD.Organization) "The holder of the authorisation"
* validityPeriod 0..1 Period "Validity period of the authorisation"
* authorisedTradeItem 1..1 Reference(TradeItem or DthPcTradeItem) "The trade item that is authorised"
* authorization 0..1 Reference(ProductAuthorization) "The Product Authorization under which this trade item is regulated"
* attribute 0..* BackboneElement "Attributes of the regulated trade item"
  * type 1..1 CodeableConcept "The attribute type"
  * type from AttributeType (extensible)
  * value[x] 1..1 string or integer or decimal or boolean or url or dateTime or Range or Ratio or Annotation or Address or Duration or CodeableConcept "The value of the attribute"
* associatedProduct 0..* BackboneElement "Associations with other products"
  * product 1..1 Reference(Product or GenericProduct) "The associated product"
  * relationship 1..* Coding "The relationship"
  * relationship from ProductRelationship (extensible)
  * quantity 1..1 Quantity "How many"
