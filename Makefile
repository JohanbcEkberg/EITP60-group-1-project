example:
	mkdir -p output
	./build.sh elmo
	./build.sh example
	./run.sh example
	python3 ./tools/analyze_traces.py example

elephant:
	mkdir -p output
	./build.sh elmo
	./build.sh elephant
	./run.sh elephant
	python3 ./tools/elmo_dumbo_cpa.py

clean:
	rm -rf ./thirdparty/elmo/output/traces
	rm -rf ./output
	rm -rf ./thirdparty/elmo/output
	cd elephant-dumbo && make clean
	cd thirdparty/elmo && make clean