DIRNAME=$(dirname $0)

owd=`pwd`
cd $DIRNAME
cwd=`pwd`

# Nvim config symbolic links
mkdir -p "$HOME/.config/nvim"
rm $HOME/.config/nvim/*.lua 2>/dev/null

for f in ".config/nvim"/*.lua
do
    ln -s "$cwd/$f" "$HOME/$f"
done

# Tmux config symbolic links
rm $HOME/.tmux.conf
ln -s "$cwd/.tmux.conf" "$HOME/.tmux.conf"
cd $owd

echo "Please update .zshrc manually."
