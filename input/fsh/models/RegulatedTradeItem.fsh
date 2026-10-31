Logical: RegulatedTradeItem
Id: RegulatedTradeItem
Title: "Regulated Trade Item"
Description: "A Regulated Trade Item represents an authorization of a Trade item within a given jurisdiction under a Product Authorization (WHO DTH Product Catalogue Handbook, Ch 2, p. 28; Fig. 9, p. 29). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/regulated-trade-item."
Characteristics: #can-be-target

* identifier 0..* Identifier "Regulated Trade Item Identifier(s)" "Jurisdiction-specific regulated product identifier(s)."
* status 1..1 code "Status" "The status of the regulated trade item in the jurisdiction's catalogue (handbook Fig. 9, p. 29)."
* status from PublicationStatus (required)
* tradeItem 1..1 Reference(TradeItem) "Trade Item" "The manufacturer-specific Trade Item authorized in this jurisdiction (handbook Fig. 9, p. 29)."
* authorization 1..1 Reference(ProductAuthorization) "Product Authorization" "The Product Authorization under which this Trade Item is regulated in the jurisdiction (handbook Fig. 9, p. 29)."
* jurisdiction 0..1 CodeableConcept "Jurisdiction" "The regulatory jurisdiction in which this regulated trade item applies."
* expiryDate 0..1 dateTime "Authorization Expiry Date" "Expiration date of the regulated trade item authorization (handbook Fig. 9, p. 29)."
* attribute 0..* ProductAttribute "Additional Attribute(s)" "Additional regulatory or jurisdiction-specific attributes (handbook Fig. 9, p. 29)."
