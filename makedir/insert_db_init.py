#!/usr/bin/python
import sys
import fileinput
import re

SrcDst_db_list = []
signal_db_list = []
insert_contents = []
#print('Start: Insert db_init')

#print 'Number of arguments:', len(sys.argv), 'arguments.'
#print 'Argument List:', str(sys.argv)

insert_file = open(sys.argv[1], 'r')

insert_str = insert_file.read()
insert_contents = list(insert_str.split("\n"))

for line in insert_contents:
   match= re.match(r".+set_SrcDst_db_entry",line)
   if match:
       SrcDst_db_list.append(line)   

   match= re.match(r".+set_signal_db_entry",line)
   if match:
       signal_db_list.append(line)

SrcDst_db_list.sort()
signal_db_list.sort()

template = open(sys.argv[2], 'r')
#template = open("../include/db_init_template.svi","r")
template_str =template.read()
template_contents = list(template_str.split("\n"))

index = template_contents.index('   //-----/\--- insert SrcDst_db')
template_contents[index:index] = SrcDst_db_list

index = template_contents.index('   //-----/\--- insert signal_db')
template_contents[index:index] =signal_db_list

with open(sys.argv[3], 'w') as f:
    for item in template_contents:
        print >> f, item

#for line in template_contents :
#    print(line)

 

