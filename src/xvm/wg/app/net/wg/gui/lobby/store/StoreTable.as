package net.wg.gui.lobby.store 
{
    import flash.text.*;
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.data.*;
    import scaleform.clik.interfaces.*;
    
    public class StoreTable extends net.wg.infrastructure.base.meta.impl.StoreTableMeta implements net.wg.infrastructure.interfaces.IStoreTable
    {
        public function StoreTable()
        {
            super();
            return;
        }

        public function as_setTable(arg1:Array):void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(arg1, "tableData");
            this._data = arg1;
            invalidate(INVALID_TABLE);
            return;
        }

        public function as_scrollToFirst(arg1:Number, arg2:String, arg3:String):void
        {
            return;
        }

        public function as_setGold(arg1:Number):void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(this._tableVO, "_tableVO");
            this._tableVO.gold = arg1;
            return;
        }

        public function as_setCredits(arg1:Number):void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(this._tableVO, "_tableVO");
            this._tableVO.credits = arg1;
            return;
        }

        public function updateHeaderCountTitle(arg1:String):void
        {
            this.header.headerInfo.countField.text = arg1;
            return;
        }

        public function setVehicleRendererLinkage(arg1:String):void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(arg1, "linkage");
            this.vehicleRendererLinkage = arg1;
            return;
        }

        public function setModuleRendererLinkage(arg1:String):void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(arg1, "linkage");
            this.moduleRendererLinkage = arg1;
            visible;
            return;
        }

        public function get rightOrientedCount():Boolean
        {
            return this._rightOrientedCount;
        }

        public function set rightOrientedCount(arg1:Boolean):void
        {
            if (arg1 != this._rightOrientedCount) 
            {
                this._rightOrientedCount = arg1;
                if (this._rightOrientedCount) 
                {
                    this.header.headerInfo.countField.x = RIGHT_ORIENTED_COUNT_POSITION;
                }
                else 
                {
                    this.header.headerInfo.countField.x = DEFAULT_COUNT_POSITION;
                }
            }
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALID_TABLE) && this._tableVO) 
            {
                this.updateTable();
            }
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            this._tableVO = new net.wg.data.VO.StoreTableVO();
            if (this._data) 
            {
                invalidate(INVALID_TABLE);
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            this._tableVO = null;
            if (this._data) 
            {
                this._data.splice(0, this._data.length);
                this._data = null;
            }
            this.vehicleRendererLinkage = null;
            this.moduleRendererLinkage = null;
            return;
        }

        internal function updateTable():void
        {
            net.wg.gui.lobby.store.StoreTable.assertNotNull(this._data, "_data");
            net.wg.gui.lobby.store.StoreTable.assertNotNull(this.moduleRendererLinkage, "moduleRendererLinkage");
            net.wg.gui.lobby.store.StoreTable.assertNotNull(this.vehicleRendererLinkage, "vehicleRendererLinkage");
            var loc1:*=this._data.shift();
            this.list.scrollToIndex(0);
            this.setupDataProvider(loc1);
            this.setupRendererType(loc1);
            return;
        }

        internal function setupRendererType(arg1:String):void
        {
            var type:String;
            var rendererName:String;
            var classRef:Class;

            var loc1:*;
            rendererName = null;
            classRef = null;
            type = arg1;
            rendererName = this.moduleRendererLinkage;
            if (type == net.wg.data.constants.FittingTypes.VEHICLE) 
            {
                rendererName = this.vehicleRendererLinkage;
            }
            this.detectRendererHeight(rendererName);
            try 
            {
                classRef = App.utils.classFactory.getClass(rendererName);
                if (this.list.itemRenderer != classRef) 
                {
                    this.list.itemRendererName = rendererName;
                }
            }
            catch (error:ReferenceError)
            {
                throw new net.wg.infrastructure.exceptions.ArgumentException(net.wg.data.constants.Errors.BAD_LINKAGE + rendererName, error.errorID);
            }
            return;
        }

        internal function setupDataProvider(arg1:String):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc2:*=scaleform.clik.data.DataProvider(this.list.dataProvider);
            loc2.splice(0);
            var loc4:*=0;
            var loc5:*=this._data;
            for each (loc3 in loc5) 
            {
                loc1 = new net.wg.data.VO.StoreTableData(loc3);
                loc1.requestType = arg1;
                loc1.tableVO = this._tableVO;
                loc2.push(loc1);
            }
            if (App.instance) 
            {
                this.headerTitle.text = App.utils.locale.makeString(MENU.SHOP_TABLE_FIND) + " " + loc2.length.toString();
            }
            else 
            {
                this.headerTitle.text = MENU.SHOP_TABLE_FIND + " " + loc2.length.toString();
            }
            return;
        }

        internal function detectRendererHeight(arg1:String):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.classFactory.getComponent(arg1, scaleform.clik.interfaces.IListItemRenderer);
                this.list.rowHeight = loc1.height;
            }
            return;
        }

        internal static function assertNotNull(arg1:Object, arg2:String):void
        {
            if (App.instance) 
            {
                App.utils.asserter.assert(!(arg1 == null), arg2 + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
            }
            return;
        }

        internal static const DEFAULT_COUNT_POSITION:Number=0;

        internal static const RIGHT_ORIENTED_COUNT_POSITION:Number=111;

        internal static const INVALID_TABLE:String="invalidTable";

        public var header:net.wg.gui.lobby.store.TableHeader=null;

        public var list:net.wg.gui.components.controls.ScrollingListEx=null;

        public var headerTitle:flash.text.TextField=null;

        internal var _tableVO:net.wg.data.VO.StoreTableVO=null;

        internal var _data:Array=null;

        internal var _rightOrientedCount:Boolean=false;

        internal var vehicleRendererLinkage:String=null;

        internal var moduleRendererLinkage:String=null;
    }
}
