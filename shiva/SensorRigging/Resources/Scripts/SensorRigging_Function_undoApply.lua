--------------------------------------------------------------------------------
--  Function......... : undoApply
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.undoApply( nIdx )
--------------------------------------------------------------------------------
	
    local undoEntry = table.getAt( this.undoStack(), nIdx )
    local undoType  = hashtable.get( undoEntry, "undo" )
    
    if( undoType == "mod" ) then
        local modelName = hashtable.get( undoEntry, "model" )
        if( hashtable.contains( this.sensors(), modelName ) ) then
            local joint = hashtable.get( undoEntry, "joint" )
            this.selectionJoint( joint )
        
            if( nIdx == table.getSize( this.undoStack() ) - 1 ) then
                this.undoBeginEntry()
                this.undoEndEntry( "mod" )
            end

            for i = 0, hashtable.getSize( undoEntry ) - 1 do
                local k = hashtable.getKeyAt( undoEntry, i )
                local v = hashtable.get     ( undoEntry, k )
                
                log.message( k .. "=" .. v )
            end
        
            local sensorEntries = hashtable.get( this.sensors(), modelName )            
            local sensorEntry = hashtable.newInstance()
            hashtable.copy( sensorEntry, undoEntry )
            hashtable.remove( sensorEntry, "undo" )
            hashtable.remove( sensorEntry, "model" )
            hashtable.remove( sensorEntry, "joint" )
            hashtable.set( sensorEntries, joint, undoEntry )
        end
    end
            
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
