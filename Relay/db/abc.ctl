load data
characterset UTF8 length semantics char
infile 'C:\Users\hanky\Desktop\Project\Relay\db\catdic.csv'
append
into table category
fields terminated by ','
trailing nullcols
(catid, xcat, lcat, mcat, scat)