class net.wargaming.controls.VoiceWave extends gfx.core.UIComponent
{
    var mutedClip, cross_x, cross_y, _visible, nextFrame, _currentframe, _totalframes, stop, prevFrame, gotoAndStop;
    function VoiceWave()
    {
        super();
    } // End of the function
    function configUI()
    {
        super.configUI();
        mutedClip.cross._x = cross_x;
        mutedClip.cross._y = cross_y;
    } // End of the function
    function isSpeak()
    {
        return (_speak);
    } // End of the function
    function setSpeaking(isSpeak, farcedStop)
    {
        _visible = _global.wg_isShowVoiceChat;
        if (isSpeak == _speak || _muted)
        {
            return;
        } // end if
        _speak = isSpeak;
/* fix decompiler error (sirmax2)
        if (_speak)
        {
            function onEnterFrame()
            {
                this.nextFrame();
                if (_currentframe == _totalframes)
                {
                    this.stop();
                    delete this.onEnterFrame;
                } // end if
            } // End of the function
		}
        else
        {
            function onEnterFrame()
            {
                this.prevFrame();
                if (_currentframe == 1)
                {
                    this.stop();
                    delete this.onEnterFrame;
                } // end if
            } // End of the function
        } // end else if
*/
        if (farcedStop)
        {
            this.gotoAndStop(1);
        } // end if
    } // End of the function
    function isMuted()
    {
        return (_muted);
    } // End of the function
    function setMuted(isMuted)
    {
        if (_muted == isMuted)
        {
            return;
        } // end if
        if (isMuted && _speak)
        {
            this.setSpeaking(false, true);
        } // end if
        mutedClip._visible = _muted = isMuted;
    } // End of the function
    var _speak = false;
    var _muted = false;
} // End of Class
