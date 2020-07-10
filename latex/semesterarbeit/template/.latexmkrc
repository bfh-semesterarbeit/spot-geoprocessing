$dvi_previewer = 'start xdvi -watchfile 1.5';
$ps_previewer  = 'start gv --watch';
$pdf_previewer = 'start evince';

@cus_dep_list = (@cus_dep_list, "eps pdf 0 eps2pdf");
sub eps2pdf {
   system("epstopdf $_[0].eps"); }

$latex = 'latex -interaction=nonstopmode -shell-escape';

$pdflatex = 'pdflatex -interaction=nonstopmode -shell-escape';

$bibtex_use = 2;
