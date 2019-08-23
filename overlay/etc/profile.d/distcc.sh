
# DISTCC-SPECIFIC STUFF

mkdir -p $HOME/distcc

export CC="distcc arm-linux-gnueabihf-gcc-7"
export CXX="distcc arm-linux-gnueabihf-g++-7"

export DISTCC_DIR=/home/turtle/distcc/
export DISTCC_HOSTS='10.61.7.231/4'
alias cdistcc="catkin build -p$(distcc -j) -j$(distcc -j)"

# distcc-pump needs configuring (include_server_port)
#alias make="distcc-pump make"

#debugging distcc:
#export DISTCC_VERBOSE=1
