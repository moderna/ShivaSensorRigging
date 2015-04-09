--------------------------------------------------------------------------------
--  State............ : Save
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.Save_onLoop()
--------------------------------------------------------------------------------
	
    local statusLbl = hud.getComponent( this.getUser(), "Hud.StatusLbl" )

    local fileStatus = xml.getSendStatus( this.sensorsXml() )    
    if    ( fileStatus == -1 ) then
        -- handled in onEnter
    elseif( fileStatus  >  0 and fileStatus < 1 ) then
        hud.setLabelText( statusLbl, string.format( "saving file %0.2f%%", 100 * fileStatus ) )
    elseif( fileStatus ==  1 ) then
        hud.setLabelText( statusLbl, "file saved" )
        this.Main()
    elseif( fileStatus == -2 ) then
        hud.setLabelText( statusLbl, "SensorRigging.Save_onLoop(): error saving file '" .. this._SENSORS_FILENAME() .. "'" )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
