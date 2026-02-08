# PDL Quickstart Guide

**Product Discovery Lifecycle (PDL)** adds a structured discovery phase before the Triad workflow. Capture ideas, score them, validate with PM, and maintain a prioritized product backlog.

---

## Quick Start

Run a single command to go from idea to backlog-ready:

```bash
/pdl.run "Add dark mode support for the dashboard"
```

This captures the idea, scores it with ICE, validates with PM, and (on approval) adds a user story to the product backlog.

---

## Commands Reference

| Command | Purpose | Input | Output |
|---------|---------|-------|--------|
| `/pdl.run <idea>` | Full discovery flow in one step | Idea description | IDEA + User Story (if approved) |
| `/pdl.idea <idea>` | Capture idea + ICE scoring only | Idea description | IDEA entry in backlog |
| `/pdl.score IDEA-NNN` | Re-score an existing idea | Idea identifier | Updated ICE score |
| `/pdl.validate IDEA-NNN` | PM validation + user story generation | Idea identifier | User Story (if approved) |

### Usage Examples

```bash
# Capture a quick idea
/pdl.idea "Implement webhook notifications for status changes"

# Full evaluation — capture, score, validate, and add to backlog
/pdl.run "User authentication with OAuth2 support"

# Re-evaluate a deferred idea when circumstances change
/pdl.score IDEA-003

# Submit a scored idea for PM review
/pdl.validate IDEA-005
```

---

## ICE Scoring Reference

ICE stands for **Impact**, **Confidence**, and **Effort** (ease of implementation). Each dimension is scored 1-10, with quick-assessment shortcuts:

### Quick-Assessment Anchors

| Dimension | High (9) | Medium (6) | Low (3) |
|-----------|----------|------------|---------|
| **Impact** | Transformative | Solid improvement | Minor enhancement |
| **Confidence** | Proven pattern | Some unknowns | Speculative |
| **Effort (Ease)** | Days of work | Weeks of work | Months of work |

### Priority Tiers

| Score Range | Priority | Action |
|-------------|----------|--------|
| 25-30 | P0 (Critical) | Fast-track to development |
| 18-24 | P1 (High) | Queue for next sprint |
| 12-17 | P2 (Medium) | Consider when capacity allows |
| < 12 | Deferred | Auto-defer; requires PM override via `/pdl.validate` |

### Auto-Defer Gate

Ideas scoring below 12 are automatically deferred. This catches ideas where all dimensions score poorly (e.g., Low/Low/Low = 9). The PM can override this gate using `/pdl.validate IDEA-NNN`.

---

## File Structure

PDL stores data in two markdown tables:

```
docs/product/_backlog/
├── 01_IDEAS.md          # All captured ideas with ICE scores
├── 02_USER_STORIES.md   # PM-validated user stories (product backlog)
└── README.md            # Backlog documentation
```

Both files are auto-created by any PDL command if they don't exist.

---

## Common Workflows

### 1. Capture a Quick Idea

```bash
/pdl.idea "Add export to CSV for reports"
```
Records the idea with ICE scoring. Use later when you want to batch-capture ideas and evaluate them separately.

### 2. Full Evaluation

```bash
/pdl.run "Real-time collaboration for document editing"
```
Captures, scores, validates with PM, and creates a user story — all in one step.

### 3. Promote a Deferred Idea

```bash
/pdl.validate IDEA-003
```
Submits a previously deferred (or scored) idea to PM for review. PM can override the auto-defer gate.

### 4. Re-Evaluate When Context Changes

```bash
/pdl.score IDEA-005
```
Updates an idea's ICE score when new information emerges or priorities shift.

---

## PDL to Triad Handoff

When a user story reaches "Ready for PRD" status:

```bash
/triad.prd dark-mode-support
```

The PRD creation flow will detect backlog items with "Ready for PRD" status and offer to link them. This creates full traceability: IDEA -> User Story -> PRD -> spec -> plan -> tasks.

---

## Known Limitations

- **Single-user assumption**: PDL assumes one user/agent edits backlog files at a time. No concurrent editing safeguards are in place (NFR-4).
- **No score history**: Re-scoring replaces the previous score. Historical scores are not tracked.
- **No archive**: Completed/rejected ideas remain in `01_IDEAS.md`. A future `03_ARCHIVE.md` may be added.

---

## FAQ

**Is PDL mandatory?**
No. PDL is entirely optional. You can still run `/triad.prd` directly without any PDL artifacts.

**Can I skip ICE scoring?**
No. ICE scoring is part of the idea capture flow and cannot be bypassed. Use the quick-assessment shortcuts (High/Medium/Low) for speed.

**What happens to rejected ideas?**
They stay in `01_IDEAS.md` with status "Rejected". You can re-score them with `/pdl.score` (which re-opens them) and then re-submit with `/pdl.validate`.

**How do I customize the auto-defer threshold?**
Edit the threshold value in the PDL skill files (`.claude/skills/pdl-*/SKILL.md`). The default is 12.
