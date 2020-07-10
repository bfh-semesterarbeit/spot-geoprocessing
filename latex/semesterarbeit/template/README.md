<a href="http://www.ti.bfh.ch/bachelor/mikro_und_medizintechnik.html" target="_blank"><img src="https://www.bfh.ch/fileadmin/images/newsmeldungen/2013/BFH_Logo_C_en_100_RGB.png" alt="IMAGE ALT TEXT HERE"/></a>
Bern University of Applied Sciences </br>
HuCE-microLab </br>
Quellgasse 21 </br>
CH-2501 Biel/Bienne </br>


# LaTex Thesis Template/Build System
The repository provides the build environment based on Makefiles using Latex for a thesis.
Include the template as a submodule into a git repository (for more info, see usage below.)

#### Author(s)
* Andreas HABEGGER <andreas.habegger@bfh.ch>
* Lukas STUDER <lukas.studer@bfh.ch>

#### Purpose
* Multipurpose LaTex templated for students at BFH
* Fully LaTex based

#### Tested on
* Debian Linux (8.0 and 9.0)
* Ubuntu LTS (14.04 and 16.04)


## Prerequisites on Debian/Ubuntu
Follow the installation procedure below if you build on Debian/Ubuntu

* Install used packages
```bash
apt install latexmk make git
apt install inkscape
```

* Install used LaTex packages
```bash
apt install texlive-base texlive-generic-recommended texlive-latex-base texlive-latex-extra texlive-extra-utils
apt install texlive-lang-english texlive-lang-french texlive-lang-german
apt install texlive-bibtex-extra
apt install texlive-formats-extra
apt install texlive-pictures
apt install texlive-science
apt install texlive-fonts-extra texlive-font-utils texlive-fonts-recommended
apt install biber
apt install lmodern
```

## HowTo (use this template)

* Create a directory tracked by the VCS Git
```bash
mkdir NAME_DOC_DIR && cd NAME_DOC_DIR && git init
```

* Add the template as a submodule. For further reading [see here](https://git-scm.com/book/en/v2/Git-Tools-Submodules)
```bash
git submodule add git@gitlab.ti.bfh.ch:latex-utils/tpl_latex-thesis.git .template
```
```bash
git status
```
```bash
git submodule init
```
```bash
git submodule update --remote .template
```

* Initialize the exam project to get all needed directories. *(This is needed only once.)*
```bash
ln -s .template/Makefile
```
```bash
make init
```

* Create an example document
```bash
make example
```

* Write the content
** 'content' folder: this is where you put your .tex files
** 'pictures' folder: this is where you put your pictures included in the .tex files


* Build the document
```
make convert
```
```bash
MAINFILE=Thesis.tex make document[_show]
```
* The environment variable **MAINFILE** is needed to specify top file


* Get more detailed information to the make interface by the following command
```bash
make help
```



## Extend the LaTex search envrionment
You can always put your personal files in a proper subdirectory of ~/texmf; for instance, your personal .sty files could go in (where you can put this template if you like to make it global available.)

```bash
~/texmf/tex/latex/bfh/
```
This "personal tree" is always consulted for input files before the other trees and doesn't need hashing (with texhash aka mktexlsr). This is by far the preferred method for personal input files.

If instead you have a folder somewhere, you can set the variable TEXINPUTS in the environment by saying something like

```bash
export TEXINPUTS=/path/to/the/local/folder//:
```
The **//** means that TeX programs will search recursively in that folder; the trailing colon means "append the standard value of TEXINPUTS" (which you don't need to provide).

Note that TEXINPUTS is usually not set; it takes a value as soon as a TeX program is started (by reading a set of texmf.cnf files). However, if the program finds it in the environment, it follows the rule sketched above.

If you need the current directory to be searched for inputs before the local one, then

```bash
export TEXINPUTS=.:/path/to/the/local/folder//:
```
should be the best choice.

I prefer to put content in a folder named *content*, images in a folder called *images* etc. The templates are located in directories named *tplsty* and *tplimage* etc. To avoid the need of prefixing all the file includes I use *TEXINPUTS*. Because one can reorganize the folder structure without the need of updating references throughout the document.
```bash
export TEXINPUTS :=./:tplsty:tplimages:src:images:lead:bib:content:appendix
```


