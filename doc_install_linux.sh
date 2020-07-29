#!/bin/sh
BUILD_DOC=${BUILD_DOC:=1}
SCRIPT_DIR=$(cd `dirname $0`; pwd)
SDK_DIR=$SCRIPT_DIR

# SDK_INSTALL_PATH should be relative path to SDK_DIR
SDK_INSTALL_PATH=.
DOCKER_IMAGE=faststone/sphinx-latexpdf

#build HTML 
if [ $BUILD_DOC -eq 1 ]; then
    echo $CMAKE_OPT
    echo ------------------------  
    echo  build DOC HTML
    echo ------------------------
    cd $SCRIPT_DIR
    mkdir -p $SDK_DIR/bin/doc
	sudo docker run --rm -v ${SDK_DIR}:/docs ${DOCKER_IMAGE} bash -l -c \
	"cd /docs;make html;cp -rf build/html /docs/bin/doc"\
	 || die "cmake failed: r=$?"
fi

#build PDF 
if [ $BUILD_DOC -eq 1 ]; then
    echo $CMAKE_OPT
    echo ------------------------  
    echo  build DOC PDF
    echo ------------------------
    cd $SCRIPT_DIR
    mkdir -p $SDK_DIR/doc
	sudo docker run --rm -v ${SDK_DIR}:/docs ${DOCKER_IMAGE} bash -l -c \
	"cd /docs;make latexpdf;cp -rf build/latex/smarttof.pdf /docs/bin/doc"\
	 || die "cmake failed: r=$?"
fi
