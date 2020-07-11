# build x86 python

export FFMPEG_FILE=ffmpeg-4.3-win32-static
export SOX_FILE=sox-14.4.2-win32
./pythonx86.$PYVER/tools/python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
./pythonx86.$PYVER/tools/python.exe -m pip install -r manim/requirements.txt
curl -L https://ffmpeg.zeranoe.com/builds/win32/static/$FFMPEG_FILE.zip -o $FFMPEG_FILE.zip
7z x $FFMPEG_FILE.zip -oFFmpeg/
cd FFmpeg && cp -r $FFMPEG_FILE/* . && rm -r $FFMPEG_FILE && cd ../
curl -L http://downloads.sourceforge.net/project/sox/sox/14.4.2/$SOX_FILE.zip -o $SOX_FILE.zip
7z x $SOX_FILE.zip -oSoX/
cd SoX && cp -r $SOX_FILE/* . && rm -r $SOX_FILE && cd ../
cd ../