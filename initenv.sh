/bin/sh
brew install python
brew install neovim
pip2 install neovim
python -m pip install --user numpy scipy matplotlib ipython jupyter pandas sympy nose
personalconf="~/.profile"
echo "alias ls='ls -G'" >> "$personalconf"
echo "export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages" >> "$personalconf"

