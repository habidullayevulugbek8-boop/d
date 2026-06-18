# MADINA AI TRADER PRO

# RISK ENGINE

Version 2.0

Institutional Risk Management Specification

---

# PURPOSE

The Risk Engine is the highest-priority module of the entire trading system.

No position may be opened, modified or increased unless approved by the Risk Engine.

Capital preservation is always more important than profit generation.

---

# PRIMARY OBJECTIVES

Protect account balance.

Protect account equity.

Protect accumulated profit.

Minimize drawdown.

Prevent catastrophic loss.

Keep long-term expectancy positive.

---

# PRIORITY

Risk Engine has higher priority than:

AI Engine

Entry Engine

Exit Engine

Smart Money

Indicators

No module can bypass Risk Engine.

---

# INPUT DATA

Risk Engine receives:

Account Balance

Account Equity

Free Margin

Margin Level

Floating Profit

Floating Loss

Daily Profit

Daily Loss

Weekly Profit

Weekly Loss

Monthly Statistics

Open Positions

Maximum Drawdown

ATR

Spread

Volatility

AI Confidence

Entry Score

Market Regime

News Status

---

# ACCOUNT PROTECTION

Continuously monitor:

Balance

Equity

Margin

Margin Level

Daily DD

Weekly DD

Monthly DD

Floating Exposure

If any limit is exceeded:

Trading immediately stops.

---

# POSITION SIZING

Support:

Fixed Lot

Risk %

Dynamic Lot

ATR Lot

Equity Lot

Balance Lot

Confidence Lot

Volatility Lot

Adaptive Lot

Every method must be selectable from Inputs.

---

# AI RISK SCALING

Risk depends on AI Confidence.

Example:

Confidence < 50

↓

Very Small Risk

50–70

↓

Normal Risk

70–90

↓

Increased Risk

90+

↓

Maximum Allowed Risk

Scaling must remain configurable.

---

# VOLATILITY CONTROL

Use ATR.

High ATR

↓

Reduce Lot

Low ATR

↓

Normal Lot

Extreme ATR

↓

No Trading

---

# SPREAD FILTER

Spread

↓

Normal

Trade Allowed

Spread

↓

High

Reduce Risk

Spread

↓

Extreme

No Trading

---

# DRAWDOWN PROTECTION

Monitor:

Current DD

Daily DD

Weekly DD

Monthly DD

Maximum Historical DD

Emergency DD

Actions:

Reduce Risk

Reduce Lot

Pause Trading

Emergency Stop

---

# DAILY LIMITS

Configurable:

Maximum Daily Loss

Maximum Daily Profit

Maximum Trades

Maximum Losing Trades

Maximum Consecutive Losses

After limit:

Trading Disabled

---

# WEEKLY LIMITS

Maximum Weekly Drawdown

Maximum Weekly Loss

Maximum Weekly Trades

Pause Trading

---

# MONTHLY LIMITS

Maximum Monthly Drawdown

Maximum Monthly Exposure

Capital Protection

---

# EXPOSURE CONTROL

Limit:

Maximum Open Trades

Maximum Buy Trades

Maximum Sell Trades

Maximum Symbol Exposure

Maximum Total Risk

---

# CORRELATION CONTROL

Future support:

Gold

Silver

DXY

NASDAQ

SP500

Oil

High correlation

↓

Reduce Exposure

---

# POSITION PYRAMIDING

Allowed only if:

Trend Strong

AI Confidence High

Risk Low

Profit Locked

Otherwise:

Forbidden

---

# MARTINGALE

Disabled.

Never average losses.

Never double lots after losses.

---

# GRID

Disabled.

No recovery grid.

No hidden averaging.

---

# STOP LOSS

Mandatory.

Every trade must have Stop Loss.

Stop Loss may move closer.

Never remove Stop Loss.

---

# BREAK EVEN

Allowed only after:

Minimum Profit

Trend Confirmation

Healthy Position

---

# PARTIAL CLOSE

Configurable.

25%

50%

75%

100%

---

# EMERGENCY MODE

Immediately stop trading if:

Critical DD

Margin Risk

Broker Restriction

Execution Failure

Critical Error

---

# LOGGING

Every decision records:

Reason

Risk Score

Drawdown

Exposure

Margin

Lot Size

Confidence

---

# FUTURE FEATURES

Portfolio Risk

AI Risk Learning

Monte Carlo Validation

Kelly Optimization

Volatility Forecast

Cloud Statistics

Risk Clustering

---

# FINAL RULE

Capital Protection

↓

Risk Control

↓

Trade Quality

↓

Profit

Never reverse this priority.
