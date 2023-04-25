#!/usr/bin/env python
# coding: utf-8

# In[1]:


pip install pandas_profiling


# In[51]:


import numpy as np
import pandas as pd
from pandas_profiling import ProfileReport
import matplotlib.pyplot as plt
import seaborn as sns
get_ipython().run_line_magic('matplotlib', 'inline')
import datetime


# In[5]:


weatherAUS = pd.read_csv(r"D:\Study\INueron Data Analyst\Tableau\Assignment\Tableau project\Asiignment 2\Dataset\weatherAUS.csv")


# In[6]:


weatherAUS_copy = weatherAUS.copy()


# In[7]:


weatherAUS_copy.head()


# In[9]:


weatherAUS_copy.shape


# In[10]:


weatherAUS_copy.columns


# In[11]:


weatherAUS_copy.describe()


# In[12]:


weatherAUS_copy.info()


# In[14]:


weatherAUS_copy.isnull()


# In[15]:


weatherAUS_copy.isna().sum()


# In[22]:


weatherAUS_copy_unclean_Profile = ProfileReport(weatherAUS_copy, title = "weatherAUS_copy_unclean_profile")


# In[23]:


weatherAUS_copy_unclean_Profile


# In[ ]:


## No Duplicate rows


# In[ ]:


weatherAUS_copy['Date']
weatherAUS_copy['Date'] = pd.to_datetime(weatherAUS_copy['Date'], format = "%d-%m-%Y")


# //weatherAUS_copy['Date'] = pd.to_datetime(weatherAUS_copy['Date'], format = "%d-%m-%Y")
# weatherAUS_copy['Date'].dt.year
# weatherAUS_copy['date_year'] = weatherAUS_copy['Date'].dt.year
# grouped_year = weatherAUS_copy.groupby('date_year')
# grouped_year_mean = grouped_year['Rainfall'].agg(np.mean)
# weatherAUS_copy['Rainfall'] = weatherAUS_copy['Rainfall'].fillna(weatherAUS_copy['Rainfall'].mean()) 
# weatherAUS_copy.drop('date_year', axis = 1, inplace = True) //

# In[112]:


weatherAUS_copy = weatherAUS_copy.dropna(how = 'any', subset =['MinTemp','MaxTemp','RainToday','RainTomorrow','WindSpeed9am','WindSpeed3pm','Humidity9am','Humidity3pm','Temp9am','Temp3pm'])
##Too many rows assosiate with them are NA or most value are NA in this columns


# In[100]:


weatherAUS_copy['Rainfall'] = weatherAUS_copy['Rainfall'].fillna(weatherAUS_copy['Rainfall'].mean()) # will use in Rain data not much NAn value so averaged it


# In[124]:


weatherAUS_copy['WindDir9am'] = weatherAUS_copy['WindDir9am'].fillna(weatherAUS_copy['WindDir9am'].mean()) # will use in Rain data not much NAn value so averaged it


# In[126]:


weatherAUS_copy['WindGustDir'] = weatherAUS_copy['WindGustDir'].fillna("Unknown") # ##Direction can be unknown


# In[121]:


weatherAUS_copy['WindGustSpeed'] = weatherAUS_copy['WindGustSpeed'].fillna("Unknown") ##Direction can be unknown


# In[115]:


weatherAUS_copy['WindDir3pm'] = weatherAUS_copy['WindDir3pm'].fillna("Unknown") ##Direction can be unknown


# In[101]:


weatherAUS_copy.drop('Sunshine', axis = 1, inplace = True) #approx 50% are NAn


# In[102]:


weatherAUS_copy.drop('Evaporation', axis = 1, inplace = True) #approx 50% are NAn


# In[104]:


weatherAUS_copy.drop('Pressure9am', axis = 1, inplace = True) #alot are NA will not use in my rain data


# In[105]:


weatherAUS_copy.drop('Pressure3pm', axis = 1, inplace = True) #alot are NA will not use in my rain data


# In[128]:


weatherAUS_copy.drop('Cloud9am', axis = 1, inplace = True) #alot are NA


# In[129]:


weatherAUS_copy.drop('Cloud3pm', axis = 1, inplace = True) #alot are NA


# In[131]:


weatherAUS_copy.isna().sum()


# In[130]:


weatherAUS_copy.shape


# In[132]:


weatherAUS_copy_cleaned_Profile = ProfileReport(weatherAUS_copy, title = "weatherAUS_copy_cleaned_profile")


# In[133]:


weatherAUS_copy_cleaned_Profile 


# In[137]:


weatherAUS_copy.to_csv(r"D:\Study\INueron Data Analyst\Tableau\Assignment\Tableau project\Asiignment 2\Dataset\weatherAUS_cleaned.csv",index=False, header=True)


# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:




