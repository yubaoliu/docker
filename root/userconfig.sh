 
# Install Ruby
sudo apt-add-repository ppa:brightbox/ruby-ng
sudo apt update && sudo apt install -f
sudo apt install -y ruby-full npm

npm install -g remark-cli
 
# echo "on-my-zsh"
# sudo apt install zsh
# sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Config editor
git clone https://github.com/yubaoliu/dotfiles.gi://github.com/yubaoliu/dotfiles.git  ~/dotfiles

cd ~/
rm ~/.vimrc
rm ~/.tmux.conf

ln -s ~/dotfiles/.vimrc
ln -s ~/dotfiles/.tmux.conf


# VIm plugin
# Install tools for editor
sudo apt-get update && \
    apt-get install -y  astyle \
    clang-format \
    python-autopep8

gem install --user-install tmuxinator & \
    bundler 

# completion for tmuxinator
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/local/share/zsh/site-functions/_tmuxinator 

 

