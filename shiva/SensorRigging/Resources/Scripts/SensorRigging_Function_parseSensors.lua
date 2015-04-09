--------------------------------------------------------------------------------
--  Function......... : parseSensors
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.parseSensors( sCsv )
--------------------------------------------------------------------------------
	
    local csvLines = table.newInstance()
    string.explode( sCsv, csvLines, "\r\n" )

--     local csvHeaderLine = table.getFirst( csvLines )
--     local headers = table.newInstance()
--     string.explode( csvHeaderLine, headers, ";" )        
 
    for r = 1, table.getSize( csvLines ) - 1 do
        local csvLine = table.getAt( csvLines, r )
        local cells = table.newInstance()
        string.explode( csvLine, cells, ";" )

        local model =                  table.getAt( cells,  0 )
        local joint =                  table.getAt( cells,  1 )
        local id    = string.toNumber( table.getAt( cells,  2 ) )
        local type  =                  table.getAt( cells,  3 )
        local x     = string.toNumber( table.getAt( cells,  4 ) )
        local y     = string.toNumber( table.getAt( cells,  5 ) )
        local z     = string.toNumber( table.getAt( cells,  6 ) )
        local w     = string.toNumber( table.getAt( cells,  7 ) )
        local h     = string.toNumber( table.getAt( cells,  8 ) )
        local d     = string.toNumber( table.getAt( cells,  9 ) )
        local r     = string.toNumber( table.getAt( cells, 10 ) )
        
        this.addSensorEntry( model, joint, id, type, x, y, z, w, h, d, r )
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
