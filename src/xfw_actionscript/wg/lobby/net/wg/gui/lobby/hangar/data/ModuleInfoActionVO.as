package net.wg.gui.lobby.hangar.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class ModuleInfoActionVO extends DAAPIDataClass
    {

        public var visible:Boolean = false;

        public var label:String = "";

        public function ModuleInfoActionVO(param1:Object)
        {
            super(param1);
        }
    }
}
