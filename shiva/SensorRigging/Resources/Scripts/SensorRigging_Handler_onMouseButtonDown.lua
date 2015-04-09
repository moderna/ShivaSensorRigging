--------------------------------------------------------------------------------
--  Handler.......... : onMouseButtonDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onMouseButtonDown( nButton, nPointX, nPointY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	if    ( nButton == 0 ) then
        this.mouseDown0( true )
        this.mouseDownMoved( false )
    elseif( nButton == 1 ) then
        this.mouseDown1( true )         
    elseif( nButton == 2 ) then
        this.mouseDown2( true )         
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
