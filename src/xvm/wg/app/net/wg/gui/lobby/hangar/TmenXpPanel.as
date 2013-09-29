package net.wg.gui.lobby.hangar 
{
    import flash.display.*;
    import flash.events.*;
    import net.wg.gui.components.controls.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import scaleform.clik.events.*;
    
    public class TmenXpPanel extends net.wg.infrastructure.base.meta.impl.TmenXpPanelMeta implements net.wg.infrastructure.base.meta.ITmenXpPanelMeta
    {
        public function TmenXpPanel()
        {
            super();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            var loc1:*;
            this.xpToTmenCheckbox.visible = loc1 = false;
            this.checkboxTankersBg.visible = loc1;
            this.xpToTmenCheckbox.label = DIALOGS.XPTOTMENCHECKBOX_TITLE;
            this.xpToTmenCheckbox.addEventListener(flash.events.MouseEvent.ROLL_OVER, showXpTankmenTooltip);
            this.xpToTmenCheckbox.addEventListener(flash.events.MouseEvent.ROLL_OUT, hideXpTankmenTooltip);
            this.xpToTmenCheckbox.addEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onXpToTmenCheckboxClick);
            return;
        }

        public function as_setTankmenXpPanel(arg1:Boolean, arg2:Boolean):void
        {
            this._panelVisible = arg1;
            this._panelSelected = arg2;
            invalidate(INVALIDATE_XP_PANEL);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_XP_PANEL)) 
            {
                var loc1:*;
                this.xpToTmenCheckbox.visible = loc1 = this._panelVisible;
                this.checkboxTankersBg.visible = loc1;
                this.xpToTmenCheckbox.selected = this._panelSelected;
            }
            return;
        }

        protected override function onDispose():void
        {
            App.toolTipMgr.hide();
            super.onDispose();
            this.xpToTmenCheckbox.removeEventListener(flash.events.MouseEvent.ROLL_OVER, showXpTankmenTooltip);
            this.xpToTmenCheckbox.removeEventListener(flash.events.MouseEvent.ROLL_OUT, hideXpTankmenTooltip);
            this.xpToTmenCheckbox.removeEventListener(scaleform.clik.events.ButtonEvent.CLICK, this.onXpToTmenCheckboxClick);
            return;
        }

        internal function onXpToTmenCheckboxClick(arg1:scaleform.clik.events.ButtonEvent):void
        {
            App.toolTipMgr.hide();
            DebugUtils.LOG_DEBUG(this.xpToTmenCheckbox.selected);
            accelerateTmenXpS(this.xpToTmenCheckbox.selected);
            return;
        }

        internal static function showXpTankmenTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showComplex(TOOLTIPS.HANGAR_XPTOTMENCHECKBOX);
            return;
        }

        internal static function hideXpTankmenTooltip(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal static const INVALIDATE_XP_PANEL:String="invXpPanel";

        public var checkboxTankersBg:flash.display.MovieClip;

        public var xpToTmenCheckbox:net.wg.gui.components.controls.CheckBox;

        internal var _panelVisible:Boolean=false;

        internal var _panelSelected:Boolean=false;
    }
}
