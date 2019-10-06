package net.wg.gui.battle.windows.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class IngameDetailsPageVO extends DAAPIDataClass
    {

        public var title:String = "";

        public var descr:String = "";

        public var image:String = "";

        public var buttons:Array;

        public var selected:Boolean;

        public function IngameDetailsPageVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            this.buttons.splice(0,this.buttons.length);
            this.buttons = null;
            super.onDispose();
        }
    }
}
