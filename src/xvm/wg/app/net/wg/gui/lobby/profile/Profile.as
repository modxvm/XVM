package net.wg.gui.lobby.profile
{
    import net.wg.infrastructure.base.meta.impl.ProfileMeta;
    import net.wg.infrastructure.base.meta.IProfileMeta;
    import net.wg.gui.components.windows.ScreenBg;
    import scaleform.clik.events.InputEvent;
    import net.wg.data.Aliases;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.LobbyMetrics;
    
    public class Profile extends ProfileMeta implements IProfileMeta
    {
        
        public function Profile() {
            super();
        }
        
        public var screenBg:ScreenBg = null;
        
        public var tabNavigator:ProfileTabNavigator;
        
        private function handleEscape(param1:InputEvent) : void {
            onCloseProfileS();
        }
        
        override protected function configUI() : void {
            super.configUI();
            registerComponent(this.tabNavigator,Aliases.PROFILE_TAB_NAVIGATOR);
            this.tabNavigator.centerOffset = ProfileConstants.MAIN_CENTER_OFFSET;
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
        }
        
        public function as_update(param1:Object) : void {
        }
        
        override public function updateStage(param1:Number, param2:Number) : void {
            setViewSize(param1,param2);
        }
        
        override protected function draw() : void {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.screenBg.setSize(_width,_height + LobbyMetrics.LOBBY_MESSENGER_HEIGHT);
                this.tabNavigator.setAvailableSize(_width,_height - this.tabNavigator.y);
            }
        }
        
        override protected function onDispose() : void {
            if(this.screenBg)
            {
                this.screenBg.parent.removeChild(this.screenBg);
                this.screenBg.dispose();
                this.screenBg = null;
            }
            this.tabNavigator = null;
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN);
            super.onDispose();
        }
        
        override public function get isModal() : Boolean {
            return true;
        }
    }
}
