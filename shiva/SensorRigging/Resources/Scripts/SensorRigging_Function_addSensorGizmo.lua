--------------------------------------------------------------------------------
--  Function......... : addSensorGizmo
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.addSensorGizmo( sModel, sJoint, cType )
--------------------------------------------------------------------------------

    local hScene = application.getCurrentUserScene()
    
    local hGizmo
    if    ( cType == "s" ) then
        hGizmo  = scene.createRuntimeObject( hScene, "DefaultSphere"       )
    elseif( cType == "b" ) then
        hGizmo  = scene.createRuntimeObject( hScene, "DefaultBox"          )        
    end

    scene.setObjectTag( hScene, hGizmo , sModel .. "_" .. sJoint .. "#" )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
