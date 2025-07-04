FROM ubuntu:18.04

ENV DEBIAN_FRONTEND='noninteractive'

#setup android tools
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_SDK_HOME=${ANDROID_HOME}
ENV ANDROID_SDK_ROOT=${ANDROID_HOME}
ENV ANDROID_SDK=${ANDROID_HOME}

ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/cmdline-tools/tools/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/tools/bin"
ENV PATH="${PATH}:${ANDROID_HOME}/build-tools/30.0.2"
ENV PATH="${PATH}:${ANDROID_HOME}/platform-tools"
ENV PATH="${PATH}:${ANDROID_HOME}/emulator"
ENV PATH="${PATH}:${ANDROID_HOME}/bin"

RUN dpkg --add-architecture i386 && \
    apt-get update -yqq && \
    apt-get install -y curl expect git libc6:i386 libgcc1:i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386 openjdk-8-jdk wget unzip vim python3 openssh-server && \
    apt-get clean

RUN groupadd android && useradd -d /opt/android-sdk-linux -g android android

COPY tools /opt/tools
RUN mkdir -p $ANDROID_HOME
RUN cp /opt/tools/commandlinetools-linux.zip $ANDROID_HOME/commandlinetools-linux.zip
# COPY licenses /opt/licenses
WORKDIR /opt/android-sdk-linux

RUN /opt/tools/entrypoint.sh built-in

RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "cmdline-tools;latest"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "build-tools;30.0.2"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platform-tools"
RUN /opt/android-sdk-linux/cmdline-tools/tools/bin/sdkmanager "platforms;android-28"

WORKDIR /opt/tools/atua-toolset
