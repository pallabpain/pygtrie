all: test lint coverage docs

test: test2 test3

test2: test.py pygtrie.py
	python2 $<
	python2 -m doctest pygtrie.py

test3: test.py pygtrie.py
	python3 $<
	python3 -m doctest pygtrie.py

lint: .pylintrc pygtrie.py test.py example.py
	lint=$$(which pylint3 2>/dev/null) || lint=$$(which pylint) && \
	"$$lint" --rcfile $^

coverage: test.py pygtrie.py
	cov=$$(which python3-coverage 2>/dev/null) || \
	cov=$$(which python-coverage) && \
	"$$cov" run $< && "$$cov" report -m

docs:
	python3 setup.py build_doc

.PHONY: all test test2 test3 lint coverage docs
