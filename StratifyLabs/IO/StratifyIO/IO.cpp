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

#include "IO.h"

#include <QDebug>

using namespace StratifyIO;


IO::IO(Link & link) : mLink(link){}


bool IO::updateProgressCallback(void * context, int progress, int max){
    IO* object = (IO*)context;
    return object->updateProgress(progress, max);
}

bool IO::updateProgress(int value, int max){
    emit progressChanged(value, max);
    return false;
}

bool IO::updateCummulativeCallback(void * context, int progress, int max){
    IO * object = (IO*)context;
    return object->updateCummulative(progress, max);

}

bool IO::updateCummulative(int progress, int max){
    max = 0; //suppress warning

    if( mCummulativeProgressCached > progress ){
        mCummulativeProgressCached = 0;
    }
    mCummulativeProgress += (progress - mCummulativeProgressCached);
    mCummulativeProgressCached = progress;

    emit progressChanged(mCummulativeProgress, mCummulativeMax);

    return false;
}

void IO::setCummulativeMax(int value){
    mCummulativeProgress = 0;
    mCummulativeProgressCached = 0;
    mCummulativeMax = value;
}

void IO::resetCummulativeMax(){
    setCummulativeMax(0);
}

