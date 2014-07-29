package net.wg.gui.lobby.fortifications.windows.impl
{
    import net.wg.infrastructure.base.meta.impl.FortIntelligenceWindowMeta;
    import net.wg.infrastructure.base.meta.IFortIntelligenceWindowMeta;
    import flash.text.TextField;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.gfx.TextFieldEx;
    
    public class FortIntelligenceWindow extends FortIntelligenceWindowMeta implements IFortIntelligenceWindowMeta
    {
        
        public function FortIntelligenceWindow()
        {
            super();
            isModal = false;
            isCentered = true;
            this.texts = [this.headerTitle,this.headerBody,this.topHeader,this.topBody,this.middleHeader,this.middleBody,this.bottomHeader,this.bottomBody];
            TextFieldEx.setVerticalAlign(this.comingSoon,TextFieldEx.VALIGN_CENTER);
            this.comingSoon.mouseEnabled = false;
            this.updateHeaderPosition();
        }
        
        public var headerTitle:TextField = null;
        
        public var headerBody:TextField = null;
        
        public var topHeader:TextField = null;
        
        public var topBody:TextField = null;
        
        public var middleHeader:TextField = null;
        
        public var middleBody:TextField = null;
        
        public var bottomHeader:TextField = null;
        
        public var bottomBody:TextField = null;
        
        public var comingSoon:TextField = null;
        
        private var texts:Array = null;
        
        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            this.updatePosition();
        }
        
        public function as_setData(param1:Array) : void
        {
            var _loc3_:* = 0;
            var _loc2_:int = this.texts.length;
            _loc3_ = 0;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
                TextField(this.texts[_loc3_]).mouseEnabled = false;
                TextField(this.texts[_loc3_]).htmlText = param1[_loc3_];
                _loc3_++;
            }
            this.comingSoon.htmlText = param1[_loc3_];
        }
        
        override protected function onPopulate() : void
        {
            super.onPopulate();
            window.title = FORTIFICATIONS.FORTINTELLIGENCE_WINDOWTITLE;
        }
        
        override protected function configUI() : void
        {
            super.configUI();
            this.updatePosition();
        }
        
        override protected function onDispose() : void
        {
            this.texts.splice(0,this.texts.length);
            this.texts = null;
            super.onDispose();
        }
        
        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.updateHeaderPosition();
                this.updatePosition();
            }
        }
        
        private function updatePosition() : void
        {
            window.x = Math.floor((App.appWidth - window.width) / 2);
            window.y = Math.floor((App.appHeight - window.height) / 2);
        }
        
        private function updateHeaderPosition() : void
        {
            this.headerBody.x = Math.floor((this.width - this.headerBody.width) / 2);
            this.headerTitle.x = Math.floor((this.width - this.headerTitle.width) / 2);
        }
    }
}
