@echo off
python.%PYVER%\tools\python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
cd manim
..\python.%PYVER%\tools\python.exe -m pip install .
cd ../
dir python.%PYVER%/tools/Scripts
cd ../