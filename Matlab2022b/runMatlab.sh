#!/bin/bash

#mkdir -p /tmp/matlabwrksp
rsync -rtuv ~/Sims/* /tmp/Sims
cd /tmp/Sims
~/Matlab_shortcuts/matlab
rsync -rtuv /tmp/Sims/* ~/Sims


