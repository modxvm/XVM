/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.limits
{
    import net.wg.gui.lobby.LobbyPage;
    import net.wg.infrastructure.interfaces.entity.IDisposable;

    public interface ILimitsUI extends IDisposable
    {
        function init(page:LobbyPage):void;
    }

}
