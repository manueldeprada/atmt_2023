import pickle
import torch
import sys

#read file path from first argument
file_path = sys.argv[1]
if len(sys.argv) < 3:
    out_path = file_path[:-4]
else:
    out_path = sys.argv[2]
#if not out path is given, use the same path as the input filE, but removing the txt extension    
tensor_list = []
#read each line. Each line is a sentence as a sequence of integers. save as tensor and add to the list
with open(file_path) as f:
    for line in f:
        tensor_list.append(torch.tensor([int(x) for x in line.split()]))
#save the list as a pickle file
with open(out_path, 'wb') as f:
    pickle.dump(tensor_list, f)
