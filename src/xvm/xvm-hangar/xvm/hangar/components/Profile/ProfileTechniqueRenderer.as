package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.events.ObjectEvent;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.vehinfo.*;
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
            this.proxy = proxy;
        }

        public function draw():void
        {
            if (!proxy || !proxy.data)
                return;

            var isSummary:Boolean = proxy.data.id == 0;

            proxy.levelMC.visible = !isSummary;
            proxy.vehicleTF.x = isSummary ? 121 : 166;

            proxy.vehicleTF.textColor = Defines.UICOLOR_DEFAULT;
            if (!isSummary)
            {
                var vi:Object = VehicleInfo.getInfo2ByVid(proxy.data.id);
                if (vi != null && vi.premium == 1)
                    proxy.vehicleTF.textColor = Defines.UICOLOR_GOLD;
            }
        }

        // PRIVATE
    }

}
