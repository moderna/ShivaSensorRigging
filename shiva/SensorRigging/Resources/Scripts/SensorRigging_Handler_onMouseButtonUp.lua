--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonUp
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onMouseButtonUp( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	if    ( nButton == 0 ) then
        this.mouseDown0( false )
	
        if( not this.mouseDownMoved() ) then
            local hScene = application.getCurrentUserScene()
            local hCam = user.getActiveCamera( this.getUser() )
            local px, py, pz = object.getTranslation( hCam, object.kGlobalSpace )
            
            this.selectionModel( "" )
            this.selectionJoint( "" )
            
            local sensObj, sensDist, sensSurfaceId = scene.getFirstHitSensor( hScene, px, py, pz, nRayDirX, nRayDirY, nRayDirZ, 100 )
            if( sensObj ~= nil ) then
                local parentObj = object.getParent( sensObj )
                if( parentObj ~= nil ) then
                    -- joint selected
                    if( object.getModelName( parentObj ) == "GizmoJoint" ) then
                        local modelName = object.getModelName( this.model() )
                        
                        local joint = scene.getObjectTag( hScene, parentObj )
                        local d = this.getJointLength( this.model(), joint )
                        if( d > 0 ) then
                            local jointParent = shape.getSkeletonJointParentJointName( this.model(), joint )
                            if( not hashtable.contains( hashtable.get( this.sensors(), modelName ), jointParent ) ) then
                                this.addSensorEntry( modelName   , jointParent, 0, this.type(), 0, 0, d / 2, d, d, d, d / 2 )
                                this.addSensor     ( this.model(), jointParent,    this.type() )
                                this.addSensorGizmo( modelName   , jointParent,    this.type() )
                            end
                            
                            this.selectionModel( modelName   )
                            this.selectionJoint( jointParent )
                        end
                    -- sensor selected
                    else
                        local modelName = object.getModelName( parentObj )
                        local sensTag = scene.getObjectTag( hScene, sensObj )
                        this.selectionModel( modelName )
                        this.selectionJoint( string.getSubString( sensTag, string.getLength( modelName .. "_" ), string.getLength( sensTag ) ) )
                    end

                    local jointLbl = hud.getComponent( this.getUser(), "Hud.JointLbl" )
                    hud.setLabelText( jointLbl, this.selectionJoint() )
                end
            end
        end
    elseif( nButton == 1 ) then
        this.mouseDown1( false )        
    elseif( nButton == 2 ) then
        this.mouseDown2( false )        
    end

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
