limit = [60, 30, 10]
dr = [10, 30, 60, 90]

def f(l, d):
  min_limit = l -10
  if d >= min_limit:
      d = min_limit
  return d

for l in limit:
    for d in dr:
        print("l: ", l, "d: ", d, "result: ", f(l,d))
    print()
