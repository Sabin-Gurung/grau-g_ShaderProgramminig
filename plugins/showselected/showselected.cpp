#include "showselected.h"

#include <vector>

int ShowSelected::createCube()
{
	GLWidget& g = *glwidget();
	g.makeCurrent();

	GLuint vao;
	g.glGenVertexArrays (1, &vao);
	g.glBindVertexArray (vao);

	float coord[] = 
	{
		// bottom
		0, 0, 0,
		0, 0, 1,
		1, 0, 1,
		1, 0, 0,

		// top
		0, 1, 0,
		0, 1, 1,
		1, 1, 1,
		1, 1, 0,
	};
	GLuint coordVBO;
	g.glGenBuffers (1, &coordVBO);
	g.glBindBuffer (GL_ARRAY_BUFFER, coordVBO);
	g.glBufferData (GL_ARRAY_BUFFER, sizeof (float) * 8 * 3, coord, GL_STATIC_DRAW);
	g.glVertexAttribPointer (0, 3, GL_FLOAT, GL_FALSE, 0, 0);
	g.glEnableVertexAttribArray (0);

	int indices[] =
	{
		1, 0, 3,
		3, 2, 1,
		7, 4, 5,
		5, 6, 7,
		6, 5, 1,
		1, 2, 6,
		4, 7, 3,
		3, 0, 4,
		7, 6, 2,
		2, 3, 7,
		5, 4, 0,
		0, 1, 5
	};
	GLuint indexVBO;
	g.glGenBuffers (1, &indexVBO);
	g.glBindBuffer (GL_ELEMENT_ARRAY_BUFFER, indexVBO);
	g.glBufferData (GL_ELEMENT_ARRAY_BUFFER, sizeof (int) * 36, indices, GL_STATIC_DRAW);

	return vao; 
}

void ShowSelected::onPluginLoad()
{
    // Load & compile VS 
    vs = new QOpenGLShader(QOpenGLShader::Vertex, this);
    vs->compileSourceFile("plugins/showselected/showselected.vert");
    qDebug() << vs->log() << endl;

    // Load & compile FS 
    fs = new QOpenGLShader(QOpenGLShader::Fragment, this);
    fs->compileSourceFile("plugins/showselected/showselected.frag");
    qDebug() << fs->log() << endl;

    // Link program
    program = new QOpenGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    qDebug() << program->log() << endl;

    m_vaoCube = this -> createCube();
}

void ShowSelected::postFrame()
{
	GLWidget& g = *glwidget();
	g.makeCurrent();

	program -> bind();
	g.glBindVertexArray (m_vaoCube);
	g.glPolygonMode (GL_FRONT_AND_BACK, GL_LINE);

	program -> setUniformValue ("modelViewProjectionMatrix", camera() -> projectionMatrix() * camera() -> viewMatrix()); 

	const std::vector <Object> objs = scene() -> objects();

	int selectedObject = scene() -> selectedObject();
	if (selectedObject < objs.size() && selectedObject >= 0)
	{
		program -> setUniformValue ("boundingBoxMax", objs[selectedObject].boundingBox().max());	
		program -> setUniformValue ("boundingBoxMin", objs[selectedObject].boundingBox().min());	
		g.glDrawElements (GL_TRIANGLES, 36, GL_UNSIGNED_INT, 0);
	}

	g.glPolygonMode (GL_FRONT_AND_BACK, GL_FILL);
	g.glBindVertexArray (0);
	program -> release();
}




#if QT_VERSION < 0x050000                                                                                                                         
Q_EXPORT_PLUGIN2(showselected, ShowSelected)   // plugin name, plugin class
#endif 
