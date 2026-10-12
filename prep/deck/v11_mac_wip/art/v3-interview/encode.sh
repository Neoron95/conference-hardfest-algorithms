#!/bin/bash
# usage: encode.sh A posesdir out.mp4 [rotate_poses]
set -e
S=$1; D=$2; OUT=$3; ROT=${4:-0}
FF=$(python3 -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())")
if [ "$S" = A ]; then T=6; else T=5; fi
NP=$((T*12)); NF=$((T*30))
FR=$D/frames; rm -rf $FR; mkdir -p $FR
for ((f=0; f<NF; f++)); do
  p=$(( (f*12/30 + ROT) % NP ))
  ln -s ../pose_$(printf %03d $p).png $FR/f_$(printf %04d $f).png
done
$FF -y -loglevel error -framerate 30 -i $FR/f_%04d.png -c:v libx264 -preset slow -crf ${CRF:-23} -tune animation \
  -pix_fmt yuv420p -movflags +faststart -an -r 30 $OUT
ls -la $OUT
