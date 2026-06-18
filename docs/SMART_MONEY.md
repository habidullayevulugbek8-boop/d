# MADINA AI TRADER PRO

# SMART_MONEY_ENGINE

Version 1.0

---

# PURPOSE

The Smart Money Engine is responsible for detecting institutional activity.

The engine never predicts.

The engine only identifies areas where institutions are likely active.

Output:

BUY Confirmation

SELL Confirmation

WAIT

Confidence Score

Institutional Score

---

# GENERAL PRINCIPLE

Retail traders usually trade indicators.

Institutions trade liquidity.

The Smart Money Engine must always prioritize liquidity over indicators.

---

# DETECTABLE STRUCTURES

The engine must detect:

Liquidity

Order Blocks

Fair Value Gaps

Break Of Structure

Change Of Character

Mitigation Blocks

Breaker Blocks

Premium Zone

Discount Zone

Equal Highs

Equal Lows

Stop Hunts

Liquidity Sweep

Displacement

Imbalance

Inducement

OTE

SMT Divergence

Institutional Trend

---

# MARKET STRUCTURE

Structure determines trend.

Bullish

Higher High

Higher Low

Bearish

Lower High

Lower Low

No structure

WAIT

---

# BREAK OF STRUCTURE

Bullish BOS

Current High > Previous Swing High

Bearish BOS

Current Low < Previous Swing Low

Requirements

Strong candle

Volume confirmation

Momentum confirmation

ATR confirmation

---

# CHANGE OF CHARACTER

CHOCH appears before trend reversal.

Bullish CHOCH

Lower Low

↓

Higher High

Bearish CHOCH

Higher High

↓

Lower Low

---

# ORDER BLOCK

Bullish Order Block

Last bearish candle before impulsive bullish move.

Bearish Order Block

Last bullish candle before impulsive bearish move.

Requirements

Impulse

Volume

BOS

Fresh Zone

Untested

---

# FAIR VALUE GAP

Three candle imbalance.

Bullish

High Candle1

↓

Gap

↓

Low Candle3

Bearish

Low Candle1

↓

Gap

↓

High Candle3

Minimum size configurable.

---

# LIQUIDITY

Detect

Equal Highs

Equal Lows

Session High

Session Low

Daily High

Daily Low

Weekly High

Weekly Low

Monthly High

Monthly Low

Round Numbers

Psychological Levels

---

# LIQUIDITY SWEEP

Conditions

Liquidity exists

Fast breakout

Immediate rejection

Volume spike

Return inside range

Confirmation required.

---

# IMBALANCE

Measure

Gap Size

Gap Age

Gap Fill

Gap Direction

Importance

0-100

---

# MITIGATION BLOCK

Detect institutional revisit.

Conditions

Existing Order Block

Price Return

Reaction

Momentum

Confirmation

---

# BREAKER BLOCK

Invalid Order Block

↓

Break

↓

Retest

↓

New Direction

---

# PREMIUM

Upper half of dealing range.

Selling preferred.

---

# DISCOUNT

Lower half of dealing range.

Buying preferred.

---

# DEALING RANGE

Highest Swing

↓

Lowest Swing

↓

50%

↓

Premium

↓

Discount

---

# OTE

Optimal Trade Entry

62%

70.5%

79%

Retracement zone.

---

# SMT DIVERGENCE

Compare

Correlated Symbols

Example

Gold

Silver

DXY

Indices

Detect hidden institutional divergence.

---

# DISPLACEMENT

Strong impulsive move.

Requirements

Large candle

Volume

Momentum

Low overlap

ATR expansion

---

# INDUCEMENT

Fake structure.

Purpose

Force retail entries.

Institution later reverses market.

---

# INSTITUTIONAL SCORE

Each confirmation adds score.

Liquidity Sweep

20

Order Block

20

FVG

15

BOS

15

CHOCH

15

OTE

5

Volume

5

Momentum

5

Maximum

100

---

# SIGNAL QUALITY

0-30

Ignore

31-50

Weak

51-70

Average

71-85

Strong

86-100

Institutional

---

# MULTI TIMEFRAME

HTF

Trend

↓

M15

Structure

↓

M5

Entry

↓

M1

Execution

---

# FILTERS

Reject trades if

No BOS

No Liquidity

Weak Momentum

High Spread

No Volume

Counter Trend

Low Confidence

News

---

# AI INTEGRATION

Smart Money never executes trades.

It only sends confirmations to

AI Engine

Entry Engine

Risk Engine

Dashboard

Logger

---

# FUTURE IMPROVEMENTS

Volume Profile

Footprint

DOM

Options Data

COT Data

Machine Learning

Liquidity Heatmaps

Institutional Statistics

Adaptive Scoring

---

# FINAL RULE

Never trade indicators alone.

Trade liquidity.

Trade institutional confirmation.

Trade probability.

Never chase price.

Wait for confirmation.
