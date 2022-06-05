# ATUA-docker

## Introduction

ATUA is a test automation tool for mobile Apps. It focuses on testing methods updated in each software release. The tool aims to maximize the coverage of updated methods and their instructions with a reduced set of inputs. We created a docker for facilitating the experience of ATUA. All you need is build the docker and run a container from built image. This docker contains the ATUA's toolchain (i.e, including AppDiff, Extended-DM2-Instrumenter, Extended-Gator and ATUA testing tool. This docker contains only a case study for demonstration. Some others case studies can be download from [here](). Due to the limitation of nested virtualization in Windows and Macos, this docker neither supports launching an android emulator. Therefore, the emulator needs to be launched from the host machine.

## Instructions

### Install Docker

Please follow the installation instruction from [Docker's website](https://docs.docker.com/get-docker/) to install Docker.

### Build the ATUA-docker image
There are two ways to build the ATUA-docker image.

1. Build directly from this Git repo.

From the ATUA-docker's directory, run the following command to build the docker image:

        docker build -t atua https://github.com/SNTSVV/ATUA-docker.git
  
- "atua" is just the name given for the built image.

2. If you want to modify the docker (e.g., change the android platform version), you can clone this git, modify the DockerFile and build the image from the context directory.

From the ATUA-docker's directory, run the following command to build the docker image:

        docker build -t atua ./

### Run the ATUA-docker image

Since the docker does not contain subject apps except for a case study included for demonstration,  we have to mount a shared folder between the container and the host. The shared folder can be used to store the output of the testing.

                docker run -it --rm --mount type=bind,source=/tmp/subject-apps,target=/data atua bash
 


