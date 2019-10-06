package net.wg.gui.lobby.personalMissions.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.filters.DropShadowFilter;
    import flash.text.TextField;

    public class OperationButtonPostponed extends Sprite implements IDisposable
    {

        private static const ICON_RIGHT_MARGIN:int = -6;

        private static const TXT_FILTER:DropShadowFilter = new DropShadowFilter(0,90,9831174,1,12,12,1.8,2);

        public var labelTF:TextField = null;

        public var icon:Sprite = null;

        public function OperationButtonPostponed()
        {
            super();
            this.labelTF.filters = [TXT_FILTER];
        }

        public final function dispose() : void
        {
            this.labelTF = null;
            this.icon = null;
        }

        public function set label(param1:String) : void
        {
            this.labelTF.text = param1;
            this.icon.x = -(this.labelTF.textWidth >> 1) - this.icon.width - ICON_RIGHT_MARGIN;
        }
    }
}
