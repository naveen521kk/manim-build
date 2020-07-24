# build x86 python

./pythonx86.$PYVER/tools/python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
./pythonx86.$PYVER/tools/python.exe -m pip install -r manim/requirements.txt
cd manim
../pythonx86.$PYVER/tools/python.exe -m pip install .
cd ../
dir pythonx86.$PYVER/tools/Scripts
cd ../