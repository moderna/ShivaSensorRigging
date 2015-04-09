--------------------------------------------------------------------------------
--  Handler.......... : onKeyboardKeyDown
--  Author........... : 
--  Description...... : 
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
function SensorRigging.onKeyboardKeyDown( kKeyCode )
--------------------------------------------------------------------------------

    this.inputFlushTotalFrameTime( application.getTotalFrameTime() )
    if( not this.inputFlushLastFrame() ) then        
        if    ( false ) then
        elseif( kKeyCode == input.kKeyLAlt     or kKeyCode == input.kKeyRAlt     ) then
            this.keyAltDown    ( true )
        elseif( kKeyCode == input.kKeyLControl or kKeyCode == input.kKeyRControl ) then
            this.keyControlDown( true )
        elseif( kKeyCode == input.kKeyLShift   or kKeyCode == input.kKeyRShift   ) then
            this.keyShiftDown  ( true )
        elseif( kKeyCode == input.kKeyLeft     ) then
            this.keyX( -1 )
            --this.undoBeginEntry()
        elseif( kKeyCode == input.kKeyRight    ) then
            this.keyX(  1 )
            --this.undoBeginEntry()
        elseif( kKeyCode == input.kKeyDown     ) then
            this.keyY( -1 )
            --this.undoBeginEntry()
        elseif( kKeyCode == input.kKeyUp       ) then
            this.keyY(  1 )
            --this.undoBeginEntry()
        elseif( kKeyCode == input.kKeyPageDown ) then
            this.keyZ( -1 )
            --this.undoBeginEntry()
        elseif( kKeyCode == input.kKeyPageUp   ) then
            this.keyZ(  1 )
            --this.undoBeginEntry()
        end
    end
    
--------------------------------------------------------------------------------
end
--------------------------------------------------------------------------------
