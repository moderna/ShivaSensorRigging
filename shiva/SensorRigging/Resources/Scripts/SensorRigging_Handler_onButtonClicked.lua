--------------------------------------------------------------------------------
--  Handler.......... : onButtonClicked
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onButtonClicked( sTemplate, sButton )
--------------------------------------------------------------------------------
	
    log.message( "SensorRigging.onButtonClicked( sTemplate='" .. sTemplate .. "', sButton='" .. sButton .. "' )" )
    local btn = hud.getComponent( this.getUser(), sTemplate .. "." .. sButton .. "Btn" )

    local hScene = application.getCurrentUserScene()

    if( btn ~= nil ) then
        if     ( sTemplate == "Hud" ) then
            if    ( false ) then
            elseif( sButton == "Show" ) then
                local isModelVisible = shape.getMeshOpacity( this.model() ) > 0
                shape.setMeshOpacity( this.model(), isModelVisible and 0 or 255 )
                for i = 0, scene.getObjectCount( hScene ) - 1 do
                    local hObj = scene.getObjectAt( hScene, i )
                    if( object.getModelName( hObj ) == "GizmoJoint" ) then
                        object.setVisible( hObj, isModelVisible )
                    end
                end        
            end
        end
    else
        log.warning( "SensorRigging.onButtonClicked: component not found '" .. sTemplate .. "." .. sButton .. "Btn'" )
    end

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
