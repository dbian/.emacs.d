#!/bin/bash -ex
tar  -zcvf ~/Downloads/em.tgz --exclude='*.git' --exclude='*.elc'  --exclude='*~' .
