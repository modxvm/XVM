package net.wg.gui.prebattle.squads.event
{
    import net.wg.gui.prebattle.squads.simple.SimpleSquadTeamSection;
    import flash.display.Sprite;
    import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
    import net.wg.utils.IClassFactory;
    import net.wg.gui.rally.controls.interfaces.ISlotRendererHelper;
    import flash.display.DisplayObject;
    import net.wg.gui.prebattle.squads.simple.SimpleSquadSlotHelper;
    import flash.events.Event;

    public class EventSquadTeamSection extends SimpleSquadTeamSection
    {

        private static const EVENT_SQUAD_RENDERER:String = "EventSquadRendererUI";

        private static const SQUAD_RENDERER_START_Y:int = 114;

        private static const SQUAD_RENDERER_SPACING:int = 56;

        private static const BOTTOM_SPACE:int = 132;

        private static const BTN_BOTTOM_PADDING:int = 43;

        private static const STATUS_PADDING:int = 24;

        public var background:Sprite = null;

        public function EventSquadTeamSection()
        {
            super();
        }

        override protected function updateDynamicSlots() : void
        {
            var _loc2_:Vector.<IRallySimpleSlotRenderer> = null;
            var _loc3_:IRallySimpleSlotRenderer = null;
            var _loc4_:IClassFactory = null;
            var _loc5_:String = null;
            var _loc6_:* = 0;
            var _loc7_:* = 0;
            var _loc8_:* = 0;
            var _loc9_:IRallySimpleSlotRenderer = null;
            var _loc10_:ISlotRendererHelper = null;
            var _loc11_:* = 0;
            var _loc1_:int = rallyData?rallyData.slotsArray.length:0;
            if(_slotsUi.length < _loc1_)
            {
                _loc2_ = _slotsUi;
                _loc3_ = null;
                _loc4_ = App.utils.classFactory;
                _loc5_ = this.getSlotRenderer();
                _loc6_ = this.getSlotRendererStartY();
                _loc7_ = this.getSlotRendererSpacing();
                _loc8_ = 0;
                while(_loc8_ < _loc1_)
                {
                    _loc3_ = _loc4_.getComponent(_loc5_,IRallySimpleSlotRenderer);
                    _loc2_.push(_loc3_);
                    _loc3_.y = _loc6_;
                    _loc6_ = _loc6_ + _loc7_;
                    addChild(DisplayObject(_loc3_));
                    _loc8_++;
                }
                _loc10_ = new SimpleSquadSlotHelper();
                _loc11_ = 0;
                for each(_loc9_ in _loc2_)
                {
                    _loc9_.helper = _loc10_;
                    _loc9_.index = _loc11_;
                    _loc11_++;
                }
                this.updateLayout();
                dispatchEvent(new Event(Event.RESIZE));
            }
        }

        override protected function getSlotsUI() : Vector.<IRallySimpleSlotRenderer>
        {
            return new Vector.<IRallySimpleSlotRenderer>();
        }

        override protected function onDispose() : void
        {
            this.background = null;
            super.onDispose();
        }

        protected function getSlotRenderer() : String
        {
            return EVENT_SQUAD_RENDERER;
        }

        protected function getSlotRendererStartY() : int
        {
            return SQUAD_RENDERER_START_Y;
        }

        protected function getSlotRendererSpacing() : int
        {
            return SQUAD_RENDERER_SPACING;
        }

        protected function updateLayout() : void
        {
            var _loc1_:IRallySimpleSlotRenderer = null;
            if(_slotsUi && _slotsUi.length > 0)
            {
                _loc1_ = _slotsUi[_slotsUi.length - 1];
                this.background.height = _loc1_.y + _loc1_.height + BOTTOM_SPACE - this.background.y;
                btnNotReady.y = btnFight.y = this.background.y + this.background.height - BTN_BOTTOM_PADDING;
                lblStatus.y = btnFight.y - STATUS_PADDING;
                height = this.background.y + this.background.height;
            }
        }
    }
}
