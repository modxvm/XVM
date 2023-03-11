/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 * @author Pavel Máca
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.lobby.ui.battleresults
{
    import com.xfw.*;
    import com.xfw.XfwAccess;
    import com.xfw.events.ObjectEvent;
    import com.xvm.*;
    import com.xvm.lobby.vo.VOLobbyMacrosOptions;
    import com.xvm.types.cfg.CBattleResultsBonusState;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.utils.getQualifiedClassName;
    import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
    import net.wg.data.constants.generated.BATTLE_RESULTS_PREMIUM_STATES;
    import net.wg.data.constants.generated.TEXT_ALIGN;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.gui.lobby.battleResults.components.EfficiencyIconRenderer;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.ComparePremiumState;
    import net.wg.gui.lobby.battleResults.components.detailsBlockStates.PremiumBonusState;
    import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
    import net.wg.gui.lobby.battleResults.data.DetailedStatsItemVO;
    import net.wg.gui.lobby.battleResults.data.IconEfficiencyTooltipData;
    import net.wg.gui.lobby.battleResults.data.PersonalDataVO;
    import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
    import net.wg.gui.lobby.questsWindow.SubtasksList;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ListEvent;
    import scaleform.gfx.TextFieldEx;

    public dynamic class UI_CommonStats extends CommonStats
    {
        private static const FIELD_POS_TITLE:String = "fieldPosTitle";
        private static const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private static const FIELD_POS_PREM:String = "fieldPosPrem";
        private static const CSS_FIELD_CLASS:String = "xvm_bsField";
        private static const XP_IMG_TXT:String = " <IMG SRC='img://gui/maps/icons/library/XpIcon-1.png' width='16' height='16' vspace='-2'/>";
        private static const HEADER_INVALID:String = "headerInvalid";

        private var _fieldsInitialized:Boolean = false;
        private var _data:BattleResultsVO = null;
        private var _xvmData:XvmCommonStatsDataListVO = null;
        private var _currentTankIndex:int = 0;

        private var armorNames:Array = null;
        private var damageAssistedNames:Array = null;
        private var damageDealtNames:Array = null;
        private var stunNames:Array = null;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;
		
        private var bonusState:PremiumBonusState;

        private var tooltips:Object;

        private var fakeNames:Object = { };

        public function UI_CommonStats()
        {
            //Logger.add("UI_CommonStats");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            tooltips = { };
            tankSlot.addEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler, false, 0, true);
            Stat.instance.addEventListener(Stat.COMPLETE_BATTLERESULTS, onStatLoaded, false, 0, true);
        }

        override protected function onDispose():void
        {
            tankSlot.removeEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler);
            Stat.instance.removeEventListener(Stat.COMPLETE_BATTLERESULTS, onStatLoaded);

            _data = null;
            _xvmData = null;

            if (bonusState)
            {
                removeChild(bonusState);
                bonusState = null;
            }

            try
            {
                // Some error occurs for an unknown reason
                super.onDispose();
            }
            catch (ex:Error)
            {
                if (Config.IS_DEVELOPMENT)
                {
                    Logger.err(ex);
                }
            }
        }

        override protected function draw():void
        {
            super.draw();
            if (_data != null)
            {
                if (isInvalid(InvalidationType.DATA, InvalidationType.SIZE))
                {
                    var compareState:ComparePremiumState = detailsMc.compareState;
                    var cfg:CBattleResultsBonusState = Config.config.battleResults.bonusState;
                    if (!compareState.visible && cfg.enabled)
                    {
                        compareState.visible = true;
                        compareState.setData(_data.personal);
                    }
                    compareState.validateNow();
                    updateValues();
                }
            }
        }

        override public function update(data:Object):void
        {
            //Logger.add("update");
            try
            {
                // Use data['common']['regionNameStr'] value to transfer XVM data.
                // Cannot add in data object because DAAPIDataClass is not dynamic.
                var xdataStr:String = data.common.regionNameStr;
                if (xdataStr.indexOf("\"__xvm\"") > 0)
                {
                    _xvmData = new XvmCommonStatsDataListVO(JSONx.parse(xdataStr));
                    data.common.regionNameStr = _xvmData.regionNameStr;
                }

                // search localized strings for tooltips and calculate total values
                var personal:PersonalDataVO = data.personal;
                for (var i:String in personal.details)
                {
                    var creditsData:Vector.<DetailedStatsItemVO> = personal.creditsData[i] as Vector.<DetailedStatsItemVO>;
                    creditsData = creditsData.filter(function(x:DetailedStatsItemVO):Boolean { return x.lineType == "wideLine"; });
                    var totalData:DetailedStatsItemVO = creditsData[0];
                    _xvmData.data[i].creditsNoPremTotalStr = totalData.col1;
                    _xvmData.data[i].creditsPremTotalStr = totalData.col3;
                    for each (var detail:Object in personal.details[i])
                    {
                        if (armorNames == null)
                        {
                            armorNames = detail.armorNames;
                        }
                        if (damageAssistedNames == null)
                        {
                            damageAssistedNames = detail.damageAssistedNames;
                        }
                        if (damageDealtNames == null)
                        {
                            damageDealtNames = detail.damageDealtNames;
                        }
                        if (stunNames == null)
                        {
                            stunNames = detail.stunNames;
                        }
                    }
                }

                /*
                try
                {
                    var item:Object;
                    var options:VOLobbyMacrosOptions = new VOLobbyMacrosOptions();
                    // team 1
                    for each (item in data.team1)
                    {
                        //Logger.addObject(item, 2);
                        options.playerName = item.playerName;
                        if (fakeNames[item.playerName] == null)
                            fakeNames[item.playerName] = item.userVO.fakeName;
                        item.userVO.fakeName = Macros.Format("<font color='{{c:xr}}'>{{r}}</font> ", options) + fakeNames[item.playerName];
                    }
                    // team 2
                    for each (item in data.team2)
                    {
                        //Logger.addObject(item, 2);
                        options.playerName = item.playerName;
                        if (fakeNames[item.playerName] == null)
                            fakeNames[item.playerName] = item.userVO.fakeName;
                        item.userVO.fakeName = Macros.Format("<font color='{{c:xr}}'>{{r}}</font> ", options) + fakeNames[item.playerName];
                    }
                    // damage list
                    //Logger.addObject(data.details);
                    //Logger.addObject(data.details[0]);
                    //for each (item in data.details[0])
                    //{
                        //if (item.playerRealName != null)
                        //{
                            //options.playerName = item.playerRealName;
                            //if (fakeNames[item.playerRealName] == null)
                                //fakeNames[item.playerRealName] = item.playerFakeName;
                            //item.playerFakeName = Macros.Format("<font color='{{c:xr}}'>{{r}}</font> ", options) + fakeNames[item.playerRealName];
                        //}
                    //}
                }
                catch (e:Error)
                {
                    Logger.err(e);
                }
                */

                // original update
                super.update(data);

                // XVM update
                this._data = BattleResultsVO(data);

                detailsMc.validateNow();

                if (!_fieldsInitialized)
                {
                    validateNow();
                    initializeFields();
                    Stat.loadBattleResultsStat(_xvmData.arenaUniqueID);
                    _fieldsInitialized = true;
                }

                hideQuestsShadows();

                updateValues();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function onDropDownIndexChangeHandler(e:ListEvent) : void
        {
            _currentTankIndex = e.index;
            updateValues();
        }

        private function initializeFields():void
        {
            compactQuests();

            if (_data.personal.dynamicPremiumState == BATTLE_RESULTS_PREMIUM_STATES.PREMIUM_BONUS)
            {
                initPremiumBonusFields();
            }

            if (Config.config.battleResults.showExtendedInfo)
            {
                initTextFields();
            }

            if (Config.config.battleResults.showCrewExperience)
            {
                initCrewExperience();
            }
        }

        private function get _xdata():XvmCommonStatsDataVO
        {
            return _xvmData.data[_currentTankIndex];
        }

        private function compactQuests():void
        {
            var progressReport:SubtasksList = XfwAccess.getPrivateField(this, "xfw_progressReport");
            if (progressReport)
            {
                progressReport.linkage = getQualifiedClassName(UI_BR_SubtaskComponent);
            }
        }

        private function hideQuestsShadows():void
        {
            upperShadow.visible = false;
            lowerShadow.visible = false;
        }

        private function initPremiumBonusFields():void
        {
            var cfg:CBattleResultsBonusState = Config.config.battleResults.bonusState;
            if (!bonusState && cfg.enabled)
            {
                bonusState = addChild(detailsMc.bonusState) as PremiumBonusState;
                bonusState.scrollRect = new Rectangle(190, 13, 320, 90);
                bonusState.x = cfg.offsetX;
                bonusState.y = cfg.offsetY;
                bonusState.backgroundIcon.alpha = cfg.backgroundAlpha;
            }
        }

        private function initTextFields():void
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            // align standard fields
            compareState.noPremTitleLbl.y -= 13;
            compareState.premTitleLbl.y -= 13;
            compareState.creditsTitle.y -= 24;
            compareState.creditsLbl.y -= 24;
            compareState.premCreditsLbl.y -= 24;
            compareState.xpTitleLbl.y -= 24;
            compareState.xpLbl.y -= 24;
            compareState.premXpLbl.y -= 24;

            if (Config.config.battleResults.showCrewExperience)
            {
                compareState.backgroundIcon.scrollRect = new Rectangle(20, 0, width, height);
                compareState.noPremTitleLbl.x -= 30;
                compareState.premTitleLbl.x += 15;
                compareState.creditsTitle.x -= 30;
                compareState.creditsLbl.x -= 30;
                compareState.premCreditsLbl.x += 15;
                compareState.xpTitleLbl.x -= 30;
                compareState.xpTitleLbl.scrollRect = new Rectangle(0, 0, 147, 20);
                compareState.xpLbl.x -= 30;
                compareState.premXpLbl.x += 15;
            }

            // add new fields
            shotsTitle = createTextField(FIELD_POS_TITLE, 1);
            shotsCount = createTextField(FIELD_POS_NON_PREM, 1);
            shotsPercent = createTextField(FIELD_POS_PREM, 1);
            damageAssistedTitle = createTextField(FIELD_POS_TITLE, 2);

            damageAssistedValue = createTextField(FIELD_POS_NON_PREM, 2);
            damageAssistedValue.name = BATTLE_EFFICIENCY_TYPES.ASSIST;
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);

            damageValue = createTextField(FIELD_POS_PREM, 2);
            damageValue.name = BATTLE_EFFICIENCY_TYPES.DAMAGE;
            damageValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            damageValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
        }

        private static const CREW_EXP_OFFSET_X:int = 30;
        private function initCrewExperience():void
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            if (compareState.xpTitleLbl)
                compareState.xpTitleLbl.width += 50;
            if (compareState.noPremTitleLbl)
                compareState.noPremTitleLbl.x += CREW_EXP_OFFSET_X;
            if (compareState.creditsLbl)
                compareState.creditsLbl.x += CREW_EXP_OFFSET_X;
            if (compareState.xpLbl)
                compareState.xpLbl.x += CREW_EXP_OFFSET_X;
            if (shotsCount)
                shotsCount.x += CREW_EXP_OFFSET_X;
            if (damageAssistedValue)
                damageAssistedValue.x += CREW_EXP_OFFSET_X;
        }

        private function updateValues():void
        {
            if (!_fieldsInitialized)
            {
                return;
            }

            var compareState:ComparePremiumState = detailsMc.compareState;
            if (compareState.noPremTitleLbl.defaultTextFormat.leading == 2)
            {
                var textFormat:TextFormat = compareState.noPremTitleLbl.defaultTextFormat;
                textFormat.leading = -4;
                textFormat.align = TEXT_ALIGN.CENTER;
                compareState.noPremTitleLbl.setTextFormat(textFormat);
                compareState.premTitleLbl.setTextFormat(textFormat);
            }

            if (Config.config.battleResults.showExtendedInfo)
            {
                showExtendedInfo();
            }

            if (Config.config.battleResults.showTotalExperience)
            {
                showTotalExperience();
            }

            if (Config.config.battleResults.showCrewExperience)
            {
                showCrewExperience();
            }

            if (Config.config.battleResults.showNetIncome)
            {
                showNetIncome();
            }
        }

        private function showExtendedInfo():void
        {
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(_xdata.hits + "/" + _xdata.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitsRatio:Number = (_xdata.shots <= 0) ? 0 : (_xdata.hits / _xdata.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitsRatio) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(App.utils.locale.integer(_xdata.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(App.utils.locale.integer(_xdata.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function showTotalExperience():void
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            compareState.xpLbl.htmlText = App.utils.locale.integer(_xdata.origXP) + XP_IMG_TXT;
            compareState.premXpLbl.htmlText = App.utils.locale.integer(_xdata.premXP) + XP_IMG_TXT;
        }

        private function showCrewExperience():void
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            compareState.xpTitleLbl.htmlText += " / " + Locale.get("BR_xpCrew");
            compareState.xpLbl.htmlText = compareState.xpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(_xdata.origCrewXP) + " <IMG SRC");
            compareState.premXpLbl.htmlText = compareState.premXpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(_xdata.premCrewXP) + " <IMG SRC");
        }

        private function showNetIncome():void
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            compareState.creditsLbl.htmlText = _xdata.creditsNoPremTotalStr;
            compareState.premCreditsLbl.htmlText = _xdata.creditsPremTotalStr;
        }

        private function onStatLoaded(e:ObjectEvent):void
        {
            invalidate(InvalidationType.DATA);
        }

        // helpers

        private function createTextField(position:String, line:Number):TextField
        {
            var compareState:ComparePremiumState = detailsMc.compareState;
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = compareState.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = compareState.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = compareState.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.height = compareState.xpTitleLbl.height;
            newTf.alpha = 1;

            newTf.styleSheet = XfwUtils.createTextStyleSheet(CSS_FIELD_CLASS, compareState.xpTitleLbl.defaultTextFormat);
            newTf.mouseEnabled = true;
            newTf.selectable = false;
            TextFieldEx.setNoTranslate(newTf, true);
            newTf.antiAliasType = AntiAliasType.ADVANCED;

            var y_space:Number = compareState.xpTitleLbl.height;
            var y_pos:Number = compareState.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            compareState.addChild(newTf);

            return newTf;
        }

        private function createTotalItem(params:Object = null):EfficiencyIconRenderer
        {
            var icon:EfficiencyIconRenderer = App.utils.classFactory.getComponent("EfficiencyIconRendererGUI", EfficiencyIconRenderer, params);
            icon.addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
            icon.addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
            return icon;
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function onRollHandler(e:MouseEvent):void
        {
            //Logger.add("onRollHandler: " + e.type);
            if (e.type == MouseEvent.ROLL_OVER)
            {
                var icon:EfficiencyIconRenderer = e.currentTarget as EfficiencyIconRenderer;
                var kind:String = icon != null ? icon.kind : e.currentTarget.name;
                var tooltip:IconEfficiencyTooltipData = tooltips[kind];
                if (tooltip == null)
                    return;
                tooltip.type = kind;
                tooltip.disabled = icon == null ? false : icon.value <= 0;
                tooltip.isGarage = _data.common.playerVehicles.length > 1;
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM, null, tooltip);
            }
            else
            {
                App.toolTipMgr.hide();
            }
        }
    }
}
