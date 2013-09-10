package net.wg.gui.lobby.hangar 
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import net.wg.data.*;
    import net.wg.data.constants.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import net.wg.gui.lobby.hangar.ammunitionPanel.*;
    import net.wg.gui.lobby.hangar.crew.*;
    import net.wg.gui.lobby.hangar.tcarousel.*;
    import net.wg.infrastructure.base.meta.*;
    import net.wg.infrastructure.base.meta.impl.*;
    import net.wg.utils.*;
    import scaleform.clik.events.*;
    
    public class Hangar extends net.wg.infrastructure.base.meta.impl.HangarMeta implements net.wg.infrastructure.base.meta.IHangarMeta
    {
        public function Hangar()
        {
            super();
            return;
        }

        protected override function onPopulate():void
        {
            super.onPopulate();
            registerComponent(this.crew, net.wg.data.Aliases.CREW);
            registerComponent(this.tmenXpPanel, net.wg.data.Aliases.TMEN_XP_PANEL);
            registerComponent(this.params, net.wg.data.Aliases.PARAMS);
            registerComponent(this.carousel, net.wg.data.Aliases.TANK_CAROUSEL);
            registerComponent(this.ammunitionPanel, net.wg.data.Aliases.AMMUNITION_PANEL);
            addEventListener(net.wg.gui.lobby.hangar.CrewDropDownEvent.SHOW_DROP_DOWN, this.onShowCrewDropwDownHandler);
            if (this.vehResearchPanel != null) 
            {
                registerComponent(this.vehResearchPanel, net.wg.data.Aliases.RESEARCH_PANEL);
            }
            return;
        }

        protected override function onDispose():void
        {
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN);
            this.igrLabel.removeEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.updateIgrPosition);
            this.igrLabel.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this.onIgrRollOver);
            this.igrLabel.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this.onIgrRollOut);
            App.stage.dispatchEvent(new net.wg.gui.events.LobbyEvent(net.wg.gui.events.LobbyEvent.UNREGISTER_DRAGGING));
            removeEventListener(net.wg.gui.lobby.hangar.CrewDropDownEvent.SHOW_DROP_DOWN, this.onShowCrewDropwDownHandler);
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.F1, flash.events.KeyboardEvent.KEY_DOWN);
            App.gameInputMgr.clearKeyHandler(flash.ui.Keyboard.F1, flash.events.KeyboardEvent.KEY_UP);
            super.onDispose();
            return;
        }

        protected override function configUI():void
        {
            super.configUI();
            App.stage.dispatchEvent(new net.wg.gui.events.LobbyEvent(net.wg.gui.events.LobbyEvent.REGISTER_DRAGGING));
            this.updateStage(parent.width, parent.height);
            this.params.mouseEnabled = false;
            this.params.mouseChildren = false;
            mouseEnabled = false;
            this.bottomBg.mouseEnabled = false;
            this.igrLabel.addEventListener(net.wg.gui.events.UILoaderEvent.COMPLETE, this.updateIgrPosition);
            this.igrLabel.addEventListener(flash.events.MouseEvent.ROLL_OVER, this.onIgrRollOver);
            this.igrLabel.addEventListener(flash.events.MouseEvent.ROLL_OUT, this.onIgrRollOut);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.F1, flash.events.KeyboardEvent.KEY_DOWN, this.showLayoutHandler, true);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.F1, flash.events.KeyboardEvent.KEY_UP, this.closeLayoutHandler, true);
            App.gameInputMgr.setKeyHandler(flash.ui.Keyboard.ESCAPE, flash.events.KeyboardEvent.KEY_DOWN, this.handleEscape, true);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATE_ENABLED_CREW)) 
            {
                this.crew.enabled = this.crewEnabled;
            }
            return;
        }

        internal function handleEscape(arg1:scaleform.clik.events.InputEvent):void
        {
            App.contextMenuMgr.hide();
            if (App.helpLayout.isShowed()) 
            {
                onEscapeS();
            }
            return;
        }

        internal function closeLayoutHandler():void
        {
            closeHelpLayoutS();
            return;
        }

        internal function onShowCrewDropwDownHandler(arg1:net.wg.gui.lobby.hangar.CrewDropDownEvent):void
        {
            var loc1:*=globalToLocal(new flash.geom.Point(arg1.dropDownref.x, arg1.dropDownref.y));
            var loc2:*=App.utils.events;
            loc2.disableDisposingForObj(arg1.dropDownref);
            addChild(arg1.dropDownref);
            loc2.enableDisposingForObj(arg1.dropDownref);
            arg1.dropDownref.x = loc1.x;
            arg1.dropDownref.y = loc1.y;
            return;
        }

        internal function showLayoutHandler(arg1:scaleform.clik.events.InputEvent):void
        {
            showHelpLayoutS();
            return;
        }

        internal function onIgrRollOver(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.showSpecial(net.wg.data.constants.Tooltips.IGR_INFO, null);
            return;
        }

        internal function onIgrRollOut(arg1:flash.events.MouseEvent):void
        {
            App.toolTipMgr.hide();
            return;
        }

        internal function updateIgrPosition(arg1:net.wg.gui.events.UILoaderEvent=null):void
        {
            if (this.igrLabel) 
            {
                this.igrLabel.x = width - this.igrLabel.width >> 1;
            }
            return;
        }

        public override function updateStage(arg1:Number, arg2:Number):void
        {
            var loc1:*=NaN;
            _originalWidth = arg1;
            _originalHeight = arg2;
            setSize(arg1, arg2);
            if (this.carousel) 
            {
                this.carousel.updateSize(arg1, this.carousel.height);
                this.carousel.y = arg2 - this.carousel.height;
            }
            if (this.bottomBg) 
            {
                this.bottomBg.x = 0;
                this.bottomBg.y = _originalHeight - this.bottomBg.height + MESSENGER_BAR_PADDING;
                this.bottomBg.width = _originalWidth;
            }
            this.updateIgrPosition();
            if (this.params) 
            {
                this.params.x = arg1 - this.params.width - PARAMS_RIGHT_MARGIN;
            }
            if (this.ammunitionPanel) 
            {
                this.ammunitionPanel.x = arg1 - this.ammunitionPanel.width >> 1;
                loc1 = this.carousel.height + CAROUSEL_AMMUNITION_PADDING;
                this.ammunitionPanel.y = arg2 - this.ammunitionPanel.height - loc1;
                this.ammunitionPanel.updateStage(arg1, arg2 - loc1);
            }
            if (this.vehResearchPanel != null) 
            {
                this.vehResearchPanel.x = arg1 - RESEARCH_PANEL_RIGHT_MARGIN;
            }
            if (this._isShowHelpLayout) 
            {
                this.as_closeHelpLayout();
            }
            return;
        }

        public function as_readyToFight(arg1:Boolean, arg2:String, arg3:String, arg4:Boolean, arg5:Boolean, arg6:Boolean, arg7:Boolean, arg8:Boolean):void
        {
            this.carousel.enabled = !arg5;
            this.crewEnabled = !arg5;
            invalidate(INVALIDATE_ENABLED_CREW);
            this.ammunitionPanel.setVehicleStatus(arg2, arg3);
            this.ammunitionPanel.disableAmmunitionPanel(!arg1 && arg6 && !arg8);
            this.ammunitionPanel.disableTuningButton(arg7 ? !arg1 && arg6 && arg8 : true);
            this.params.visible = arg4;
            this.crew.visible = arg4;
            this.ammunitionPanel.visible = arg4;
            this.carousel.visible = arg4;
            this.bottomBg.visible = arg4;
            this.vehResearchPanel.visible = arg4;
            return;
        }

        public function as_showHelpLayout():void
        {
            if (!this._isShowHelpLayout) 
            {
                this._isShowHelpLayout = true;
                if (this.crew.visible) 
                {
                    this.crew.showHelpLayout();
                }
                if (this.params.visible) 
                {
                    this.params.showHelpLayout();
                }
                if (this.ammunitionPanel.visible) 
                {
                    this.ammunitionPanel.showHelpLayout();
                }
                if (this.carousel.visible) 
                {
                    this.carousel.showHelpLayout();
                }
                if (this.vehResearchPanel.visible) 
                {
                    this.vehResearchPanel.showHelpLayout();
                }
            }
            return;
        }

        public function as_closeHelpLayout():void
        {
            if (this._isShowHelpLayout) 
            {
                this._isShowHelpLayout = false;
                App.instance.utils.helpLayout.destroyBackground();
                this.crew.closeHelpLayout();
                this.params.closeHelpLayout();
                this.ammunitionPanel.closeHelpLayout();
                this.carousel.closeHelpLayout();
                this.vehResearchPanel.closeHelpLayout();
            }
            return;
        }

        public function as_setIsIGR(arg1:Boolean):void
        {
            if (arg1) 
            {
                this.igrLabel.visible = true;
                this.igrLabel.mouseChildren = false;
                var loc1:*;
                this.igrLabel.buttonMode = loc1 = true;
                this.igrLabel.useHandCursor = loc1;
                this.igrLabel.source = IGR_LOGO;
            }
            else 
            {
                this.igrLabel.visible = false;
            }
            return;
        }

        internal static const CAROUSEL_AMMUNITION_PADDING:int=10;

        internal static const PARAMS_RIGHT_MARGIN:int=5;

        internal static const RESEARCH_PANEL_RIGHT_MARGIN:int=172;

        internal static const MESSENGER_BAR_PADDING:int=38;

        internal static const INVALIDATE_ENABLED_CREW:String="InvalidateEnabledCrew";

        internal static const IGR_LOGO:String="../maps/icons/library/igrLogo.png";

        public var vehResearchPanel:net.wg.gui.lobby.hangar.ResearchPanel;

        public var tmenXpPanel:net.wg.gui.lobby.hangar.TmenXpPanel;

        public var crew:net.wg.gui.lobby.hangar.crew.Crew;

        public var params:net.wg.gui.lobby.hangar.Params;

        public var carousel:net.wg.gui.lobby.hangar.tcarousel.TankCarousel;

        public var ammunitionPanel:net.wg.gui.lobby.hangar.ammunitionPanel.AmmunitionPanel;

        public var bottomBg:flash.display.Sprite;

        public var igrLabel:net.wg.gui.components.controls.UILoaderAlt;

        internal var _isShowHelpLayout:Boolean=false;

        internal var crewEnabled:Boolean=true;
    }
}
