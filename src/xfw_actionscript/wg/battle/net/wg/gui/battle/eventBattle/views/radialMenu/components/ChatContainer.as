package net.wg.gui.battle.eventBattle.views.radialMenu.components
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import net.wg.gui.battle.eventBattle.views.radialMenu.EventRadialMenu;

    public class ChatContainer extends Sprite implements IDisposable
    {

        private static const BG_OFFSET:uint = 30;

        public var allyTF:TextField = null;

        public var normalTF:TextField = null;

        public var bg:Sprite = null;

        public function ChatContainer()
        {
            super();
        }

        public final function dispose() : void
        {
            this.allyTF = null;
            this.normalTF = null;
            this.bg = null;
        }

        public function setTitleText(param1:String, param2:String) : void
        {
            var _loc3_:* = false;
            var _loc4_:* = false;
            _loc3_ = param2 == EventRadialMenu.DEFAULT_STATE;
            _loc4_ = param2 == EventRadialMenu.ALLY_STATE;
            this.normalTF.visible = _loc3_;
            this.allyTF.visible = _loc4_;
            if(_loc3_)
            {
                this.setText(param1,this.normalTF);
            }
            else if(_loc4_)
            {
                this.setText(param1,this.allyTF);
            }
        }

        private function setText(param1:String, param2:TextField) : void
        {
            param2.text = param1;
            this.bg.width = Math.ceil(param2.textWidth) + BG_OFFSET;
            this.bg.x = -this.bg.width >> 1;
        }
    }
}
