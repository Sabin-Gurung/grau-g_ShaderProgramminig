#ifndef MOSUESELECT_H
#define MOSUESELECT_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

class MouseSelect : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:

    void onPluginLoad();
	
    void mouseReleaseEvent (QMouseEvent *);

 public slots:

 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;
 };
 
 #endif
