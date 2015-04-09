--------------------------------------------------------------------------------
--  Function......... : addSensor
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.addSensor( hObj, sJoint, cType )
--------------------------------------------------------------------------------
	
    local hScene = application.getCurrentUserScene()

    -- unfortunately we cannot create a dummy object and a the sensor manually
    -- because the sphere size is completely messed up and won't change
    local hSensor
    if    ( cType == "s" ) then
        hSensor = scene.createRuntimeObject( hScene, "DefaultSphereSensor" )
    elseif( cType == "b" ) then
        hSensor = scene.createRuntimeObject( hScene, "DefaultBoxSensor"    )
    end

    local modelName = object.getModelName( hObj )
    scene.setObjectTag( hScene, hSensor, modelName .. "_" .. sJoint )

    object.setParent( hSensor, hObj, false )
    object.bindTransformToParentSkeletonJoint( hSensor, sJoint )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
