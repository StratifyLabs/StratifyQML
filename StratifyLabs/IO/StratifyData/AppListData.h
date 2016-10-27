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

#ifndef APPLISTDATA_H
#define APPLISTDATA_H


#include <QString>
#include <QStringList>

#include "ListData.h"

namespace StratifyData {

class AppListData : public ListData
{
public:
    AppListData(DataService * service = 0);


private:

};


}

#endif // APPLISTDATA_H
