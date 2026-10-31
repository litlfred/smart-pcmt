Logical: ProductName
Id: ProductName
Title: "ProductName"
Description: "ProductName — structured multilingual name element for health product master data (handbook Fig. 9, p. 29)."
Characteristics: #can-be-target

* value 1..1 string "The name of the product"
* language 0..1 code "The language of the name"
* language from CommonLanguages (preferred)

Logical: ProductAttribute
Id: ProductAttribute
Title: "ProductAttribute"
Description: "ProductAttribute — extensible code/value attribute pair for health product master data (handbook Fig. 9, p. 29)."
Characteristics: #can-be-target

* code 1..1 Coding "The code for the attribute"
* value 1..1 Element "The value of the attribute"

Logical: ProductClassification
Id: ProductClassification
Title: "ProductClassification"
Description: "ProductClassification — classification entry linking a health product to a classification system such as INN, ATC, ICD-11, GMDN, EMDN, or UNSPSC (handbook Fig. 9, p. 29; Table 1, p. 19)."
Characteristics: #can-be-target

* code 1..* Coding "The code for the classification"

Logical: Product
Id: Product
Title: "Product (Abstract / Legacy Supertype)"
Description: "Product master data supertype retained for backward compatibility. Per WHO DTH Product Catalogue Handbook Ch 2 (pp. 28-29, Fig. 9) and litlfred/smart-ra#145, product master data is separated into three domain layers: GenericProduct (https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/generic-product), TradeItem (https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/trade-item), and ProductAuthorization / RegulatedTradeItem (https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/regulated-trade-item), anchored to Product Master Data (https://litlfred.github.io/dth-pc/v0/ns#glossary/dth-pc/product-master-data)."
Characteristics: #can-be-target

* status 1..1 code "The status of the product"
* status from PublicationStatus (required)
* identifier 0..* Identifier "The identifier of the product"
* name 0..* ProductName "The name of the product"
* description 0..1 markdown "The description of the product"
* classification 0..* ProductClassification "The classification of the product"
* associatedGenericProduct 0..* Reference(GenericProduct) "The generic product associated with the product"
* manufacturer 0..* Reference(Organization) "The manufacturer of the product"
* packaging 0..* BackboneElement "The packaging of the product"
* attribute 0..* ProductAttribute "Additional attributes of the product"
* contains 0..* Reference(Product) "Products that this product contains"
