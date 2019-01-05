include config/base.config

####   
CMAKEVER		= 3.13.2
CMAKESRC		= cmake-${CMAKEVER}
CMAKETAR		= ${CMAKESRC}.tar.gz
CMAKE_INST_PATH	= ${NLYTIQ_INST_PATH}
#--------------------------------------------------------------------------#


### force baseline gcc if GCC_VER is not blank
include config/forcegcc.config

# ${_EPF_} contains the front matter for configure after the include below
include config/configure.prefix.flag.config


all:    	install-cmake

clean:		clean-cmake  


configure-cmake: 
	tar -zxf sources/${CMAKETAR}
	#cd ${CMAKESRC} ; CC=${CC} CXX=${CXX} CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS} ./configure --prefix=${NLYTIQ_INST_PATH}  
	cd ${CMAKESRC} ; ${_EPF} ./configure --prefix=${NLYTIQ_INST_PATH} --no-qt-gui --parallel=${NCPU}
	touch configure-cmake

make-cmake: configure-cmake
	cd ${CMAKESRC} ; make -j${NCPU}
	touch make-cmake
 
install-cmake: make-cmake
	cd ${CMAKESRC} ; make -j${NCPU} install
	touch install-cmake

clean-cmake:
	rm -rf ${CMAKESRC} make-cmake install-cmake configure-cmake cmake
