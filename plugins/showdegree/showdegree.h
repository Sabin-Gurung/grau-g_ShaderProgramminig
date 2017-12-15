#ifndef SHOWDEGREE_H
#define SHOWDEGREE_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>
#include <QElapsedTimer>

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

class ShowDegree : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:

    void onPluginLoad();
    void onObjectAdd();

    void postFrame();

 public slots:

 private:
    void calculateInfo();
    float migDegree;

    GLuint textureID;
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;
 };
 
 #endif
