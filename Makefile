build_elmo:
	./build.sh elmo

build_example:
	./build.sh example

build_elephant:
	./build.sh elephant

run_example:
	./run.sh example

run_elephant:
	./run.sh elephant

analyze_example:
	python3 ./tools/analyze_traces.py example

analyze_elephant:
	python3 ./tools/analyze_traces.py elephant

example:
	mkdir -p output
	./build.sh elmo
	./build.sh example
	./run.sh example
	python3 ./tools/analyze_traces.py example

elephant:
	mkdir -p output
	./build.sh elephant
	./run.sh elephant
	python3 ./tools/analyze_traces.py elephant

clean:
	rm -rf output
	rm -rf thirdparty/elmo/output