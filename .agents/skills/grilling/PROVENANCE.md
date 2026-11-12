# Provenance

Upstream reviewed and adapted on 2026-09-08. Pi questionnaire integration updated on 2026-09-10.

- Upstream: `mattpocock/skills`
- Exact upstream revision: `85f83d3fde1d3a90d5c9a657f6998c79a6c37308`
- Upstream path: `skills/productivity/grilling/`
- Upstream Git tree: `f0732035b8b1b60ae39454e4191caef32fa91903`
- Immutable corroborating vendor: `dmmulroy/.dotfiles@d0b81835146e03a42e374312de47ef9b303f6205`, path `home/.agents/skills/grilling/`
- License: MIT, upstream `LICENSE` blob `f1dd2c09108dde1a5f56097cee8461b3ea834499`

The upstream tree matched Dominik's vendored tree exactly. Reviewed source hashes:

| File | SHA-256 |
| --- | --- |
| `SKILL.md` | `10ff989e7498b23b5acb49d5048f11dcd906757d2f79c5cdf8a00001381296f2` |
| `agents/openai.yaml` | `1411d7df7d99b7e621a1ff8283c8133cc2464be63d064e52d8ce169c6800ee9b` |

Local adaptations preserve the dependency-tree/frontier-round contract while adding: direct current-source investigation; materiality and convergence bounds; Router Mode ownership; conservative treatment of low-risk reversible details; and an explicit no-mutation/shared-understanding gate. The 2026-09-10 integration uses the source-reviewed `@nguyenquangthai/pi-ask@0.1.15` `ask_user_question` tool for TUI frontier rounds, preserves numbered prose fallback, batches frozen frontiers above four questions without advancing dependent branches, and avoids the reviewed optional-multi-select skip defect. Package provenance, focused validation, and rollback are recorded in `~/.agents/adapters/pi/PI-ASK.md`. The metadata short description was updated to match the adapted contract.

## Technical-design completeness gate, 2026-11-12

The personal adaptation now requires implementation-grade technical contracts before presenting or publishing an engineering specification, plan or design, including review drafts. The gate covers current-versus-proposed ownership, concrete storage schemas and relationships, interface payloads and errors, end-to-end data flow, atomicity and concurrency, affected UI/export behavior, compatibility/rollout, and public acceptance/test seams. Inapplicable items require a reason; the gate does not mandate unnecessary tables or abstractions.

The interview's completion criteria now require this gate as well as resolved material decisions and explicit user confirmation. Facts, proposed designs and approved decisions remain separate. The upstream revisions and reviewed upstream hashes above are unchanged. Skill routing and agent metadata were updated to reflect this local addition.
