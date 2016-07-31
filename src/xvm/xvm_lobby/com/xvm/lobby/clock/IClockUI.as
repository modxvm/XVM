/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.clock
{
    import net.wg.gui.lobby.LobbyPage;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface IClockUI extends IDisposable
    {
        function init(page:LobbyPage):void;
    }
}
