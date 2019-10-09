/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.limits
{
    import net.wg.gui.lobby.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public interface ILimitsUI extends IDisposable
    {
        function init(page:LobbyPage):void;
    }
}
