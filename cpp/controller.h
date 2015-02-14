#include <QObject>
#include <QString>
#include <QVariantList>
#include <QApplication>
#include "configuration.h"
#include "section.h"

class Controller : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QList<QObject*> model MEMBER m_model NOTIFY modelChanged)
  Q_PROPERTY(QString config_text MEMBER m_configText NOTIFY configTextChanged)

  public:
    Controller(QObject* parent = qApp);
    Configuration* makeConfiguration();

  public slots:
    void generate();
    void load();
    void save();

  signals:
    void modelChanged();
    void configTextChanged();
    void configurationChanged();

  private:
    Configuration* m_configuration;
    QList<QObject*> m_model;
    QString m_configText;
};

