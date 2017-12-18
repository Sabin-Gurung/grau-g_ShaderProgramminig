#ifndef DISTROT_H
#define DISTROT_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QElapsedTimer>


class Distort : public QObject, public BasicPlugin
{
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    bool paintGL();
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;  
    GLuint textureId;

    QTimer timer;
    QElapsedTimer elapsedTimer;
 };
 
 #endif
