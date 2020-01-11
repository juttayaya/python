#!/usr/bin/env python3

import argparse
import csv
import os


def to_csv_payment_dict(csv_filename):
    csv_payment_dict = {}

    with open(csv_filename, 'r', encoding='ISO-8859-1') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            csv_payment_filename = row['csv Filename']
            csv_payment_linenumber = row['csv Linenumber']
            if csv_payment_filename in csv_payment_dict:
                csv_payment_dict[csv_payment_filename].append(int(csv_payment_linenumber))
            else:
                csv_payment_dict[csv_payment_filename] = [int(csv_payment_linenumber)]

    return csv_payment_dict


def to_input_dict(input_dir):
    input_dict = {}
    for file in os.listdir(input_dir):
        if file.endswith(".csv"):
            print(f"Storing input csv {file}")
            with open(os.path.join(input_dir,file), 'r', encoding='ISO-8859-1') as input_csv_file:
                for cnt, csv_line in enumerate(input_csv_file):
                    if file in input_dict:
                        input_dict[file].append(csv_line)
                    else:
                        input_dict[file] = [csv_line]

    return input_dict


def process_csv(csv_filename, input_dir):
    print(f"Processing csv {csv_filename}")

    csv_payment_dict = to_csv_payment_dict(csv_filename)
    input_dict = to_input_dict(input_dir)

    output_missing_csv = input_dir + "_missing.csv"
    with open(output_missing_csv, 'w', encoding='ISO-8859-1') as outputfile:
        for k in input_dict:
            csv_header = input_dict[k][0].rstrip()
            print(f"{csv_header},csv_FileName,csv_MissingLine", file=outputfile)
            break

        for csv_payment_key in sorted(csv_payment_dict):
            csv_payment_values = csv_payment_dict[csv_payment_key]
            csv_payment_values.sort()
            input_values = input_dict[csv_payment_key]
            line_count = 0
            for v in csv_payment_values:
                line_count = line_count + 1

                while v != line_count:
                    missing_line = (input_values[line_count]).rstrip()
                    print(f"{missing_line},{csv_payment_key},{line_count}", file=outputfile)
                    line_count = line_count + 1

            line_count = line_count + 1
            if line_count < len(input_values):
                for c in range(line_count,len(input_values)):
                    missing_line = (input_values[c]).rstrip()
                    print(f"{missing_line},{csv_payment_key},{c}", file=outputfile)

                
def main():
    program_desc = 'Performs automated QA on payment uploads'
    parser = argparse.ArgumentParser(description=program_desc)
    parser.add_argument('-p', '--payment', required=True,
                        help='Partner Payment Report File')
    parser.add_argument('-i', '--input_dir', required=True,
                        help='Payment CSV Input Directory')
    args = parser.parse_args()

    process_csv(args.payment, args.input_dir)


if __name__ == '__main__':
    main()
