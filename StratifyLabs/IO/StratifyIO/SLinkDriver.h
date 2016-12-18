/*
Copyright 2016 Tyler Gilbert

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/


#ifndef IFACE_SLINKDRIVER_H_
#define IFACE_SLINKDRIVER_H_

#if defined QT_SERIALPORT_LIB

#include <QThread>
#include <iface/link.h>
#include <iface/link_transport.h>
#include <QMutex>
#include <QtSerialPort/QtSerialPort>


class SerialPort : public QSerialPort {
public:
    SerialPort(const QString & name) : QSerialPort(name){}
    void lock(){ mutex.lock(); }
    void unlock(){ mutex.unlock(); }

private:
    QMutex mutex;
};


class SLinkDriver {
public:

    SLinkDriver(){

        //initialize the driver
        m_driver.getname = getname;
        m_driver.lock = lock;
        m_driver.unlock = unlock;
        m_driver.status = status;

        m_driver.dev.handle = 0;
        m_driver.dev.open = open;
        m_driver.dev.write = write;
        m_driver.dev.read = read;
        m_driver.dev.close = close;
        m_driver.dev.wait = wait;
        m_driver.dev.flush = flush;
        m_driver.dev.timeout = 250;
    }

    link_transport_mdriver_t * driver(){ return &m_driver; }

private:

    static link_transport_phy_t open(const char * name, int baudrate){

        SerialPort * serialPort = new SerialPort(QString(name));
        baudrate = 0; //prevent warnings

        if( serialPort->open(SerialPort::ReadWrite) == true ){
            printf("--------Opened serial port %s\n", name); fflush(stdout);
            return (void*)serialPort;
        } else {
            delete serialPort;
        }

        return LINK_PHY_OPEN_ERROR;
    }


    static int getname(char * dest, const char * last, int len){
        QList<QSerialPortInfo> list;
        int i;
        bool pastLast;
        list = QSerialPortInfo::availablePorts();
        pastLast = false;

        if( strlen(last) == 0 ){
            pastLast = true;
        }

        for(i=0; i < list.length(); i++){
            if( list.at(i).portName().contains("Bluetooth") ){
                list.removeAt(i);
                i--;
            } else {
                qDebug() << list.at(i).portName();
            }
        }


        for(i=0; i < list.length(); i++){
            if( pastLast == true ){
                strncpy(dest, list.at(i).portName().toStdString().c_str(), len);
                return 0;
            } else if( strcmp(last, list.at(i).portName().toStdString().c_str()) == 0 ){
                pastLast = true;
            }
        }

        return -1;
    }

    static int lock(link_transport_phy_t handle){
        SerialPort * serialPort = (SerialPort *)handle;
        if( serialPort ){
            serialPort->lock();
        }
        return 0;

    }

    static int unlock(link_transport_phy_t handle){
        SerialPort * serialPort = (SerialPort *)handle;
        if( serialPort ){
            serialPort->unlock();
        }
        return 0;
    }

    static int status(link_transport_phy_t handle){
        SerialPort * serialPort = (SerialPort *)handle;

        if( handle == LINK_PHY_OPEN_ERROR ){
            return LINK_PHY_ERROR;
        }

        if( serialPort->error() != SerialPort::NoError ){
            //serialPort->close();
            //delete serialPort;

            //this might leak memory
            printf("Bad status %d:%s\n", serialPort->error(), serialPort->errorString().toStdString().c_str()); fflush(stdout);
            //return LINK_PHY_ERROR;
        }

        return 0;

    }

    static int write(link_transport_phy_t handle, const void* buf, int nbyte){
        int n;
        SerialPort * serialPort = (SerialPort *)handle;
        if( handle == LINK_PHY_OPEN_ERROR ){
            return LINK_PHY_ERROR;
        }
        n = serialPort->write((const char*)buf, nbyte);
        serialPort->flush();
        return n;
    }

    static int read(link_transport_phy_t handle, void *buf, int nbyte){
        SerialPort * serialPort = (SerialPort *)handle;
        if( handle == LINK_PHY_OPEN_ERROR ){
            return LINK_PHY_ERROR;
        }
        if( serialPort->waitForReadyRead(0) == false ){
            serialPort->clearError();
        }

        if( serialPort->bytesAvailable() < nbyte ){
            return 0;
        }

        return serialPort->read((char*)buf, nbyte);
    }

    static int close(link_transport_phy_t handle){
        SerialPort * serialPort = (SerialPort *)handle;

        if( handle == LINK_PHY_OPEN_ERROR ){
            return LINK_PHY_ERROR;
        }

        serialPort->close();

        delete serialPort;
        return 0;
    }

    static void wait(int msec){
        QThread::usleep(msec*1000);
    }

    static void flush(link_transport_phy_t handle){
        SerialPort * serialPort = (SerialPort *)handle;
        serialPort->clear(SerialPort::AllDirections);
    }


    link_transport_mdriver_t m_driver;

};

#endif //QT_SERIALPORT_LIB

#endif // SLINKDRIVER_H

