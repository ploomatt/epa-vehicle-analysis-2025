import pandas as pd

input_file = r"C:\Users\Matt\Downloads\25data\2025 EPA Rating FE Ratings.csv"
output_file = r"C:\Users\Matt\Downloads\25data\EPA_FE_Ratings_Clean.csv"

df = pd.read_csv(input_file, low_memory=False)

#keep columns
columns_to_keep=[
'Model Year',
'Mfr Name',
'Division',
'Carline',
'Eng Displ',
'# Cyl',
'Transmission',
'# Gears',
'Drive Desc',
'City FE (Guide) - Conventional Fuel',
'Hwy FE (Guide) - Conventional Fuel',
'Comb FE (Guide) - Conventional Fuel',
'Carline Class Desc',
'Annual Fuel1 Cost - Conventional Fuel',
'FE Rating (1-10 rating on Label)',
'GHG Rating (1-10 rating on Label)',
'City CO2 Rounded Adjusted',
'Hwy CO2 Rounded Adjusted',
'Comb CO2 Rounded Adjusted (as shown on FE Label)',
'$ You Save over 5 years (amount saved in fuel costs over 5 years - on label) ',
'$ You Spend over 5 years (increased amount spent in fuel costs over 5 years - on label) ',
'Guzzler? ',
'Air Aspiration Method Desc',
'Stop/Start System (Engine Management System)  Description',
]

#keep columns that only exist in raw file
existing_cols=[]
    for c in columns_to_keep:
        if c in df.columns:
            existing_cols.append(c)
          
df = df[existing_cols]

#remove start & end spaces 
df.columns = df.columns.str.strip()  

#rename columns to be more legible
rename_map = {
    'Model Year':'Model_Year',
    'Mfr Name': 'Manufacturer',
    'Division':'Brand',
    'Carline': 'Model',
    'Eng Displ': 'Engine_Displacement',
    '# Cyl': 'Cylinders',
    'Transmission':'Transmission',
    '# Gears':'Num_Gears',
    'Drive Desc': 'Drive_Type',
    'City FE (Guide) - Conventional Fuel': 'City_MPG',
    'Hwy FE (Guide) - Conventional Fuel': 'Hwy_MPG',
    'Comb FE (Guide) - Conventional Fuel':'Combined_MPG',
    'Carline Class Desc': 'Vehicle_Class',
    'Annual Fuel1 Cost - Conventional Fuel':'Annual_Fuel_Cost',
    'FE Rating (1-10 rating on Label)':'FE_Rating',
    'GHG Rating (1-10 rating on Label)': 'GHG_Rating',
    'City CO2 Rounded Adjusted':'City_CO2',
    'Hwy CO2 Rounded Adjusted': 'Hwy_CO2',
    'Comb CO2 Rounded Adjusted (as shown on FE Label)': 'Combined_CO2',
    '$ You Save over 5 years (amount saved in fuel costs over 5 years - on label) ':'Savings_5yr',
    '$ You Spend over 5 years (increased amount spent in fuel costs over 5 years - on label)': 'Extra_Spend_5yr',
    'Guzzler?': 'Gas_Guzzler',
    'Air Aspiration Method Desc':'Air_Aspiration',
    'Stop/Start System (Engine Management System)  Description': 'StopStart_System',
}

df = df.rename(columns=rename_map)

#remove empty rows
df = df.dropna(how='all')
#get rid of rows where 'Model' is null or is only whitespace
if 'Model' in df.columns:
    df = df[df['Model'].notna()]
    df = df[df['Model'].str.strip() != '']

#cut whitespace from all string columns
for col in df.columns:
    if df[col].dtype =='object':
        df[col] = df[col].str.strip()


df.to_csv(output_file, index=False)
print(f"\nClean file saved to:\n{output_file}")







