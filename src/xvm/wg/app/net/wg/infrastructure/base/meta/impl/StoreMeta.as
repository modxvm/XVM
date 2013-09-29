package net.wg.infrastructure.base.meta.impl 
{
    import net.wg.data.VO.*;
    import net.wg.data.VO.generated.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.base.*;
    import net.wg.infrastructure.exceptions.*;
    
    public class StoreMeta extends net.wg.infrastructure.base.AbstractView
    {
        public function StoreMeta()
        {
            super();
            return;
        }

        public function requestTableDataS(arg1:Number, arg2:String, arg3:Array):void
        {
            App.utils.asserter.assertNotNull(this.requestTableData, "requestTableData" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestTableData(arg1, arg2, arg3);
            return;
        }

        public function requestFilterDataS(arg1:String):void
        {
            App.utils.asserter.assertNotNull(this.requestFilterData, "requestFilterData" + net.wg.data.constants.Errors.CANT_NULL);
            this.requestFilterData(arg1);
            return;
        }

        public function onCloseButtonClickS():void
        {
            App.utils.asserter.assertNotNull(this.onCloseButtonClick, "onCloseButtonClick" + net.wg.data.constants.Errors.CANT_NULL);
            this.onCloseButtonClick();
            return;
        }

        public function onShowInfoS(arg1:net.wg.data.VO.StoreTableData):void
        {
            App.utils.asserter.assertNotNull(this.onShowInfo, "onShowInfo" + net.wg.data.constants.Errors.CANT_NULL);
            this.onShowInfo(arg1);
            return;
        }

        public function getNameS():String
        {
            App.utils.asserter.assertNotNull(this.getName, "getName" + net.wg.data.constants.Errors.CANT_NULL);
            return this.getName();
        }

        public function as_setFilterType(arg1:Object):void
        {
            var loc1:*=new net.wg.data.VO.generated.ShopNationFilterData(arg1);
            this.setFilterType(loc1);
            return;
        }

        protected function setFilterType(arg1:net.wg.data.VO.generated.ShopNationFilterData):void
        {
            var loc1:*="as_setFilterType" + net.wg.data.constants.Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(loc1);
            throw new net.wg.infrastructure.exceptions.AbstractException(loc1);
        }

        public var requestTableData:Function=null;

        public var requestFilterData:Function=null;

        public var onCloseButtonClick:Function=null;

        public var onShowInfo:Function=null;

        public var getName:Function=null;
    }
}
