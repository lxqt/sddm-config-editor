#ifndef SECTION_H
#define SECTION_H

#include <QObject>
#include <QString>
#include <QList>
#include <QJsonObject>
#include <QDebug>
#include "setting.h"

class Section : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QString name MEMBER m_name NOTIFY nameChanged)
  Q_PROPERTY(QList<QObject*> settings MEMBER m_settings NOTIFY settingsChanged)
  Q_PROPERTY(QObject* controller MEMBER m_controller)

  public:
    Section(QObject* parent = 0);
    static Section* fromJson(const QJsonObject&, QObject* parent=0);
    QString toString() const;

  signals:
    void nameChanged();
    void settingsChanged();

  private:
    QString m_name;
    QList<QObject*> m_settings;
    QObject* m_controller;

  friend QDebug operator<<(QDebug, const Section&);
};

#endif

