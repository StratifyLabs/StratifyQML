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

#ifndef ASSETS_H
#define ASSETS_H

#include <QString>
#include <QStringList>
#include <QJsonDocument>
#include <QJsonArray>

#include "StratifyObject.h"

namespace StratifyData {

class KernelAssets : public StratifyObject
{
    Q_OBJECT
public:
    KernelAssets();

    static QString binaryKey() { return "binary"; }
    static QString binaryBase64Key() { return "binary-base64"; }

    static QString destKey() { return "dest"; }
    static QString filesKey() { return "files"; }


    static QString appSettingsKey() { return "settings"; }
    static QString appSettingsBase64Key() { return "settings-base64"; }
    static QString appSettingsFormatKey() { return "settingsFormat"; }
    static QString testTimeoutKey() { return "timeout"; }
    static QString testOrderKey() { return "order"; }
    static QString testResetKey() { return "reset"; }
    static QString testRamSizeKey() { return "ramSize"; }
    static QString testDelayKey() { return "delay"; }
    static QString testNameKey() { return "name"; }


    static QStringList types();

    bool collect(const QString & path, const QString & source, const QString & dest);
    bool extract(const QString & path, const QJsonObject & source, const QString & dest);


private:
    static bool convertBinary(QJsonObject & object, const QString & path, const QString & key);
    static bool convertBase64(QJsonObject & object, const QString & path, const QString & destKey, const QString & baseKey);


};

}

#endif // ASSETS_H
