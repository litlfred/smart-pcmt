# AGENTS.md — smart-pcmt

This file is agent-generic: Claude Code, Gemini CLI, Cursor, Copilot and others
read it natively. What binds everywhere is the harness's
[`AGENTS.md`](https://github.com/litlfred/cat-harness/blob/HEAD/AGENTS.md); what
this repository *is* is [`README.md`](README.md).

## What this instance is

The WHO SMART Product Catalog implementation guide (`smart.who.int.pcmt`): FHIR
IG source under `input/`, built by the IG Publisher. It takes the
smart-immunizations shape: it has no harness of its own. `index.config.json`
mounts `smart-base` and the layers below it (pins copied from
smart-immunizations), and `smart-pcmt.json` declares what an index may mount
from here.

**sushi must run without error before any commit.**

## Where it sits

```
smart-ra  <-  dth-sc  <-  dth-pc  <-  smart-pcmt
```

smart-pcmt is **downstream of litlfred/dth-pc** (owner, 2026-10-31). dth-pc's
SKOS glossary (`glossary/dth-pc.glossary.json`) defines the product catalogue
concepts: **Product Master Data, Generic Product, Trade Item, Regulated Trade
Item, Product Classification, Country Trade Item Identifier, Unit of Use**. The
logical models here realise those concepts. They never redefine them:

- each logical model's description quotes the dth-pc definition and links its
  SKOS IRI, and the dth-pc term carries `exactMatch` to the model's canonical;
- KG concepts are written Capitalized (owner, 2026-10-31);
- **Trade Item** is the WHO concept with the narrow sense (manufacturer-specific
  branded health products), `broadMatch` the GS1 trade item (litlfred/smart-ra#142);
- code lists (Status, NameType, RegulationType, ProductRelationship,
  AttributeType) stay FHIR CodeSystems, not glossary terms.

The logical models (`GenericProduct`, `TradeItem`, `ProductAuthorization`, and
`RegulatedTradeItem` under `input/fsh/models/`, plus `PCMTGlossary#unit-of-use`
in `input/fsh/codesystems/glossary.fsh`) realise the three-layer product master
data separation from handbook Ch 2 (pp. 28-29, Fig. 9). The WHO-hosted PCMT
catalogue access matrix (`decisions/PC-DT-03.dmn`) and catalogue access, copy,
and export workflow (`processes/PC-BP-09-pcmt-access.bpmn`) realise handbook
Ch 6 §6.2 (pp. 46-47, Fig. 14). Tracked in litlfred/smart-ra#145 and
litlfred/dth-pc#2 §2e (PC-8). Issues are disabled on this fork.

## Sources that are not open

The catalogues are derived from published FHIR IGs such as
`smart.who.int/pcmt-vaxprequal`, which come from proprietary databases. A
source whose licence forbids a copy (a public PDF or API) is recorded with the
ingest's `--reference` arm (identity, checksum, outline, no text). It is never
copied into this repository.

## Rules carried

- No empirical claims in formal content: counts, coverage figures and dates
  stay in cited narrative, never in a model, a code system or a SKOS definition.
- Medical devices are out of scope (the product catalogue handbook excludes them).
- **The declaration names only what an index mounting this instance has.** When
  a directory is added to an index's override, declare it in `smart-pcmt.json`
  in the same change.
- Never push to or open PRs on WorldHealthOrganization/smart-pcmt; this is its fork.
