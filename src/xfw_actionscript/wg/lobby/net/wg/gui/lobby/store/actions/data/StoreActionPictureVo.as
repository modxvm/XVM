package net.wg.gui.lobby.store.actions.data
{
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class StoreActionPictureVo extends DAAPIDataClass
    {

        public var src:String = "";

        public var isWeb:Boolean = false;

        public function StoreActionPictureVo(param1:Object = null)
        {
            super(param1);
        }
    }
}
