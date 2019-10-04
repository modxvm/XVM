package net.wg.gui.battle.views.messages.VO
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.data.constants.Values;

    public class PoolSettingsVO extends Object implements IDisposable
    {

        public var renderer:String = "";

        public var colorType:String = "";

        public function PoolSettingsVO(param1:Array)
        {
            super();
            this.colorType = param1[0];
            this.renderer = param1[1];
        }

        public function dispose() : void
        {
            this.colorType = Values.EMPTY_STR;
            this.renderer = Values.EMPTY_STR;
        }
    }
}
