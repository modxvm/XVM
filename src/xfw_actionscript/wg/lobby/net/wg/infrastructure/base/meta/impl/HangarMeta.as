package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.tutorial.GFTutorialView;
    import net.wg.gui.lobby.hangar.ammunitionPanel.data.AmmunitionPanelVO;
    import net.wg.gui.lobby.post.data.TeaserVO;
    import net.wg.gui.lobby.eventCrew.data.EventCrewVO;
    import net.wg.data.constants.Errors;
    import net.wg.infrastructure.exceptions.AbstractException;

    public class HangarMeta extends GFTutorialView
    {

        public var onEscape:Function;

        public var onCloseBtnClick:Function;

        public var showHelpLayout:Function;

        public var closeHelpLayout:Function;

        public var hideTeaser:Function;

        public var onTeaserClick:Function;

        public var onEventExitClick:Function;

        public var onEventParamsToggle:Function;

        private var _ammunitionPanelVO:AmmunitionPanelVO;

        private var _array:Array;

        private var _teaserVO:TeaserVO;

        private var _eventCrewVO:EventCrewVO;

        public function HangarMeta()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this._ammunitionPanelVO)
            {
                this._ammunitionPanelVO.dispose();
                this._ammunitionPanelVO = null;
            }
            if(this._array)
            {
                this._array.splice(0,this._array.length);
                this._array = null;
            }
            if(this._teaserVO)
            {
                this._teaserVO.dispose();
                this._teaserVO = null;
            }
            if(this._eventCrewVO)
            {
                this._eventCrewVO.dispose();
                this._eventCrewVO = null;
            }
            super.onDispose();
        }

        public function onEscapeS() : void
        {
            App.utils.asserter.assertNotNull(this.onEscape,"onEscape" + Errors.CANT_NULL);
            this.onEscape();
        }

        public function onCloseBtnClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
            this.onCloseBtnClick();
        }

        public function showHelpLayoutS() : void
        {
            App.utils.asserter.assertNotNull(this.showHelpLayout,"showHelpLayout" + Errors.CANT_NULL);
            this.showHelpLayout();
        }

        public function closeHelpLayoutS() : void
        {
            App.utils.asserter.assertNotNull(this.closeHelpLayout,"closeHelpLayout" + Errors.CANT_NULL);
            this.closeHelpLayout();
        }

        public function hideTeaserS() : void
        {
            App.utils.asserter.assertNotNull(this.hideTeaser,"hideTeaser" + Errors.CANT_NULL);
            this.hideTeaser();
        }

        public function onTeaserClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onTeaserClick,"onTeaserClick" + Errors.CANT_NULL);
            this.onTeaserClick();
        }

        public function onEventExitClickS() : void
        {
            App.utils.asserter.assertNotNull(this.onEventExitClick,"onEventExitClick" + Errors.CANT_NULL);
            this.onEventExitClick();
        }

        public function onEventParamsToggleS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onEventParamsToggle,"onEventParamsToggle" + Errors.CANT_NULL);
            this.onEventParamsToggle(param1);
        }

        public final function as_setupAmmunitionPanel(param1:Object) : void
        {
            var _loc2_:AmmunitionPanelVO = this._ammunitionPanelVO;
            this._ammunitionPanelVO = new AmmunitionPanelVO(param1);
            this.setupAmmunitionPanel(this._ammunitionPanelVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_show3DSceneTooltip(param1:String, param2:Array) : void
        {
            var _loc3_:Array = this._array;
            this._array = param2;
            this.show3DSceneTooltip(param1,this._array);
            if(_loc3_)
            {
                _loc3_.splice(0,_loc3_.length);
            }
        }

        public final function as_showTeaser(param1:Object) : void
        {
            var _loc2_:TeaserVO = this._teaserVO;
            this._teaserVO = new TeaserVO(param1);
            this.showTeaser(this._teaserVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        public final function as_setEventCrew(param1:Object) : void
        {
            var _loc2_:EventCrewVO = this._eventCrewVO;
            this._eventCrewVO = new EventCrewVO(param1);
            this.setEventCrew(this._eventCrewVO);
            if(_loc2_)
            {
                _loc2_.dispose();
            }
        }

        protected function setupAmmunitionPanel(param1:AmmunitionPanelVO) : void
        {
            var _loc2_:String = "as_setupAmmunitionPanel" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function show3DSceneTooltip(param1:String, param2:Array) : void
        {
            var _loc3_:String = "as_show3DSceneTooltip" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc3_);
            throw new AbstractException(_loc3_);
        }

        protected function showTeaser(param1:TeaserVO) : void
        {
            var _loc2_:String = "as_showTeaser" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }

        protected function setEventCrew(param1:EventCrewVO) : void
        {
            var _loc2_:String = "as_setEventCrew" + Errors.ABSTRACT_INVOKE;
            DebugUtils.LOG_ERROR(_loc2_);
            throw new AbstractException(_loc2_);
        }
    }
}
