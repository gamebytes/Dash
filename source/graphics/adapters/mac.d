/**
* TODO
*/
module graphics.adapters.mac;

version( OSX ):

import core.gameobject;
import graphics.graphics;
import graphics.adapters.adapter;

public import derelict.opengl3.cgl;
import derelict.opengl3.gl3;

public alias CGLContextObj GLRenderContext;
public alias uint GLDeviceContext;

/**
* TODO
*/
final class Mac : Adapter
{
public:
    static @property Mac get() { return cast(Mac)Graphics.adapter; }

    override void initialize() { }
    override void shutdown() { }
    override void resize() { }
    override void refresh() { }
    override void swapBuffers() { }

    override void openWindow() { }
    override void closeWindow() { }

    override void messageLoop() { }
}
