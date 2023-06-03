import csv
import codecs

def read_csv_file(filename):
    data = []
    with open(filename, "rb") as csvfile:
        reader = csv.reader(codecs.iterdecode(csvfile, 'utf-8'))
        for row in reader:
            data.append(row)
    return data