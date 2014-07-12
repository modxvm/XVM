package net.wg.gui.lobby.store
{
    import scaleform.clik.controls.ListItemRenderer;
    import net.wg.infrastructure.interfaces.entity.ISoundable;
    import scaleform.clik.interfaces.IUIComponent;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.NullPointerException;
    import flash.text.TextField;
    import net.wg.data.constants.SoundManagerStates;
    
    public class ComplexListItemRenderer extends ListItemRenderer implements ISoundable, IUIComponent
    {
        
        public function ComplexListItemRenderer() {
            super();
        }
        
        private static function assertNotNull(param1:Object, param2:String) : void {
            if(App.instance)
            {
                App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL,NullPointerException);
            }
        }
        
        public var descField:TextField = null;
        
        private var _soundType:String = "rendererNormal";
        
        private var _soundId:String = "";
        
        override protected function configUI() : void {
            buttonMode = true;
            super.configUI();
            App.soundMgr.addSoundsHdlrs(this);
        }
        
        override public function set enabled(param1:Boolean) : void {
            super.enabled = param1;
            mouseEnabled = true;
            buttonMode = param1;
        }
        
        public final function get soundType() : String {
            return this._soundType;
        }
        
        public final function set soundType(param1:String) : void {
            assertNotNull(param1,"soundType" + Errors.CANT_NULL);
            this._soundType = param1;
        }
        
        public final function get soundId() : String {
            return this._soundId;
        }
        
        public final function set soundId(param1:String) : void {
            assertNotNull(param1,"soundId" + Errors.CANT_NULL);
            this._soundId = param1;
        }
        
        public final function getSoundType() : String {
            return this.soundType;
        }
        
        public final function getSoundId() : String {
            return this.soundId;
        }
        
        public final function getStateOverSnd() : String {
            return SoundManagerStates.SND_OVER;
        }
        
        public final function getStateOutSnd() : String {
            return SoundManagerStates.SND_OUT;
        }
        
        public final function getStatePressSnd() : String {
            return SoundManagerStates.SND_PRESS;
        }
        
        override protected function onDispose() : void {
            if(App.soundMgr)
            {
                App.soundMgr.addSoundsHdlrs(this);
            }
            super.onDispose();
        }
    }
}
