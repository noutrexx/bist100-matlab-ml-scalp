# BIST 100 MATLAB Algorithmic Trading and Backtesting Project

This repository contains a compact MATLAB backtesting study for the BIST 100 index. The strategy combines moving-average crossovers with an RSI filter, then evaluates the result against a buy-and-hold baseline.

## Training and Test Flow

The project uses the bundled historical CSV files under `data/`.

1. `rsi.m` searches RSI thresholds from 68 to 80 on the training dataset.
2. The best threshold is selected from that search.
3. `main.m` applies the chosen threshold to the test dataset.
4. Final strategy value is compared with a buy-and-hold result.

This is a simple parameter search workflow, not a general-purpose machine learning pipeline.

## Strategy Summary

- Short-term moving average: 3 days
- Long-term moving average: 100 days
- Buy signal: short-term average crosses above the long-term average
- Sell signal: short-term average crosses below the long-term average
- RSI filter: new buys are blocked when RSI is above the selected threshold

## Optimization

The `rsi.m` script runs an optimization loop over the training dataset. It iterates through RSI thresholds ranging from 68 to 80 and selects the threshold that yields the highest final portfolio value.

## Results

### Price Action and Executed Trades

<img width="957" height="608" alt="grafik" src="https://github.com/user-attachments/assets/8bc3e83f-89f1-4932-877d-14bf04ba9110" />

### Trade Summary

<img width="247" height="262" alt="sonuc" src="https://github.com/user-attachments/assets/5346839d-76e5-432f-bdf9-cceae0d8052f" />

```text
Selected RSI Threshold : 68
Strategy Final Value   : 50,826.73 TL
Buy & Hold Final Value : 48,894.16 TL
```

With the included sample data, the strategy outperformed the buy-and-hold comparison on the test split.

## Project Structure

```text
bist100-matlab-ml/
├── main.m               Main execution script
├── rsi.m                RSI calculation and threshold search
├── grafik.png           Chart image showing prices and trade markers
├── sonuc.png            Screenshot of the result output
├── islemler.txt         Generated trade log and summary
└── data/
    ├── egitim_verisi.csv  Training dataset
    └── test_verisi.csv    Testing dataset
```

## Data Notes

The repository already includes prepared CSV files inside `data/`.

Original source references used while preparing the datasets:

- Training data: [Kaggle - BIST100 Turkish Stock Market Dataset](https://www.kaggle.com/datasets/umar47/bist100-turkish-stock-market-dataset)
- Test data: [zakcali/pandas-ta2numba XU100-1D.csv](https://raw.githubusercontent.com/zakcali/pandas-ta2numba/main/XU100-1D.csv)

## How to Run

1. Open the project folder in MATLAB.
2. Run the following command in the Command Window:

```matlab
main
```

## Expected Output

Running `main` will:

- Select the RSI threshold from the training data
- Execute the backtest on the test data
- Draw the price and portfolio charts
- Write a trade log to `islemler.txt`

## Requirements

- MATLAB with support for `readtable`, `datetime`, and `movmean`
- The CSV files under `data/`
