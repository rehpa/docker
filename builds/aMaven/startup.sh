#!/bin/bash
mkdir /git
cd /git
git clone $gitrepo
cd *
mvn clean install
cp ./target/*.war /
sleep 2d

