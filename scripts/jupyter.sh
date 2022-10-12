#!/bin/bash

echo "=== Install and run JupyterLab locally"

python3 -m venv .venv
. .venv/bin/activate

python3 -m pip install pip --upgrade
python3 -m pip install jupyterlab

python3 -m pip install bash_kernel
python3 -m bash_kernel.install

echo "==="
echo "=== running: press ^C to shutdown"
echo "==="
jupyter-lab

