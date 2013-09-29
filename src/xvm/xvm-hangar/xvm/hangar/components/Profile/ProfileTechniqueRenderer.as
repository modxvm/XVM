package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.events.ObjectEvent;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class ProfileTechniqueRenderer
    {
        private var proxy:TechniqueRenderer;

        private var effField:TextField;
        private var playerName:String;

        public function ProfileTechniqueRenderer(proxy:TechniqueRenderer)
        {
            try
            {
                this.proxy = proxy;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public function draw():void
        {
            if (!proxy || !proxy.data)
                return;
            Logger.addObject(proxy.data);

            var isSummary:Boolean = proxy.data.id == -1;

            proxy.levelMC.visible = !isSummary;
            proxy.vehicleTF.x = isSummary ? 121 : 166;
            // TODO proxy.vehicleTF.textColor = proxy.data.premium ? Defines.UICOLOR_GOLD : Defines.UICOLOR_DEFAULT;
        }

        // PRIVATE
    }

}
