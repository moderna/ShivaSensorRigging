--------------------------------------------------------------------------------
--  Function......... : addSensorEntry
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.addSensorEntry( sModel, sJoint, nId, cType, x, y, z, w, h, d, r )
--------------------------------------------------------------------------------

    local hScene = application.getCurrentUserScene()

    local sensorData = hashtable.newInstance()
    hashtable.add( sensorData, "id"  , nId   )
    hashtable.add( sensorData, "type", cType )
    hashtable.add( sensorData, "x"   , x     )
    hashtable.add( sensorData, "y"   , y     )
    hashtable.add( sensorData, "z"   , z     )
    hashtable.add( sensorData, "w"   , w     )
    hashtable.add( sensorData, "h"   , h     )
    hashtable.add( sensorData, "d"   , d     )
    hashtable.add( sensorData, "r"   , r     )
    
    if( hashtable.contains( this.sensors(), sModel ) ) then
        local sensorEntries = hashtable.get( this.sensors(), sModel )
        hashtable.add( sensorEntries, sJoint, sensorData )
    else
        local sensorEntries = hashtable.newInstance()
        hashtable.add( sensorEntries, sJoint, sensorData )
        hashtable.add( this.sensors(), sModel, sensorEntries )
    end

--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
