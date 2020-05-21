#include "section.h"
#include <QJsonObject>
#include <QJsonArray>
#include <QList>
#include <QObject>
#include <QVariant>
#include <QDebug>
#include <algorithm>
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
  for(QJsonArray::const_iterator element = array.cbegin(); element != array.cend(); element++) {
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

QString Section::getValue(QString key) const
{
  auto found = std::find_if(m_settings.begin(), m_settings.end(), [key](auto o) {
      return o->property("key") == key;
  });
  if(found != m_settings.end()) {
    return reinterpret_cast<Setting*>(*found)->getValue();
  }
  return "";
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

QDebug operator<<(QDebug debug, const Section &section)
{
  debug.nospace().noquote() << "[" << section.m_name << "]";
  foreach(QObject* setting, section.m_settings) {
    debug.maybeSpace() << *static_cast<Setting*>(setting);
  }
  return debug.space();
}

