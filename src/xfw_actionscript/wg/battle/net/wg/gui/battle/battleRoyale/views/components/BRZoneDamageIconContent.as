package net.wg.gui.battle.battleRoyale.views.components
{
    import flash.display.MovieClip;
    import net.wg.gui.battle.components.interfaces.IStatusNotificationCallback;
    import net.wg.gui.battle.components.StatusNotificationsPanel;

    public class BRZoneDamageIconContent extends MovieClip implements IStatusNotificationCallback
    {

        public var animation:MovieClip = null;

        private var _callbackTypes:Vector.<String> = null;

        public function BRZoneDamageIconContent()
        {
            super();
            this.animation.stop();
            this._callbackTypes = new <String>[StatusNotificationsPanel.ZONE_DAMAGE_EVENT_TYPE];
        }

        public function getCallbackTypes() : Vector.<String>
        {
            return this._callbackTypes;
        }

        public function invoke(param1:String) : void
        {
            if(param1 == StatusNotificationsPanel.ZONE_DAMAGE_EVENT_TYPE)
            {
                this.animation.gotoAndPlay(1);
            }
        }

        public final function dispose() : void
        {
            this.onDispose();
        }

        protected function onDispose() : void
        {
            if(this._callbackTypes)
            {
                this._callbackTypes.length = 0;
                this._callbackTypes = null;
            }
        }
    }
}
