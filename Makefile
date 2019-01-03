OBJ			= ${OBJ_DIR}student_constants.o ${OBJ_DIR}student_types.o ${OBJ_DIR}Serv.o
OBJ_DIR		= ./obj/
GCC			= g++ -std=c++11
LIBS_DIR   	= -L/usr/local/lib
THRIFT_DIR 	= /usr/local/include/thrift
LIBS		= -lpthread -lthrift
CPP_DEFS	= -D=HAVE_CONFIG_H
CPP_OPTS	= -Wall -O2
GEN_INC  	= -I./gen-cpp -I/usr/local/include/thrift
RUN_LIBS 	= -Wl,-rpath -Wl,/usr/local/lib

demo_3_a 	= ${OBJ_DIR}demo_3.a

all:demo_3.a server client

demo_3.a:${OBJ}
	ar -cr $(OBJ_DIR)$@ $(OBJ)

server:${OBJ_DIR}server.o
	${GCC} ${CPP_OPTS} $< -o $@ ${demo_3_a} ${RUN_LIBS} ${LIBS}

client:${OBJ_DIR}client.o
	${GCC} ${CPP_OPTS} $< -o $@ ${demo_3_a} ${RUN_LIBS} ${LIBS}

${OBJ_DIR}server.o:server.cpp
	${GCC} -c ${CPP_OPTS} ${GEN_INC}  $< -o $@

${OBJ_DIR}client.o:client.cpp
	${GCC} -c ${CPP_OPTS} ${GEN_INC}  $< -o $@

${OBJ_DIR}student_constants.o:./gen-cpp/student_constants.cpp
	${GCC} -c ${CPP_OPTS} $< -o $@

${OBJ_DIR}student_types.o:./gen-cpp/student_types.cpp
	${GCC} -c ${CPP_OPTS} $< -o $@

${OBJ_DIR}Serv.o:./gen-cpp/Serv.cpp
	${GCC} -c ${CPP_OPTS} $< -o $@

clean:
	${RM} -rf obj/*
	${RM} -rf client server

