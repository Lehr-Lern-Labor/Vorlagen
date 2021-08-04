#private
for i in *_*.tex
do
  pdflatex -jobname ${i%%.*} $i
  pdflatex -jobname ${i%%.*} $i
  pdflatex -jobname ${i%%.*} $i
done
  find . -regextype posix-extended -regex '.+\.(aux|lo[gft]|toc|idx|out|lsg|dvi)' -delete
