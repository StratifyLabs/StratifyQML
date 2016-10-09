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

#ifndef KERNELMANAGER_H
#define KERNELMANAGER_H

#include "DeviceManager.h"

namespace StratifyIO {

class KernelManager: public DeviceManager
{
    Q_OBJECT
public:
    KernelManager(Link & link);
    KernelManager(Link & link, Link::update_callback_t update, void * context);

    int installKernel(const QString & source, bool verifyInstall);
    int installData(const QString & projectPath, bool runTests = true);


private:

    int runTest(const QString & projectPath, const QJsonObject & testObject);

    int installAppObject(const QString & projectPath, const QJsonObject & appObject, const QString & key);
    int installDataObject(const QString & projectPath, const QJsonObject & dataObject, const QString & key);

    int calcAppObject(const QString & projectPath, const QJsonObject & appObject);
    int calcDataObject(const QString & projectPath, const QJsonObject & dataObject);



};

}

#endif // KERNELMANAGER_H
