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
#include "Helper.h"

using namespace StratifyIO;

KernelIO::KernelIO(Link & link) : IO(link){}


int KernelIO::installKernel(const QString & source, bool verifyInstall){
    QString projectName;
    int i;

    //projectName = ui->installer->project();

    if ( mLink.get_is_connected() == false ){
        mError = "Not Connected";
        return -1;
    } else {


        if ( mLink.is_bootloader() == false ){
            emit statusChanged(INFO, "Reset Bootloader");
            updateProgress(0, 0);
            qDebug("now reset to bootloader");
            //Invoke the bootloader
            if ( mLink.reset_bootloader() == 0 ){
                emit connectionChanged();

                //need to wait until the device is available
                emit statusChanged(INFO, "Waiting for bootloader");


                for(i=0; i < 60; i++){

                    QThread::msleep(500);

                    IO::refreshDeviceList(mLink);

                    if ( IO::deviceList().count() > 0 ){
                        //connect to last known serial number
                        emit statusChanged(DEBUG, "Reconnect to last serial number");
                        mLink.reinit(); //suppress any error messages
                    }

                    QThread::msleep(500);

                    emit statusChanged(DEBUG, "Check if device is reconnected");

                    if ( mLink.get_is_connected() ){
                        emit statusChanged(DEBUG, "Reconnected to device; check for bootloader");

                        emit connectionChanged();
                        if( mLink.is_bootloader() ){
                            emit statusChanged(INFO, "Connecting to Bootloader");
                        }
                        break;
                    }


                }

                if ( i == 60 ){
                    mError = "Bootloader did not load. Try invoking manually.";
                    emit statusChanged(ERROR, mError);
                    return -1;
                }

            } else {
                emit statusChanged(ERROR, "Failed to start bootloader");
                return -1;
            }
        }
    }


    if( mLink.update_os(source.toStdString(),
                         verifyInstall,
                         updateProgressCallback,
                         this) < 0 ){
        mError = mLink.error_message().c_str();
        emit statusChanged(ERROR, "Failed to Install");
        emit connectionChanged();

        return -1;
    }

    emit statusChanged(INFO, "Kernel Update Complete");

    updateProgress(0, 0);

    mLink.reset();

    emit connectionChanged();


    return 0;


}


int KernelIO::installData(const QString & projectPath, bool runTests){
    //load the StratifyKernelInstallApps.json file
    QFile file;
    int app;
    int appTotal;
    int cummulativeMax;
    file.setFileName(projectPath + "/StratifyKernelData.json");

    qDebug() << "Load Kernel Install Apps" << file.fileName();

    if( file.open(QFile::ReadOnly) == false ){
        qDebug() << "Didn't open file";
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
            cummulativeMax += calcAppObject(projectPath, dataObject);
        } else if( dataObject.value("type") == "data" ){
            cummulativeMax += calcDataObject(projectPath, dataObject);
        } else if( dataObject.value("type") == "test" ){

            if( runTests == true ){
                if( dataObject.value("when") == "before" ){
                    if( runTest(projectPath, dataObject) < 0 ){
                        qDebug() << "Test failed";
                        return -1;
                    }
                }
            }

        }
    }

    setCummulativeMax(cummulativeMax);

    foreach(QString key, keys){
        app++;
        emit statusChanged(INFO, "Installing " + key);

        qDebug() << "Process Key" << key;

        dataObject = object.value(key).toObject();

        if( dataObject.value("type") == "app" ){
            if( installAppObject(projectPath, dataObject, key) < 0 ){
                mError = "Failed to install " + key;
                resetCummulativeMax();
                return -1;
            }
        } else if( dataObject.value("type") == "data" ){
            if( installDataObject(projectPath, dataObject, key) < 0 ){
                mError = "Failed to install " + key;
                resetCummulativeMax();
                return -1;
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
                qDebug() << mLink.error_message().c_str();
                return -1;
            }
        }

        qDebug() << "Copy" << source << "to" << destination;


        if( copyFileToDeviceCummulative(source, destination + "/" + key) < 0 ){
            qDebug() << mLink.error_message().c_str();
            mError = QString("Failed to copy " + source + " to " + destination);
            return -1;
        }

    } else {
        mError = QString(source + " doesn't exist");

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

                if( Helper::son_create_from_json(
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
                qDebug() << mLink.error_message().c_str();
                mError = mLink.error_message().c_str();
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
    QString when;
    bool reset;
    QFileInfo info;
    int count;
    QFile testReport;

    AppIO appManager(mLink);
    TerminaIO terminalManager(mLink);
    QByteArray terminalData;
    QJsonDocument doc;
    QJsonObject reportObject;
    QJsonObject testObjectLocal = testObject;


    binary = testObject.value("binary").toString();
    name = testObject.value("name").toString();
    output = testObject.value("output").toString();
    timeout = testObject.value("timeout").toInt() * 10; //use 100ms update rate
    when = testObject.value("when").toString();
    reset = testObject.value("reset").toBool();

    qDebug() << "Check is connected";
    if( mLink.get_is_connected() == false ){
        mError = "Device is not connected";
        return -1;
    }

    qDebug() << "Delete test if it exists";
    //delete the output file (if it already exists)
    mLink.unlink(output.toStdString());

    //Install the Test App in RAM
    info.setFile(projectPath + "/" + binary);

    if( appManager.prepareBinary(info.filePath(), info.fileName(), false, true, 0) < 0 ){
        qDebug() << "Failed to prepare binary file";
        return -1;
    }

    if( appManager.installApp(info.filePath(), "/app/flash", info.fileName()) < 0 ){
        qDebug() << "Failed to install app" << appManager.error();
        return -1;
    }


    if( terminalManager.open() < 0 ){
        qDebug() << "Failed to open terminal";
        return -1;
    }

    terminalManager.read(); //flush any data in STDOUT

    //Run the Test App
    if( appManager.runApp(info.fileName()) < 0 ){
        qDebug() << "Failed to run app" << info.fileName() << appManager.error();
        terminalManager.close();
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

        incoming = terminalManager.read();
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

    terminalManager.close();

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

        testObjectLocal.insert("serial", mLink.last_serial_no().c_str());
        testObjectLocal.insert("date", QDateTime::currentDateTimeUtc().toString());


        testReportObject.insert("test", testObjectLocal);
        testReportObject.insert("results", reportObject);
        doc.setObject(testReportObject);

        testReport.setFileName(projectPath + "/" + name + "-" + mLink.last_serial_no().c_str() + "-" + QDateTime::currentDateTimeUtc().toString() + ".json");

        testReport.open(QFile::WriteOnly);
        testReport.write(doc.toJson());
        testReport.close();

        foreach(QString key, reportObject.keys()){
            if( key != "status" ){
                emit statusChanged(INFO, key + ":" + reportObject.value(key).toString());
            }
        }

        if( reportObject.value("status").toString() != "passed" ){
            emit statusChanged(INFO, name + " failed");
            qDebug() << "Test failed";
            return -1;
        } else {
            emit statusChanged(INFO, name + " passed");
        }
    }


    return 0;

}

