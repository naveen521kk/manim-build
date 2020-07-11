pyinstaller --noconfirm --clean \
    --onefile \
    --add-data="logo.ico;img" \
    --hidden-import=xml \
    --icon=logo.ICO \
    manim.py