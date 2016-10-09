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

#ifndef APPMANAGER_H
#define APPMANAGER_H

#include "DeviceManager.h"

namespace StratifyIO {

class AppManager : public DeviceManager
{
    Q_OBJECT
public:
    AppManager(Link & link);
    AppManager(Link & link, Link::update_callback_t update, void * context);

    int kill(const QString & name);
    int installFiles(const QString & settingsPath);
    int installApp(const QString & sourcePath, const QString & installPath, const QString & name);
    int runApp(const QString & name);
    int uninstallApp(const QString & path, const QString & name);
    int prepareBinary(const QString & sourcePath, const QString & name, bool startup, bool ram, int ramSize);

};

}

#endif // APPMANAGER_H
