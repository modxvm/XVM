package net.wg.gui.lobby.eventHangar
{
    import net.wg.infrastructure.base.meta.impl.EventHeaderMeta;
    import net.wg.infrastructure.base.meta.IEventHeaderMeta;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import net.wg.gui.lobby.eventHangar.components.EventHeaderButtonBar;
    import net.wg.utils.ICounterManager;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.Event;
    import scaleform.clik.data.DataProvider;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.controls.Button;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.infrastructure.managers.counter.CounterProps;
    import net.wg.gui.lobby.header.vo.HangarMenuTabItemVO;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.interfaces.ISoundButtonEx;

    public class LobbyHangarHeader extends EventHeaderMeta implements IEventHeaderMeta
    {

        private static const FRAME_SMALL:String = "small";

        private static const FRAME_BIG:String = "big";

        private static const SMALL_RESOLUTION_WIDTH:int = 1500;

        private static const SMALL_RESOLUTION_HEIGHT:int = 1000;

        private static const TABBAR_SMALL_Y:int = 60;

        private static const TABBAR_BIG_Y:int = 108;

        private static const EVENT_NOTES:String = "eventNotes";

        public var textHeader:AnimatedTextContainer = null;

        public var tabBar:EventHeaderButtonBar = null;

        private var _stageWidth:int = -1;

        private var _stageHeight:int = -1;

        private var _counterManager:ICounterManager = null;

        private var _counterBtnAlias:String = "";

        private var _counterValue:String = "";

        public function LobbyHangarHeader()
        {
            super();
            this._counterManager = App.utils.counterManager;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.tabBar.addEventListener(ButtonEvent.CLICK,this.onTabBarClickHandler);
            this.tabBar.addEventListener(Event.COMPLETE,this.onTabBarCompleteHandler);
            this.tabBar.centerTabs = true;
        }

        override protected function onDispose() : void
        {
            var _loc1_:int = this.tabBar.dataProvider.length;
            var _loc2_:* = 0;
            while(_loc2_ < _loc1_)
            {
                this._counterManager.removeCounter(this.tabBar.getButtonAt(_loc2_));
                _loc2_++;
            }
            this._counterManager = null;
            this.textHeader.dispose();
            this.textHeader = null;
            this.tabBar.removeEventListener(ButtonEvent.CLICK,this.onTabBarClickHandler);
            this.tabBar.removeEventListener(Event.COMPLETE,this.onTabBarCompleteHandler);
            this.tabBar.dispose();
            this.tabBar = null;
            super.onDispose();
        }

        override protected function setHangarMenuData(param1:DataProvider) : void
        {
            this.tabBar.dataProvider = param1;
        }

        override protected function draw() : void
        {
            var _loc1_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.LAYOUT) && this.tabBar.container != null)
            {
                _loc1_ = this._stageWidth < SMALL_RESOLUTION_WIDTH || this._stageHeight < SMALL_RESOLUTION_HEIGHT;
                if(_loc1_)
                {
                    gotoAndStop(FRAME_SMALL);
                    this.textHeader.gotoAndStop(FRAME_SMALL);
                    this.tabBar.y = TABBAR_SMALL_Y;
                }
                else
                {
                    gotoAndStop(FRAME_BIG);
                    this.textHeader.gotoAndStop(FRAME_BIG);
                    this.tabBar.y = TABBAR_BIG_Y;
                }
                this.textHeader.text = EVENT.HANGAR_HEADER_LABEL;
            }
        }

        public function as_removeButtonCounter(param1:String) : void
        {
            var _loc2_:Button = this.getButtonByAlias(param1);
            if(_loc2_)
            {
                this.tabBar.setNotesSpace(false);
                this._counterManager.removeCounter(_loc2_);
            }
        }

        public function as_setButtonCounter(param1:String, param2:String) : void
        {
            var _loc3_:Button = this.getButtonByAlias(param1);
            if(_loc3_)
            {
                this.tabBar.setNotesSpace(true);
                this._counterManager.setCounter(_loc3_,param2);
                this._counterBtnAlias = param1;
                this._counterValue = param2;
            }
        }

        public function as_setCoins(param1:int) : void
        {
            var _loc2_:Button = null;
            if(this._counterBtnAlias == EVENT_NOTES && !StringUtils.isEmpty(this._counterValue))
            {
                _loc2_ = this.getButtonByAlias(this._counterBtnAlias);
                if(_loc2_)
                {
                    this._counterManager.setCounter(_loc2_,this._counterValue,null,new CounterProps(CounterProps.DEFAULT_OFFSET_X + 1));
                }
            }
        }

        public function as_setDifficulty(param1:int) : void
        {
            this.tabBar.setDifficulty(param1);
        }

        public function as_setScreen(param1:String) : void
        {
            var _loc3_:* = 0;
            var _loc4_:HangarMenuTabItemVO = null;
            var _loc5_:uint = 0;
            var _loc2_:IDataProvider = this.tabBar.dataProvider;
            if(_loc2_ != null)
            {
                _loc3_ = _loc2_.length;
                _loc5_ = 0;
                while(_loc5_ < _loc3_)
                {
                    _loc4_ = HangarMenuTabItemVO(_loc2_[_loc5_]);
                    if(_loc4_.value == param1)
                    {
                        this.tabBar.selectedIndex = _loc5_;
                        break;
                    }
                    _loc5_++;
                }
            }
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        public function updateStage(param1:Number, param2:Number) : void
        {
            this._stageWidth = param1;
            this._stageHeight = param2;
            invalidateLayout();
        }

        private function getButtonByAlias(param1:String) : Button
        {
            var _loc4_:* = 0;
            var _loc5_:HangarMenuTabItemVO = null;
            var _loc6_:uint = 0;
            var _loc2_:IDataProvider = this.tabBar.dataProvider;
            var _loc3_:Button = null;
            if(_loc2_ != null)
            {
                this.tabBar.validateNow();
                _loc4_ = _loc2_.length;
                _loc6_ = 0;
                while(_loc6_ < _loc4_)
                {
                    _loc5_ = HangarMenuTabItemVO(_loc2_[_loc6_]);
                    if(_loc5_.value == param1)
                    {
                        _loc3_ = this.tabBar.getButtonAt(_loc6_);
                        break;
                    }
                    _loc6_++;
                }
            }
            return _loc3_;
        }

        private function onTabBarCompleteHandler(param1:Event) : void
        {
            invalidateLayout();
        }

        private function onTabBarClickHandler(param1:ButtonEvent) : void
        {
            var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
            var _loc3_:HangarMenuTabItemVO = HangarMenuTabItemVO(_loc2_.data);
            if(_loc3_ != null)
            {
                menuItemClickS(_loc3_.value);
            }
        }
    }
}
