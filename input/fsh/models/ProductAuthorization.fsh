Logical: ProductAuthorization
Id: ProductAuthorization
Title: "Product Authorization"
Description: "Regulatory market authorization of a Trade Item within a given jurisdiction by a Regulatory Authority, establishing a Regulated Trade Item (WHO DTH Product Catalogue Handbook, Ch 2, p. 28; Fig. 9, p. 29). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/regulated-trade-item."
Characteristics: #can-be-target

* identifier 1..* Identifier "Registration / Authorization Identifier(s)" "Official registration or market authorization number(s) assigned by the regulatory authority."
* number 0..1 string "Authorization Number" "String representation of the market authorization number (handbook Fig. 9, p. 29)."
* tradeItem 1..1 Reference(TradeItem) "Authorized Trade Item" "The manufacturer-specific Trade Item covered by this market authorization (handbook Ch 2, p. 28; Fig. 9, p. 29)."
* product 0..1 Reference(Product or TradeItem) "Product Reference (Legacy)" "Legacy reference to the authorized product or trade item."
* jurisdiction 1..1 CodeableConcept "Jurisdiction" "The country, region, or regulatory jurisdiction in which the trade item is authorized for market entry or distribution (handbook Ch 2, p. 28)."
* holder 1..1 Reference(Organization) "Market Authorization Holder / Authority" "The organization (Market Authorization Holder or Regulatory Authority) holding or issuing the authorization (handbook Fig. 9, p. 29)."
* status 1..1 code "Authorization Status" "Current lifecycle status of the market authorization (e.g., active, draft, retired)."
* status from PublicationStatus (required)
* type 0..1 CodeableConcept "Authorization Type" "Type of regulatory authorization (e.g., full marketing authorization, emergency use listing, WHO prequalification; handbook Fig. 9, p. 29)."
* validityPeriod 0..1 Period "Validity Period" "Time period during which the product authorization is valid (issue date through expiration date)."
