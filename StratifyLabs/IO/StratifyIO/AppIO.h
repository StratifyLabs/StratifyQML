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

#include "IO.h"

namespace StratifyIO {

class AppIO : public IO
{
    Q_OBJECT
public:
    AppIO(Link & link);

    int kill(const QString & name);
    int installFiles(const QString & settingsPath);
    int installApp(const QString & sourcePath, const QString & installPath, const QString & name);
    int installAppCummulative(const QString & sourcePath, const QString & installPath, const QString & name);
    int runApp(const QString & name);
    int uninstallApp(const QString & path, const QString & name);
    int prepareBinary(const QString & sourcePath, const QString & name, bool startup, bool ram, int ramSize);

    int installApp(const QString & sourcePath, const QString & installPath, const QString & name, bool (*update)(void*,int,int), void * object);

private:

};

}

#endif // APPMANAGER_H
