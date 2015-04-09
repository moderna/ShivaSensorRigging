--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyUp
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onKeyboardKeyUp( kKeyCode )
--------------------------------------------------------------------------------
	
    this.inputFlushTotalFrameTime( application.getTotalFrameTime() )
    if( not this.inputFlushLastFrame() ) then
        local hScene = application.getCurrentUserScene()
        local statusLbl = hud.getComponent( this.getUser(), "Hud.StatusLbl" )

        if    ( false ) then
        elseif( kKeyCode == input.kKeyLAlt     or kKeyCode == input.kKeyRAlt     ) then
            this.keyAltDown    ( false )
        elseif( kKeyCode == input.kKeyLControl or kKeyCode == input.kKeyRControl ) then
            this.keyControlDown( false )
        elseif( kKeyCode == input.kKeyLShift   or kKeyCode == input.kKeyRShift   ) then
            this.keyShiftDown  ( false )
        elseif( kKeyCode == input.kKeyLeft     ) then
            this.keyX( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyRight    ) then
            this.keyX( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyDown     ) then
            this.keyY( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyUp       ) then
            this.keyY( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyPageUp   ) then
            this.keyZ( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyPageDown ) then
            this.keyZ( 0 )
            --this.undoEndEntry( "mod" )
        elseif( kKeyCode == input.kKeyF        ) then        
            local x, y, z
            if( this.focusSensor() or (string.isEmpty( this.selectionModel() ) and string.isEmpty( this.selectionJoint() )) ) then
                this.focusSensor( false )
                --x, y, z = object.getBoundingSphereCenter( this.model() )
                -- TODO find center of mesh, not object
                x = 0
                y = 1
                z = 0
                --this.camDist( 2.5 )
                log.message( string.format( "focus model: %+0.2f %+0.2f %+0.2f", x, y, z ) )
            else
                this.focusSensor( true )
                local hGizmo = scene.getTaggedObject ( hScene, this.selectionModel() .. "_" .. this.selectionJoint() .. "#" )
                x, y, z = object.getTranslation( hGizmo, object.kGlobalSpace )
                --this.camDist( 1 )
                log.message( string.format( "focus sensor: %+0.2f %+0.2f %+0.2f", x, y, z ) )
            end
            this.camDestX( x )
            this.camDestY( y )
            this.camDestZ( z )
        elseif( kKeyCode == input.kKeyT        ) then        
            if( not (string.isEmpty( this.selectionModel() ) or string.isEmpty( this.selectionJoint() )) ) then
                local sensorEntries = hashtable.get( this.sensors(), this.selectionModel() )
                local sensorData    = hashtable.get( sensorEntries , this.selectionJoint() )
                local type          = hashtable.get( sensorData    , "type"                )
                if    ( type == "s" ) then
                    this.type( "b" )
                elseif( type == "b" ) then
                    this.type( "s" )
                end
                hashtable.set( sensorData, "type", this.type() )
                
                local hSensor = scene.getTaggedObject( hScene, this.selectionModel() .. "_" .. this.selectionJoint() )
                local hGizmo  = scene.getTaggedObject( hScene, this.selectionModel() .. "_" .. this.selectionJoint() .. "#" )
                
                scene.destroyRuntimeObject( hScene, hSensor )
                scene.destroyRuntimeObject( hScene, hGizmo  )
                
                this.addSensor     ( this.model()         , this.selectionJoint(), this.type() )
                this.addSensorGizmo( this.selectionModel(), this.selectionJoint(), this.type() )
            else
                if    ( this.type() == "s" ) then
                    this.type( "b" )
                elseif( this.type() == "b" ) then
                    this.type( "s" )
                end            
            end
        elseif( kKeyCode == input.kKeyC ) then
            if( this.keyControlDown() ) then
                if( not (string.isEmpty( this.selectionModel() ) or string.isEmpty( this.selectionJoint() )) ) then
                    local sensorEntries = hashtable.get( this.sensors(), this.selectionModel() )
                    local sensorData    = hashtable.get( sensorEntries , this.selectionJoint() )
                    
                    hashtable.copy( this.clipboardSensorData(), sensorData )

                    hud.setLabelText( statusLbl, "copied to clipboard" )
                end            
            end
        elseif( kKeyCode == input.kKeyV ) then
            if( this.keyControlDown() ) then
                if( not (string.isEmpty( this.selectionModel() ) or string.isEmpty( this.selectionJoint() )) ) then
                    local sensorEntries = hashtable.get( this.sensors(), this.selectionModel() )
                    local sensorData    = hashtable.get( sensorEntries , this.selectionJoint() )
                    
                    hashtable.copy( sensorData, this.clipboardSensorData() )

                    hud.setLabelText( statusLbl, "pasted from clipboard" )
                end
            end
        elseif( kKeyCode == input.kKey0 ) then
            if( not this.keyControlDown() ) then
                this.precision( 0 )
                hud.setLabelText( statusLbl, "precision: 0" )
            end
        elseif( kKeyCode == input.kKey1 ) then
            this.precision( 1 )
            hud.setLabelText( statusLbl, "precision: 1" )
        elseif( kKeyCode == input.kKey2 ) then
            this.precision( 2 )
            hud.setLabelText( statusLbl, "precision: 2" )
        elseif( kKeyCode == input.kKey3 ) then
            this.precision( 3 )
            hud.setLabelText( statusLbl, "precision: 3" )
        elseif( kKeyCode == input.kKey4 ) then
            this.precision( 4 )
            hud.setLabelText( statusLbl, "precision: 4" )
        elseif( kKeyCode == input.kKey5 ) then
            this.precision( 5 )
            hud.setLabelText( statusLbl, "precision: 5" )
        elseif( kKeyCode == input.kKey6 ) then
            this.precision( 6 )
            hud.setLabelText( statusLbl, "precision: 6" )
        elseif( kKeyCode == input.kKeyDelete   ) then
            if( not (string.isEmpty( this.selectionModel() ) or string.isEmpty( this.selectionJoint() )) ) then
                local sensorEntries = hashtable.get( this.sensors(), this.selectionModel()  )
                hashtable.remove( sensorEntries, this.selectionJoint() )
                
                local hSensor = scene.getTaggedObject( hScene, this.selectionModel() .. "_" .. this.selectionJoint() )
                local hGizmo  = scene.getTaggedObject( hScene, this.selectionModel() .. "_" .. this.selectionJoint() .. "#" )
                
                scene.destroyRuntimeObject( hScene, hSensor )
                scene.destroyRuntimeObject( hScene, hGizmo  )
            
                this.selectionModel( "" )
                this.selectionJoint( "" )
            end
        elseif( kKeyCode == input.kKeyTab ) then
            if( not this.keyControlDown() ) then
                local isModelVisible = shape.getMeshOpacity( this.model() ) > 0
                shape.setMeshOpacity( this.model(), isModelVisible and 0 or 255 )
                for i = 0, scene.getObjectCount( hScene ) - 1 do
                    local hObj = scene.getObjectAt( hScene, i )
                    if( object.getModelName( hObj ) == "GizmoJoint" ) then
                        object.setVisible( hObj, isModelVisible )
                    end
                end        
            else
                this.isOpace( not this.isOpace() )            
            end
        elseif( kKeyCode == input.kKeyBackspace ) then
            if( not (string.isEmpty( this.selectionModel() ) or string.isEmpty( this.selectionJoint() )) ) then
                local sensorEntries = hashtable.get( this.sensors(), this.selectionModel() )
                local sensorData    = hashtable.get( sensorEntries , this.selectionJoint() )
                local type          = hashtable.get( sensorData    , "type"                )

                -- scale
                if( not (this.keyAltDown() or this.keyControlDown() or this.keyShiftDown()) ) then
                    local d = this.getJointLength( this.model(), this.selectionJoint() )
                    if( d > 0 ) then                    
                        if    ( type == "s" ) then
                            hashtable.set( sensorData, "r", d / 2 )
                        elseif( type == "b" ) then
                            hashtable.set( sensorData, "w", d )
                            hashtable.set( sensorData, "h", d )
                            hashtable.set( sensorData, "d", d )
                        end
                    end
                -- move
                elseif( this.keyShiftDown()   and not (this.keyAltDown() or this.keyControlDown()) ) then
                    hashtable.set( sensorData, "x", 0 )
                    hashtable.set( sensorData, "y", 0 )
                    hashtable.set( sensorData, "z", 0 )
                end
            end
        elseif( kKeyCode == input.kKeySpace    ) then
            if( this.animate() ) then
                this.animate( false )
                if( object.hasController( this.model(), object.kControllerTypeAnimation ) ) then
                    animation.enablePlayback( this.model(), false )
                end
            else
                this.animate( true )
                if( object.hasController( this.model(), object.kControllerTypeAnimation ) ) then
                    animation.enablePlayback( this.model(), true )
                    animation.setPlaybackSpeed( this.model(), 0, this.animationSpeed() )
                end
            end
        elseif( kKeyCode == input.kKeyS ) then
            if( this.keyControlDown() ) then    
                this.Save()
            end
        elseif( kKeyCode == input.kKeyO ) then
            local modelName = object.getModelName( this.model() )
            
            local i = table.getSize( this.models() )
            local modelBasename
            repeat
                modelBasename = table.getAt( this.models(), i )
                i = i - 1
            until( modelBasename == modelName or i < 0  )
            
            if( i < 0 ) then i = table.getSize( this.models() ) - 1 end
            modelBasename = table.getAt( this.models(), i )
            this.changeModel( modelBasename )
        elseif( kKeyCode == input.kKeyP ) then
            local modelName = object.getModelName( this.model() )
            
            local i = 0
            local modelBasename
            repeat
                modelBasename = table.getAt( this.models(), i )
                i = i + 1
            until( modelBasename == modelName or i >= table.getSize( this.models() ) )
            
            i = math.mod( i, table.getSize( this.models() ) )
            modelBasename = table.getAt( this.models(), i )
            this.changeModel( modelBasename )
        elseif( kKeyCode == input.kKeyZ ) then
--             if( this.keyControlDown() ) then
--                 if( this.undoIdx() > 0 ) then
--                     this.undoApply( this.undoIdx() )
--                     this.undoIdx( this.undoIdx() - 1 )
--                 end
--             end
        elseif( kKeyCode == input.kKeyY ) then
--             if( this.keyControlDown() ) then
--                 if( this.undoIdx() < table.getSize( this.undoStack() ) - 1 ) then
--                     this.undoIdx( this.undoIdx() + 1 )
--                     this.undoApply( this.undoIdx() )
--                 end
--             end
        end
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
