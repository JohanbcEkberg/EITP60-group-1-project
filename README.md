# EITP60 Group 1 Project

This repository contains the EITP60 Group 1 project and the tools used to
generate and analyse simulated power traces. The project uses
[ELMO](thirdparty/elmo/README.md), a leakage simulator for ARM Thumb code,
and the NIST LWC power-analysis tooling included under `thirdparty/`.

## Repository layout

- `thirdparty/elmo/` - ELMO source code, models, and examples.
- `thirdparty/nist-lwc-power-analysis/` - power-analysis tooling and targets.
- `tools/analyze_traces.py` - summarises ELMO traces and performs a first-byte
  AES CPA.
- `build.sh` and `run.sh` - convenience scripts for building and running the
  examples.
- `output/` - generated plots and CSV summaries. This directory is ignored by
  Git.

## Prerequisites

Install the following tools before building:

- GCC and `make` for compiling ELMO.
- The GNU Arm Embedded Toolchain, including `arm-none-eabi-gcc`.
- Python 3 with `numpy` and `matplotlib` for trace analysis.

The ELMO documentation contains additional installation information in
[`thirdparty/elmo/README.md`](thirdparty/elmo/README.md).

## Initial setup

The ELMO and NIST LWC repositories are Git submodules. Clone and initialise
them with:

```bash
git submodule update --init --recursive
```

## Running the example

From the repository root, build ELMO, build the MBedAES example, generate
traces, and run the trace analysis with:

```bash
make example
```

The individual stages can also be run separately:

```bash
make build_elmo
make build_example
make run_example
make analyze_example
```

The complete example pipeline:

1. Builds the ELMO simulator.
2. Builds the `MBedAES` ARM Thumb binary.
3. Runs ELMO on the binary.
4. Writes the generated traces and analysis data.
5. Saves `output/trace_analysis.png` and
   `output/trace_analysis_summary.csv`.

## Recompiling `elmoasmfunctions.s`

Depending on the toolchain and the version of the ELMO example being used,
modifications to
[`thirdparty/elmo/Examples/elmoasmfunctions.s`](thirdparty/elmo/Examples/elmoasmfunctions.s)
may be needed for the example to run correctly.

After making or applying those modifications, compile the assembly file from
the `thirdparty/elmo/Examples/` directory with:

```bash
arm-none-eabi-gcc -mthumb -mcpu=cortex-m4 -c elmoasmfunctions.s -o elmoasmfunctions.o
```

The resulting `elmoasmfunctions.o` is linked into the example by the
`MBedAES` Makefile. Re-run the example build after recompiling the object:

```bash
make build_example
make run_example
```

## Cleaning generated files

To remove generated analysis output and ELMO output files:

```bash
make clean
```

This does not remove source files or the Git submodules.

## License and upstream projects

ELMO and the included third-party projects retain their respective licenses
and attribution notices. See the documentation and license files inside
[`thirdparty/elmo/`](thirdparty/elmo/) and
[`thirdparty/nist-lwc-power-analysis/`](thirdparty/nist-lwc-power-analysis/).
