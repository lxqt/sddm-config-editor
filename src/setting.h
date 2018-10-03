#ifndef SETTING_H
#define SETTING_H

#include <QObject>
#include <QString>
#include <QJsonObject>
#include <QDebug>

class Setting : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QString key MEMBER m_key NOTIFY keyChanged)
  Q_PROPERTY(QString description MEMBER m_description NOTIFY descriptionChanged)
  Q_PROPERTY(QString label MEMBER m_label NOTIFY labelChanged)
  Q_PROPERTY(QString type MEMBER m_type NOTIFY typeChanged)
  Q_PROPERTY(QString value MEMBER m_value NOTIFY valueChanged)
  Q_PROPERTY(QString defaultValue MEMBER m_defaultValue NOTIFY defaultValueChanged)

  public:
    Setting(QObject* parent = 0);
    static Setting* fromJson(const QJsonObject&, QObject* parent = 0);
    QString getValue() const;
    QString toString() const;

    Q_INVOKABLE bool isDefined() const;

  signals:
    void keyChanged();
    void descriptionChanged();
    void labelChanged();
    void typeChanged();
    void valueChanged();
    void defaultValueChanged();

  private:
    QString m_key;
    QString m_description;
    QString m_label;
    QString m_type;
    QString m_value;
    QString m_defaultValue;

  friend QDebug operator<<(QDebug, const Setting&);
};

#endif

