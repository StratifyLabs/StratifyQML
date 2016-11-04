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

#include "StratifyPrompt.h"

StratifyPrompt::StratifyPrompt(bool accept){
    mIsAcceptEnabled = accept;
    mIsRejectEnabled = false;
    mIsCancelEnabled = false;
    mAcceptWork = 0;
    mRejectWork = 0;
    mCancelWork = 0;
    mContext = 0;
}

StratifyPrompt::StratifyPrompt(bool accept,
               bool reject,
               bool cancel,
               void (*acceptWork)(void*),
               void (*rejectWork)(void*),
               void (*cancelWork)(void*),
               void * context
               ){
    mIsAcceptEnabled = accept;
    mIsRejectEnabled = reject;
    mIsCancelEnabled = cancel;
    mAcceptWork = acceptWork;
    mRejectWork = rejectWork;
    mCancelWork = cancelWork;
    mContext = context;
}

StratifyPrompt::StratifyPrompt(const StratifyPrompt & prompt){
    mIsAcceptEnabled = prompt.mIsAcceptEnabled;
    mIsRejectEnabled = prompt.mIsRejectEnabled;
    mIsCancelEnabled = prompt.mIsCancelEnabled;
    mAcceptWork = prompt.mAcceptWork;
    mRejectWork = prompt.mRejectWork;
    mCancelWork = prompt.mCancelWork;
    mContext = prompt.mContext;
    mTitle = prompt.mTitle;
    mBody = prompt.mBody;
}

StratifyPrompt::~StratifyPrompt(){}


void StratifyPrompt::acceptWork() const {
    if( mAcceptWork != 0 ){
        mAcceptWork(mContext);
    }
}

void StratifyPrompt::rejectWork() const {
    if( mRejectWork != 0 ){
        mRejectWork(mContext);
    }
}

void StratifyPrompt::cancelWork() const {
    if( mCancelWork != 0 ){
        mCancelWork(mContext);
    }
}
