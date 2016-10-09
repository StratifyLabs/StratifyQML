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

namespace StratifyIO {

class Data
{
public:
    Data();

    const QString & token() const { return mToken; }
    void setToken(const QString & value){ mToken = value; }

    virtual void getValue() = 0;
    virtual void putValue() = 0;
    virtual void post() = 0;
    virtual void patch() = 0;
    virtual void deleteValue() = 0;


private:
    QString mToken;

};

}

#endif // DATA_H
