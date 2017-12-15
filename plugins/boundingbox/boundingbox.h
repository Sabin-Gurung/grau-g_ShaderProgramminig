#ifndef BOUNDINGBOX_H
#define BOUNDINGBOX_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QElapsedTimer>


class BoundingBox : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
	void onPluginLoad();
    void postFrame();

 public slots:

 private:
 	int createCube();
 	int m_vaoCube;

    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;

 };
 
 #endif
