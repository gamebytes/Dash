/**
 * Container for the graphics adapter needed for the appropriate platform
 */
module graphics.graphics;
import graphics.adapters, graphics.shaders;

/**
 * Abstract class to store the appropriate Adapter
 */
final abstract class Graphics
{
public static:
    /// The active Adapter
    Adapter adapter;
    /// Aliases adapter to Graphics
    alias adapter this;

    /**
     * Initialize the controllers.
     */
    final void initialize()
    {
        version( Windows )
        {
            adapter = new Win32;
        }
        else version( OSX )
        {
            adapter = new Mac;
        }
        else version( linux )
        {
            adapter = new Linux;
        }
        else
        {
            adapter = null;
        }

        adapter.initialize();
        adapter.initializeDeferredRendering();
        Shaders.initialize();
    }

    /**
     * Shutdown the adapter and shaders.
     */
    final void shutdown()
    {
        Shaders.shutdown();
        adapter.shutdown();
    }

private:
    this() { }
}
