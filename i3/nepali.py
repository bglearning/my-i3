#!/usr/bin/env python3
import sys
import subprocess
import json

def print_line(message):
    """ non-buffered print to stdout """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    """ interrupted reader for stdin """
    try:
        line = sys.stdin.readline().strip()
        if not line:
            sys.exit(3)
        return line
    except KeyboardInterrupt:
        sys.exit()

def get_cal():
    """ get calender """
    return subprocess.check_output(["nepaliconv", "-bs",
        '-n', '-U', '-f', 'y.m.d' ]).decode('utf-8')[:-1]


def main():
    # skipt the first line which contains the version header
    print_line(read_line())

    # second line contains the start of the infinite array
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        if line.startswith(','):
            line, prefix = line[1:]
        j = json.loads(line)
        j.insert(-1, {'full_text' : get_cal(), 
            'name' : 'nepalical'})
        print_line(prefix + json.dumps(j))

if __name__=="__main__":
    main()

