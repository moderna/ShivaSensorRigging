--------------------------------------------------------------------------------
--  Function......... : undoEndEntry
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.undoEndEntry( sType )
--------------------------------------------------------------------------------

    if( not hashtable.isEmpty( this.undoBegin() ) ) then
        local modelName = object.getModelName( this.model() )
        hashtable.add( this.undoBegin(), "model", modelName )
        hashtable.add( this.undoBegin(), "joint", this.selectionJoint() )
        hashtable.add( this.undoBegin(), "undo" , "mod" )
        
        table.add( this.undoStack(), this.undoBegin() )        
        this.undoIdx( table.getSize( this.undoStack() ) - 1 )
        
        log.message( "added undo entry" )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
