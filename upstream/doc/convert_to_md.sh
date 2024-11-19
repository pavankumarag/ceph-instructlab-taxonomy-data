src_files=$(find . -name "*.rst")

for x in $src_files ; do
	tgt_file=$(echo $x|sed 's/rst/md/')
	echo "/root/pandoc-3.3/bin/pandoc $x -t markdown -o $tgt_file"
	/root/pandoc-3.3/bin/pandoc $x -t markdown -o $tgt_file
done


