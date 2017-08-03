FROM ubuntu:latest

ENV ANDROID_NDK_ROOT=/android-ndk-r15c/

ADD qt-install.qs /

RUN apt-get update

RUN apt-get install -y \
	wget \
	curl \
	unzip \
	git \
	g++ \
	make
	
# Download QT/Android NDK

RUN curl -LS http://download.qt.io/official_releases/qt/5.9/5.9.1/qt-opensource-linux-x64-5.9.1.run -o qt-install.run \
	&& chmod +x qt-install.run 

# Abhängikieten für QT-Installer
RUN apt-get install -y \
	libgl1-mesa-glx \
	libglib2.0-0

# Abhängikkeiten für QT-Komponenten
Run apt-get install -y \
	libfontconfig1 \
	libdbus-1-3 \
	libx11-xcb1

RUN	./qt-install.run --script qt-install.qs --platform minimal -v

RUN curl -LS https://dl.google.com/android/repository/android-ndk-r15c-linux-x86_64.zip -o android-ndk.zip \
	&& unzip android-ndk.zip  -d . 

RUN rm -fv \
	qt-install.run \
	android-ndk.zip \
	qt-install.qs

CMD ["/bin/bash"]
