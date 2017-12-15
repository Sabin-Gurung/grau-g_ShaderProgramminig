#include "mouseselect.h"
#include <cstdlib>

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

void MouseSelect::onPluginLoad()
{
    // Load & compile VS 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("plugins/mouseselect/mouseselect.vert");
    qDebug() << vs->log() << endl;

    // Load & compile FS 
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("plugins/mouseselect/mouseselect.frag");
    qDebug() << fs->log() << endl;

    // Link program
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    qDebug() << program->log() << endl;

}

void encodeID (int i, GLubyte* color)
{
	color[0] = i;
	color[1] = i;
	color[2] = i;
	color[3] = i;
}

int decodeID (GLubyte* color)
{
	return color [0];
}


void MouseSelect::mouseReleaseEvent (QMouseEvent* e)
{

	// check modifiers
	if (! (e -> button() & Qt::RightButton))        return;
	if (e -> modifiers() & (Qt::ShiftModifier))     return;
	if (! (e -> modifiers() & Qt::ControlModifier)) return;

	glwidget() -> makeCurrent();

	// clear the screen
	glClearColor (1.0, 1.0, 1.0, 1.0);
	glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	// draw objects with different colors
	program -> bind();
	program -> setUniformValue ("modelViewProjectionMatrix", camera() -> projectionMatrix() * camera() -> viewMatrix());
	for (uint i = 0; i < scene() -> objects().size(); ++i)
	{
		GLubyte color[4];
		encodeID (i, color);

		program -> setUniformValue ("color", QVector4D (float (color[0]) / 255.0, float (color[1]) / 255.0, float (color[2]) / 255.0, 1.0));

		drawPlugin() -> drawObject (i);
	}

	program -> release();

	// read from buffer
	int x = e -> x();
	int y = glwidget() -> height() - e -> y();
	GLubyte read[4];
	glReadPixels (x, y, 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, read);
	int s = decodeID (read);

	// decode it and set respective selected object
	if (s == 255)
		scene() -> setSelectedObject (-1);
	else
		scene() -> setSelectedObject (s);

	glwidget() -> update();
}


#if QT_VERSION < 0x050000                                                                                                                         
Q_EXPORT_PLUGIN2(mouseselect, MouseSelect)   // plugin name, plugin class
#endif 
