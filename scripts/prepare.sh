#! /bin/bash

# prepares an ubuntu environment for Cairo development
# by installing the required dependencies, taking care 
# to not override the system version of ubuntu.

# this "should" be usable on mac osx, you will just need to uncomment
# the `brew` install_dependencies function below

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

echo "[INFO] shartnet_starkit installing dependencies"
install_dependencies
install_python37

echo "[INFO] shartnet_starkit preparing cairo virtual env"
python3.7 -m venv ~/cairo_venv
install_cairo

test_cairo_install

echo "[INFO] shartnet_starkit installed cairo"