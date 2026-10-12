#!/bin/bash
# usage: encode.sh A|B  -> builds ../v1-exam-X.mp4 and ../v1-exam-X.png from work/X/pNNN.png
set -e
cd "$(dirname "$0")"
S=$1; if [ "$S" = A ]; then F=180; else F=150; fi
FF=$(python3 -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())")
rm -rf fr$S && mkdir fr$S
for ((f=0; f<F; f++)); do p=$(( f*12/30 )); ln -s ../$S/p$(printf %03d $p).png fr$S/f$(printf %04d $f).png; done
$FF -y -loglevel error -framerate 30 -i fr$S/f%04d.png -c:v libx264 -preset slow -crf ${CRF:-20} -pix_fmt yuv420p -profile:v high -tune animation -g 60 -movflags +faststart -an -r 30 ../v1-exam-$S.mp4
cp $S/p000.png ../v1-exam-$S.png
ls -la ../v1-exam-$S.mp4 ../v1-exam-$S.png
