package net.wg.gui.lobby.vehiclePreview20.infoPanel.modules
{
    import net.wg.gui.lobby.modulesPanel.ModulesPanel;
    import net.wg.utils.IStageSizeDependComponent;
    import flash.text.TextField;
    import net.wg.gui.lobby.components.data.DeviceSlotVO;
    import net.wg.gui.lobby.modulesPanel.DeviceIndexHelper;
    import net.wg.utils.StageSizeBoundaries;
    import flash.events.Event;

    public class VPModulesPanel extends ModulesPanel implements IStageSizeDependComponent
    {

        private static const TITLE_VERTICAL_OFFSET:int = 13;

        private static const SMALL_SLOTS_OFFSET:int = 55;

        private static const BIG_SLOTS_OFFSET:int = 65;

        public var gunTitleTF:TextField;

        public var turretTitleTF:TextField;

        public var engineTitleTF:TextField;

        public var chassisTitleTF:TextField;

        public var radioTitleTF:TextField;

        private var _titles:Vector.<TextField>;

        public function VPModulesPanel()
        {
            super();
        }

        override protected function initialize() : void
        {
            super.initialize();
            this._titles = new <TextField>[this.gunTitleTF,this.turretTitleTF,this.chassisTitleTF,this.engineTitleTF,this.radioTitleTF];
            App.stageSizeMgr.register(this);
        }

        override protected function configUI() : void
        {
            super.configUI();
            mouseEnabled = false;
            this.gunTitleTF.mouseWheelEnabled = this.gunTitleTF.mouseEnabled = false;
            this.turretTitleTF.mouseWheelEnabled = this.turretTitleTF.mouseEnabled = false;
            this.engineTitleTF.mouseWheelEnabled = this.engineTitleTF.mouseEnabled = false;
            this.chassisTitleTF.mouseWheelEnabled = this.chassisTitleTF.mouseEnabled = false;
            this.radioTitleTF.mouseWheelEnabled = this.radioTitleTF.mouseEnabled = false;
        }

        override protected function onDispose() : void
        {
            this._titles.length = 0;
            this._titles = null;
            this.gunTitleTF = null;
            this.turretTitleTF = null;
            this.engineTitleTF = null;
            this.chassisTitleTF = null;
            this.radioTitleTF = null;
            super.onDispose();
        }

        override protected function trySetupDevice(param1:DeviceSlotVO) : Boolean
        {
            var _loc2_:int = DeviceIndexHelper.getDeviceIndex(param1.slotType);
            if(_loc2_ != -1)
            {
                _slots[_loc2_].update(param1);
                this._titles[_loc2_].text = param1.name;
                return true;
            }
            return false;
        }

        public function setStateSizeBoundaries(param1:int, param2:int) : void
        {
            var _loc3_:int = param2 == StageSizeBoundaries.HEIGHT_768?SMALL_SLOTS_OFFSET:BIG_SLOTS_OFFSET;
            var _loc4_:int = _slots.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
                _slots[_loc5_].y = _loc5_ * _loc3_;
                this._titles[_loc5_].y = TITLE_VERTICAL_OFFSET + _loc5_ * _loc3_;
                _loc5_++;
            }
            dispatchEvent(new Event(Event.RESIZE));
        }
    }
}
