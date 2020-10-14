package net.wg.gui.lobby.vehiclePreview.infoPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.tabs.OrangeTabMenu;
    import net.wg.gui.components.advanced.ViewStackEx;
    import net.wg.gui.lobby.vehiclePreview.data.VPPageVO;
    import net.wg.utils.ICounterManager;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.events.IndexEvent;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.controls.Button;
    import net.wg.infrastructure.managers.counter.CounterProps;

    public class VPInfoPanel extends UIComponentEx implements IStageSizeDependComponent
    {

        private static const FLAG_ICON_H_OFFSET:int = 4;

        private static const VEH_NAME_SMALL_Y_OFFSET:int = 24;

        private static const VEH_NAME_BIG_Y_OFFSET:int = 19;

        private static const TAB_BAR_SMALL_OFFSET:int = 13;

        private static const TAB_BAR_BIG_OFFSET:int = 17;

        private static const VIEWSTACK_SMALL_OFFSET:int = 60;

        private static const VIEWSTACK_BIG_OFFSET:int = 85;

        private static const VEH_NAME_SCALE_SMALL:Number = 0.64;

        private static const VEH_NAME_SCALE_NORMAL:Number = 1;

        private static const NATION_CHANGE_ICON_SMALL_Y_OFFSET:int = 8;

        private static const NATION_CHANGE_ICON_BIG_Y_OFFSET:int = 18;

        private static const BULLET_VISIBILITY_INVALID:String = "BULLET_VISIBILITY_INVALID";

        public var vehicleTypeIcon:Image = null;

        public var nationFlagIcon:Image = null;

        public var nationTF:TextField;

        public var vehicleTypeTF:TextField;

        public var vehicleNameTF:TextField;

        public var nationChangeIcon:Sprite;

        public var tabButtonBar:OrangeTabMenu;

        public var viewStack:ViewStackEx;

        private var _bulletTabIdx:int = -1;

        private var _isBulletVisible:Boolean = false;

        private var _tabBarOffset:int;

        private var _viewStackOffset:int;

        private var _data:VPPageVO;

        private var ncIconOffset:Number;

        private var _counterManager:ICounterManager;

        public function VPInfoPanel()
        {
            this._counterManager = App.utils.counterManager;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
            this.tabButtonBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.vehicleTypeTF.mouseEnabled = this.vehicleTypeTF.mouseWheelEnabled = false;
            this.vehicleTypeTF.autoSize = TextFieldAutoSize.LEFT;
            this.vehicleTypeTF.wordWrap = false;
            this.ncIconOffset = this.nationChangeIcon.x - this.vehicleNameTF.x - this.vehicleNameTF.width;
            this.vehicleNameTF.mouseEnabled = this.vehicleNameTF.mouseWheelEnabled = false;
            this.vehicleNameTF.autoSize = TextFieldAutoSize.LEFT;
            this.vehicleNameTF.wordWrap = false;
            this.nationTF.mouseEnabled = this.nationTF.mouseWheelEnabled = false;
            this.nationTF.autoSize = TextFieldAutoSize.LEFT;
            this.nationTF.wordWrap = false;
            this.vehicleTypeIcon.mouseEnabled = this.vehicleTypeIcon.mouseChildren = false;
            this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.nationFlagIcon.mouseEnabled = this.nationFlagIcon.mouseChildren = false;
            this.nationFlagIcon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            App.stageSizeMgr.register(this);
        }

        override protected function onDispose() : void
        {
            this._counterManager.removeCounter(this.tabButtonBar.getButtonAt(this._bulletTabIdx));
            this._counterManager = null;
            this.viewStack.dispose();
            this.viewStack = null;
            this._data = null;
            this.tabButtonBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabIndexChangeHandler);
            this.tabButtonBar.dispose();
            this.tabButtonBar = null;
            this.vehicleTypeTF = null;
            this.vehicleNameTF = null;
            this.nationTF = null;
            this.nationChangeIcon = null;
            this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.vehicleTypeIcon.dispose();
            this.vehicleTypeIcon = null;
            this.nationFlagIcon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this.nationFlagIcon.dispose();
            this.nationFlagIcon = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.vehicleTypeTF.text = this._data.vehicleTitle;
                this.vehicleNameTF.htmlText = this._data.vehicleName;
                this.nationChangeIcon.x = this.vehicleNameTF.x + this.vehicleNameTF.width + this.ncIconOffset;
                this.nationChangeIcon.visible = this._data.isMultinational;
                this.nationTF.text = this._data.nationName;
                this.vehicleTypeIcon.source = this._data.vehicleTypeIcon;
                this.nationFlagIcon.source = this._data.nationFlagIcon;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.tabButtonBar.y = this.vehicleNameTF.y + this.vehicleNameTF.height + this._tabBarOffset >> 0;
                this.tabButtonBar.width = App.appWidth >> 1;
                this.tabButtonBar.validateNow();
                this.vehicleTypeIcon.y = this.vehicleTypeTF.y + (this.vehicleTypeTF.height - this.vehicleTypeIcon.height >> 1);
                this.vehicleTypeTF.x = this.vehicleTypeIcon.x + this.vehicleTypeIcon.width;
                this.nationFlagIcon.x = this.vehicleTypeTF.x + this.vehicleTypeTF.width + FLAG_ICON_H_OFFSET >> 0;
                this.nationTF.x = this.nationFlagIcon.x + this.nationFlagIcon.width + FLAG_ICON_H_OFFSET;
                this.viewStack.y = this.tabButtonBar.y + this._viewStackOffset >> 0;
                this.viewStack.setSize(this.width,height - this.viewStack.y);
            }
            if(isInvalid(BULLET_VISIBILITY_INVALID))
            {
                this.updateBulletVisibility();
            }
        }

        public function setData(param1:VPPageVO) : void
        {
            this._data = param1;
            invalidateData();
            invalidateSize();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(param2 <= StageSizeBoundaries.HEIGHT_900)
            {
                this.vehicleNameTF.scaleX = this.vehicleNameTF.scaleY = VEH_NAME_SCALE_SMALL;
                this.vehicleNameTF.y = VEH_NAME_SMALL_Y_OFFSET;
                this._tabBarOffset = TAB_BAR_SMALL_OFFSET;
                this._viewStackOffset = VIEWSTACK_SMALL_OFFSET;
                this.nationChangeIcon.y = NATION_CHANGE_ICON_SMALL_Y_OFFSET;
            }
            else
            {
                this.vehicleNameTF.scaleX = this.vehicleNameTF.scaleY = VEH_NAME_SCALE_NORMAL;
                this.vehicleNameTF.y = VEH_NAME_BIG_Y_OFFSET;
                this._tabBarOffset = TAB_BAR_BIG_OFFSET;
                this._viewStackOffset = VIEWSTACK_BIG_OFFSET;
                this.nationChangeIcon.y = NATION_CHANGE_ICON_BIG_Y_OFFSET;
            }
            this.nationChangeIcon.x = this.vehicleNameTF.x + this.vehicleNameTF.width + this.ncIconOffset;
            invalidateSize();
        }

        public function setTabsData(param1:DataProvider) : void
        {
            this.tabButtonBar.dataProvider = param1;
            invalidateSize();
        }

        public function setBulletVisibility(param1:int, param2:Boolean) : void
        {
            this._bulletTabIdx = param1;
            this._isBulletVisible = param2;
            invalidate(BULLET_VISIBILITY_INVALID);
        }

        override public function get width() : Number
        {
            return this.tabButtonBar.getWidth();
        }

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            this.tabButtonBar.visible = param1;
        }

        private function updateBulletVisibility() : void
        {
            var _loc1_:Button = this.tabButtonBar.getButtonAt(this._bulletTabIdx);
            if(_loc1_ != null && this._isBulletVisible)
            {
                if(this.tabButtonBar.selectedIndex != this._bulletTabIdx)
                {
                    this._counterManager.setCounter(_loc1_," ",null,new CounterProps(-10,-3));
                }
                else
                {
                    this._counterManager.removeCounter(_loc1_);
                    this._isBulletVisible = false;
                }
            }
        }

        private function onIconChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }

        private function onTabIndexChangeHandler(param1:IndexEvent) : void
        {
            invalidate(BULLET_VISIBILITY_INVALID);
        }
    }
}
