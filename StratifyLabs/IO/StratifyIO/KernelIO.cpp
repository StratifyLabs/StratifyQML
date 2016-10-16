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


#include "KernelIO.h"

#include <QTimer>
#include <QThread>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QDebug>
#include <QFile>
#include <QFileInfo>
#include <QTemporaryDir>
#include <QDateTime>
#include <stfy/son.h>

#include "AppIO.h"
#include "TerminalIO.h"
#include "ConnectionIO.h"
#include "PortIO.h"
#include "Helper.h"

using namespace StratifyIO;

KernelIO::KernelIO(Link & link) : IO(link){}


int KernelIO::installKernel(const QString & source, bool verifyInstall){

    if ( mLink.get_is_connected() == false ){
        emit statusChanged(ERROR, "Not connected");
        return -1;
    } else {


        if ( mLink.is_bootloader() == false ){
            emit statusChanged(INFO, "Reset Bootloader");
            updateProgress(0, 0);
            qDebug("now reset to bootloader");
            //Invoke the bootloader
            if ( mLink.reset_bootloader() == 0 ){
                emit connectionChanged(); //disconnected

                //need to wait until the device is available
                emit statusChanged(INFO, "Waiting for bootloader");

                if( PortIO::reconnect(mLink) == true ){

                    if( mLink.is_bootloader() ){
                        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Reconnected to device; check for bootloader");

                        emit connectionChanged();
                        if( mLink.is_bootloader() ){
                            emit statusChanged(INFO, "Succeessfully connected to bootloader: "  +
                                               QString(mLink.serial_no().c_str()));
                        }
                    } else {
                        emit statusChanged(ERROR | PROMPT, "Bootloader did not load. Try invoking manually.");
                        return -1;
                    }

                }

                /*
                for(i=0; i < 60; i++){

                    QThread::msleep(500);

                    PortIO::refreshPortList(mLink);

                    if ( PortIO::lookupSerialNumber(mLink.serial_no().c_str()) != 0 ){
                        //connect to last known serial number
                        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Reconnect to last serial number");
                        mLink.reinit(); //suppress any error messages
                    }

                    QThread::msleep(500);

                    emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Check if device is reconnected");

                    if ( mLink.get_is_connected() ){
                        emit statusChanged(DEBUG, QString(Q_FUNC_INFO) + ": Reconnected to device; check for bootloader");

                        emit connectionChanged();
                        if( mLink.is_bootloader() ){
                            emit statusChanged(INFO, "Connecting to Bootloader");
                        }
                        break;
                    }


                }

                if ( i == 60 ){
                    emit statusChanged(ERROR | PROMPT, "Bootloader did not load. Try invoking manually.");
                    return -1;
                }
                */

            } else {
                emit statusChanged(ERROR | PROMPT, "Failed to start bootloader. Try invoking manually");
                return -1;
            }
        }
    }


    if( mLink.update_os(source.toStdString(),
                        verifyInstall,
                        updateProgressCallback,
                        this) < 0 ){
        emit statusChanged(ERROR | PROMPT, "Failed to install: " + QString(mLink.error_message().c_str()));
        emit connectionChanged();
        return -1;
    }

    emit statusChanged(INFO, "Kernel update complete");
    emit progressChanged(0, 0);
    mLink.reset();
    emit connectionChanged();

    return 0;


}


int KernelIO::installData(const QString & projectPath, bool isInstallData, bool isRunTests){
    //load the StratifyKernelInstallApps.json file
    QFile file;
    int app;
    int appTotal;
    int cummulativeMax;

    if( mLink.get_is_connected() == false ){
        emit statusChanged(ERROR, "Failed to install data: not connected");
        return -1;
    }

    file.setFileName(projectPath + "/StratifyKernelData.json");

    qDebug() << "Load Kernel Install Apps" << file.fileName();

    if( file.open(QFile::ReadOnly) == false ){
        emit statusChanged(ERROR, "Failed to open: " + file.fileName());
        return -1;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    QJsonObject object = doc.object();
    QJsonObject dataObject;

    file.close();

    QStringList keys;

    keys = object.keys();

    app = 0;
    appTotal = keys.count();

    cummulativeMax = 0;
    foreach(QString key, keys){
        QStringList appKeys;


        dataObject = object.value(key).toObject();
        if( dataObject.value("type") == "app" ){
            if( isInstallData == true ){
                cummulativeMax += calcAppObject(projectPath, dataObject);
            }
        } else if( dataObject.value("type") == "data" ){
            if( isInstallData == true ){
                cummulativeMax += calcDataObject(projectPath, dataObject);
            }
        } else if( dataObject.value("type") == "test" ){

            if( isRunTests == true ){
                if( dataObject.value("when") == "before" ){
                    if( runTest(projectPath, dataObject) < 0 ){
                        emit statusChanged(ERROR, "Test failed: " + dataObject.value("name").toString());
                        return -1;
                    }
                }
            }

        }
    }

    setCummulativeMax(cummulativeMax);

    foreach(QString key, keys){
        app++;

        qDebug() << "Process Key" << key;

        dataObject = object.value(key).toObject();

        if( dataObject.value("type") == "app" ){
            if( isInstallData ){
                emit statusChanged(INFO, "Installing " + key);
                if( installAppObject(projectPath, dataObject, key) < 0 ){
                    emit statusChanged(ERROR, "Failed to install " + key + ": " + QString(mLink.error_message().c_str()));
                    resetCummulativeMax();
                    return -1;
                }
            }
        } else if( dataObject.value("type") == "data" ){
            if( isInstallData ){
                emit statusChanged(INFO, "Installing " + key);
                if( installDataObject(projectPath, dataObject, key) < 0 ){
                    emit statusChanged(ERROR, "Failed to install " + key + ": " + QString(mLink.error_message().c_str()));
                    resetCummulativeMax();
                    return -1;
                }
            }
        }
    }

    if( isRunTests ){
        foreach(QString key, keys){
            dataObject = object.value(key).toObject();
            if( dataObject.value("type") == "test" ){
                if( dataObject.value("when") == "after" ){
                    if( runTest(projectPath, dataObject) < 0 ){
                        emit statusChanged(ERROR, "Test failed: " + dataObject.value("name").toString());
                        return -1;
                    }
                }
            }
        }
    }

    resetCummulativeMax();
    updateProgress(0,0);

    return 0;
}

int KernelIO::installAppObject(const QString & projectPath, const QJsonObject & appObject, const QString & key){
    QStringList appKeys;
    QString source;
    QString destination;
    QString settings;
    QString settingsFormat;

    appKeys = appObject.keys();

    source = projectPath + "/" + appObject.value("binary").toString();
    destination = appObject.value("dest").toString();
    settings = appObject.value("settings").toString();
    if( settings.isEmpty() == false ){
        settings = projectPath + "/" + settings;
    }

    settingsFormat = appObject.value("settingsFormat").toString();

    QFileInfo fileInfo;

    fileInfo.setFile(source);
    if( fileInfo.exists() ){
        qDebug() << "Create destination" << destination;
        if( mLink.mkdir(destination.toStdString(), 0777) < 0 ){
            if( link_errno != 17 ){ //17 is EEXIST
                emit statusChanged(ERROR, "Failed to create folder " + destination + ": " + QString(mLink.error_message().c_str()));
                return -1;
            }
        }

        qDebug() << "Copy" << source << "to" << destination;


        if( copyFileToDeviceCummulative(source, destination + "/" + key) < 0 ){
            emit statusChanged(ERROR, "Failed to copy " + source + " to " + destination + ": " + QString(mLink.error_message().c_str()));
            return -1;
        }

    } else {
        emit statusChanged(ERROR, "Failed because " + source + " doesn't exist");
    }

    qDebug() << "App Settings:" << settings;

    if( settings.isEmpty() == false ){
        fileInfo.setFile(settings);
        if( fileInfo.exists() ){

            QString sourceFilePath;
            QString destFileName;
            if( settingsFormat == "son" ){
                qDebug() << "Create SON file and transfer";
                QString sonFilePath;

                sonFilePath = fileInfo.path() + "/" + fileInfo.completeBaseName() + ".son";

                if( Helper::createSonFromJson(
                            sonFilePath,
                            fileInfo.filePath()
                            ) < 0 ){
                    qDebug() << "Failed to create from JSON";
                    return -1;
                }


                son_t son;
                if( son_open(&son, sonFilePath.toStdString().c_str()) < 0 ){
                    qDebug() << "Failed to open" << sonFilePath;
                } else {
                    son_to_json(&son, (sonFilePath + ".json").toStdString().c_str());
                    son_close(&son,0);
                }

                sourceFilePath = sonFilePath;
                destFileName = fileInfo.baseName() + ".son";

            } else {
                qDebug() << "Copy JSON file to destination;";
                sourceFilePath = fileInfo.filePath();
                destFileName = fileInfo.fileName();

            }

            //now copy the file to the device
            if( copyFileToDeviceCummulative(sourceFilePath, destination + "/" + destFileName) < 0 ){
                emit statusChanged(ERROR, "Failed to copy " + sourceFilePath + " to " + destination + ": " + QString(mLink.error_message().c_str()));
                return -1;
            }

        } else {
            qDebug() << "settings is defined but doesn't exist";
        }
    }

    return 0;

}

int KernelIO::installDataObject(const QString & projectPath, const QJsonObject & dataObject, const QString & key){

    QString dest;
    int i;
    QJsonArray filesArray;
    QFileInfo info;

    qDebug() << "Install data object" << key;

    dest = dataObject.value("dest").toString();

    filesArray = dataObject.value("files").toArray();

    for(i=0; i < filesArray.count(); i++){
        info.setFile(projectPath + "/" + filesArray.at(i).toString());

        qDebug() << "Copy" << info.filePath() << "to" << dest + "/" + info.fileName();
        if( copyFileToDeviceCummulative(info.filePath(), dest + "/" + info.fileName()) < 0 ){
            return -1;
        }
    }

    return 0;
}

int KernelIO::calcAppObject(const QString & projectPath, const QJsonObject & appObject){
    QJsonArray filesArray;
    QString source;
    QString settings;
    int cummulativeMax;
    QFileInfo info;
    int i;

    cummulativeMax = 0;
    source = projectPath + "/" + appObject.value("binary").toString();
    settings = appObject.value("settings").toString();

    //add the size of the binary
    info.setFile(source);
    cummulativeMax += info.size();

    //add the size of the settings
    info.setFile(projectPath + "/" + settings);
    cummulativeMax += info.size();

    //add the size of any other files
    filesArray = appObject.value("files").toArray();
    for(i=0; i < filesArray.count(); i++){
        info.setFile(projectPath + "/" + filesArray.at(i).toString());
        cummulativeMax += info.size();
    }

    return cummulativeMax;
}

int KernelIO::calcDataObject(const QString & projectPath, const QJsonObject & dataObject){
    int cummulativeMax;
    QJsonArray filesArray;
    QFileInfo info;
    int i;
    cummulativeMax = 0;
    filesArray = dataObject.value("files").toArray();
    for(i=0; i < filesArray.count(); i++){
        info.setFile(projectPath + "/" + filesArray.at(i).toString());
        cummulativeMax += info.size();
    }
    return cummulativeMax;
}

int KernelIO::runTest(const QString & projectPath, const QJsonObject & testObject){
    QString binary;
    QString name;
    QString output;
    int timeout;
    int delay;
    QString when;
    bool reset;
    QFileInfo info;
    int count;
    QFile testReport;

    AppIO appIO(mLink);
    TerminalIO terminalIO(mLink);
    QByteArray terminalData;
    QJsonDocument doc;
    QJsonObject reportObject;
    QJsonObject testObjectLocal = testObject;

    //enable error reporting on these objects
    connect(&appIO, SIGNAL(statusChanged(int,const QString&)), this, SIGNAL(statusChanged(int,QString)));
    connect(&terminalIO, SIGNAL(statusChanged(int,const QString&)), this, SIGNAL(statusChanged(int,QString)));

    binary = testObject.value("binary").toString();
    name = testObject.value("name").toString();
    output = testObject.value("output").toString();
    timeout = testObject.value("timeout").toInt() * 10; //use 100ms update rate
    when = testObject.value("when").toString();
    reset = testObject.value("reset").toBool();
    delay = testObject.value("delay").toInt();

    qDebug() << "Check is connected";
    if( mLink.get_is_connected() == false ){
        emit statusChanged(ERROR, "Device is not connected");
        return -1;
    }

    qDebug() << "Delete test if it exists";
    //delete the output file (if it already exists)
    mLink.unlink(output.toStdString());

    //Install the Test App in RAM
    info.setFile(projectPath + "/" + binary);

    if( appIO.prepareBinary(info.filePath(), info.fileName(), false, true, 0) < 0 ){
        //appIO will emit error status
        return -1;
    }

    if( appIO.installApp(info.filePath(), "/app/flash", info.fileName()) < 0 ){
        //appIO will emit error status
        return -1;
    }


    if( terminalIO.open() < 0 ){
        //terminalIO will emit error status
        return -1;
    }

    terminalIO.read(); //flush any data in STDOUT

    //Run the Test App
    if( appIO.runApp(info.fileName()) < 0 ){
        //appIO will emit error status
        terminalIO.close();
        return -1;
    }

    //Wait for the test to complete (output is created) or for a timeout
    count = 0;

    QByteArray incoming;
    bool testComplete = false;

    while( (count < timeout) && !testComplete ){
        QThread::msleep(100);
        count++;
        emit updateProgress(count, timeout);

        incoming = terminalIO.read();
        terminalData += incoming;
        if( incoming.isEmpty() == false ){
            qDebug() << "Incoming:" << incoming.toStdString().c_str();
            qDebug() << "Terminal Data:" << terminalData.toStdString().c_str();
        }

        doc = QJsonDocument::fromJson(terminalData);
        if( !doc.isNull() ){
            testComplete = true;
        }
    }

    terminalIO.close();

    emit updateProgress(0,0);

    if( !testComplete ){
        emit statusChanged(INFO, name + " failed (timeout)");
        qDebug() << "Test timed out";
        return -1;
    } else {
        qDebug() << "Test reported succesfully";
        //report test results

        //save the test with the name and the serial number

        reportObject = doc.object();
        QJsonObject testReportObject;

        testObjectLocal.insert("serial", mLink.serial_no().c_str());
        testObjectLocal.insert("date", QDateTime::currentDateTimeUtc().toString());


        testReportObject.insert("test", testObjectLocal);
        testReportObject.insert("results", reportObject);
        doc.setObject(testReportObject);

        testReport.setFileName(projectPath + "/" + name + "-" + mLink.serial_no().c_str() + "-" + QDateTime::currentDateTimeUtc().toString() + ".json");

        testReport.open(QFile::WriteOnly);
        testReport.write(doc.toJson());
        testReport.close();

        foreach(QString key, reportObject.keys()){
            if( key != "status" ){
                emit statusChanged(INFO, key + ":" + reportObject.value(key).toString());
            }
        }

        if( reportObject.value("status").toString() != "passed" ){
            emit statusChanged(WARNING, name + " failed");
            qDebug() << "Test failed";
            return -1;
        } else {
            emit statusChanged(INFO, name + " passed");
        }
    }

    if( reset == true ){
        emit statusChanged(INFO, "Resetting device after " + name);
        mLink.reset();
        emit connectionChanged();
        if( PortIO::reconnect(mLink, 10, delay) == true ){
            emit statusChanged(INFO, "Successfully reconnected to " + QString(mLink.serial_no().c_str()));
            emit connectionChanged();
        } else {
            emit statusChanged(ERROR, "Failed to reconnect to " +
                               QString(mLink.serial_no().c_str()));
            return -1;
        }

    }

    return 0;

}

