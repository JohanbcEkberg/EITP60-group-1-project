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
git submodule update --init
```

## Make targets

Run the commands below from the repository root:

```bash
make example
```

This builds ELMO and the `MBedAES` example, generates ELMO traces, and runs
the standard trace analysis. The results are saved in `output/`.

To run the reduced Elephant-Dumbo experiment instead:

```bash
make elephant
```

This builds the target in [`elephant-dumbo/`](elephant-dumbo/), generates
traces with ELMO, and runs the CPA script. The CPA results are written to
`output/elephant_dumbo_cpa.csv`.

To remove generated binaries, traces, and analysis output:

```bash
make clean
```

The `clean` target does not remove source files or Git submodules.

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
`MBedAES` Makefile. Re-run `make example` after recompiling the object.

## Elephant-Dumbo ELMO experiment

The paper's real experiment applies CPA to physical power traces from an
unprotected Elephant-Dumbo implementation on an STM32F303 Cortex-M4. It
targets the first Spongent round while absorbing the first associated-data
block. The original target sources, leakage models, and attack code are
available in [`thirdparty/nist-lwc-power-analysis/`](thirdparty/nist-lwc-power-analysis/).

This repository includes a smaller ELMO reproduction in
[`elephant-dumbo/`](elephant-dumbo/).
It runs only the first 160-bit Spongent round, randomizes associated data,
and performs CPA on four mask bytes. Full-key recovery and the paper's
exhaustive-search correction are intentionally omitted.

The target is compiled for ELMO's
Thumb-1/M0-compatible emulator; this is a simulator adaptation, not a claim
that ELMO emulates the STM32F303 Cortex-M4 instruction set.

## License and upstream projects

ELMO and the included third-party projects retain their respective licenses
and attribution notices. See the documentation and license files inside
[`thirdparty/elmo/`](thirdparty/elmo/) and
[`thirdparty/nist-lwc-power-analysis/`](thirdparty/nist-lwc-power-analysis/).
