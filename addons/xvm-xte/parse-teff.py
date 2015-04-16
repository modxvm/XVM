import json

with open('xte.csv', 'r') as f:
    lines = f.read().rstrip().split('\n')
lines.pop(0)

data = {}
for line in lines:
   items = line.split(',')
   v = int(items.pop(0))
   ad = float(items.pop(0))
   td = float(items.pop(0))
   af = float(items.pop(0))
   tf = float(items.pop(0))
   x = [float(x) for x in items]
   data[v] = {'ad':ad,'af':af,'td':td,'tf':tf,'x':x}

with open('xte.json', 'w') as f:
    f.writelines(json.dumps(data, separators=(',', ':')))
