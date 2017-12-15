#include "animatevertices.h"


void AnimateVertices::onPluginLoad()
{
    // Load & compile VS 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("plugins/animatevertices/animatevertices.vert");
    qDebug() << vs->log() << endl;

    // Load & compile FS 
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("plugins/animatevertices/animatevertices.frag");
    qDebug() << fs->log() << endl;

    // Link program
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    qDebug() << program->log() << endl;

    // Timers
    connect(&timer, SIGNAL(timeout()), glwidget(), SLOT(update()));
    timer.start();
    elapsedTimer.start();
}



void AnimateVertices::preFrame()
{
	program -> bind();
	
	// get necessary matrices
	QMatrix4x4 modelViewProjectionMatrix = camera() -> projectionMatrix() * camera() -> viewMatrix();
	QMatrix3x3 normalMatrix              = camera() -> viewMatrix().normalMatrix();

	// send uniforms to shader progrma
	program -> setUniformValue ("time", float (elapsedTimer.elapsed() / 1000.0f));
	program -> setUniformValue ("modelViewProjectionMatrix", modelViewProjectionMatrix);
	program -> setUniformValue ("normalMatrix", normalMatrix);
}

void AnimateVertices::postFrame()
{
	program -> release();
}


#if QT_VERSION < 0x050000                                                                                                                         
Q_EXPORT_PLUGIN2(animatevertices, AnimateVertices)   // plugin name, plugin class
#endif 
