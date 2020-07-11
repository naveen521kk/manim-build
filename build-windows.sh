pyinstaller --noconfirm --clean \
    --add-data="logo.ico;img" \
    --hidden-import=xml \
    --icon=logo.ICO \
    manim.py
