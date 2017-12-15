#include "template.h"
#include <cstdlib>

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

void Template::onPluginLoad()
{
    // Load & compile VS 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("plugins/templatep/template.vert");
    qDebug() << vs->log() << endl;

    // Load & compile FS 
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("plugins/templatep/template.frag");
    qDebug() << fs->log() << endl;

    // Link program
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    qDebug() << program->log() << endl;

    // Timers
    connect(&timer, SIGNAL(timeout()), glwidget(), SLOT(updateGL()));
    timer.start();
    elapsedTimer.start();
}


void Template::onObjectAdd()
{
    unsigned int numObjects = scene()->objects().size();
    qDebug() << "Added new object " << endl;
    qDebug() << " Current scene has " << numObjects << " objects" << endl;
    unsigned int numFaces = scene()->objects()[numObjects-1].faces().size();
    unsigned int numVertices = scene()->objects()[numObjects-1].vertices().size();
    qDebug() << " Last object has " << numFaces << " faces and " << numVertices << " vertices" << endl;
}

void Template::preFrame()
{
}

void Template::postFrame()
{
    
}

bool Template::drawScene()
{
    // See example DrawImmediate and DrawVBO examples
    // If you draw the scene here, you should return true
    return false;
}
	
void Template::keyPressEvent (QKeyEvent *e)
{
}

void Template::keyReleaseEvent (QKeyEvent *)
{}

void Template::mouseMoveEvent (QMouseEvent *) 
{}

void Template::mousePressEvent (QMouseEvent *e)
{   
    qDebug() << "Mouse (x,y) = " << e->x() << ", " << e->y() << endl;
}

void Template::mouseReleaseEvent (QMouseEvent *)
{}

void Template::wheelEvent (QWheelEvent *)
{}


bool Template::paintGL()
{
}

#if QT_VERSION < 0x050000                                                                                                                         
Q_EXPORT_PLUGIN2(templatep, Template)   // plugin name, plugin class
#endif 
