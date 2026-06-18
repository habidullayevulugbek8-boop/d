# MADINA AI TRADER PRO

# PROJECT RULES

Version: 1.0

---

# PURPOSE

This document defines the mandatory engineering rules for developing MADINA AI TRADER PRO.

Every developer, AI assistant, Codex agent, or contributor must follow these rules before making any modification.

The primary objective is to preserve stability while continuously improving the trading system.

---

# DEVELOPMENT PHILOSOPHY

The project is built around five priorities:

1. Capital Protection
2. Stability
3. Maintainability
4. Performance
5. Profitability

Profitability must NEVER be improved by sacrificing stability.

---

# BEFORE WRITING CODE

Always complete these steps:

1. Read README.md
2. Read every file inside /docs
3. Understand the architecture
4. Understand existing modules
5. Search for existing implementations
6. Avoid duplicate functionality
7. Review recent changes

Never start coding immediately.

---

# BEFORE MODIFYING CODE

Always ask:

Does this functionality already exist?

Can it be improved instead of rewritten?

Can it reuse an existing module?

Will this break compatibility?

Will this increase CPU usage?

Will this increase memory usage?

---

# ARCHITECTURE RULES

Every module has one responsibility.

Do not mix:

AI

Risk

Entry

Exit

Dashboard

Logging

Every subsystem must remain modular.

---

# CODING RULES

Use English names.

Use meaningful variable names.

Avoid hardcoded numbers.

Avoid duplicated calculations.

Avoid duplicated indicators.

Avoid nested code where possible.

Create reusable functions.

Keep functions small.

Every function must have one purpose.

---

# PERFORMANCE RULES

Minimize CopyBuffer()

Cache indicators

Reuse calculations

Avoid repeated loops

Avoid unnecessary allocations

Avoid heavy processing every tick

Prefer calculations on new bars whenever possible

---

# SAFETY RULES

Never remove Stop Loss.

Never remove Risk Engine protection.

Never disable account protection.

Never remove emergency exits.

Never ignore spread filters.

Never bypass risk validation.

---

# CONFIGURATION RULES

Every important parameter must be configurable through Inputs.

User-facing input names should be understandable.

Default values must be conservative.

---

# TESTING RULES

Before every commit:

Compile successfully

Zero critical errors

Review warnings

Verify existing behaviour

Backtest modified logic

Check logs

Check trade management

Check Stop Loss

Check Take Profit

Check Break Even

Check Partial Close

Check Trailing Stop

---

# REFACTORING RULES

Refactoring must preserve behaviour.

Never rewrite large parts unnecessarily.

Refactor in small logical steps.

One logical change per commit.

---

# DOCUMENTATION RULES

Every architectural change must update:

ARCHITECTURE.md

CHANGELOG.md

Relevant module documentation

---

# COMMIT RULES

Commit messages must be clear.

Examples:

feat: improve adaptive trailing

fix: correct AI confidence calculation

refactor: simplify market snapshot

docs: update architecture

perf: reduce CopyBuffer usage

---

# PROHIBITED ACTIONS

Do NOT:

Remove working features

Duplicate trading logic

Duplicate indicators

Introduce hidden behaviour

Ignore compiler warnings

Increase complexity without benefit

Commit untested code

---

# CODE REVIEW CHECKLIST

Before finishing any task verify:

Architecture preserved

Compilation clean

Performance acceptable

Risk management intact

Trading logic preserved

Documentation updated

No duplicate code

No dead code introduced

No unnecessary globals

---

# LONG-TERM GOAL

Transform MADINA AI TRADER PRO into a professional institutional-grade MetaTrader 5 trading system.

The codebase must remain:

Readable

Maintainable

Scalable

High Performance

Professionally documented

Suitable for long-term commercial development.

---

# FINAL RULE

If there is uncertainty:

Do not guess.

Analyze.

Explain.

Then implement the safest solution.
