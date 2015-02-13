#include "controller.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QDebug>
#include "configuration.h"

Controller::Controller(QObject* parent) : QObject(parent),
  m_configuration(new Configuration(this)),
  m_model(),
  m_configText("")
{
  QFile schemaFile(":/data/config-schema.json");
  if(!schemaFile.open(QIODevice::ReadOnly)) {
    qDebug() << "Failed to load configuration schema";
  }
  QJsonDocument schemaJson = QJsonDocument::fromJson(schemaFile.readAll());
  m_configuration->loadSchema(schemaJson.array());

  QSettings settings("/etc/sddm.conf", QSettings::IniFormat);
  m_configuration->loadSettings(settings);

  m_model = m_configuration->model();
  m_configText = m_configuration->toFile();
}

void Controller::generate()
{
  m_configText = m_configuration->toFile();
  emit configTextChanged();
}

void Controller::load()
{
  QSettings settings("/etc/sddm.conf", QSettings::IniFormat);
  m_configuration->loadSettings(settings);
}

void Controller::save()
{

}

