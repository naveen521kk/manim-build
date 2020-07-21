# build x86 python

export FFMPEG_FILE=ffmpeg-4.3-win32-static
export SOX_FILE=sox-14.4.2-win32
./pythonx86.$PYVER/tools/python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
./pythonx86.$PYVER/tools/python.exe -m pip install -r manim/requirements.txt
./pythonx86.$PYVER/tools/python.exe pip -m pip install .
cd ../