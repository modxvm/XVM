package net.wg.gui.lobby.settings.feedback.damageIndicator
{
    import flash.display.Sprite;
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.text.TextField;
    import scaleform.gfx.TextFieldEx;

    public class DamageIndicatorExtended extends Sprite implements IDisposable
    {

        public var critTF:TextField = null;

        public var blockedTF:TextField = null;

        public var damageTF:TextField = null;

        public var damageModuleTF:TextField = null;

        public var damageCountTF:TextField = null;

        public function DamageIndicatorExtended()
        {
            super();
            TextFieldEx.setVerticalAutoSize(this.damageTF,TextFieldEx.VAUTOSIZE_CENTER);
            TextFieldEx.setVerticalAutoSize(this.critTF,TextFieldEx.VAUTOSIZE_CENTER);
            TextFieldEx.setVerticalAutoSize(this.blockedTF,TextFieldEx.VAUTOSIZE_CENTER);
            this.critTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_CRITLABEL;
            this.blockedTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKEDLABEL;
            this.damageTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_DAMAGELABEL;
            this.damageModuleTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_DAMAGEMODULE;
            this.damageCountTF.text = SETTINGS.FEEDBACK_TAB_DAMAGEINDICATOR_INDICATOR_BLOCKDAMAGECOUNTTF;
        }

        public final function dispose() : void
        {
            this.critTF = null;
            this.blockedTF = null;
            this.damageTF = null;
            this.damageModuleTF = null;
            this.damageCountTF = null;
        }
    }
}
