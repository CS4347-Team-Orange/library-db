import csv, pandas

tsv_file = open('books.tsv')
author_data = csv.reader(tsv_file, delimiter="\t")
for a in author_data:
	print(a)


