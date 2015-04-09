--------------------------------------------------------------------------------
--  Function......... : changeModel
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.changeModel( sModel )
--------------------------------------------------------------------------------

    local hScene = user.getScene( this.getUser() )

    if( this.model() ~= nil ) then
        scene.destroyRuntimeObject( hScene, this.model() )    
    
        for o = scene.getObjectCount( hScene ) - 1, 0, -1 do
            local hObj = scene.getObjectAt( hScene, o )
            local modelName = object.getModelName( hObj )
            if( modelName == "DefaultBox" or modelName == "DefaultSphere" or modelName == "GizmoJoint" ) then
                scene.destroyRuntimeObject( hScene, hObj )
            end
        end
    end
    
    this.model( scene.createRuntimeObject( hScene, sModel ) )
    local modelLbl = hud.getComponent( this.getUser(), "Hud.ModelLbl" )
    hud.setLabelText( modelLbl, sModel )

    -- disable all childs
    for c = 0, object.getChildCount( this.model() ) - 1 do
        local child = object.getChildAt( this.model(), c )
        object.setParent ( child, nil, false )
        object.setVisible( child, false )
    end
    
    -- apply sensors and sensors gizmos
    if( hashtable.contains( this.sensors(), sModel ) ) then
        local sensorEntries = hashtable.get( this.sensors(), sModel )
        for s = 0, hashtable.getSize( sensorEntries ) - 1 do
            local joint      = hashtable.getKeyAt( sensorEntries, s     )
            local sensorData = hashtable.get     ( sensorEntries, joint )
            
            local type = hashtable.get( sensorData, "type" )                            
            this.addSensor     ( this.model(), joint, type )
            this.addSensorGizmo( sModel      , joint, type )
        end
    else
        local sensorEntries = hashtable.newInstance()
        hashtable.add( this.sensors(), sModel, sensorEntries )
    end
    
    -- add joint gizmos
    for i = 0, shape.getSkeletonJointCount( this.model() ) - 1 do
        local joint = shape.getSkeletonJointNameAt( this.model(), i )        
        local d = this.getJointLength( this.model(), joint )
        if( d > 0 ) then
            local hJointObj  = scene.createRuntimeObject( hScene, "GizmoJoint" )
            
            local hJointMesh = object.getChildAt( hJointObj, 0 )
            scene.setObjectTag( hScene, hJointObj, joint )
            object.setScale  ( hJointMesh, 1, 1, d )
            object.setParent ( hJointObj, this.model(), true )
            object.setVisible( hJointObj, true )
            
            local jointParent = shape.getSkeletonJointParentJointName( this.model(), joint )
            object.bindTransformToParentSkeletonJoint( hJointObj, jointParent )
        end
    end

    -- set animation
    if( object.hasController( this.model(), object.kControllerTypeAnimation ) ) then
        animation.setCurrentClip          ( this.model(), 0,  0 )
        animation.setPlaybackKeyFrameBegin( this.model(), 0, this._ANIM_FRAME_BEGIN() )
        animation.setPlaybackKeyFrameEnd  ( this.model(), 0, this._ANIM_FRAME_END  () )
        animation.setPlaybackCursor       ( this.model(), 0,  0 )
        animation.setPlaybackMode         ( this.model(), 0, animation.kPlaybackModeLoop )

        -- model has to be animated for one frame in order to apply joint translations
        --animation.enablePlayback  ( this.model(), true )
        this.animateOnce( true )
        animation.setPlaybackSpeed( this.model(), 0, this.animationSpeed() )
    end
    
    -- remove all AIs
    for a = object.getAIModelCount( this.model() ) - 1, 0, -1 do
        local aiName = object.getAIModelNameAt( this.model(), a )
        object.removeAIModel( this.model(), aiName )
    end
    
    -- disable dynamics
    if( object.hasController( this.model(), object.kControllerTypeDynamics ) ) then
        dynamics.enableDynamics( this.model(), false )
    end     
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
