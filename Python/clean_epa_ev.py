import pandas as pd

input_file  = r"C:\Users\Matt\Downloads\25data\2025 EPA Rating EV.csv"
output_file = r"C:\Users\Matt\Downloads\25data\EPA_EV_Clean(2).csv"

#skip junk rows below header
df = pd.read_csv(input_file, low_memory=False, skiprows=[1, 2])

#choose and rename column names
columns_to_keep = {
    'Model Year': 'Model_Year',
    'Mfr Name': 'Manufacturer',
    'Division':'Brand',
    'Carline': 'Model',
    'Drive Desc': 'Drive_Type',
    'Carline Class Desc': 'Vehicle_Class',
    'City FE (Guide) - Conventional Fuel':'City_MPGe',
    'Hwy FE (Guide) - Conventional Fuel': 'Hwy_MPGe',
    'Comb FE (Guide) - Conventional Fuel':'Combined_MPGe',
    'Annual Fuel1 Cost - Conventional Fuel': 'Annual_Fuel_Cost',
    'FE Rating (1-10 rating on Label)':'FE_Rating',
    'GHG Rating (1-10 rating on Label)':'GHG_Rating',
    '$ You Save over 5 years (amount saved in fuel costs over 5 years - on label) ': 'Savings_5yr',
    '$ You Spend over 5 years (increased amount spent in fuel costs over 5 years - on label) ': 'Extra_Spend_5yr',
    'City CO2 Rounded Adjusted':'City_CO2',
    'Hwy CO2 Rounded Adjusted': 'Hwy_CO2',
    'Comb CO2 Rounded Adjusted (as shown on FE Label)': 'Combined_CO2',
    'Comb Range as shown on FE Label (miles)': 'Range_Miles_Combined',
    'City Range (miles)': 'Range_Miles_City',
    'Hwy Range (miles)': 'Range_Miles_Hwy',
    '240V Charge Time at 240 volts (hours)':'Charge_Time_240V_hrs',
    '120V Charge time at 120 Volts (hours)':'Charge_Time_120V_hrs',
    'Rated Motor Gen Power (kW)': 'Motor_Power_kW',
    'Battery Type Desc': 'Battery_Type',
    'Regen Braking Type Desc': 'Regen_Braking_Type',
}

#Keep columns that exist
existing = {}
for k, v in columns_to_keep.items():
    if k in df.columns:
        existing[k] = v
df = df[list(existing.keys())].rename(columns=existing)

#remove completely empty rows
df = df.dropna(how='all')

#Remove junk rows where 'Model' is empty
if 'Model' in df.columns:
    df = df[df['Model'].notna()]
    df = df[df['Model'].astype(str).str.strip() != '']
    df = df[df['Model'].astype(str).str.strip() != 'nan']

#cut whitespace from string columns
for col in df.columns:
    if df[col].dtype == 'object':
        df[col] = df[col].str.strip()

#standardize lucid name
df['Brand'] = df['Brand'].str.replace('Lucid USA Inc.', 'Lucid', regex=False)

df.to_csv(output_file, index=False)
print(f"\nclean file saved to:\n{output_file}")


