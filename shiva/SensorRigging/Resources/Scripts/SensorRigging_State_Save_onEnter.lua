--------------------------------------------------------------------------------
--  State............ : Save
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.Save_onEnter()
--------------------------------------------------------------------------------

    local precision = 0
    if( this.keyShiftDown() ) then
        precision = this.precision()
    end

    local csv = this.serializeSensorsToCsv( precision )
    local hRoot = xml.getRootElement( this.sensorsXml() )
    xml.setElementValue( hRoot, csv )
    
    local dir = "file://" .. application.getPackDirectory() .. "/AdditionalFiles/"
    xml.send( this.sensorsXml(), dir .. this._SENSORS_FILENAME() )
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
