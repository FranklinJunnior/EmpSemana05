#!/bin/bash

cd TutorialBlazor
docker build -t tutorial05 .
docker run -d -p 5000:5000 --name semana05 tutorial05