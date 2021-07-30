import csv

tsv_file = open('books.tsv')
author_data = csv.reader(tsv_file, delimiter="\t")
list = []
for a in author_data:
    names = a[3].split(",")
    for name in names:
        if name != 'author':
            name = name.strip()
            list.append(name)
print (list)

