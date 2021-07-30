import csv

tsv_file = open('books.tsv')
author_data = csv.reader(tsv_file, delimiter="\t")
list = []
for a in author_data:
    list.append(a[3])
    print (list)
