# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 18:51:19 2024

@author: Prashant Chauhan
"""

import streamlit as st
import pandas as pd
import joblib

# Load the trained Random Forest model and column names
classifier = joblib.load('rf.pkl')
column_names = joblib.load('column_names.pkl')

# Initialize session state for input values
if 'Education' not in st.session_state:
    st.session_state['Education'] = 'Basic'
if 'Marital_Status' not in st.session_state:
    st.session_state['Marital_Status'] = 'Single'
if 'Income' not in st.session_state:
    st.session_state['Income'] = 0
if 'Kidhome' not in st.session_state:
    st.session_state['Kidhome'] = 0
if 'Teenhome' not in st.session_state:
    st.session_state['Teenhome'] = 0
if 'Recency' not in st.session_state:
    st.session_state['Recency'] = 0
if 'MntWines' not in st.session_state:
    st.session_state['MntWines'] = 0
if 'MntFruits' not in st.session_state:
    st.session_state['MntFruits'] = 0
if 'MntMeatProducts' not in st.session_state:
    st.session_state['MntMeatProducts'] = 0
if 'MntFishProducts' not in st.session_state:
    st.session_state['MntFishProducts'] = 0
if 'MntSweetProducts' not in st.session_state:
    st.session_state['MntSweetProducts'] = 0
if 'MntGoldProds' not in st.session_state:
    st.session_state['MntGoldProds'] = 0
if 'NumDealsPurchases' not in st.session_state:
    st.session_state['NumDealsPurchases'] = 0
if 'NumWebPurchases' not in st.session_state:
    st.session_state['NumWebPurchases'] = 0
if 'NumCatalogPurchases' not in st.session_state:
    st.session_state['NumCatalogPurchases'] = 0
if 'NumStorePurchases' not in st.session_state:
    st.session_state['NumStorePurchases'] = 0
if 'NumWebVisitsMonth' not in st.session_state:
    st.session_state['NumWebVisitsMonth'] = 0
if 'AcceptedCmp1' not in st.session_state:
    st.session_state['AcceptedCmp1'] = 0
if 'AcceptedCmp2' not in st.session_state:
    st.session_state['AcceptedCmp2'] = 0
if 'AcceptedCmp3' not in st.session_state:
    st.session_state['AcceptedCmp3'] = 0
if 'AcceptedCmp4' not in st.session_state:
    st.session_state['AcceptedCmp4'] = 0
if 'AcceptedCmp5' not in st.session_state:
    st.session_state['AcceptedCmp5'] = 0
if 'Complain' not in st.session_state:
    st.session_state['Complain'] = 0
if 'Response' not in st.session_state:
    st.session_state['Response'] = 0
if 'Age' not in st.session_state:
    st.session_state['Age'] = 18

# Define the input form for user data
def user_input_features():
    st.session_state['Education'] = st.selectbox('Education', ['Basic', '2n Cycle', 'Graduation', 'Master', 'PhD'], index=['Basic', '2n Cycle', 'Graduation', 'Master', 'PhD'].index(st.session_state['Education']))
    st.session_state['Marital_Status'] = st.selectbox('Marital Status', ['Single', 'Together', 'Married', 'Divorced', 'Widow'], index=['Single', 'Together', 'Married', 'Divorced', 'Widow'].index(st.session_state['Marital_Status']))
    st.session_state['Income'] = st.number_input('Income', min_value=0, value=st.session_state['Income'])
    st.session_state['Kidhome'] = st.number_input('Kidhome', min_value=0, max_value=10, step=1, value=st.session_state['Kidhome'])
    st.session_state['Teenhome'] = st.number_input('Teenhome', min_value=0, max_value=10, step=1, value=st.session_state['Teenhome'])
    st.session_state['Recency'] = st.number_input('Recency', min_value=0, max_value=1000, step=1, value=st.session_state['Recency'])
    st.session_state['MntWines'] = st.number_input('MntWines', min_value=0, value=st.session_state['MntWines'])
    st.session_state['MntFruits'] = st.number_input('MntFruits', min_value=0, value=st.session_state['MntFruits'])
    st.session_state['MntMeatProducts'] = st.number_input('MntMeatProducts', min_value=0, value=st.session_state['MntMeatProducts'])
    st.session_state['MntFishProducts'] = st.number_input('MntFishProducts', min_value=0, value=st.session_state['MntFishProducts'])
    st.session_state['MntSweetProducts'] = st.number_input('MntSweetProducts', min_value=0, value=st.session_state['MntSweetProducts'])
    st.session_state['MntGoldProds'] = st.number_input('MntGoldProds', min_value=0, value=st.session_state['MntGoldProds'])
    st.session_state['NumDealsPurchases'] = st.number_input('NumDealsPurchases', min_value=0, max_value=100, step=1, value=st.session_state['NumDealsPurchases'])
    st.session_state['NumWebPurchases'] = st.number_input('NumWebPurchases', min_value=0, max_value=100, step=1, value=st.session_state['NumWebPurchases'])
    st.session_state['NumCatalogPurchases'] = st.number_input('NumCatalogPurchases', min_value=0, max_value=100, step=1, value=st.session_state['NumCatalogPurchases'])
    st.session_state['NumStorePurchases'] = st.number_input('NumStorePurchases', min_value=0, max_value=100, step=1, value=st.session_state['NumStorePurchases'])
    st.session_state['NumWebVisitsMonth'] = st.number_input('NumWebVisitsMonth', min_value=0, max_value=100, step=1, value=st.session_state['NumWebVisitsMonth'])
    st.session_state['AcceptedCmp1'] = st.selectbox('AcceptedCmp1', [0, 1], index=[0, 1].index(st.session_state['AcceptedCmp1']))
    st.session_state['AcceptedCmp2'] = st.selectbox('AcceptedCmp2', [0, 1], index=[0, 1].index(st.session_state['AcceptedCmp2']))
    st.session_state['AcceptedCmp3'] = st.selectbox('AcceptedCmp3', [0, 1], index=[0, 1].index(st.session_state['AcceptedCmp3']))
    st.session_state['AcceptedCmp4'] = st.selectbox('AcceptedCmp4', [0, 1], index=[0, 1].index(st.session_state['AcceptedCmp4']))
    st.session_state['AcceptedCmp5'] = st.selectbox('AcceptedCmp5', [0, 1], index=[0, 1].index(st.session_state['AcceptedCmp5']))
    st.session_state['Complain'] = st.selectbox('Complain', [0, 1], index=[0, 1].index(st.session_state['Complain']))
    st.session_state['Response'] = st.selectbox('Response', [0, 1], index=[0, 1].index(st.session_state['Response']))
    st.session_state['Age'] = st.number_input('Age', min_value=18, max_value=100, step=1, value=st.session_state['Age'])

    data = {
        'Education': st.session_state['Education'],
        'Marital_Status': st.session_state['Marital_Status'],
        'Income': st.session_state['Income'],
        'Kidhome': st.session_state['Kidhome'],
        'Teenhome': st.session_state['Teenhome'],
        'Recency': st.session_state['Recency'],
        'MntWines': st.session_state['MntWines'],
        'MntFruits': st.session_state['MntFruits'],
        'MntMeatProducts': st.session_state['MntMeatProducts'],
        'MntFishProducts': st.session_state['MntFishProducts'],
        'MntSweetProducts': st.session_state['MntSweetProducts'],
        'MntGoldProds': st.session_state['MntGoldProds'],
        'NumDealsPurchases': st.session_state['NumDealsPurchases'],
        'NumWebPurchases': st.session_state['NumWebPurchases'],
        'NumCatalogPurchases': st.session_state['NumCatalogPurchases'],
        'NumStorePurchases': st.session_state['NumStorePurchases'],
        'NumWebVisitsMonth': st.session_state['NumWebVisitsMonth'],
        'AcceptedCmp1': st.session_state['AcceptedCmp1'],
        'AcceptedCmp2': st.session_state['AcceptedCmp2'],
        'AcceptedCmp3': st.session_state['AcceptedCmp3'],
        'AcceptedCmp4': st.session_state['AcceptedCmp4'],
        'AcceptedCmp5': st.session_state['AcceptedCmp5'],
        'Complain': st.session_state['Complain'],
        'Response': st.session_state['Response'],
        'Age': st.session_state['Age'],
    }
    
    features = pd.DataFrame(data, index=[0])
    return features

# Preprocess and predict function
def preprocess_and_predict(data):
    # Create 'TotalSpent' and 'TotalKids'
    data['TotalSpent'] = data[['MntWines', 'MntFruits', 'MntMeatProducts', 'MntFishProducts', 'MntSweetProducts', 'MntGoldProds']].sum(axis=1)
    data['TotalKids'] = data['Kidhome'] + data['Teenhome']
    
    # One-hot encoding for categorical columns
    data = pd.get_dummies(data, columns=['Education', 'Marital_Status'])
    
    # Ensure the new data has the same columns as the training data
    data = data.reindex(columns=column_names, fill_value=0)
    
    # Predict the cluster label using the trained classifier
    cluster_label = classifier.predict(data)
    
    return cluster_label[0]

# Streamlit app
st.title('Customer Cluster Prediction')

st.write("""
### Enter the following details to predict the cluster
""")

# Collect user input
input_df = user_input_features()

# When the user clicks the Predict button
if st.button('Predict'):
    cluster = preprocess_and_predict(input_df)
    st.write(f"Predicted Cluster: {cluster}")
