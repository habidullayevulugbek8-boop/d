# Changelog

## Unreleased

- Added a cached market snapshot layer to reduce repeated OHLC, volume, spread and indicator work during visual testing.
- Cached Smart Money and directional AI scores per bar to avoid repeated expensive structure calculations.
- Cached cross-market trend detection on the H1 bar so market-intelligence scoring no longer creates temporary indicator handles repeatedly per tick.
- Rebuilt the dashboard with automatic row spacing, throttled updates and cached object property changes to avoid label overlap and flicker.
- Added high-confidence aggressive lot scaling bounded by existing broker and MaxLot validation.

- Refactored position management and entry orchestration into smaller behavior-preserving helpers.
- Removed duplicated partial-close handling between buy and sell position management paths.
- Documented the first architectural refactoring step for maintainability without changing trading logic, inputs, presets, Magic Numbers, or trade management thresholds.
