#!/bin/bash

# ToDo: output any errors to file

# sudo already prepended where needed
# want pyenv to be installed at standard user's home
if [[ $EUID -eq 0 ]]; then
    echo "[-] Do not run \"$(basename "$0")\" as root or with sudo"
    exit 1
fi

home () { cd /opt; }
home

# --------------------------
# TOOLS INSTALLED UNDER /opt
# __________________________

# Sysinternals Suite
sudo wget https://download.sysinternals.com/files/SysinternalsSuite.zip
sudo unzip SysinternalsSuite.zip -d ./SysinternalsSuite
sudo rm SysinternalsSuite.zip

# Nishang
sudo git clone https://github.com/samratashok/nishang

# SharpCollection
sudo git clone https://github.com/Flangvik/SharpCollection

# PowerSploit
sudo git clone https://github.com/PowerShellMafia/PowerSploit

# Impacket
sudo git clone https://github.com/SecureAuthCorp/impacket

# enum4linux-ng
sudo git clone https://github.com/cddmp/enum4linux-ng

# Privilege Escalation: Linux
# ---------------------------
sudo mkdir -p priv_esc/linux; cd priv_esc/linux

# linux-smart-enumeration
sudo git clone https://github.com/diego-treitos/linux-smart-enumeration

# LinEnum
sudo git clone https://github.com/rebootuser/LinEnum

# linpeas
sudo wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh

# linux-exploit-suggester-2
sudo git clone https://github.com/jondonas/linux-exploit-suggester-2
home

# Privilege Escalation: Windows
# -----------------------------
sudo mkdir priv_esc/windows; cd priv_esc/windows

# winpeas 
sudo wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat
sudo wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany.exe

# EventViewer UAC Bypass
sudo wget https://raw.githubusercontent.com/CsEnox/EventViewer-UACBypass/main/Invoke-EventViewer.ps1

# windows exploit suggester - next generation
sudo git clone https://github.com/bitsadmin/wesng --depth 1
cd wesng
sudo python wes.py --update
home

# -----------------------------------------------
# TOOLS INSTALLED UNDER EXISTING KALI DIRECTORIES
# -----------------------------------------------

# multi OS version of PHP reverse shell
sudo wget -c https://raw.githubusercontent.com/ivan-sincek/php-reverse-shell/master/src/reverse/php_reverse_shell.php \
    -O /usr/share/webshells/php/php-rev_multi-os.php

# ------------------------
# TOOLS INSTALLED WITH APT
# ------------------------

sudo apt update

# seclists
# /usr/share/seclists
sudo apt -y install seclists

# crowbar
sudo apt -y install crowbar

# edb
sudo apt -y install edb-debugger

# rlwrap
sudo apt -y install rlwrap

# gobuster
sudo apt -y install gobuster

# xsel
sudo apt -y install xsel

# xxd
sudo apt -y install xxd

# html2text
sudo apt -y install html2text

# sshpass
sudo apt -y install sshpass

# mingw-w64
sudo apt -y install mingw-w64

# gcc-multilib
sudo apt -y install gcc-multilib

# Exploit-DB Papers
sudo apt -y install exploitdb exploitdb-papers

# ranger
sudo apt -y install ranger caca-utils highlight atool w3m poppler-utils mediainfo
mkdir -p ~/.config/ranger
ranger --copy-config=all

# pyenv prerequisites
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# -----------------------------
# TOOLS WITH CUSTOMIZED INSTALL
# -----------------------------

# CrackMapExec from source
curl -sSL https://install.python-poetry.org | python
sudo apt -y install libssl-dev libffi-dev python-dev-is-python3 build-essential
sudo git clone https://github.com/byt3bl33d3r/CrackMapExec.git
sudo chown -R $(whoami):$(whoami) CrackMapExec
cd CrackMapExec
poetry install

# pyenv install with 2.7.18
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo -e '\n# pyenv' >> ~/.zshrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.zshrc
. ~/.zshrc
pyenv install 2.7.18

# ------------
# CREATE LINKS
# ------------
sudo ln -s /opt/PowerSploit/Privesc /opt/priv_esc/windows/PowerSploit
sudo ln -s /opt/nishang/Escalation /opt/priv_esc/windows/nishang
