#include "keyselect.h"
#include <iostream>
#include <QKeyEvent>

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

void KeySelect::onPluginLoad()
{
	std::cout << "plugin loaded nicely\n";
}

	
void KeySelect::keyPressEvent (QKeyEvent* ev)
{
	int s;
	switch (ev -> key())
	{
		case Qt::Key_0:
			s = 0;
			break;
		case Qt::Key_1:
			s = 1;
			break;
		case Qt::Key_2:
			s = 2;
			break;
		case Qt::Key_3:
			s = 3;
			break;
		case Qt::Key_4:
			s = 4;
			break;
		case Qt::Key_5:
			s = 5;
			break;
		case Qt::Key_6:
			s = 6;
			break;
		case Qt::Key_7:
			s = 7;
			break;
		case Qt::Key_8:
			s = 8;
			break;
		case Qt::Key_9:
			s = 9;
			break;
		default:
			s = -1;
			break;
	}
	if (s >= 0 && s < scene() -> objects().size())
	{
		std::cout << s << "\n";
		scene() -> setSelectedObject (s);
	}
	else
		scene() -> setSelectedObject (-1);
	
	glwidget() -> makeCurrent();
	glwidget() -> update();
}


#if QT_VERSION < 0x050000                                                                                                                         
Q_EXPORT_PLUGIN2(keyselect, KeySelect)   // plugin name, plugin class
#endif 
