--------------------------------------------------------------------------------
--  State............ : Main
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.Main_onLoop()
--------------------------------------------------------------------------------
	
    local dt    = application.getLastFrameTime()
    local hScene = user.getScene( this.getUser() )    

    -- camera
    local hCam = user.getActiveCamera( this.getUser() )        
    object.setTranslation( hCam, this.camDestX(), this.camDestY(), this.camDestZ(), object.kGlobalSpace )
    object.setRotation   ( hCam, 0, this.camRotY(), 0, object.kGlobalSpace )
    object.setRotation   ( hCam, this.camRotX(), 0, 0, object.kLocalSpace )
    object.translate     ( hCam, this.camPosX(), this.camPosY(), this.camDist(), object.kLocalSpace  )

    -- sensors
    local jointLbl = hud.getComponent( this.getUser(), "Hud.JointLbl" )
    local posXLbl  = hud.getComponent( this.getUser(), "Hud.PosXLbl" )
    local posYLbl  = hud.getComponent( this.getUser(), "Hud.PosYLbl" )
    local posZLbl  = hud.getComponent( this.getUser(), "Hud.PosZLbl" )
    local dimWLbl  = hud.getComponent( this.getUser(), "Hud.DimWLbl" )
    local dimHLbl  = hud.getComponent( this.getUser(), "Hud.DimHLbl" )
    local dimDLbl  = hud.getComponent( this.getUser(), "Hud.DimDLbl" )
    local dimRLbl  = hud.getComponent( this.getUser(), "Hud.DimRLbl" )
    local hasSelected = not (string.isEmpty( this.selectionModel() ) and string.isEmpty( this.selectionJoint() ))
    hud.setComponentVisible( jointLbl, hasSelected )
    hud.setComponentVisible( posXLbl , hasSelected )
    hud.setComponentVisible( posYLbl , hasSelected )
    hud.setComponentVisible( posZLbl , hasSelected )
    hud.setComponentVisible( dimWLbl , hasSelected )
    hud.setComponentVisible( dimHLbl , hasSelected )
    hud.setComponentVisible( dimDLbl , hasSelected )
    hud.setComponentVisible( dimRLbl , hasSelected )
    
    local modelName = object.getModelName( this.model() )
    if( hashtable.contains( this.sensors(), modelName ) ) then
        local sensorEntries = hashtable.get( this.sensors(), modelName )
        for s = 0, hashtable.getSize( sensorEntries ) - 1 do
            local k = hashtable.getKeyAt( sensorEntries, s )
            local v = hashtable.get     ( sensorEntries, k )
            
            local isSelected = (modelName == this.selectionModel() and k == this.selectionJoint())
            
            local type = hashtable.get( v, "type" )
            local x = hashtable.get( v, "x" )
            local y = hashtable.get( v, "y" )
            local z = hashtable.get( v, "z" )
            local w = hashtable.get( v, "w" )
            local h = hashtable.get( v, "h" )
            local d = hashtable.get( v, "d" )
            local r = hashtable.get( v, "r" )
                            
            local px, py, pz = shape.getSkeletonJointTranslation( this.model(), k, object.kGlobalSpace )
            local rx, ry, rz = shape.getSkeletonJointRotation   ( this.model(), k, object.kGlobalSpace )

            if( isSelected ) then
                local dt_ = dt
                local precision = 1
                if( this.keyShiftDown() ) then
                    if( this.precision() > 0 ) then
                        dt_ = 1
                    else
                        dt_ = dt_ / 100
                    end
                    
                    precision = math.pow( 10, this.precision() )
                end

                -- scale
                if( not this.keyControlDown() ) then                    
                    if    ( type == "s" ) then
                        r = math.max( r + dt_ * (this.keyX() + this.keyY() + this.keyZ()) / precision, 0 )
                        hashtable.set( v, "r", r )                               
                    elseif( type == "b" ) then                        
                        w = math.max( w + dt_ * this.keyX() / precision, 0 )
                        h = math.max( h + dt_ * this.keyY() / precision, 0 )
                        d = math.max( d + dt_ * this.keyZ() / precision, 0 )
                        hashtable.set( v, "w", w )
                        hashtable.set( v, "h", h )
                        hashtable.set( v, "d", d )  
                    end
                -- move
                else
                    x = x + dt_ * this.keyX() / precision
                    y = y + dt_ * this.keyY() / precision
                    z = z + dt_ * this.keyZ() / precision

                    hashtable.set( v, "x", x )
                    hashtable.set( v, "y", y )
                    hashtable.set( v, "z", z )
                end

                if( this.keyShiftDown() and this.precision() > 0  ) then
                    this.keyX( 0 )
                    this.keyY( 0 )
                    this.keyZ( 0 )
                end
            end
            
            if( this.precision() > 0 ) then
                local precisionStr = string.format( "%%0.%df", this.precision() )
                x = string.toNumber( string.format( precisionStr, x ) )
                y = string.toNumber( string.format( precisionStr, y ) )
                z = string.toNumber( string.format( precisionStr, z ) )
                w = string.toNumber( string.format( precisionStr, w ) )
                h = string.toNumber( string.format( precisionStr, h ) )
                d = string.toNumber( string.format( precisionStr, d ) )
                r = string.toNumber( string.format( precisionStr, r ) )
            end
                            
            local hSensor = scene.getTaggedObject( hScene, modelName .. "_" .. k        )
            local hGizmo  = scene.getTaggedObject( hScene, modelName .. "_" .. k .. "#" )

            object.setTranslation( hGizmo,  px,  py,  pz, object.kGlobalSpace )
            object.setRotation   ( hGizmo,  rx,  ry,  rz, object.kGlobalSpace )
            object.translate     ( hGizmo,   x,   y,   z, object.kLocalSpace  )
            
            if    ( type == "s" ) then
                sensor.setSphereRadiusAt( hSensor, 0, r )
                sensor.setSphereCenterAt( hSensor, 0, x, y, z, object.kLocalSpace )
                object.setUniformScale( hGizmo, r )
                object.setRotation    ( hGizmo, 0, 0, 0, object.kGlobalSpace ) -- avoid flicker
            elseif( type == "b" ) then
                sensor.setBoxSizeAt  ( hSensor, 0, w, h, d )
                sensor.setBoxCenterAt( hSensor, 0, x, y, z, object.kLocalSpace )
                object.setScale      ( hGizmo, w, h, d )
            end 
            
            if( isSelected ) then
                hud.setLabelText( posXLbl, string.format( "x: %+g", x ) )
                hud.setLabelText( posYLbl, string.format( "y: %+g", y ) )
                hud.setLabelText( posZLbl, string.format( "z: %+g", z ) )
                hud.setLabelText( dimWLbl, string.format( "w: %g" , w ) )
                hud.setLabelText( dimHLbl, string.format( "h: %g" , h ) )
                hud.setLabelText( dimDLbl, string.format( "d: %g" , d ) )
                hud.setLabelText( dimRLbl, string.format( "r: %g" , r ) )
                
                shape.overrideMeshMaterialDiffuse( hGizmo, 255, 0, 0, 1 )
                shape.setMeshOpacity( hGizmo, this.selectionOpacity() )
            else
                shape.overrideMeshMaterialDiffuse( hGizmo, 127, 127, 127, 1 )
                shape.setMeshOpacity( hGizmo, this.isOpace() and this.selectionOpacity() or 1 )
            end                
        end
    end
    
    if( this.animateOnce() ) then
        this.animateOnce( false )
        animation.enablePlayback( this.model(), true )
    else
        animation.enablePlayback( this.model(), this.animate() )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
