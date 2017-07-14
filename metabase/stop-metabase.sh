#!/bin/bash
pid=`ps -C "java -jar metabase.jar" -o pid=`
kill -9 $pid
