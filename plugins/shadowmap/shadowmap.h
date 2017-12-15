#ifndef _SHADOWMAP_H
#define _SHADOWMAP_H

#include "basicplugin.h"
#include <QOpenGLShader>
#include <QOpenGLShaderProgram>


class ShadowMap : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    bool paintGL();
    void keyPressEvent(QKeyEvent*);   
 
 private:
    QOpenGLShaderProgram* program;
    QOpenGLShader* vs;
    QOpenGLShader* fs;  
    GLuint textureId;
    Camera lightCamera;

    void drawQuad(const Point& p0, const Point& p1, const Point& p2, const Point& p3);
 };
 
 #endif
