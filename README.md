

# BIST 100 MATLAB Algorithmic Trading & Backtesting Project

This is a simple backtesting project written in MATLAB for the BIST 100 index. It utilizes an algorithmic trading strategy based on Moving Averages (MA) and the Relative Strength Index (RSI).

## Methodology 

The project uses a machine learning approach by splitting the historical BIST 100 data into two distinct datasets: **Training** and **Testing**. The historical data is used to train the model and optimize the RSI threshold. Once the best threshold is found, it is applied to the separate test dataset and evaluated against a standard Buy-and-Hold strategy.

### The Strategy

* **Short-Term MA:** 3-day moving average.
* **Long-Term MA:** 100-day moving average.
* **Buy Signal:** Triggered when the short-term MA crosses **above** the long-term MA (Golden Cross).
* **Sell Signal:** Triggered when the short-term MA crosses **below** the long-term MA (Death Cross).
* **RSI Filter:** If the current RSI is **above** the optimized threshold (indicating an overbought market), the algorithm will block new buy orders.

### Optimization (Training)

The `rsi.m` script runs an optimization loop over the training dataset. It iterates through RSI thresholds ranging from 68 to 80, evaluating backtest performance to select the threshold that yields the highest return.

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

**Conclusion:** Starting with an initial capital of 10,000 TL, the proposed algorithmic strategy successfully outperformed the traditional Buy-and-Hold method on the test dataset.

## Project Structure

```text
bist100-matlab-ml-scalp/
├── main.m               # Main execution script
├── rsi.m                # RSI calculation and threshold optimization
├── grafik.png           # Chart image showing prices and trade markers
├── sonuc.png            # Screenshot of the terminal output/results
├── islemler.txt         # Auto-generated trade log and summary
└── data/
    ├── egitim_verisi.csv  # Training dataset
    └── test_verisi.csv    # Testing dataset

```

## Data Sources

* **Training Data:** [Kaggle — BIST100 Turkish Stock Market Dataset](https://www.google.com/search?q=https://www.kaggle.com/datasets/umar47/bist100-turkish-stock-market-dataset%3Fresource%3Ddownload)
* **Test Data:** [github.com/zakcali/pandas-ta2numba](https://www.google.com/search?q=https://raw.githubusercontent.com/zakcali/pandas-ta2numba/main/XU100-1D.csv)

## How to Run

1. Open the project folder in MATLAB.
2. Type the following command in the Command Window and press Enter::

```matlab
main

```

**Upon execution, the program will automatically:**

* Determine the optimal RSI threshold using the training data.
* Execute the backtest (buy/sell trades) on the test data.
* Display a plotted chart of price movements and trade entry/exit points.
* Generate an `islemler.txt` file containing the detailed trade log.
