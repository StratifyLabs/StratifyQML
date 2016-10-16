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
