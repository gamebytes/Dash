/**
 * Defines the GameObject class, to be subclassed by scripts and instantiated for static objects.
 */
module core.gameobject;
import core.properties;
import components.icomponent;
import graphics.shaders.ishader;
import math.transform;

import yaml;
import std.signals, std.conv;

final class GameObject
{
public:
	/**
	 * The shader this object uses to draw.
	 */
	mixin( Property!( "IShader", "shader", "public" ) );
	/**
	 * The current transform of the object.
	 */
	mixin( Property!( "Transform", "transform", "public" ) );

	/**
	 * Creates basic GameObject with transform and connection to transform's emitter.
	 */
	this()
	{
		transform = new Transform;
		transform.connect( &emit );
	}

	/**
	 * Initializes GameObject with shader
	 */
	this( IShader shader )
	{
		this();

		// Transform
		this.shader = shader;
	}

	this( Node jsonObject )
	{
		this();
		// Handle stuff
	}

	~this()
	{
		destroy( transform );

		if( shader )
		{
			destroy( shader );
			shader = null;
		}
	}

	/**
	 * Called once per frame to update all components.
	 */
	void update()
	{
		foreach( ci, component; componentList )
		{
			component.update();
		}
	}

	/**
	 * Called once per frame to draw all components.
	 */
	void draw()
	{
		foreach( ci, component; componentList )
		{
			component.draw( shader );
		}
	}

	/**
	 * Called when the game is shutting down, to shutdown all components.
	 */
	void shutdown()
	{
		foreach( ci, component; componentList )
		{
			component.shutdown();
		}

		foreach( key; componentList.keys )
		{
			componentList.remove( key );
		}
	}

	void onCollision( GameObject other )
	{
		
	}

	void addComponent( T )( T newComponent )
	{
		componentList[ T.classinfo ] = newComponent;
	}

	T getComponent( T )()
	{
		return componentList[ T.classinfo ];
	}

	mixin Signal!( string, string );

private:
	IComponent[ClassInfo] componentList;
}
