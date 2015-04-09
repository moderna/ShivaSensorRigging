--------------------------------------------------------------------------------
--  State............ : _Init
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging._Init_onEnter()
--------------------------------------------------------------------------------
	
    local modelFilenames = table.newInstance()
    local modelIgnores   = table.newInstance()

    local modelIgnoreStrs = "DefaultDirectionnalLight,DefaultDynamicLightSet,DefaultStaticLightSet,CamOrbit,DefaultBox,DefaultBoxSensor,DefaultSphere,DefaultSphereSensor,GizmoJoint"
    string.explode( modelIgnoreStrs, modelIgnores, "," )
    
    local modelDir = application.getPackDirectory() .. "/Models/"
    system.findFiles( modelFilenames, modelDir, "*." .. this._MODEL_EXT() )
    for i = 0, table.getSize( modelFilenames ) - 1 do
        local modelFilename = table.getAt( modelFilenames, i )
        local modelBasename = string.getSubString( modelFilename, 0, string.getLength( modelFilename ) - string.getLength( "." .. this._MODEL_EXT() ) )
        
        if( not table.contains( modelIgnores, modelBasename ) ) then
            table.add( this.models(), modelBasename )
        end        
    end

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
