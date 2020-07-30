@echo off
pythonx86.%PYVER%\tools\python.exe -m pip install -i https://test.pypi.org/simple/ pycairo
cd manim
..\pythonx86.%PYVER%\tools\python.exe -m pip install .
cd ..\