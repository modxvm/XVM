package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.gui.components.common.ticker.RSSEntryVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class TickerMeta extends BaseDAAPIComponent
    {

        public var showBrowser:Function;

        private var _vectorRSSEntryVO:Vector.<RSSEntryVO>;

        public function TickerMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            var _loc1_:RSSEntryVO = null;
            if(this._vectorRSSEntryVO)
            {
                for each(_loc1_ in this._vectorRSSEntryVO)
                {
                    _loc1_.dispose();
                }
                this._vectorRSSEntryVO.splice(0,this._vectorRSSEntryVO.length);
                this._vectorRSSEntryVO = null;
            }
            super.onDispose();
        }

        public function showBrowserS(param1:String) : void
        {
            App.utils.asserter.assertNotNull(this.showBrowser,"showBrowser" + Errors.CANT_NULL);
            this.showBrowser(param1);
        }

        public final function as_setItems(param1:Array) : void
        {
            var _loc5_:RSSEntryVO = null;
            var _loc2_:Vector.<RSSEntryVO> = this._vectorRSSEntryVO;
            this._vectorRSSEntryVO = new Vector.<RSSEntryVO>(0);
            var _loc3_:uint = param1.length;
            var _loc4_:* = 0;
            while(_loc4_ < _loc3_)
            {
                this._vectorRSSEntryVO[_loc4_] = new RSSEntryVO(param1[_loc4_]);
                _loc4_++;
            }
            this.setItems(this._vectorRSSEntryVO);
            if(_loc2_)
            {
                for each(_loc5_ in _loc2_)
                {
                    _loc5_.dispose();
                }
                _loc2_.splice(0,_loc2_.length);
            }
        }

        protected function setItems(param1:Vector.<RSSEntryVO>) : void
        {
            var _loc2_:String = "as_setItems" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
