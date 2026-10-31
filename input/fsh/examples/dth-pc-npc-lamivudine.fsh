// Example products from the WHO Digital transformation handbook for
// health product catalogues (ISBN 9789240116191, "dth-pc"): the national
// product code NPC01101001 (Lamivudine 50 mg tablet) and two manufacturers'
// trade-item hierarchies, in the product master data section.
//
// Column mapping from the handbook table:
//   GTIN                           -> identifier (system GS1 GTIN)
//   Country Trade Item Identifier  -> identifier (type text)
//   Manufacturer                   -> manufacturer.display
//   Country of Origin              -> countryOfOrigin (ISO 3166)
//   Child GTIN / Child SKU         -> associatedProduct.product, relationship #contains
//   Child Quantity                 -> that associatedProduct's quantity
//   Quantity of Eaches             -> associatedProduct to the generic product,
//                                     quantity in its unit of use ("each")
//   Shelf Life                     -> shelfLife (days, as the model states)
// Values are transcribed as printed, including where they do not multiply
// out (see the PR).

RuleSet: DthPcNpcSource
* description = "Source: WHO, Digital transformation handbook for health product catalogues, product master data example (NPC01101001)."

RuleSet: CountryTradeItemId(value)
* identifier[+].type.text = "Country Trade Item Identifier"
* identifier[=].value = "{value}"

RuleSet: TradeItem(name, mfr, country, shelf)
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "{name}"
* insert DthPcNpcSource
* status = #active
* manufacturer.display = "{mfr}"
* countryOfOrigin = urn:iso:std:iso:3166#{country}
* shelfLife = {shelf} 'd' "days"
* unitOfUse.text = "each"
* dosageForm.text = "TA"
* routeOfAdministration[0].text = "Oral"

RuleSet: Eaches(qty)
* associatedProduct[+].product = Reference(DthPcNpc01101001)
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.value = {qty}
* associatedProduct[=].quantity.unit = "each"

Instance: DthPcNpc01101001
InstanceOf: Product
Usage: #example
Title: "dth-pc: national product code NPC01101001"
* identifier[0].type.text = "National Product Code"
* identifier[0].value = "NPC01101001"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Lamivudine 50 Mg tablet"
* insert DthPcNpcSource
* status = #active
* unitOfUse.text = "each"
* dosageForm.text = "TA"
* routeOfAdministration[0].text = "Oral"

Instance: DthPcNpcMfr001Gtin58904093825793
InstanceOf: Product
Usage: #example
Title: "dth-pc: MFR001 trade item 58904093825793"
* identifier[0].system = $GTIN
* identifier[0].value = "58904093825793"
* insert CountryTradeItemId(58904093825793)
* insert TradeItem(Lamivudine 50 Mg tablet [MFR001 58904093825793], MFR001, IN, 670)
* associatedProduct[+].product = Reference(DthPcNpcMfr001Gtin58904093825700)
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.value = 100
* insert Eaches(3000)

Instance: DthPcNpcMfr001Gtin58904093825700
InstanceOf: Product
Usage: #example
Title: "dth-pc: MFR001 trade item 58904093825700"
* identifier[0].system = $GTIN
* identifier[0].value = "58904093825700"
* insert CountryTradeItemId(58904093825700)
* insert TradeItem(Lamivudine 50 Mg tablet [MFR001 58904093825700], MFR001, IN, 670)
// The child 58904093825600 has no row of its own in the table, so it is
// referenced by identifier only.
* associatedProduct[+].product.identifier.system = $GTIN
* associatedProduct[=].product.identifier.value = "58904093825600"
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.value = 10
* insert Eaches(3000)

Instance: DthPcNpcMfr002SkuP006008
InstanceOf: Product
Usage: #example
Title: "dth-pc: MFR002 trade item P006008 (no GTIN)"
* insert CountryTradeItemId(P006008)
* insert TradeItem(Lamivudine 50 Mg tablet [MFR002 P006008], MFR002, KE, 1095)
* associatedProduct[+].product = Reference(DthPcNpcMfr002SkuP006009)
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.value = 120
* insert Eaches(7200)

Instance: DthPcNpcMfr002SkuP006009
InstanceOf: Product
Usage: #example
Title: "dth-pc: MFR002 trade item P006009 (no GTIN)"
* insert CountryTradeItemId(P006009)
* insert TradeItem(Lamivudine 50 Mg tablet [MFR002 P006009], MFR002, KE, 1095)
// The table gives Child Quantity 30 but no child identifier, so the child
// is named only as not given.
* associatedProduct[+].product.display = "child not identified in the source"
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.value = 30
* insert Eaches(7200)
