#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QList>
#include <QVariant>
#include <QJsonObject>
#include <QSettings>
#include "section.h"

class Configuration : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QList<QObject*> sections MEMBER m_sections NOTIFY sectionsChanged)
  Q_PROPERTY(QObject* controller MEMBER m_controller)

  public:
    Configuration(QObject* parent = 0);
    QList<QObject*> model();
    QString toFile() const;
    void loadSchema(const QJsonArray&);
    void loadSettings(QSettings&);
    QString getValue(const QString&, const QString&) const;
    friend QDebug operator<<(QDebug, const Configuration&);

  signals:
    void sectionsChanged();

  private:
    QList<QObject*> m_sections;
    QObject* m_controller;
    bool m_initialized;
};

#endif

