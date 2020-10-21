package net.wg.gui.lobby.eventHangar.components
{
    import net.wg.gui.components.advanced.ButtonBarEx;
    import net.wg.gui.components.common.FrameStateCmpnt;
    import scaleform.clik.events.IndexEvent;
    import scaleform.clik.core.UIComponent;
    import net.wg.gui.components.controls.SoundButtonEx;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.controls.Button;

    public class EventHeaderButtonBar extends ButtonBarEx
    {

        private static const ALPHA_1:Number = 1;

        private static const ALPHA_05:Number = 0.5;

        private static const DIFFICULTY_INDEX:int = 5;

        private static const DIFFICULTY_WIDTH:int = 11;

        private static const NOTES_INDEX:int = 3;

        private static const NOTES_SPACE:int = 10;

        private static const DIFFICULTY_INVALID:String = "difficultyInvalidate";

        private static const DIFFICULTY_LABEL:String = "difficulty";

        private static const DIFFICULTY_LIGHT_LABEL:String = "difficultyLight";

        public var difficulty:FrameStateCmpnt = null;

        private var _difficulty:int = 1;

        private var _notesSpace:Boolean = false;

        private var _isDifficultyUpdated:Boolean = false;

        public function EventHeaderButtonBar()
        {
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.difficulty.visible = false;
            addEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(IndexEvent.INDEX_CHANGE,this.onButtonBarIndexChangeHandler);
            this.difficulty.dispose();
            this.difficulty = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:UIComponent = null;
            var _loc2_:uint = 0;
            var _loc3_:uint = 0;
            var _loc4_:UIComponent = null;
            var _loc5_:* = 0;
            var _loc6_:SoundButtonEx = null;
            var _loc7_:String = null;
            super.draw();
            if(isInvalid(InvalidationType.DATA))
            {
                _loc2_ = _renderers.length;
                if(this._notesSpace)
                {
                    _loc3_ = NOTES_INDEX + 1;
                    while(_loc3_ < _loc2_)
                    {
                        _loc4_ = _renderers[_loc3_];
                        _loc4_.x = _loc4_.x + NOTES_SPACE;
                        _loc3_++;
                    }
                }
                _loc5_ = _originalWidth - container.width >> 1;
                if(container.x != _loc5_)
                {
                    container.x = _loc5_;
                }
                _loc6_ = SoundButtonEx(getButtonAt(DIFFICULTY_INDEX));
                if(_loc6_)
                {
                    this.difficulty.x = _loc6_.x + _loc6_.width + container.x | 0;
                    this.difficulty.alpha = _loc6_.enabled?ALPHA_1:ALPHA_05;
                    if(!this._isDifficultyUpdated)
                    {
                        _loc6_.preventAutosizing = true;
                        _loc6_.hitMc.width = _loc6_.hitMc.width + DIFFICULTY_WIDTH;
                        this._isDifficultyUpdated = true;
                    }
                }
            }
            if(isInvalid(DIFFICULTY_INVALID))
            {
                _loc7_ = selectedIndex == DIFFICULTY_INDEX?DIFFICULTY_LABEL:DIFFICULTY_LIGHT_LABEL;
                this.difficulty.frameLabel = _loc7_ + this._difficulty.toString();
                _loc1_ = getButtonAt(DIFFICULTY_INDEX);
                if(_loc1_)
                {
                    this.difficulty.visible = true;
                    this.difficulty.x = _loc1_.x + _loc1_.width + container.x | 0;
                    this.difficulty.alpha = _loc1_.enabled?ALPHA_1:ALPHA_05;
                }
            }
        }

        public function setNotesSpace(param1:Boolean) : void
        {
            if(this._notesSpace != param1)
            {
                this._notesSpace = param1;
                invalidate(InvalidationType.DATA);
            }
        }

        public function setDifficulty(param1:int) : void
        {
            if(this._difficulty != param1)
            {
                this._difficulty = param1;
                invalidate(DIFFICULTY_INVALID);
            }
        }

        override protected function setupRenderer(param1:Button, param2:uint) : void
        {
            param1.buttonMode = true;
            super.setupRenderer(param1,param2);
        }

        private function onButtonBarIndexChangeHandler(param1:IndexEvent) : void
        {
            invalidate(DIFFICULTY_INVALID);
        }
    }
}
