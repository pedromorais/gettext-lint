all: test1 test2

test1:
	@mkdir -p tmp
	@cp 2.po tmp/
	python ../POFileFill.in tmp/2.po 1.po
	@diff -u tmp/2.po 2.result.po

test2:
	@mkdir -p tmp
	@cp 3.po tmp/
	python ../POFileFill.in tmp/3.po 1.po
	@diff -u tmp/3.po 3.result.po

spell1:
	@mkdir -p tmp
	@cp spell1.po spell1.dict tmp
	python ../POFileSpell.in -i --dict=tmp/spell1.dict tmp/spell1.po

spell2:
	@mkdir -p tmp
	@cp spell2.po tmp
	python ../POFileSpell.in -i tmp/spell2.po

spell3:
	@mkdir -p tmp
	@cp spell3.po tmp
	python ../POFileSpell.in -i tmp/spell3.po

check1:
	@mkdir -p tmp
	python ../POFileChecker.in check1.po > tmp/check1.result.xml
	@diff -u tmp/check1.result.xml check1.result.xml
