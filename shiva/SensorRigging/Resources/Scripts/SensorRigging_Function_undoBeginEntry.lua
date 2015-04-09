--------------------------------------------------------------------------------
--  Function......... : undoBeginEntry
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.undoBeginEntry()
--------------------------------------------------------------------------------

    hashtable.empty( this.undoBegin() )
	
    if( not string.isEmpty( this.selectionJoint() ) ) then
        local modelName = object.getModelName( this.model() )
        if( hashtable.contains( this.sensors(), modelName ) ) then
            local sensorEntries = hashtable.get( this.sensors(), modelName )
            local sensorEntry   = hashtable.get( sensorEntries , this.selectionJoint() )
            
            for i = table.getSize( this.undoStack() ) - 1, this.undoIdx() + 1, -1 do
                table.removeLast( this.undoStack() )
            end
            
            hashtable.copy( this.undoBegin(), sensorEntry )
        end
    end
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
