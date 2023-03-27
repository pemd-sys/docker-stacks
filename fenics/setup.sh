#!/bin/sh

git clone --branch v0.6.0 --depth 1  git@github.com:FEniCS/dolfinx.git
git clone --branch 2023.1.1.post0 --depth 1  git@github.com:FEniCS/ufl.git
git clone --branch v0.6.0 --depth 1  git@github.com:FEniCS/basix.git
git clone --branch v0.6.0 --depth 1  git@github.com:FEniCS/ffcx.git

# docker build -t fenics .
# rm -rf dolfinx
# rm -rf ufl
# rm -rf basix
# rm -rf ffcx

# git clone --branch  v0.6.0.post0 --depth 1  git@github.com:jorgensd/dolfinx-tutorial.git

