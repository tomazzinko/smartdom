#!/bin/bash
set -e

echo "Installing Oh My Zsh on $SSH_HOST"

su - $SMARTDOM_USER << EOF
    if [ ! -d "\$HOME/.oh-my-zsh" ]; then
        sh -c "\$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi 

    # copy shell.sh to home directory
    cp $SMARTDOM_OPT/shell.sh $SMARTDOM_HOME/shell.sh

    chmod +x $SMARTDOM_HOME/shell.sh
    chown $SMARTDOM_USER:$SMARTDOM_USER $SMARTDOM_HOME/shell.sh

    # Ensure .bashrc contains the line to source shell.sh
    if ! grep -Fxq "source $SMARTDOM_HOME/shell.sh" ~/.bashrc; then
        echo "source $SMARTDOM_HOME/shell.sh" >> ~/.bashrc
    fi

    # Ensure .zshrc contains the line to source shell.sh
    if ! grep -Fxq "source $SMARTDOM_HOME/shell.sh" ~/.zshrc; then
        echo "source $SMARTDOM_HOME/shell.sh" >> ~/.zshrc
    fi
EOF