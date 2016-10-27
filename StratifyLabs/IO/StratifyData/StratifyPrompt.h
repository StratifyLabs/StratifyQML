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

#ifndef STRATIFYPROMPT_H
#define STRATIFYPROMPT_H

#include <QObject>
#include <QString>

class StratifyPrompt {
public:
    StratifyPrompt(bool accept = true);
    StratifyPrompt(bool accept,
                   bool reject,
                   bool cancel,
                   void (*acceptWork)(void*),
                   void (*rejectWork)(void*),
                   void (*cancelWork)(void*),
                   void * context
                   );

    StratifyPrompt(const StratifyPrompt & prompt);
    ~StratifyPrompt();

    void setTitle(const QString & value){ mTitle = value; }
    void setBody(const QString & value){ mBody = value; }

    bool isAcceptEnabled() const { return mIsAcceptEnabled; }
    bool isRejectEnabled() const { return mIsRejectEnabled; }
    bool isCancelEnabled() const { return mIsCancelEnabled; }

    void acceptWork() const;
    void rejectWork() const;
    void cancelWork() const;

    void (*mAcceptWork)(void*);
    void (*mRejectWork)(void*);
    void (*mCancelWork)(void*);
    QString mTitle;
    QString mBody;
    bool mIsAcceptEnabled;
    bool mIsRejectEnabled;
    bool mIsCancelEnabled;
    void * mContext;

private:


};

Q_DECLARE_METATYPE(StratifyPrompt)

#endif // STRATIFYPROMPT_H
