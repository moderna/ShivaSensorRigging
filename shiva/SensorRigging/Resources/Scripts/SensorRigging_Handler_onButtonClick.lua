--------------------------------------------------------------------------------
--  Handler.......... : onButtonClick
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onButtonClick( sTemplate, sButton )
--------------------------------------------------------------------------------
	
    log.message( "SensorRigging.onButtonClick( sTemplate='" .. sTemplate .. "', sButton='" .. sButton .. "' )" )
    local btn = hud.getComponent( this.getUser(), sTemplate .. "." .. sButton .. "Btn" )

    if( btn ~= nil ) then    
        if    ( sTemplate == "Hud" ) then
            if    ( false ) then
            elseif( sButton == "Show" ) then
            end
        end
    else
        log.warning( "SensorRigging.onButtonClick: component not found '" .. sTemplate .. "." .. sButton .. "Btn'" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
