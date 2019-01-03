#include "Serv.h"

#include <transport/TSocket.h>
#include <transport/TBufferTransports.h>
#include <protocol/TBinaryProtocol.h>
 
using namespace apache::thrift;
using namespace apache::thrift::protocol;
using namespace apache::thrift::transport;

int main(int argc, char **argv) {
    ::apache::thrift::stdcxx::shared_ptr<TSocket> socket(new TSocket("localhost", 9090));
    ::apache::thrift::stdcxx::shared_ptr<TTransport> transport(new TBufferedTransport(socket));
    ::apache::thrift::stdcxx::shared_ptr<TProtocol> protocol(new TBinaryProtocol(transport));

    ServClient client(protocol);
    transport->open();

    Student s;
    s.sno = 123;
    s.sname = "张三";
    s.ssex = 1;
    s.sage = 30;   

    client.put(s);
    
    Student ss;
    printf("get! sno=123\n");
    client.get(ss, 123);
    if (ss.sno != -1) {
        printf("find name=%s, sex=%d, age=%d, no=%d\n", ss.sname.c_str(), ss.ssex, ss.sage, ss.sno);
    }

    printf("get! sno=111\n");
    client.get(ss, 111);
    if (ss.sno != -1) {
        printf("find name=%s, sex=%d, age=%d, no=%d\n", ss.sname.c_str(), ss.ssex, ss.sage, ss.sno);
    } else {
        printf("not find\n");
    }

    transport->close();

    return 0;
}
