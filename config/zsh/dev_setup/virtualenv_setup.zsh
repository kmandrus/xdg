# virtualenv setup
# Review virtualenv setup practices before running this again.
# Also, consider replacing with poetry or uv
mkdir ~/.virtualenvs
cd ~/.virtualenvs
python -m venv debugpy
debugpy/bin/python -m pip install debugpy
cd ~
