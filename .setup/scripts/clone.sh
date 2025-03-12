#!/bin/bash

git clone git@github.com:jeksterslab/manCULTA.git
rm -rf "$PWD.git"
mv manCULTA/.git "$PWD"
rm -rf manCULTA
