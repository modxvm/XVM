package net.wg.gui.lobby.store 
{
    import flash.text.*;
    import net.wg.data.constants.*;
    import net.wg.infrastructure.exceptions.*;
    import net.wg.infrastructure.interfaces.entity.*;
    import scaleform.clik.controls.*;
    import scaleform.clik.interfaces.*;
    
    public class ComplexListItemRenderer extends scaleform.clik.controls.ListItemRenderer implements net.wg.infrastructure.interfaces.entity.ISoundable, scaleform.clik.interfaces.IUIComponent
    {
        public function ComplexListItemRenderer()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            buttonMode = true;
            super.configUI();
            App.soundMgr.addSoundsHdlrs(this);
            return;
        }

        public override function set enabled(arg1:Boolean):void
        {
            super.enabled = arg1;
            mouseEnabled = true;
            buttonMode = arg1;
            return;
        }

        public final function get soundType():String
        {
            return this._soundType;
        }

        public final function set soundType(arg1:String):void
        {
            assertNotNull(arg1, "soundType" + net.wg.data.constants.Errors.CANT_NULL);
            this._soundType = arg1;
            return;
        }

        public final function get soundId():String
        {
            return this._soundId;
        }

        public final function set soundId(arg1:String):void
        {
            assertNotNull(arg1, "soundId" + net.wg.data.constants.Errors.CANT_NULL);
            this._soundId = arg1;
            return;
        }

        public final function getSoundType():String
        {
            return this.soundType;
        }

        public final function getSoundId():String
        {
            return this.soundId;
        }

        public final function getStateOverSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OVER;
        }

        public final function getStateOutSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_OUT;
        }

        public final function getStatePressSnd():String
        {
            return net.wg.data.constants.SoundManagerStates.SND_PRESS;
        }

        internal static function assertNotNull(arg1:Object, arg2:String):void
        {
            if (App.instance) 
            {
                App.utils.asserter.assertNotNull(arg1, arg2 + net.wg.data.constants.Errors.CANT_NULL, net.wg.infrastructure.exceptions.NullPointerException);
            }
            return;
        }

        public var descField:flash.text.TextField=null;

        internal var _soundType:String="rendererNormal";

        internal var _soundId:String="";
    }
}
