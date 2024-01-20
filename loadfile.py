import pandas as pd 
import psycopg2
import sqlalchemy

from sqlalchemy import create_engine
engine = create_engine('postgresql+psycopg2://admin:adminadmin@localhost/postgres')



df = pd.read_csv("files/SB Cen Comm Dist 2 Dem_Voter History.TXT", sep="\t")
df.to_sql('voterhistory', con=engine, if_exists='replace', index=False)


df2 = pd.read_csv("files/SB Cen Comm Dist 2 Dem_Voter Registration.TXT", sep="\t")
df2.to_sql('voter', con=engine, if_exists='replace', index=False)



