package net.wg.gui.lobby.vehiclePreview20.infoPanel
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.utils.IStageSizeDependComponent;
    import net.wg.gui.components.controls.Image;
    import flash.text.TextField;
    import flash.display.Sprite;
    import net.wg.gui.components.controls.tabs.OrangeTabMenu;
    import net.wg.gui.components.advanced.ViewStackEx;
    import net.wg.gui.lobby.vehiclePreview20.data.VPPageVO;
    import flash.text.TextFieldAutoSize;
    import flash.events.Event;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.utils.StageSizeBoundaries;
    import scaleform.clik.data.DataProvider;

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

        public var vehicleTypeIcon:Image = null;

        public var nationFlagIcon:Image = null;

        public var nationTF:TextField;

        public var vehicleTypeTF:TextField;

        public var vehicleNameTF:TextField;

        public var nationChangeIcon:Sprite;

        public var tabButtonBar:OrangeTabMenu;

        public var viewStack:ViewStackEx;

        private var _tabBarOffset:int;

        private var _viewStackOffset:int;

        private var _data:VPPageVO;

        private var ncIconOffset:Number;

        public function VPInfoPanel()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.tabButtonBar.autoSize = TextFieldAutoSize.LEFT;
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
            this.viewStack.dispose();
            this.viewStack = null;
            this._data = null;
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
        }

        public function setData(param1:VPPageVO) : void
        {
            this._data = param1;
            invalidateData();
            invalidateSize();
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            if(param2 == StageSizeBoundaries.HEIGHT_768)
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

        override public function get width() : Number
        {
            return this.tabButtonBar.getWidth();
        }

        private function onIconChangeHandler(param1:Event) : void
        {
            invalidateSize();
        }
    }
}
