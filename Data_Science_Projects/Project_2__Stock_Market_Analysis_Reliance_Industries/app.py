# -*- coding: utf-8 -*-
"""
Created on Mon Aug  5 21:17:04 2024

@author: Prashant Chauhan
"""

import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.statespace.sarimax import SARIMAX
import warnings

# Suppress specific warnings
warnings.filterwarnings("ignore", message="Non-stationary starting autoregressive parameters found.")
warnings.filterwarnings("ignore", message="Non-invertible starting MA parameters found.")

# Load the data
file_path = 'Reliance_Industries_stock_data.csv'
data = pd.read_csv(file_path)

# Convert the 'Date' column to datetime
data['Date'] = pd.to_datetime(data['Date'], format='%d-%m-%Y')

# Set 'Date' column as the index
data.set_index('Date', inplace=True)

# Set frequency to business days
data = data.asfreq('B', method='ffill')

# Remove commas from numeric columns and convert to numeric types
for col in ['Open', 'High', 'Low', 'Close', 'Adj Close', 'Volume']:
    data[col] = data[col].str.replace(',', '')  # Remove commas

# Handle invalid entries and convert to float
for col in ['Open', 'High', 'Low', 'Close', 'Adj Close', 'Volume']:
    data[col] = pd.to_numeric(data[col], errors='coerce')  # Convert to numeric, invalid parsing will be set as NaN

# Handle missing data
data.ffill(inplace=True)

# Ensure the index is a DatetimeIndex
if not isinstance(data.index, pd.DatetimeIndex):
    data.index = pd.to_datetime(data.index)

# Define a function to forecast stock prices
def forecast_stock_prices(days):
    # SARIMA Model
    model = SARIMAX(data['Close'], 
                    order=(1, 1, 1),
                    seasonal_order=(1, 1, 0, 30))  # Simplified SARIMA seasonal period

    model_fit = model.fit(disp=False, method='lbfgs')

    # Forecast future values
    forecast_steps = days
    forecast = model_fit.get_forecast(steps=forecast_steps)
    forecast_index = pd.date_range(start=data.index[-1] + pd.DateOffset(1), periods=forecast_steps, freq='B')

    # Get forecast mean and confidence intervals
    forecast_mean = forecast.predicted_mean
    forecast_conf_int = forecast.conf_int()

    # Convert forecast to DataFrame
    forecast_df = pd.DataFrame({'Forecast': forecast_mean}, index=forecast_index)
    forecast_df['Lower CI'] = forecast_conf_int.iloc[:, 0]
    forecast_df['Upper CI'] = forecast_conf_int.iloc[:, 1]
    
    # Format the index to remove time component
    forecast_df.index = forecast_df.index.date
    
    return forecast_df

# Streamlit app
st.title('Stock Price Forecasting App')

st.write('This app forecasts the stock prices of Reliance Industries.')

# User input for number of days to forecast
days = st.number_input('Enter the number of days to forecast:', min_value=1, max_value=365, value=30)

# Forecast the stock prices
if st.button('Forecast'):
    forecast_df = forecast_stock_prices(days)

    # Plot the forecast
    plt.figure(figsize=(17, 10))
    plt.plot(data.index, data['Close'], label='Observed')
    plt.plot(forecast_df.index, forecast_df['Forecast'], label='Forecast', color='red')
    plt.fill_between(forecast_df.index, 
                     forecast_df['Lower CI'], 
                     forecast_df['Upper CI'], 
                     color='red', alpha=0.3)
    plt.xlabel('Date')
    plt.ylabel('Close Price')
    plt.title(f'SARIMA Forecast for Next {days} Days')
    plt.legend()
    st.pyplot(plt)

    st.write(forecast_df)