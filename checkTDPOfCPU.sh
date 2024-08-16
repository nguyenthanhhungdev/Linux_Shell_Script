#!/bin/bash
sudo turbostat --Summary --quiet --show PkgWatt --interval 1 | gawk '{ printf("%.2f\n" , $1); fflush(); }' | ttyplot -s 40 -t "Turbostat - CPU Power (watts)" -u "watts"