# MADINA AI TRADER PRO

# ENTRY ENGINE

Version 1.0

---

# PURPOSE

The Entry Engine is responsible for opening positions.

It NEVER predicts.

It evaluates probability.

Only high-quality setups are allowed.

The objective is to reduce bad entries while preserving profitable opportunities.

---

# ENTRY PIPELINE

Market Snapshot

↓

Market Regime

↓

AI Confidence

↓

Smart Money Confirmation

↓

Trend Validation

↓

Risk Validation

↓

Spread Validation

↓

Session Validation

↓

Volume Validation

↓

Entry Score

↓

BUY / SELL / WAIT

---

# BUY CONDITIONS

Required:

✓ Strong Bullish Trend

✓ AI Confidence above threshold

✓ Smart Money Confirmation

✓ Acceptable Spread

✓ Acceptable ATR

✓ Bullish Momentum

✓ Risk Approved

✓ Session Allowed

✓ No News Restriction

---

# SELL CONDITIONS

Required:

✓ Strong Bearish Trend

✓ AI Confidence above threshold

✓ Smart Money Confirmation

✓ Acceptable Spread

✓ Acceptable ATR

✓ Bearish Momentum

✓ Risk Approved

✓ Session Allowed

✓ No News Restriction

---

# ENTRY SCORE

Each confirmation contributes:

Trend ............... 20

AI Confidence ....... 20

Smart Money ......... 20

Momentum ............ 10

ATR ................. 10

Volume .............. 10

Spread .............. 5

Session ............. 5

Maximum Score = 100

---

# ENTRY QUALITY

0–30    Ignore

31–50   Weak

51–70   Normal

71–85   Strong

86–100  Institutional Grade

---

# ENTRY FILTERS

Reject entries if:

Spread too high

Low AI Confidence

Weak Trend

Low Volume

Counter Trend

Low Liquidity

High Volatility (unsafe)

Low Volatility (dead market)

Weekend

Trading Disabled

Risk Limit Exceeded

---

# MULTI-TIMEFRAME LOGIC

HTF

↓

Trend Direction

↓

M15

↓

Structure

↓

M5

↓

Signal

↓

M1

↓

Execution

All timeframes should agree before execution whenever possible.

---

# POSITION LIMITS

Maximum simultaneous positions:

Configurable.

Maximum positions per direction:

Configurable.

Maximum daily trades:

Configurable.

Maximum daily loss:

Configurable.

---

# SAFETY RULES

Never chase price.

Never enter after extreme impulse.

Never average losing positions.

Never remove Stop Loss.

Always respect Risk Engine.

---

# OUTPUT

BUY

SELL

WAIT

Entry Score

Confidence

Reason

---

# FINAL RULE

The Entry Engine opens only high-quality trades.

If there is any doubt,

WAIT.
