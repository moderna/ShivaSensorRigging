--------------------------------------------------------------------------------
--  Handler.......... : onMouseMove
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onMouseMove( nPointX, nPointY, nDeltaX, nDeltaY, nRayPntX, nRayPntY, nRayPntZ, nRayDirX, nRayDirY, nRayDirZ )
--------------------------------------------------------------------------------
	
	if( this.mouseDown0() ) then
        this.mouseDownMoved( true )
    
        this.camRotY( this.camRotY() + -nDeltaX * 50 )
        this.camRotX( this.camRotX() +  nDeltaY * 10 )        
    end
    
    if( this.mouseDown1() ) then
        local hCam = user.getActiveCamera( this.getUser() )
        this.camPosX( this.camPosX() + -nDeltaX )
        this.camPosY( this.camPosY() + -nDeltaY )        
    end

    if( this.mouseDown2() ) then
        this.camDist( this.camDist() + nDeltaY )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
