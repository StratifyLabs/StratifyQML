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

#ifndef DATA_H
#define DATA_H

#include <QString>
#include "StratifyObject.h"
#include "DataService.h"

namespace StratifyData {

class Data : public StratifyObject
{
public:
    Data();

    static void setDefaultDataService(DataService * dataService){
        mDefaultDataService = dataService;
    }

    void setDataService(DataService * dataService){ mDataService = dataService; }


    void getValue(){ checkService(); mDataService->getValue(mToken, mValue); }
    void putValue(){ checkService(); mDataService->putValue(mToken, mValue); }
    void post(){ checkService(); mDataService->post(mToken, mValue); }
    void patch(){ checkService(); mDataService->patch(mToken, mValue); }
    void deleteValue(){ checkService(); mDataService->deleteValue(mToken); }

protected:
    DataService & dataService(){ return *mDataService; }


private:
    QString mToken;
    QString mValue;

    static DataService * mDefaultDataService;
    DataService * mDataService;

    void checkService(){
        if( mDataService == 0 ){
            mDataService = mDefaultDataService;
        }
    }

};

}

#endif // DATA_H
