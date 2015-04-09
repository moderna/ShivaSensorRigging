--------------------------------------------------------------------------------
--  State............ : _Init
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging._Init_onLoop()
--------------------------------------------------------------------------------

    local allLoaded = true
    
    -- check model files
    for m = table.getSize( this.models() ) - 1, 0, -1 do
        local modelBasename = table.getAt( this.models(), m )
        local modelFilename = modelBasename .. "." .. this._MODEL_EXT()
        local fileStatus = cache.getFileStatus( modelFilename )
        if    ( fileStatus == -1 ) then
            local modelDir = application.getPackDirectory() .. "/Models/"
            cache.addFile( modelFilename, modelDir .. modelFilename )
            allLoaded = allLoaded and false
        elseif( fileStatus > 0 and fileStatus < 1 ) then
            allLoaded = allLoaded and false
        elseif( fileStatus == -2 ) then
            log.warning( "SensorRigging._Init_onLoop(): error loading model '" .. modelBasename .. "' ... removing" )
            table.removeAt( this.models(), m )
        end
    end
    
    -- check sensors.xml
    local fileStatus = xml.getReceiveStatus( this.sensorsXml() )
    if    ( fileStatus == -1 ) then
        local dir = "file://" .. application.getPackDirectory() .. "/AdditionalFiles/"
        local ok = xml.receive( this.sensorsXml(), dir .. this._SENSORS_FILENAME() )
        
        local fileStatus = xml.getReceiveStatus( this.sensorsXml() )
        if( ok and fileStatus == -1 ) then
            -- assume file missing
            local csv = this.serializeSensorsToCsv( 0 )
            local hRoot = xml.getRootElement( this.sensorsXml() )
            xml.setElementValue( hRoot, csv )
            xml.send( this.sensorsXml(), dir .. this._SENSORS_FILENAME() )
        else
            allLoaded = allLoaded and false
        end
    elseif( fileStatus  >  0 and fileStatus < 1 ) then
        allLoaded = allLoaded and false
    elseif( fileStatus == -2 ) then
        log.error( "SensorRigging._Init_onLoop(): error loading file '" .. dir .. this._SENSORS_FILENAME() .. "'"  )
        application.quit()
    end
    
    local ft = application.getTotalFrameTime()
    if( this.inputFlushLastFrame() ) then
        if( ft ~= this.inputFlushTotalFrameTime() ) then
            this.inputFlushLastFrame( false )
            if( ft > 0 ) then
                log.warning( string.format( "Shiva editor input bug - flushed old inputs (%0.2fs)", ft ) )
            end
        else
            allLoaded = allLoaded and false
        end
    end

    if( allLoaded ) then
        this.Main()
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
