package net.wg.gui.battle.windows.vo
{
    import net.wg.data.daapi.base.DAAPIDataClass;
    import scaleform.clik.data.DataProvider;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import net.wg.gui.components.paginator.vo.PaginatorPageNumVO;

    public class IngameDetailsHelpVO extends DAAPIDataClass
    {

        private static const PAGES:String = "pages";

        public var title:String = "";

        private var _pages:DataProvider;

        public function IngameDetailsHelpVO(param1:Object = null)
        {
            super(param1);
        }

        override protected function onDispose() : void
        {
            var _loc1_:IDisposable = null;
            for each(_loc1_ in this._pages)
            {
                _loc1_.dispose();
            }
            this._pages.cleanUp();
            this._pages = null;
            super.onDispose();
        }

        override protected function onDataWrite(param1:String, param2:Object) : Boolean
        {
            var _loc3_:Object = null;
            if(param1 == PAGES)
            {
                this._pages = new DataProvider();
                for each(_loc3_ in param2)
                {
                    this._pages.push(new PaginatorPageNumVO(_loc3_));
                }
                return false;
            }
            return super.onDataWrite(param1,param2);
        }

        public function get pages() : DataProvider
        {
            return this._pages;
        }
    }
}
