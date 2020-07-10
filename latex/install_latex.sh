#!/bin/bash

# setup project
mkdir semesterarbeit && cd semesterarbeit && git init
git submodule add https://gitlab.ti.bfh.ch/latex-utils/tpl_latex-thesis.git .template
git submodule init
git submodule update --remote .template
ln -s .template/Makefile
make example

# install dependencies
apt install texlive-base texlive-generic-recommended texlive-latex-base texlive-latex-extra texlive-extra-utils
apt install texlive-lang-english texlive-lang-french texlive-lang-german
apt install texlive-bibtex-extra
apt install texlive-formats-extra
apt install texlive-pictures
apt install texlive-science
apt install texlive-fonts-extra texlive-font-utils texlive-fonts-recommended
apt install biber
apt install lmodern
