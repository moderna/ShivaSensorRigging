--------------------------------------------------------------------------------
--  Handler.......... : onMouseWheel
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onMouseWheel( nDelta )
--------------------------------------------------------------------------------
	
    if    ( not (this.keyControlDown() or this.keyAltDown()) ) then
        local dx = nDelta * 0.1
        this.camDist( this.camDist() + dx )
    elseif( this.keyControlDown() and not this.keyAltDown() ) then
        this.selectionOpacity( math.clamp( this.selectionOpacity() + nDelta * 0.1, 0, 1 ) )
    elseif( this.keyAltDown() and not this.keyControlDown() ) then
        this.animationSpeed( math.clamp( this.animationSpeed() + nDelta * 5, 0, 200 ) )
        
        local hScene = application.getCurrentUserScene()
        animation.setPlaybackSpeed( this.model(), 0, this.animationSpeed() )
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
