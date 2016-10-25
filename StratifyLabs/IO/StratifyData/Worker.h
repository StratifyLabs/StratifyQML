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

#ifndef WORKER_H
#define WORKER_H

#include <QMutex>
#include <QThread>

namespace Stratify {


class Worker : public QThread {
    Q_OBJECT
public:

    Worker(){ mMutex = 0; }

    static void startWork(void (*worker)(void*), void * context, QMutex * mutex = 0){
        if( worker != 0 ){
            Worker *workerThread = new Worker();
            workerThread->setObject(context);
            workerThread->setWork(worker);
            QObject::connect(workerThread, &Worker::finished, workerThread, &QObject::deleteLater);
            workerThread->setMutex(mutex);
            workerThread->start();
        }
    }
    void setObject(void * v){ mObject = v; }
    void setWork(void (*v)(void *)){ mWork = v; }

    void setMutex(QMutex * mutex){ mMutex = mutex; }

    void run() Q_DECL_OVERRIDE {
        if( mWork ){
            if( mMutex ){ mMutex->lock(); }
            //run the worker function
            mWork(object());
            if( mMutex ){ mMutex->unlock(); }
        }
    }

private:

    QMutex * mMutex;
    void * object(){ return mObject; }
    void * mObject;
    void (*mWork)(void*);


};

}

#endif // WORKER_H
