all: test1 test2 test4 test5

test1:
	@mkdir -p tmp
	@cp 2.po tmp/
	../POFileFill.in tmp/2.po 1.po
	@diff -u tmp/2.po 2.result.po

test2:
	@mkdir -p tmp
	@cp 3.po tmp/
	../POFileFill.in tmp/3.po 1.po
	@diff -u tmp/3.po 3.result.po

test4:
	@mkdir -p tmp
	../POFileReplace.in --remove-fuzzy 4.po 2 teste2 > tmp/4.po
	@diff -u tmp/4.po 4.result.po

test5:
	@mkdir -p tmp
	../POFileReplace.in --remove-fuzzy 5.po 2 teste2 > tmp/5.po
	@diff -u tmp/5.po 5.result.po

spell1:
	@mkdir -p tmp
	@cp spell1.po spell1.dict tmp
	../POFileSpellShell.in --dict=tmp/spell1.dict tmp/spell1.po

spell2:
	@mkdir -p tmp
	@cp spell2.po tmp
	../POFileSpellShell.in tmp/spell2.po

spell3:
	@mkdir -p tmp
	@cp spell3.po tmp
	../POFileSpellShell.in tmp/spell3.po
