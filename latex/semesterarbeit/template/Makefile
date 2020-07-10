##
## Ext variables for build ctrl. All use a default set
##
MAINFILE ?= Thesis.tex
DEBUG ?= 0

##
## Used commands by the build process
##
CWD := $(shell pwd)
RM  := rm
_MK_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
_CWD_NAME := $(notdir $(patsubst %/,%,$(dir $(_MK_PATH))))
##
## Internal variables
##
_BUILD_DIR=_build
_OUT_DIR=_output
_XFIG_DIR=fig
_SVG_DIR=svg
_IMG_DIR=pictures
_MAINFILE:= $(MAINFILE:.tex=)
_DB_DIR=database
_EXAMPLE_SRC_DIR=src
_MAINFILE:= $(MAINFILE:.tex=)
_CONTENT_DIR=content
_TEMPLATE_DIR=template
_TEMPLATE_DIRS=${_CONTENT_DIR} \
	${_XFIG_DIR} \
	${_SVG_DIR} \
	${_IMG_DIR} \
	${_DB_DIR} \
	${_EXAMPLE_SRC_DIR}

_BUILD_DIRS=${_BUILD_DIR} \
            ${_OUT_DIR}

#_MAKE_LATEX_IF="make_parameters.tex"

ifeq (${_CWD_NAME},${_TEMPLATE_DIR})
  _DESTINATION_DIR=..
else
  _DESTINATION_DIR=.
endif

export _TEMPLATE_DIR
export _CONTENT_DIR
export _DESTINATION_DIR

##
## Lists
##
SVGFILES := $(wildcard $(_SVG_DIR)/*.svg)
XFIGFILES := $(wildcard $(_XFIG_DIR)/*.fig)

export TEXINPUTS :=./:$(_TEMPLATE_DIR)/sty/:$(_TEMPLATE_DIR)/:exsrc/:pictures/:fig/:$(TEXINPUTS)

ifeq ($(DEBUG), 2)
# Extra options, these must be available for both pdflatex and latexmk
  _DEFAULT_LATEX_OPTIONS=-synctex=1 -output-directory=$(_BUILD_DIR) -aux-directory=$(_BUILD_DIR)
else ifeq ($(DEBUG), 1)
# Extra options, these must be available for both pdflatex and latexmk
  _DEFAULT_LATEX_OPTIONS=-synctex=1 -output-directory=$(_BUILD_DIR) -aux-directory=$(_BUILD_DIR) -interaction=batchmode 
else
  _DEFAULT_LATEX_OPTIONS=-synctex=1 -output-directory=$(_BUILD_DIR) -aux-directory=$(_BUILD_DIR) -interaction=batchmode -quiet -silent
endif

# Options for glossary
_GLOSSARY_OPTIONS = -q

_LINE_WIDTH = error_line=240 half_error_line=160 max_print_line=240

# Command to build document
_BUILD = $(_LINE_WIDTH) latexmk -pdf -jobname=$(_MAINFILE) $(_DEFAULT_LATEX_OPTIONS) $(_MAINFILE)

# Command to build glossary and glossarylists
# (Not using -d option due to incompatibility with some systems)
_BUILD_GLOSSARY = cd $(BUILD_DIR) &&\
 makeglossaries $(_GLOSSARY_OPTIONS) $(_MAINFILE) &&\
 cd - >/dev/null

.PHONY : init example document document_show archive list help  distclean clean mrproper

help:
	@echo "=========================================================================="
	@echo "MAKE OPTIONS"
	@echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	@echo ""
	@echo "MAINFILE=            : For an alternative exam main file (termExam)"
	@echo "DEBUG=[0|1|2]        : Increase LaTex build verbosity level"
	@echo ""
	@echo "MAKE TARGETS"
	@echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	@echo ">> Information targets"
	@echo "--------------------------------------------------------------------------"
	@echo ""
	@echo "help                 : Print this dialogue"
	@echo "[e*|s*]_show         : Build the exam or solution and display the output in"
	@echo "                       in a viewer"
	@echo "list                 : List available QUESTIONS located in '$(_CONTENT_DIR)/'"
	@echo ""
	@echo ">> Build targets"
	@echo "--------------------------------------------------------------------------"
	@echo ""
	@echo "document             : Build the PDF of $_MAINFILE"
	@echo "document_show        : Build and display the PDF"
	@echo "convert              : Convert *.fig and *.svg files. (The following direct-"
	@echo "                       ories are parsed : '$(_XFIG_DIR)' and '$(_SVG_DIR)')"
	@echo ""
	@echo ">> Clean-up targets"
	@echo "--------------------------------------------------------------------------"
	@echo ""
	@echo "clean                : Remove files in directory '$(_BUILD_DIR)/'"
	@echo "mrproper             : Remove temp files such as '*~'"
	@echo "distclean            : Cleanup everything and remove all '_*' directories"
	@echo ""
	@echo ">> Initialization targets"
	@echo "--------------------------------------------------------------------------"
	@echo ""
	@echo "init                 : Create all directories holding exam source and"
	@echo "                       prepare with a sammples for a first test drive ;-)"
	@echo ""
	@echo "=========================================================================="
	@echo "Author : Andreas HABEGGER <andreas.habegger@bfh.ch>"
	@echo "Date   : 2016-11-30"
	@echo "Version: v2.0"
	@echo "=========================================================================="
	@echo ""

document_show: _document_
	@$(_LINE_WIDTH) latexmk -pdf -pv -bibtex -jobname=$(_MAINFILE) $(_DEFAULT_LATEX_OPTIONS) $(MAINFILE)

init:   $(_TEMPLATE_DIRS) _mkgitignore_ _mklatexmkrc_
	@touch ${_DB_DIR}/.keep
	@touch ${_SVG_DIR}/.keep
	@touch ${_IMG_DIR}/.keep
	@touch ${_CONTENT_DIR}/.keep
	@touch ${_EXAMPLE_SRC_DIR}/.keep
	@echo "Initialization of new thesis environment completed ..."

example: init
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-Thesis.template
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-variables.template
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-abstract.template
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-samples.template
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-sampleCode.template
	@cp ${_DESTINATION_DIR}/${_TEMPLATE_DIR}/placeholder.jpg ${_DESTINATION_DIR}/${_IMG_DIR}/
	@echo "Example doc created..."

list:
	@if [ -d $(_CONTENT_DIR) ]; then ls $(_CONTENT_DIR)/*.tex | cut -d"/" -f2-; fi

document_log: document
	@grep -i --color -n10 error ${_BUILD_DIR}/$(_MAINFILE).log

document: _document_
	@cp $(_BUILD_DIR)/$(_MAINFILE).pdf $(_OUT_DIR)/$(_MAINFILE)_$@.pdf

archive:
	@git archive --format zip --prefix $(_CWD_NAME)/ master > ../$(_CWD_NAME).zip

convert: $(_BUILD_DIRS) _convsvg_  _convfig_

clean:
	@if [ $(_BUILD_DIR) ] && [ `readlink -f $(_BUILD_DIR)` != $(CWD) ]; then find $(_BUILD_DIR)/ -iname '$(_MAINFILE).*' -exec $(RM) '{}' \; ;fi

mrproper:
	@find . -iname '*~' -exec $(RM) '{}' \;
	@find . -iname '#*' -exec $(RM) '{}' \;

distclean: mrproper clean
	@latexmk -C > /dev/null 2>&1
	@if [ $(_BUILD_DIR) ] && [ `readlink -f $(_BUILD_DIR)` != $(CWD) ]; then $(RM) -rf $(_BUILD_DIR) > /dev/null; fi
	@if [ $(_OUT_DIR) ] && [ `readlink -f $(_OUT_DIR)` != $(CWD) ]; then $(RM) -rf $(_OUT_DIR) > /dev/null; fi

_document_: $(_BUILD_DIRS)
	$(eval export TEXINPUTS=$(_CONTENT_DIR):$(TEXINPUTS))
	@$(_BUILD) && echo ""

$(_TEMPLATE_DIRS):
	@if [ ! -d $@ ]; then mkdir -p  ${_DESTINATION_DIR}/$@; fi

$(_BUILD_DIRS):
	@if [ ! -d $@ ]; then mkdir -p  ${_DESTINATION_DIR}/$@; fi

_mkgitignore_:
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-gitignore.template

_mklatexmkrc_:
	@${_DESTINATION_DIR}/${_TEMPLATE_DIR}/heredoc-latexmkrc.template

_convfig_: $(XFIGFILES:%.fig=%.pdf_t)  #$(XFIGFILES:%.fig=%.pdf) #$(XFIGFILES:%.fig=%.png) $(XFIGFILES:%.fig=%.eps)

_convsvg_: $(SVGFILES:%.svg=%.pdf) #$(SVGFILES:%.svg=%.png)

%.eps:%.fig
	fig2dev -L eps $*.fig $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).eps

%.png:%.fig
	fig2dev -L png $*.fig $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).png

%.pdf:%.fig
	fig2dev -L pdf $*.fig $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).pdf

%.pdf_t:%.fig
	fig2dev -L pdftex $*.fig $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).pdf
	fig2dev -L pdftex_t -p $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).pdf $*.fig $(*:$(_XFIG_DIR)/%=$(_BUILD_DIR)/%).pdf_t

%.pdf:%.svg
	inkscape --without-gui --export-area-drawing -A $(*:$(_SVG_DIR)/%=$(_BUILD_DIR)/%).pdf $*.svg

%.eps:%.svg
	inkscape --without-gui --export-area-drawing -E $(*:$(_SVG_DIR)/%=$(_BUILD_DIR)/%).eps $*.svg

%.png:%.svg
	inkscape --without-gui --export-area-drawing -e $(*:$(_SVG_DIR)/%=$(_BUILD_DIR)/%).png $*.svg
