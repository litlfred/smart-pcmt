Logical: TradeItem
Id: TradeItem
Title: "Trade Item"
Description: "Trade items are manufacturer-specific branded health products that are identifiable and unique to a particular brand or manufacturer (WHO DTH Product Catalogue Handbook, Ch 2, p. 28; Fig. 9, p. 29). Models the WHO Product Catalogue narrow sense of Trade Item (broadMatch GS1 Trade Item per litlfred/smart-ra#142). Anchored to dth-pc glossary concept https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/trade-item."
Characteristics: #can-be-target

* identifier 1..* Identifier "Trade Item Identifier(s)" "Globally or nationally unique identifier(s) for the trade item, such as a GS1 Global Trade Item Number (GTIN) or country catalogue trade item code (handbook Ch 2, p. 28; Fig. 12, p. 32)."
* status 1..1 code "Status" "The publication/lifecycle status of the trade item record in the catalogue (handbook Fig. 9, p. 29)."
* status from PublicationStatus (required)
* genericProduct 1..1 Reference(GenericProduct) "Generic Product" "The canonical Generic Product that this manufacturer-specific branded Trade Item realizes (handbook Fig. 9, p. 29)."
* associatedGenericProduct 0..* Reference(GenericProduct) "Associated Generic Product(s)" "Additional associated Generic Products when a trade item maps to or combines multiple generic product definitions (handbook Fig. 9, p. 29)."
* brandName 0..1 string "Brand Name" "Proprietary or trade/brand name assigned by the manufacturer (handbook Ch 2, p. 28)."
* tradeItemName 0..* ProductName "Trade Item Name(s)" "Multilingual or alternative structured trade item names (handbook Fig. 9, p. 29)."
* description 0..1 markdown "Description" "Description of the manufacturer-specific branded trade item (handbook Fig. 9, p. 29)."
* manufacturer 1..1 Reference(Organization) "Manufacturer" "The manufacturer organization responsible for producing the branded trade item (handbook Ch 2, p. 28; Fig. 9, p. 29)."
* countryOfOrigin 0..1 CodeableConcept "Country of Origin" "Country in which the trade item is manufactured or originates."
* classification 0..* ProductClassification "Trade Item Classification(s)" "Product classifications applicable at the trade item level, such as UNSPSC (handbook Fig. 9, p. 29; Table 1, p. 19)."
* packaging 0..* BackboneElement "Packaging Hierarchy" "Packaging levels and hierarchy (primary, secondary, tertiary/shipping units and GTINs per level; handbook Fig. 9, p. 29; Fig. 11-12, pp. 31-32)."
* packaging.identifier 0..* Identifier "Package Identifier (e.g. GTIN)" "Identifier for this packaging level (e.g., level-specific GTIN)."
* packaging.type 0..1 CodeableConcept "Package Type" "Type of packaging (e.g., blister, carton, pallet, vial)."
* packaging.quantity 0..1 Quantity "Contained Quantity" "Number of units of use or child packages contained at this packaging level."
* shelfLife 0..1 Duration "Shelf Life" "Duration for which the trade item remains usable under specified storage and handling conditions (PCMTGlossary#shelfLife)."
* contains 0..* Reference(TradeItem) "Contained Trade Item(s)" "Component trade items contained within a kit, pack, or multipack trade item (handbook Fig. 9, p. 29)."
* attribute 0..* ProductAttribute "Additional Attribute(s)" "Additional trade-item-specific attributes such as storage and handling instructions (handbook Fig. 9, p. 29; PCMTGlossary#storageHandling)."
