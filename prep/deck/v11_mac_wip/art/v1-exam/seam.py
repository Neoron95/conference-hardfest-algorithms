import sys
from PIL import Image, ImageChops, ImageStat
d, n = sys.argv[1], int(sys.argv[2])
def load(i): return Image.open(f'{d}/p{i:03d}.png').convert('L').resize((410,280))
ims=[load(i) for i in range(n)]
diffs=[]
for i in range(n):
    a,b=ims[i],ims[(i+1)%n]
    diffs.append(ImageStat.Stat(ImageChops.difference(a,b)).mean[0])
srt=sorted(diffs)
print(d,'seam(last->first)=%.2f'%diffs[-1],'median=%.2f'%srt[len(srt)//2],'max=%.2f at %d'%(max(diffs),diffs.index(max(diffs))))
