# Coinbase Algorithmic Trader (Back-End)

## Description
An App that communicate's with Coinbase's REST API and WSS Feed to manage my personal Coinbase Pro account and executes limit orders depending on buy/sell signals generated by calculating rolling averages, bollinger bands and fibonacci retracement.

<br>

This backend hits endpoints on Coinbase's REST API including GET /accounts, GET /orders, POST /orders, DELETE /orders, and GET /fills and serves data as needed for the <a href='https://github.com/cjl248/coinbase-algo-trading/blob/master/README.md'>frontend</a>.
