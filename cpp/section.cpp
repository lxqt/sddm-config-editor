#include "section.h"
#include <QJsonObject>
#include <QJsonArray>
#include <QList>
#include <QObject>
#include <QVariant>
#include <QDebug>
#include "setting.h"

Section::Section(QObject* parent) : QObject(parent)
{
  if(parent) {
    m_controller = parent->property("controller").value<QObject*>();
  }
}

Section* Section::fromJson(const QJsonObject& object, QObject* parent)
{
  Section *section = new Section(parent);
  section->setProperty("name", object.value("name").toString());

  QList<QObject*> settings;
  QJsonArray array = object.value("settings").toArray();
  for(QJsonArray::const_iterator element = array.begin(); element != array.end(); element++) {
    if(!element->isObject()) {
      qDebug() << "Unable to load configuration section from schema";
    } else {
      QObject* setting = Setting::fromJson(element->toObject(), section);
      settings.append(setting);
    }
  }
  section->setProperty("settings", QVariant::fromValue(settings));
  return section;
}

QString Section::toString() const
{
  QString header = QString("[%1]\n").arg(m_name);
  QString settings;
  foreach(QObject* setting, m_settings) {
    settings += reinterpret_cast<Setting*>(setting)->toString();
  }
  if(settings.isEmpty()) {
    return "";
  } else {
    return header + settings + "\n";
  }
}

