package net.wg.gui.battle.views.postmortemPanel
{
    import net.wg.infrastructure.base.meta.impl.PostmortemPanelMeta;
    import net.wg.infrastructure.base.meta.IPostmortemPanelMeta;
    import net.wg.gui.battle.components.BattleAtlasSprite;
    import flash.text.TextField;
    import net.wg.gui.components.dogtag.DogtagComponent;
    import scaleform.clik.motion.Tween;
    import net.wg.data.constants.generated.BATTLEATLAS;
    import scaleform.gfx.TextFieldEx;
    import net.wg.data.constants.Linkages;
    import net.wg.gui.components.dogtag.VO.DogTagVO;
    import net.wg.gui.components.dogtag.ImageRepository;
    import net.wg.data.constants.Values;

    public class PostmortemPanel extends PostmortemPanelMeta implements IPostmortemPanelMeta
    {

        private static const FADE_ANIMATION_TIME:int = 200;

        private static const PANEL_ANIMATION_DELAY:int = 500;

        private static const FADE_OUT_DEAD_REASON_ANIMATION_DELAY:int = 500;

        private static const DOGTAG_VICTIM_MINI_MAP_OFFSET:int = -760;

        private static const DOGTAG_KILLER_OFFSET_Y:int = 50;

        private static const DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME:int = 300;

        private static const VICTIM_DOGTAG_LINGERING_TIME:int = 1700;

        public var bg:BattleAtlasSprite = null;

        public var observerModeTitleTF:TextField = null;

        public var observerModeDescTF:TextField = null;

        public var exitToHangarTitleTF:TextField = null;

        public var exitToHangarDescTF:TextField = null;

        private var _dogTagVictim:DogtagComponent = null;

        private var _dogTagKiller:DogtagComponent = null;

        private var _dogTagKillerInitialized:Boolean = false;

        private var _vehPanelFadeInTween:Tween = null;

        private var _deadReasonFadeInTween:Tween = null;

        private var _deadReasonFadeOutTween:Tween = null;

        private var _deadReasonBGFadeOutTween:Tween = null;

        private var _userNameFadeInTween:Tween = null;

        private var _deadReasonBGFadeInTween:Tween = null;

        private var _victimDogTagTweenIn:Tween = null;

        private var _victimDogTagTweenOut:Tween = null;

        private var _dogTagVictimMiniMapAnchor:int;

        public function PostmortemPanel()
        {
            super();
            mouseChildren = false;
            mouseEnabled = false;
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.bg.imageName = BATTLEATLAS.POSTMORTEM_TIPS_BG;
            vehiclePanelBG.imageName = BATTLEATLAS.POSTMORTEM_BG;
            deadReasonBG.imageName = BATTLEATLAS.POSTMORTEM_DEAD_REASON_BG;
            this.observerModeTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_LABEL;
            this.observerModeDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_OBSERVERMODE_TEXT;
            this.exitToHangarTitleTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_LABEL;
            this.exitToHangarDescTF.text = INGAME_GUI.POSTMORTEM_TIPS_EXITHANGAR_TEXT;
            this.showSpectatorPanel(false);
            TextFieldEx.setVerticalAutoSize(deadReasonTF,TextFieldEx.VALIGN_BOTTOM);
            setComponentsVisibility(false);
            this.updatePlayerInfoPosition();
            this.initDogTagVictim();
        }

        private function initDogTagKiller() : void
        {
            this._dogTagKiller = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
            addChild(this._dogTagKiller);
            this._dogTagKiller.x = -this._dogTagKiller.width >> 1;
            this._dogTagKiller.y = deadReasonTF.y - this._dogTagKiller.height - DOGTAG_KILLER_OFFSET_Y;
            this._dogTagKillerInitialized = true;
        }

        override protected function updatePlayerInfoPosition() : void
        {
            super.updatePlayerInfoPosition();
            if(this._dogTagKiller)
            {
                this._dogTagKiller.y = deadReasonTF.y - this._dogTagKiller.height - DOGTAG_KILLER_OFFSET_Y;
            }
        }

        private function initDogTagVictim() : void
        {
            this._dogTagVictim = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
            addChild(this._dogTagVictim);
            this._dogTagVictim.x = App.appWidth >> 1;
            this._dogTagVictim.y = this._dogTagVictimMiniMapAnchor;
            this._dogTagVictim.goToLabel(DogtagComponent.DOGTAG_LABEL_END_TOP);
            this._dogTagVictim.hideNameAndClan();
        }

        override protected function showKillerDogTag(param1:DogTagVO) : void
        {
            if(!this._dogTagKillerInitialized)
            {
                this.initDogTagKiller();
            }
            this._dogTagKiller.setDogTagInfo(param1);
        }

        override protected function showVictimDogTag(param1:DogTagVO) : void
        {
            this.visible = true;
            this._dogTagVictim.setDogTagInfo(param1);
            onVictimDogTagInPlaySoundS();
            this.animateVictimDogTag();
        }

        override protected function preloadComponents(param1:Array) : void
        {
            ImageRepository.getInstance().setImages(param1);
        }

        override public function setPlayerInfo(param1:String) : void
        {
            super.setPlayerInfo(param1);
            if(this._dogTagKiller)
            {
                this._dogTagKiller.visible = false;
            }
        }

        override public function showDeadReason() : void
        {
            super.showDeadReason();
            if(this._dogTagKiller)
            {
                this._dogTagKiller.visible = true;
            }
            this.showSpectatorPanel(true);
        }

        public function animateVictimDogTag() : void
        {
            this._dogTagVictim.alpha = 1;
            this._dogTagVictim.x = App.appWidth >> 1;
            if(this._victimDogTagTweenIn)
            {
                this._victimDogTagTweenIn.paused = true;
            }
            if(this._victimDogTagTweenOut)
            {
                this._victimDogTagTweenOut.paused = true;
            }
            this._victimDogTagTweenIn = new Tween(DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME,this._dogTagVictim,{"x":(App.appWidth >> 1) - this._dogTagVictim.width},{
                "paused":false,
                "onComplete":this.onVictimDogTagFadeInComplete
            });
        }

        private function onVictimDogTagFadeInComplete(param1:Tween) : void
        {
            this._dogTagVictim.animateDogTagUpBlink();
            this._victimDogTagTweenOut = new Tween(DOG_TAG_VICTIM_TWEEN_ANIMATION_TIME,this._dogTagVictim,{
                "alpha":0,
                "x":(App.appWidth >> 1) + this._dogTagVictim.width
            },{
                "delay":VICTIM_DOGTAG_LINGERING_TIME,
                "paused":false
            });
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(INVALID_VEHICLE_PANEL))
            {
                if(_deadReason != Values.EMPTY_STR)
                {
                    this.showSpectatorPanel(true);
                }
                if(_userName && _userName.userVO && _userName.userVO.userName != Values.EMPTY_STR)
                {
                    this.showPanel();
                }
            }
        }

        private function showSpectatorPanel(param1:Boolean) : void
        {
            this.bg.visible = param1;
            this.observerModeTitleTF.visible = param1;
            this.observerModeDescTF.visible = param1;
            this.exitToHangarTitleTF.visible = param1;
            this.exitToHangarDescTF.visible = param1;
        }

        private function showPanel() : void
        {
            vehiclePanel.alpha = 0;
            deadReasonTF.alpha = 0;
            _userName.alpha = 0;
            deadReasonBG.alpha = 0;
            this._vehPanelFadeInTween = new Tween(FADE_ANIMATION_TIME,vehiclePanel,{"alpha":1},{
                "delay":PANEL_ANIMATION_DELAY,
                "paused":false
            });
            this._deadReasonFadeInTween = new Tween(FADE_ANIMATION_TIME,deadReasonTF,{"alpha":1},{
                "delay":PANEL_ANIMATION_DELAY,
                "paused":false
            });
            this._userNameFadeInTween = new Tween(FADE_ANIMATION_TIME,_userName,{"alpha":1},{
                "delay":PANEL_ANIMATION_DELAY,
                "paused":false
            });
            this._deadReasonBGFadeInTween = new Tween(FADE_ANIMATION_TIME,deadReasonBG,{"alpha":1},{
                "delay":PANEL_ANIMATION_DELAY,
                "paused":false,
                "onComplete":this.onPanelFadeInAnimationComplete
            });
        }

        private function onPanelFadeInAnimationComplete(param1:Tween) : void
        {
            if(this._dogTagKillerInitialized)
            {
                this._deadReasonFadeOutTween = new Tween(FADE_ANIMATION_TIME,deadReasonTF,{"alpha":0},{
                    "delay":FADE_OUT_DEAD_REASON_ANIMATION_DELAY,
                    "paused":false,
                    "onComplete":this.onDeadReasonFadeOutComplete
                });
                this._deadReasonBGFadeOutTween = new Tween(FADE_ANIMATION_TIME,deadReasonBG,{"alpha":0},{
                    "delay":FADE_OUT_DEAD_REASON_ANIMATION_DELAY,
                    "paused":false
                });
            }
        }

        private function onDeadReasonFadeOutComplete(param1:Tween) : void
        {
            if(this._dogTagKiller)
            {
                this._dogTagKiller.animate();
                onDogTagKillerInPlaySoundS();
            }
        }

        public function anchorVictimDogTag(param1:int) : void
        {
            this._dogTagVictimMiniMapAnchor = DOGTAG_VICTIM_MINI_MAP_OFFSET + param1;
            if(this._dogTagVictim)
            {
                this._dogTagVictim.y = this._dogTagVictimMiniMapAnchor;
            }
        }

        public function as_setPlayerInfo(param1:String) : void
        {
            this.setPlayerInfo(param1);
        }

        public function as_showDeadReason() : void
        {
            this.showDeadReason();
        }

        override protected function onDispose() : void
        {
            this.bg = null;
            this.observerModeTitleTF = null;
            this.observerModeDescTF = null;
            this.exitToHangarTitleTF = null;
            this.exitToHangarDescTF = null;
            if(this._dogTagVictim)
            {
                this._dogTagVictim.dispose();
            }
            if(this._dogTagKiller)
            {
                this._dogTagKiller.dispose();
            }
            if(this._vehPanelFadeInTween)
            {
                this._vehPanelFadeInTween.paused = true;
                this._vehPanelFadeInTween.dispose();
                this._vehPanelFadeInTween = null;
            }
            if(this._userNameFadeInTween)
            {
                this._userNameFadeInTween.paused = true;
                this._userNameFadeInTween.dispose();
                this._userNameFadeInTween = null;
            }
            if(this._deadReasonFadeInTween)
            {
                this._deadReasonFadeInTween.paused = true;
                this._deadReasonFadeInTween.dispose();
                this._deadReasonFadeInTween = null;
            }
            if(this._deadReasonFadeOutTween)
            {
                this._deadReasonFadeOutTween.paused = true;
                this._deadReasonFadeOutTween.dispose();
                this._deadReasonFadeOutTween = null;
            }
            if(this._victimDogTagTweenIn)
            {
                this._victimDogTagTweenIn.paused = true;
                this._victimDogTagTweenIn.dispose();
                this._victimDogTagTweenIn = null;
            }
            if(this._victimDogTagTweenOut)
            {
                this._victimDogTagTweenOut.paused = true;
                this._victimDogTagTweenOut.dispose();
                this._victimDogTagTweenOut = null;
            }
            if(this._deadReasonBGFadeOutTween)
            {
                this._deadReasonBGFadeOutTween.paused = true;
                this._deadReasonBGFadeOutTween.dispose();
                this._deadReasonBGFadeOutTween = null;
            }
            if(this._deadReasonBGFadeInTween)
            {
                this._deadReasonBGFadeInTween.paused = true;
                this._deadReasonBGFadeInTween.dispose();
                this._deadReasonBGFadeInTween = null;
            }
            super.onDispose();
        }
    }
}
