--------------------------------------------------------------------------------
--  Function......... : getJointLength
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.getJointLength( hObj, sJoint )
--------------------------------------------------------------------------------

    local ret = 0
    local jointParent = shape.getSkeletonJointParentJointName( hObj, sJoint )
    if( not string.isEmpty( jointParent ) ) then
        local  x,  y,  z = shape.getSkeletonJointTranslation( hObj, sJoint     , object.kGlobalSpace )
        local px, py, pz = shape.getSkeletonJointTranslation( hObj, jointParent, object.kGlobalSpace )
        local dx, dy, dz = math.vectorSubtract( x, y, z, px, py, pz )
        ret = math.vectorLength( dx, dy, dz )
    end
    
    return ret
	
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
