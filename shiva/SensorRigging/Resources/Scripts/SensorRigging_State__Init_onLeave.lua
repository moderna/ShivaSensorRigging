--------------------------------------------------------------------------------
--  State............ : _Init
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging._Init_onLeave()
--------------------------------------------------------------------------------
	
    -- parse sensors.xml
    local hRoot = xml.getRootElement( this.sensorsXml() )
    this.parseSensors( xml.getElementValue( hRoot ) )
    cache.removeFile( this._SENSORS_FILENAME() )
    
    -- init scene and HUD
    user.setScene( this.getUser(), "SensorRigging" )
    local hScene = user.getScene( this.getUser() )

    hud.newTemplateInstance( this.getUser(), "SensorRigging", "Hud" )    

    -- set first model
    this.changeModel( table.getFirst( this.models() ) )

    -- set camera
    local hCam = scene.getTaggedObject( hScene, "CamOrbit" )
    user.setActiveCamera( this.getUser(), hCam )
    
    local x, y, z = object.getBoundingSphereCenter( this.model() )
    this.camDestX( x )
    this.camDestY( y )
    this.camDestZ( z )
    local rx, ry, rz = object.getRotation( hCam, object.kGlobalSpace )
    this.camRotX( rx )
    this.camRotY( ry )

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
