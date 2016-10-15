#ifndef STRATIFYOBJECT_H
#define STRATIFYOBJECT_H

#include <QObject>

class StratifyPrompt {
public:
    StratifyPrompt(bool accept = true){
        mIsAcceptEnabled = accept;
        mIsRejectEnabled = false;
        mIsCancelEnabled = false;
        mAcceptWork = 0;
        mRejectWork = 0;
        mCancelWork = 0;
        mContext = 0;
    }

    StratifyPrompt(bool accept,
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

    StratifyPrompt(const StratifyPrompt & prompt){
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

    ~StratifyPrompt(){}

    void setTitle(const QString & value){ mTitle = value; }
    void setBody(const QString & value){ mBody = value; }

    bool isAcceptEnabled() const { return mIsAcceptEnabled; }
    bool isRejectEnabled() const { return mIsRejectEnabled; }
    bool isCancelEnabled() const { return mIsCancelEnabled; }

    void acceptWork() const {
        if( mAcceptWork != 0 ){
            mAcceptWork(mContext);
        }
    }

    void rejectWork() const {
        if( mRejectWork != 0 ){
            mRejectWork(mContext);
        }
    }

    void cancelWork() const {
        if( mCancelWork != 0 ){
            mCancelWork(mContext);
        }
    }

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


class StratifyObject : public QObject
{
    Q_OBJECT
public:
    explicit StratifyObject(QObject *parent = 0);

    enum {
        FATAL,
        CRITICAL,
        WARNING,
        ERROR,
        INFO,
        DEBUG
    };

signals:
    void statusChanged(int type, const QString & status); //update status and log
    void progressChanged(int value, int max); //update the user with the progress update
    void connectionChanged();
    void promptChanged(const StratifyPrompt & prompt);


public slots:
};

#endif // STRATIFYOBJECT_H
