package net.wg.gui.lobby.hangar 
{
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.infrastructure.interfaces.*;
    import scaleform.clik.constants.*;
    import scaleform.clik.events.*;
    
    public class ResearchPanel extends net.wg.infrastructure.base.meta.impl.ResearchPanelMeta implements net.wg.infrastructure.base.meta.IResearchPanelMeta, net.wg.infrastructure.interfaces.IHelpLayoutComponent
    {
        public function ResearchPanel()
        {
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            if (this.button != null) 
            {
                this.button.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleButtonClick, false, 0, true);
            }
            return;
        }

        protected override function onDispose():void
        {
            super.onDispose();
            if (this.button != null) 
            {
                this.button.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.handleButtonClick);
            }
            return;
        }

        public function as_setEarnedXP(arg1:Number):void
        {
            if (this._earnedXP == arg1) 
            {
                return;
            }
            this._earnedXP = arg1;
            invalidateData();
            return;
        }

        public function as_setElite(arg1:Boolean):void
        {
            if (this._isElite == arg1) 
            {
                return;
            }
            this._isElite = arg1;
            invalidateData();
            return;
        }

        public function showHelpLayout():void
        {
            this.button.showHelpLayout();
            return;
        }

        public function closeHelpLayout():void
        {
            this.button.closeHelpLayout();
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(scaleform.clik.constants.InvalidationType.DATA) && !(this.xpText == null)) 
            {
                this.xpText.text = App.utils == null ? this._earnedXP.toString() : App.utils.locale.integer(this._earnedXP);
                this.xpText.icon = this._isElite ? net.wg.gui.components.controls.IconText.ELITE_XP : net.wg.gui.components.controls.IconText.XP;
            }
            return;
        }

        internal function handleButtonClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            goToResearchS();
            return;
        }

        internal var _earnedXP:Number=0;

        internal var _isElite:Boolean=false;

        public var xpText:net.wg.gui.components.controls.IconText;

        public var button:net.wg.gui.components.controls.IconTextButton;
    }
}
