/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.clock
{
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public interface IClockUI extends IDisposable
    {
        function init(page:LobbyPage):void;
        function setVisibility(isHangar:Boolean):void;
    }
}
