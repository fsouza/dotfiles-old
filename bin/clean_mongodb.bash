#!/bin/bash -el

mongo --quiet --eval "db.getMongo().getDBNames().forEach(function(i){db.getSiblingDB(i).dropDatabase()})"
