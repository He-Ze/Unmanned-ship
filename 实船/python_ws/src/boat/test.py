f = open('test.txt','a+')
for i in range(10):
    context = str(i)+',' + '\n'
    f.write(context)
f.close()

