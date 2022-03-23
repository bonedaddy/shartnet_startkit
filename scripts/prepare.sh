#! /bin/bash


# starknet network supported: alpha-goerli
# note: doesn't do a very good cleanup job

# usage: prepare.sh <enable-vscode-ext>
#
#   enable-vscode-ext: installs vscode extension for cario (default: yes)

# prepares an ubuntu environment for Cairo development
# by installing the required dependencies, taking care 
# to not override the system version of ubuntu.

# with a bit of modification this script will work on mac osx. you will need to
# update teh `install_dependenceis` and `install_python37` functions first.

# links
# * https://www.cairo-lang.org/docs/quickstart.html
# * https://www.cairo-lang.org/docs/hello_starknet/account_setup.html

INSTALL_VSCODE_EXT="$1"

if [[ "$INSTALL_VSCODE_EXT" == "" ]]; then
    INSTALL_VSCODE_EXT="yes"
fi


function install_dependencies() {
    # if running macos comment the following line
    sudo apt install -y libgmp3-dev
    # and uncomment this line
    # brew install gmp
}

function install_python37() {
    if [[ "$(which python3.7)" != "" ]]; then
        echo "[INFO] python3.7 likely already installed"
        return
    else
        echo "[INFO] shartnet_starkit installing python 3.7"
    fi
    wget "https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz"
    tar zxvf Python-3.7.12.tgz
    cd Python-3.7.12
    ./configure --enable-optimizations
    # these steps below here will not work on mac osx
    sudo make -j$(nproc/2) altinstall
    echo "[INFO] it is recommended to add alternative python installations to system settings, if required (this may be damaging not 100% sure):"
    echo "ex: update-alternatives --install /usr/bin/python python /usr/bin/python3.6 1"
    echo "ex: update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2"
}

function install_cairo() {
    pip3.7 install cairo-lang
}

function test_cairo_install() {
    function cleanup() {
        rm test.cairo test_compiled.json 2> /dev/null
    }
    echo """func main():
    [ap] = 1000; ap++
    [ap] = 2000; ap++
    [ap] = [ap - 2] + [ap - 1]; ap++
    ret
end
""" > test.cairo
cairo-compile test.cairo --output test_compiled.json
cairo-run \
  --program=test_compiled.json --print_output \
  --print_info --relocate_prints
  if [[ $? != "0" ]]; then
    cleanup
    echo "[ERROR] shartnet_starkit cairo installation likely failed"
    exit 1
  fi
  cleanup
}


function install_vscode_ext() {
    if [[ "$INSTALL_VSCODE_EXT" != "yes" ]]; then
        return
    fi
    echo "[INFO] shartnet_startkit installing visual studio code extension"
    wget https://github.com/starkware-libs/cairo-lang/releases/download/v0.8.0/cairo-0.8.0.vsix
    code --install-extension cairo-0.8.0.vsix
    rm cairo-0.8.0.vsix
    echo "[INFO] shartnet_startkit installing cairo language server"
    git clone https://github.com/bonedaddy/cairo-ls.git
    cd cairo-ls
    npm i
    vsce package
    code --install-extension caro-ls-0.0.19.vsix
    echo """[INFO] it is recommended to enable the following settings on vscode


\"editor.formatOnSave\": true,
\"editor.formatOnSaveTimeout\": 1500
"""
}


function setup_env_vars() {
    if [[ "$SHELL" == "/bin/fish" ]]; then
        echo "set -x STARKNET_NETWORK alpha-goerli" >> ~/.config/fish/config.fish
        echo "set -x STARKNET_WALLET starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount" >> ~/.config/fish/config.fish
    elif [[ "$SHELL" == "/bin/bash" ]]; then
        echo "export STARKNET_NETWORK=alpha-goerli" >> ~/.bashrc
        echo "export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount" >> ~/.bashrc
    fi
}

echo "[INFO] shartnet_starkit installing dependencies"
install_dependencies
install_python37

echo "[INFO] shartnet_starkit preparing cairo virtual env"
python3.7 -m venv ~/cairo_venv
install_cairo

test_cairo_install

echo "[INFO] shartnet_starkit installed cairo"
install_vscode_ext

echo "[INFO] shartnet_starkit configuring environment variables"
setup_env_vars

echo "[INFO] sharnet_startkit preparation complete. please run the following command from within a new shell to finalize"
echo "starknet deploy_account"