/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.infrastructure.*;
    import com.xvm.types.*;
    //import flash.utils.*;
    //import net.wg.gui.messenger.*;
    //import net.wg.gui.messenger.data.*;
    import net.wg.infrastructure.events.*;
    import net.wg.infrastructure.interfaces.*;
    //import net.wg.infrastructure.interfaces.entity.*;
    //import org.idmedia.as3commons.util.StringUtils;

    public class LobbyXvmView extends XvmViewBase
    {
        public function LobbyXvmView(view:IView)
        {
            super(view);
        }

        override public function onBeforePopulate(e:LifeCycleEvent):void
        {
            Config.networkServicesSettings = new NetworkServicesSettings(Xfw.cmd(XvmCommands.GET_SVC_SETTINGS));
            super.onBeforePopulate(e);
        }
    }
}
