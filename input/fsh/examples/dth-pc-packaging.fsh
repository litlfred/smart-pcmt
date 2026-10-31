// Example products from the WHO Digital transformation handbook for
// health product catalogues (ISBN 9789240116191, "dth-pc").
// Fig. 11: "Example of packaging variations across manufacturers".
//
// The figure gives identifiers, box titles, links and two quantities.
// It gives no status, unit of use, or count of units of use, all of which
// the Product model requires. Those are marked with data-absent-reason
// (or, for status, set to #active) rather than invented; see the PR.
//
// Link direction follows the Product model: a product points at the
// products it contains (associatedProduct), and a trade item points at
// its generic product with relationship #contains.

Alias: $GTIN = https://www.gs1.org/gtin
Alias: $DAR = http://hl7.org/fhir/StructureDefinition/data-absent-reason

RuleSet: DthPcFig11Source
* description = "Source: WHO, Digital transformation handbook for health product catalogues, Fig. 11 (Example of packaging variations across manufacturers)."

RuleSet: UnitOfUseNotGiven
* unitOfUse.extension[0].url = $DAR
* unitOfUse.extension[0].valueCode = #unknown

RuleSet: ContainsGeneric(generic)
* associatedProduct[+].product = Reference({generic})
* associatedProduct[=].relationship = ProductRelationship#contains
* associatedProduct[=].quantity.extension[0].url = $DAR
* associatedProduct[=].quantity.extension[0].valueCode = #unknown

Instance: DthPcFig11GenericMR001
InstanceOf: Product
Usage: #example
Title: "dth-pc Fig. 11: generic product MR001"
* identifier[0].value = "MR001"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Generic product"
* insert DthPcFig11Source
* status = #active
* insert UnitOfUseNotGiven

Instance: DthPcFig11TradeItemMfrA
InstanceOf: Product
Usage: #example
Title: "dth-pc Fig. 11: trade item (Manufacturer A)"
* identifier[0].system = $GTIN
* identifier[0].value = "17801415202675"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Trade item (MFR A)"
* insert DthPcFig11Source
* status = #active
* manufacturer.display = "Manufacturer A"
* insert UnitOfUseNotGiven
* insert ContainsGeneric(DthPcFig11GenericMR001)

Instance: DthPcFig11MfrBPallet
InstanceOf: Product
Usage: #example
Title: "dth-pc Fig. 11: Manufacturer B pallet (tertiary)"
* identifier[0].system = $GTIN
* identifier[0].value = "18901415202906"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Trade item (MFR B) Tertiary (Pallet)"
* insert DthPcFig11Source
* status = #active
* manufacturer.display = "Manufacturer B"
* insert UnitOfUseNotGiven
* insert ContainsGeneric(DthPcFig11GenericMR001)
* associatedProduct[+].product = Reference(DthPcFig11MfrBCase)
* associatedProduct[=].relationship = ProductRelationship#pallet_contains
* associatedProduct[=].quantity.value = 100

Instance: DthPcFig11MfrBCase
InstanceOf: Product
Usage: #example
Title: "dth-pc Fig. 11: Manufacturer B case (tertiary)"
* identifier[0].system = $GTIN
* identifier[0].value = "08901415202908"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Trade item (MFR B) Tertiary (Case)"
* insert DthPcFig11Source
* status = #active
* manufacturer.display = "Manufacturer B"
* insert UnitOfUseNotGiven
* associatedProduct[+].product = Reference(DthPcFig11MfrBInnerPack)
* associatedProduct[=].relationship = ProductRelationship#case_contains
* associatedProduct[=].quantity.value = 50

Instance: DthPcFig11MfrBInnerPack
InstanceOf: Product
Usage: #example
Title: "dth-pc Fig. 11: Manufacturer B inner pack (secondary)"
* identifier[0].system = $GTIN
* identifier[0].value = "08901415202910"
* name[0].nameType = http://hl7.org/fhir/device-nametype#user-friendly-name
* name[0].value = "Trade item (MFR B) Secondary (Inner pack)"
* insert DthPcFig11Source
* status = #active
* manufacturer.display = "Manufacturer B"
* insert UnitOfUseNotGiven
