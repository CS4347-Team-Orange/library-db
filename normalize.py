import csv, pandas

columnName = ['author']
author_data = pandas.read_csv('books.csv', names=columnName)
csv_to_list = []
csv_to_list.append(author_data)
print(csv_to_list)


