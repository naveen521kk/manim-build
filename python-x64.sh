# build x64 python

export FFMPEG_FILE=ffmpeg-4.3-win64-static
export SOX_FILE=sox-14.4.2-win32
./python.$PYVER/tools/python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
./python.$PYVER/tools/python.exe -m pip install -r manim/requirements.txt
./python.$PYVER/tools/python.exe -m pip install .
cd ../