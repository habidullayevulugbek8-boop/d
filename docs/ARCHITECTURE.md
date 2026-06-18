# MADINA AI TRADER PRO
# SYSTEM ARCHITECTURE

Version: 1.0

---

# PURPOSE

MADINA AI TRADER PRO is not a simple Expert Advisor.

It is an institutional-grade modular trading engine designed for MetaTrader 5.

The primary objective is long-term profitability, capital protection, and adaptive market intelligence.

The project must always prioritize:

1. Stability
2. Risk Control
3. Code Quality
4. Modular Architecture
5. Scalability
6. Maintainability

Profit optimization must NEVER reduce system stability.

---

# CORE PRINCIPLES

Every module has only one responsibility.

No duplicated calculations.

No duplicated indicators.

No duplicated trading logic.

No global chaos.

Every subsystem must communicate only through shared interfaces.

The architecture must remain readable after years of development.

---

# GLOBAL PIPELINE

Initialization

↓

Configuration Validation

↓

Market Snapshot

↓

Market Regime Detection

↓

AI Analysis

↓

Smart Money Analysis

↓

Entry Evaluation

↓

Trade Execution

↓

Position Management

↓

Risk Engine

↓

Exit Engine

↓

Profit Protection

↓

Dashboard

↓

Logging

---

# MAIN MODULES

## Market Snapshot

Responsible for collecting market information only once.

Includes:

EMA

ATR

ADX

RSI

Momentum

Spread

Session

Volume

Volatility

Liquidity

Trend

Structure

No other module should recalculate those values.

---

## AI Engine

Responsible only for decision making.

Produces:

BUY

SELL

WAIT

Confidence Score

Trend Score

Probability

Continuation Score

Reversal Score

Decision Explanation

The AI Engine NEVER sends orders.

---

## Smart Money Engine

Responsible for institutional analysis.

Detect:

Order Blocks

Fair Value Gaps

Liquidity Sweeps

Break Of Structure

Change Of Character

Premium Zones

Discount Zones

Mitigation Blocks

Breaker Blocks

Only produces confirmations.

Never executes trades.

---

## Entry Engine

Receives information from:

AI Engine

Smart Money

Market Snapshot

Risk Engine

Checks all confirmations.

If requirements are satisfied:

Generate trade signal.

Otherwise:

WAIT.

---

## Position Manager

Responsible for:

Break Even

Partial Close

Dynamic Stop

Trailing Logic

Profit Lock

Order Monitoring

Magic Number Management

Never generates new trades.

---

## Exit Engine

Responsible for:

Take Profit

Stop Loss

Trend Reversal Exit

Momentum Exit

Time Exit

Emergency Exit

News Exit

No new positions.

---

## Risk Engine

Responsible for:

Lot Calculation

Drawdown Control

Exposure

Maximum Simultaneous Positions

Maximum Daily Loss

Maximum Weekly Loss

Maximum Floating Risk

Adaptive Risk Scaling

Risk Engine has the highest priority.

---

## Dashboard

Displays:

Current Trend

AI Confidence

Risk

Session

Spread

Open Positions

Floating Profit

Daily Profit

Trade Count

System Status

---

## Logger

Every important decision must be recorded.

Examples:

Entry accepted

Entry rejected

Spread too high

Risk limit exceeded

AI confidence too low

Market regime changed

---

# CODING STANDARDS

Maximum readability.

Small reusable functions.

No hardcoded numbers.

No duplicated code.

No unnecessary global variables.

Every module must compile independently.

Every function must have one purpose.

---

# PERFORMANCE RULES

Indicator values must be cached.

Avoid repeated CopyBuffer() calls.

Avoid unnecessary loops.

Avoid heavy calculations on every tick.

Reuse market snapshot.

Memory usage should remain low.

Execution speed must remain deterministic.

---


## Current Refactoring Baseline

The first professional architecture refactor keeps the existing single-file Expert Advisor layout intact for preset and deployment compatibility while separating the largest runtime responsibilities into smaller helper functions.

Preserved behavior:

- All existing Inputs remain unchanged.
- The Magic Number remains unchanged.
- Existing entry conditions, AI score thresholds, SMC checks, SL/TP formulas and order comments remain unchanged.
- Existing break-even, trailing-stop and partial-close thresholds remain unchanged.

Refactored responsibilities:

- Position management now delegates buy stop management, sell stop management and partial-close execution to dedicated helpers.
- Entry orchestration now separates pre-trade filters, lot validation, AI validation and market-order execution from the main `OnTick()` loop.
- Duplicated partial-close code has been centralized so future exit-engine improvements can be made in one place.

This is intentionally an architectural refactor only. It does not introduce a new strategy or modify trading decisions.


## Performance Snapshot Layer

The EA now maintains a lightweight runtime snapshot for the active symbol/timeframe. The snapshot caches bid, ask, spread, recent rates, indicator buffers, Smart Money scores and directional AI scores so the trading pipeline can reuse calculated state instead of repeatedly calling expensive terminal functions on every tick.

Runtime rules:

- Bid/ask/spread are refreshed every tick.
- Rates and indicator buffers are refreshed on a new bar or first load.
- Smart Money and directional AI calculations are cached per bar.
- Dashboard labels are updated on a configurable interval and only changed when object properties actually differ.
- Dashboard rows use deterministic spacing to prevent overlapping text and flickering in the visual tester.

Trading intent remains unchanged: the cache is an execution-quality and performance layer, not a replacement strategy. High-confidence lot expansion is still bounded by `NormalizeLot()` and broker symbol limits to avoid invalid volume errors.

# FUTURE MODULES

News Filter

Economic Calendar

Machine Learning

Pattern Recognition

Portfolio Manager

Correlation Engine

Trade Statistics

Cloud Optimization

Adaptive AI Learning

Portfolio Risk Allocation

Future modules must integrate without changing existing architecture.

---

# FINAL RULE

Architecture is more important than new features.

Quality is more important than quantity.

Stability is more important than optimization.

Maintainability is more important than complexity.

Every future modification must preserve this architecture.
