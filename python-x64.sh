# build x64 python

./python.$PYVER/tools/python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
#./python.$PYVER/tools/python.exe -m pip install -r manim/requirements.txt
cd manim
../python.$PYVER/tools/python.exe -m pip install .
cd ../
dir python.$PYVER/tools/Scripts
cd ../