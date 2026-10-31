#!/usr/bin/env python3
"""Draw the dth-pc handbook's product examples from this IG's compiled instances.

The WHO Digital transformation handbook for health product catalogues (dth-pc)
shows example products twice: Fig. 12 (mapping across the product packaging
hierarchy using FHIR resources) and Fig. 13, the NPC01101001 table. Both are
written once, as Product instances in input/fsh/examples/dth-pc-*.fsh. Its
Fig. 9 data model is this IG's Product plus the DthPcTradeItem and
DthPcRegulatedTradeItem logical models (input/fsh/models/dth-pc/). This
script reads what sushi compiled from them and writes:

  dth-pc-fig-9.svg       the three classes, one box per logical model
  dth-pc-fig-9-authorization.md   DthPcRegulatedTradeItem beside ProductAuthorization
  dth-pc-fig-12.svg      the packaging figure, one box per product
  dth-pc-npc-table.md    the NPC01101001 table, one row per trade item

Nothing here holds product data or element names: every label, identifier,
number and cardinality comes from the compiled JSON.

    sushi build . && python3 scripts/dth_pc_figures.py \
        fsh-generated/resources <out-dir> --commit <smart-pcmt sha>
"""
from __future__ import annotations

import argparse
import html
import json
import pathlib

GTIN = "https://www.gs1.org/gtin"
DAR = "http://hl7.org/fhir/StructureDefinition/data-absent-reason"
REPO = "https://github.com/litlfred/smart-pcmt"
FIG12_FSH = "input/fsh/examples/dth-pc-packaging.fsh"
NPC_FSH = "input/fsh/examples/dth-pc-npc-lamivudine.fsh"
FIG9_FSH = "input/fsh/models/dth-pc/dth-pc-fig-9.fsh"
PRODUCT_FSH = "input/fsh/models/product.fsh"
AUTH_FSH = "input/fsh/models/ProductAuthorization.fsh"


def load(resources: pathlib.Path, prefix: str) -> dict[str, dict]:
    out = {}
    for path in sorted(resources.glob(f"Binary-{prefix}*.json")):
        out[path.stem.removeprefix("Binary-")] = json.loads(path.read_text())
    return out


def ident(product: dict, *, gtin: bool) -> str:
    for i in product.get("identifier", []):
        if (i.get("system") == GTIN) == gtin and (gtin or "type" in i):
            return i["value"]
    return ""


def any_id(product: dict) -> str:
    return ident(product, gtin=True) or ident(product, gtin=False) or product["identifier"][0]["value"]


def target_id(assoc: dict) -> str | None:
    ref = assoc["product"].get("reference")
    return ref.rsplit("/", 1)[-1] if ref else None


def quantity(assoc: dict) -> str | None:
    q = assoc.get("quantity", {})
    if any(e.get("url") == DAR for e in q.get("extension", [])):
        return None
    return f"{q['value']:g}" if "value" in q else None


def is_generic(pid: str, products: dict) -> bool:
    return "manufacturer" not in products[pid]


def source_link(commit: str, path: str) -> str:
    return f"{REPO}/blob/{commit}/{path}"


# ---------------------------------------------------------------- Fig. 9

# The classes in the figure's order, the heading the handbook prints for each,
# and the FSH file that defines it. The associations are the figure's.
FIG9_CLASSES = [
    ("Product", "Generic Product", PRODUCT_FSH),
    ("DthPcTradeItem", "Trade Item", FIG9_FSH),
    ("DthPcRegulatedTradeItem", "Regulated Trade Item", FIG9_FSH),
]
FIG9_ASSOC = [("1", "0..*"), ("1", "0..*")]
C_W, C_GAP, C_LH, C_TOP, C_HEAD = 274, 54, 24, 16, 58
C_FILL, C_INK, C_LINE = "#9FD6EE", "#1F2854", "#8C94AC"


def elements(sd: dict) -> list[tuple[int, str, str]]:
    """(depth, name, cardinality) for every element below the root, in order."""
    out = []
    for e in sd["differential"]["element"]:
        parts = e["path"].split(".")
        if len(parts) < 2:
            continue
        out.append((len(parts) - 2, parts[-1], f"{e.get('min', '')}..{e.get('max', '')}"))
    return out


def fig9_svg(sds: dict, commit: str) -> str:
    rows = {sid: elements(sds[sid]) for sid, _, _ in FIG9_CLASSES}
    h = C_TOP * 2 + C_HEAD + max(len(r) for r in rows.values()) * C_LH
    w = len(FIG9_CLASSES) * C_W + (len(FIG9_CLASSES) - 1) * C_GAP + 2
    x = lambda i: 1 + i * (C_W + C_GAP)
    e = html.escape
    o = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}" '
         f'font-family="\'Source Sans Pro\',\'Open Sans\',Helvetica,Arial,sans-serif" font-size="14" role="img">',
         '<title>Relationship between Generic Product, Trade Item and Regulated Trade Item, '
         'drawn from the smart-pcmt logical models</title>']
    for i, (sid, heading, fsh) in enumerate(FIG9_CLASSES):
        x0 = x(i)
        o.append(f'<g id="class-{sid}"><rect x="{x0}" y="0" width="{C_W}" height="{h}" rx="12" fill="{C_FILL}"/>')
        o.append(f'<a href="{e(source_link(commit, fsh))}"><text x="{x0 + 12}" y="{C_TOP + 14}" font-weight="700" '
                 f'fill="{C_INK}">{e(heading.upper())}</text></a>')
        o.append(f'<text x="{x0 + 12}" y="{C_TOP + 32}" font-size="11.5" font-style="italic" fill="{C_INK}">logical model {e(sid)}</text>')
        rs = rows[sid]
        y = lambda k: C_TOP + C_HEAD + k * C_LH
        spine = lambda d: x0 + 10 + d * 8
        tops = [k for k, r in enumerate(rs) if r[0] == 0]
        if tops:
            o.append(f'<path d="M{spine(0)} {y(tops[0]) - 5}V{y(tops[-1]) - 5}" stroke="{C_INK}" stroke-width="0.8"/>')
        for k, (d, name, card) in enumerate(rs):
            if d == 0:
                kids = 0
                while k + kids + 1 < len(rs) and rs[k + kids + 1][0] > 0:
                    kids += 1
                if kids:
                    o.append(f'<path d="M{spine(1)} {y(k) - 5}V{y(k + kids) - 5}" stroke="{C_INK}" stroke-width="0.8"/>')
            tx = x0 + 22 + d * 24
            o.append(f'<path d="M{spine(d)} {y(k) - 5}H{tx - 4}" stroke="{C_INK}" stroke-width="0.8"/>'
                     f'<circle cx="{tx - 4}" cy="{y(k) - 5}" r="2.6" fill="{C_INK}"/>'
                     f'<text x="{tx + 4}" y="{y(k)}" fill="{C_INK}">{e(name)} {e(card)}</text>')
        o.append("</g>")
    for i, (l, r) in enumerate(FIG9_ASSOC):
        x1, x2, yy = x(i) + C_W, x(i + 1), h / 2
        o.append(f'<path d="M{x1} {yy}H{x2}" stroke="{C_LINE}" stroke-width="1.2"/>'
                 f'<text x="{x1 + 6}" y="{yy - 6}" font-size="13" fill="{C_INK}">{l}</text>'
                 f'<text x="{x2 - 6}" y="{yy + 16}" font-size="13" text-anchor="end" fill="{C_INK}">{r}</text>')
    o.append("</svg>")
    return "\n".join(o) + "\n"


def compare_table(a: dict, b: dict, a_fsh: str, b_fsh: str, commit: str) -> str:
    """Two logical models side by side, matched by element path exactly."""
    def paths(sd):
        return {e["path"].split(".", 1)[1]: f"{e.get('min', '')}..{e.get('max', '')}"
                for e in sd["differential"]["element"] if "." in e["path"]}
    pa, pb = paths(a), paths(b)
    out = [f"| Element | [{a['name']}]({source_link(commit, a_fsh)}) | [{b['name']}]({source_link(commit, b_fsh)}) |",
           "| --- | --- | --- |"]
    for p in list(pa) + [p for p in pb if p not in pa]:
        out.append(f"| `{p}` | {f'`{pa[p]}`' if p in pa else '—'} | {f'`{pb[p]}`' if p in pb else '—'} |")
    return "\n".join(out) + "\n"


# ---------------------------------------------------------------- Fig. 12

BOX_W, BOX_H, GAP_X, GAP_Y, PAD = 340, 96, 70, 36, 40


def fig12_svg(products: dict, commit: str) -> str:
    generics = [p for p in products if is_generic(p, products)]
    packs = {p: [a for a in products[p].get("associatedProduct", [])
                 if (t := target_id(a)) and t in products and not is_generic(t, products)]
             for p in products}
    contained = {target_id(a) for edges in packs.values() for a in edges}
    tops = [p for p in products if p not in generics and p not in contained]

    chains = []
    for top in tops:
        chain, cur = [top], top
        while packs[cur]:
            cur = target_id(packs[cur][0])
            chain.append(cur)
        chains.append(chain)
    # As in the handbook: the shortest chain sits beside the generic product,
    # the others below it, reached by a line down the left margin.
    chains.sort(key=len)
    rows: list[list[str]] = [generics + chains[0]] + chains[1:] if chains else [generics]

    pos = {}
    for r, row in enumerate(rows):
        for c, pid in enumerate(row):
            pos[pid] = (PAD + c * (BOX_W + GAP_X), PAD + r * (BOX_H + GAP_Y))
    width = PAD * 2 + max(len(r) for r in rows) * (BOX_W + GAP_X) - GAP_X
    height = PAD * 2 + len(rows) * (BOX_H + GAP_Y) - GAP_Y
    href = source_link(commit, FIG12_FSH)

    parts = [
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {width} {height}" '
        f'width="{width}" height="{height}" role="img" font-family="sans-serif">',
        "<title>Mapping across product packaging hierarchy using FHIR resource</title>",
        "<desc>Generated by smart-pcmt scripts/dth_pc_figures.py from the Product "
        f"instances in {FIG12_FSH} at {commit}.</desc>",
        '<defs><marker id="arrow" viewBox="0 0 10 10" refX="10" refY="5" markerWidth="8" '
        'markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" '
        'fill="#2b2f4a"/></marker></defs>',
    ]

    def box(pid: str) -> None:
        x, y = pos[pid]
        p = products[pid]
        lines = [("identifier", any_id(p))]
        for a in p.get("associatedProduct", []):
            t = target_id(a)
            if t and t in products and not is_generic(t, products):
                lines.append((a["relationship"][0]["code"], f"{quantity(a) or '?'} × {any_id(products[t])}"))
        parts.append(f'<a href="{html.escape(href)}" target="_blank"><g id="{pid}">')
        parts.append(f'<rect x="{x}" y="{y}" width="{BOX_W}" height="{BOX_H}" rx="14" '
                     'fill="#acd3ea" stroke="#2b2f4a" stroke-width="1"/>')
        parts.append(f'<text x="{x + 14}" y="{y + 26}" font-size="13" font-weight="bold" '
                     f'fill="#2b2f4a">{html.escape(p["name"][0]["value"])}</text>')
        for i, (k, v) in enumerate(lines):
            parts.append(f'<text x="{x + 14}" y="{y + 54 + i * 22}" font-size="13" fill="#2b2f4a">'
                         f'{html.escape(k)} <tspan font-weight="bold">{html.escape(v)}</tspan></text>')
        parts.append("</g></a>")

    for pid in pos:
        box(pid)

    def arrow(x1, y1, x2, y2, label, dashed=False):
        dash = ' stroke-dasharray="5 4"' if dashed else ""
        parts.append(f'<path d="M{x1},{y1} L{x2},{y2}" stroke="#2b2f4a" fill="none"{dash} '
                     'marker-end="url(#arrow)"/>')
        if label:
            parts.append(f'<text x="{(x1 + x2) / 2}" y="{(y1 + y2) / 2 - 6}" font-size="12" '
                         f'text-anchor="middle" fill="#2b2f4a">{html.escape(label)}</text>')

    for p, edges in packs.items():
        for a in edges:
            t = target_id(a)
            (x1, y1), (x2, y2) = pos[p], pos[t]
            arrow(x1 + BOX_W, y1 + BOX_H / 2, x2, y2 + BOX_H / 2, quantity(a) or "")
    # A trade item names its generic product; the figure draws that link from the
    # generic, so the arrow runs generic -> trade item, dashed.
    spine = PAD / 2
    for p in products:
        for a in products[p].get("associatedProduct", []):
            t = target_id(a)
            if t in generics and p in tops:
                (gx, gy), (px, py) = pos[t], pos[p]
                if py == gy:
                    arrow(gx + BOX_W, gy + BOX_H / 2, px, py + BOX_H / 2, "", dashed=True)
                else:
                    parts.append(f'<path d="M{gx},{gy + BOX_H / 2} L{spine},{gy + BOX_H / 2} '
                                 f'L{spine},{py + BOX_H / 2} L{px},{py + BOX_H / 2}" stroke="#2b2f4a" '
                                 'fill="none" stroke-dasharray="5 4" marker-end="url(#arrow)"/>')

    parts.append("</svg>")
    return "\n".join(parts) + "\n"


# ---------------------------------------------------------- NPC01101001 table

def reading_order(products: dict, generic: str) -> list[str]:
    """Each outermost pack, then the packs inside it, as the handbook lists them."""
    inner = {t for p in products for a in products[p].get("associatedProduct", [])
             if (t := target_id(a)) and t != generic}
    order: list[str] = []
    for top in (p for p in products if p != generic and p not in inner):
        cur = top
        while cur and cur in products and cur not in order:
            order.append(cur)
            cur = next((t for a in products[cur].get("associatedProduct", [])
                        if (t := target_id(a)) and t != generic), None)
    return order


def npc_table(products: dict, commit: str) -> str:
    generic = next(p for p in products if is_generic(p, products))
    g = products[generic]
    href = source_link(commit, NPC_FSH)
    out = [
        f"| National Product Code | Description | Dosage Form | Route of Administration |",
        "|---|---|---|---|",
        f"| [{any_id(g)}]({href}) | {g['name'][0]['value']} | {g.get('dosageForm', {}).get('text', '')} "
        f"| {', '.join(r.get('text', '') for r in g.get('routeOfAdministration', []))} |",
        "",
        "| GTIN | Country Trade Item Identifier | Manufacturer | Country of Origin | Child GTIN "
        "| Child SKU | Child Quantity | Quantity of Eaches | Shelf Life |",
        "|---|---|---|---|---|---|---|---|---|",
    ]
    for pid in reading_order(products, generic):
        p = products[pid]
        child_gtin = child_sku = child_qty = eaches = ""
        for a in p.get("associatedProduct", []):
            t = target_id(a)
            if t == generic:
                eaches = quantity(a) or ""
                continue
            child_qty = quantity(a) or ""
            if t and t in products:
                child_gtin = ident(products[t], gtin=True)
                child_sku = ident(products[t], gtin=False)
            else:
                i = a["product"].get("identifier", {})
                if i.get("system") == GTIN:
                    child_gtin = i.get("value", "")
                else:
                    child_sku = i.get("value", "")
        country = p.get("countryOfOrigin", {}).get("coding", [{}])[0].get("code", "")
        shelf = p.get("shelfLife", {}).get("value")
        out.append("| " + " | ".join([
            ident(p, gtin=True), ident(p, gtin=False), p.get("manufacturer", {}).get("display", ""),
            country, child_gtin, child_sku, child_qty, eaches,
            f"{shelf:g}" if shelf is not None else "",
        ]) + " |")
    return "\n".join(out) + "\n"


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("resources", type=pathlib.Path, help="sushi's fsh-generated/resources")
    ap.add_argument("out", type=pathlib.Path)
    ap.add_argument("--commit", required=True, help="the smart-pcmt commit the instances come from")
    args = ap.parse_args()
    args.out.mkdir(parents=True, exist_ok=True)
    sds = {sid: json.loads((args.resources / f"StructureDefinition-{sid}.json").read_text())
           for sid in ("Product", "DthPcTradeItem", "DthPcRegulatedTradeItem", "ProductAuthorization")}
    (args.out / "dth-pc-fig-9.svg").write_text(fig9_svg(sds, args.commit))
    (args.out / "dth-pc-fig-9-authorization.md").write_text(compare_table(
        sds["DthPcRegulatedTradeItem"], sds["ProductAuthorization"], FIG9_FSH, AUTH_FSH, args.commit))
    (args.out / "dth-pc-fig-12.svg").write_text(fig12_svg(load(args.resources, "DthPcFig12"), args.commit))
    (args.out / "dth-pc-npc-table.md").write_text(npc_table(load(args.resources, "DthPcNpc"), args.commit))


if __name__ == "__main__":
    main()
