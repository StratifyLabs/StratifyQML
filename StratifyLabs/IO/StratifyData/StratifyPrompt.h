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
