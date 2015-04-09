--------------------------------------------------------------------------------
--  Function......... : serializeSensorsToCsv
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.serializeSensorsToCsv( nPrecision )
--------------------------------------------------------------------------------
	
    local ret = "\r\nmodel;joint;id;type;x;y;z;w;h;d\r\n"
    for m = 0, hashtable.getSize( this.sensors() ) - 1 do
        local modelName     = hashtable.getKeyAt( this.sensors(), m         )
        local sensorEntries = hashtable.get     ( this.sensors(), modelName )
        
        for s = 0, hashtable.getSize( sensorEntries ) - 1 do
            local joint      = hashtable.getKeyAt( sensorEntries, s     )
            local sensorData = hashtable.get     ( sensorEntries, joint )
            
            local id   = hashtable.get( sensorData, "id" )
            local type = hashtable.get( sensorData, "type" )
            local x    = hashtable.get( sensorData, "x" )
            local y    = hashtable.get( sensorData, "y" )
            local z    = hashtable.get( sensorData, "z" )
            local w    = hashtable.get( sensorData, "w" )
            local h    = hashtable.get( sensorData, "h" )
            local d    = hashtable.get( sensorData, "d" )
            local r    = hashtable.get( sensorData, "r" )
            
            local x_, y_, z_, w_, h_, d_, r_            
            if( nPrecision ==0 ) then
                -- %g removes trailing zeros
                x_ = string.format( "%g", x )
                y_ = string.format( "%g", y )
                z_ = string.format( "%g", z )
                w_ = string.format( "%g", w )
                h_ = string.format( "%g", h )
                d_ = string.format( "%g", d )
                r_ = string.format( "%g", r )
            else
                local precisionStr = string.format( "%%0.%df", nPrecision )
                x_ = string.format( precisionStr, x )
                y_ = string.format( precisionStr, y )
                z_ = string.format( precisionStr, z )
                w_ = string.format( precisionStr, w )
                h_ = string.format( precisionStr, h )
                d_ = string.format( precisionStr, d )
                r_ = string.format( precisionStr, r )
            end            
            
            ret = ret .. string.format( "%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s\r\n", modelName, joint, id, type, x_, y_, z_, w_, h_, d_, r_ )
        end
    end
    
    return ret
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
