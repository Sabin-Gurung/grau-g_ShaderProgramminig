#ifndef KEYSELECT_H
#define KEYSELECT_H

#include "basicplugin.h"

// Documentation: http://www.cs.upc.edu/~virtual/Gdocs/interfaces/html/class_basic_plugin.html

class KeySelect : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:

    void onPluginLoad();
	
    void keyPressEvent (QKeyEvent *);

 public slots:

 private:
 };
 
 #endif
