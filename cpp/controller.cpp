#include "controller.h"
#include <QJsonDocument>
#include <QJsonArray>
#include <QFile>
#include <QDebug>
#include <QTemporaryFile>
#include <QTextStream>
#include <QProcess>
#include <QFileDialog>
#include <QDir>
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

  load();

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
  emit configurationChanged();
}

void Controller::save()
{
  QProcess process;

  QTemporaryFile tempFile(&process);
  tempFile.open();
  QTextStream output(&tempFile);
  output << m_configText;
  tempFile.close();
  // Set mode 644 in case /etc/sddm.conf does not exist
  tempFile.setPermissions(QFile::ReadOwner | QFile::WriteOwner | QFile::ReadGroup | QFile::ReadOther);

  process.start("pkexec", QStringList() << "cp" << tempFile.fileName() << "/etc/sddm.conf");
  process.waitForFinished(-1);
}

QString Controller::chooseDirectory(const QString& initial)
{
  return QFileDialog::getExistingDirectory(0, "Choose a directory", initial);
}

QString Controller::chooseFile(const QString& initial)
{
  return QFileDialog::getOpenFileName(0, "Choose a file", initial);
}

QStringList Controller::directoryEntries(const QString& path)
{
  QDir directory(path);
  return directory.entryList(QDir::AllEntries | QDir::NoDotAndDotDot);
}

QObject* Controller::spawnProcess(const QString& line)
{
  QProcess* process = new QProcess();
  process->start(line);
  return process;
}

void Controller::closeProcess(QObject* process)
{
  static_cast<QProcess*>(process)->close();
}

