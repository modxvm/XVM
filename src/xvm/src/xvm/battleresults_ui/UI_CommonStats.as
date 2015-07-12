/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 * @author Pavel Máca
 */
package xvm.battleresults_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.veh.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.data.constants.generated.*;
    import net.wg.gui.lobby.battleResults.EfficiencyIconRenderer;
    import net.wg.gui.lobby.battleResults.data.*;
    import scaleform.clik.events.*;

    public dynamic class UI_CommonStats extends CommonStats
    {
        private const FIELD_POS_TITLE:String = "fieldPosTitle";
        private const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private const FIELD_POS_PREM:String = "fieldPosPrem";
        private const CSS_FIELD_CLASS:String = "xvm_bsField";
        private const XP_IMG_TXT:String = " <IMG SRC='img://gui/maps/icons/library/XpIcon-1.png' width='16' height='16' vspace='-2'/>";

        private var _data:BattleResultsVO = null;
        private var xdataList:XvmCommonStatsDataListVO = null;
        private var currentTankIndex:int = 0;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;

        private var spottedTotalField:EfficiencyIconRenderer;
        private var damageAssistedTotalField:EfficiencyIconRenderer;
        private var armorTotalField:EfficiencyIconRenderer;
        private var critsTotalField:EfficiencyIconRenderer;
        private var damageTotalField:EfficiencyIconRenderer;
        private var killsTotalField:EfficiencyIconRenderer;

        private var tooltips:Object;

        public function UI_CommonStats()
        {
            //Logger.add("UI_CommonStats");
            super();
        }

        override protected function configUI():void
        {
            super.configUI();
            tooltips = { };
            tankSlot.addEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler);
        }

        override protected function onDispose():void
        {
            super.onDispose();

            tankSlot.removeEventListener(ListEvent.INDEX_CHANGE, onDropDownIndexChangeHandler);

            _data = null;
            xdataList = null;
        }

        override public function update(data:Object):void
        {
            //Logger.add("update");
            try
            {
                if (data != null)
                {
                    // Using first vehicle item for transferring XVM data.
                    // Cannot add to data object because DAAPIDataClass is not dynamic.
                    var vehicles:Array = data.vehicles;
                    if (vehicles.length > 0 && vehicles[0]['__xvm'])
                    {
                        xdataList = new XvmCommonStatsDataListVO(vehicles.shift());
                    }
                }

                super.update(data);

                if (this._data == null)
                {
                    this._data = BattleResultsVO(data);

                    detailsMc.validateNow();

                    compactQuests();
                    hideQuestsShadows();

                    if (Config.config.battleResults.showExtendedInfo)
                    {
                        hideDetailBtn();
                        hideQuestLabel();
                        initTextFields();
                    }

                    if (Config.config.battleResults.showTotals)
                        initTotals();

                    if (Config.config.battleResults.showCrewExperience)
                        detailsMc.xpTitleLbl.width += 50;

                    updateValues();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function onDropDownIndexChangeHandler(e:ListEvent) : void
        {
            this.currentTankIndex = e.index;
            updateValues();
        }

        // PRIVATE

        private function get xdata():XvmCommonStatsDataVO
        {
            return xdataList.data[this.currentTankIndex];
        }

        private function compactQuests():void
        {
            progressReport.linkage = getQualifiedClassName(UI_BR_SubtaskComponent);
        }

        private function hideQuestsShadows():void
        {
            upperShadow.visible = false;
            lowerShadow.visible = false;
        }

        private function hideDetailBtn():void
        {
            detailsMc.detailedReportBtn.visible = false;
        }

        private function hideQuestLabel():void
        {
            detailsMc.progressTF.visible = false;
        }

        private function initTextFields():void
        {
            shotsTitle = createTextField(FIELD_POS_TITLE, 1);

            shotsCount = createTextField(FIELD_POS_NON_PREM, 1);

            shotsPercent = createTextField(FIELD_POS_PREM, 1);

            damageAssistedTitle = createTextField(FIELD_POS_TITLE, 2);

            damageAssistedValue = createTextField(FIELD_POS_NON_PREM, 2);
            damageAssistedValue.name = BATTLE_EFFICIENCY_TYPES.ASSIST;
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);

            damageValue = createTextField(FIELD_POS_PREM, 2);
            damageValue.name = BATTLE_EFFICIENCY_TYPES.DAMAGE;
            damageValue.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
            damageValue.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
        }

        private function initTotals():void
        {
            try
            {
                var x:int = efficiencyTitle.x + 275;
                var y:int = efficiencyTitle.y;
                var w:Number = 33;

                // spotted
                spottedTotalField = addChild(createTotalItem( { x: x, y: y, kind: BATTLE_EFFICIENCY_TYPES.DETECTION })) as EfficiencyIconRenderer;

                // damage assisted (radio/tracks)
                damageAssistedTotalField = addChild(createTotalItem( { x: x + w * 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.ASSIST })) as EfficiencyIconRenderer;

                // armor
                armorTotalField = addChild(createTotalItem( { x: x + w * 2, y: y, kind: BATTLE_EFFICIENCY_TYPES.ARMOR })) as EfficiencyIconRenderer;

                // crits
                critsTotalField = addChild(createTotalItem( { x: x + w * 3, y: y, kind: BATTLE_EFFICIENCY_TYPES.CRITS })) as EfficiencyIconRenderer;

                // piercings
                damageTotalField = addChild(createTotalItem( { x: x + w * 4 + 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.DAMAGE })) as EfficiencyIconRenderer;

                // kills
                killsTotalField = addChild(createTotalItem( { x: x + w * 5 + 1, y: y, kind: BATTLE_EFFICIENCY_TYPES.DESTRUCTION })) as EfficiencyIconRenderer;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function updateValues():void
        {
            if (Config.config.battleResults.showExtendedInfo)
                showExtendedInfo();

            if (Config.config.battleResults.showTotals)
                showTotals();

            if (Config.config.battleResults.showTotalExperience)
                showTotalExperience();

            if (Config.config.battleResults.showCrewExperience)
                showCrewExperience();

            if (Config.config.battleResults.showNetIncome)
                showNetIncome();
        }

        private function showExtendedInfo():void
        {
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(xdata.hits + "/" + xdata.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitsRatio:Number = (xdata.shots <= 0) ? 0 : (xdata.hits / xdata.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitsRatio) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(App.utils.locale.integer(xdata.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(App.utils.locale.integer(xdata.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function showTotals():void
        {
            // spotted
            spottedTotalField.value = xdata.spotted;
            spottedTotalField.enabled = xdata.spotted > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.DETECTION] = { };

            // damage assisted (radio/tracks)
            damageAssistedTotalField.value = xdata.damageAssistedCount;
            damageAssistedTotalField.enabled = xdata.damageAssistedCount > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.ASSIST] = {
                totalAssistedDamage: xdata.damageAssisted,
                values: App.utils.locale.integer(xdata.damageAssistedRadio) + "<br/>" +
                    App.utils.locale.integer(xdata.damageAssistedTrack) + "<br/>" +
                    App.utils.locale.integer(xdata.damageAssisted),
                discript: xdataList.damageAssistedNames,
                totalItemsCount: 2
            };

            // armor
            armorTotalField.value = xdata.armorCount;
            armorTotalField.enabled = xdata.armorCount > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.ARMOR] = {
                values: xdata.ricochetsCount + "<br/>" + xdata.nonPenetrationsCount + "<br/>" + App.utils.locale.integer(xdata.damageBlockedByArmor),
                discript: xdataList.armorNames,
                totalItemsCount: 3
            };

            // crits
            critsTotalField.value = xdata.critsCount;
            critsTotalField.enabled = xdata.critsCount > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.CRITS] = { };

            // piercings
            damageTotalField.value = xdata.piercings;
            damageTotalField.enabled = xdata.piercings > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.DAMAGE] = {
                values: App.utils.locale.integer(xdata.damageDealt) + "<br/>" + xdata.piercings,
                discript: xdataList.damageDealtNames,
                totalItemsCount: 2
            };

            // kills
            killsTotalField.value = xdata.kills;
            killsTotalField.enabled = xdata.kills > 0;
            tooltips[BATTLE_EFFICIENCY_TYPES.DESTRUCTION] = { };
        }

        private function showTotalExperience():void
        {
            detailsMc.xpLbl.htmlText = App.utils.locale.integer(xdata.origXP) + XP_IMG_TXT;
            detailsMc.premXpLbl.htmlText = App.utils.locale.integer(xdata.premXP) + XP_IMG_TXT;
        }

        private function showCrewExperience():void
        {
            detailsMc.xpTitleLbl.htmlText += " / " + Locale.get("BR_xpCrew");
            detailsMc.xpLbl.htmlText = detailsMc.xpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(xdata.origCrewXP) + " <IMG SRC");
            detailsMc.premXpLbl.htmlText = detailsMc.premXpLbl.htmlText.replace("<IMG SRC",
                "/ " + App.utils.locale.integer(xdata.premCrewXP) + " <IMG SRC");
        }

        private function showNetIncome():void
        {
            detailsMc.creditsLbl.htmlText = xdata.creditsNoPremTotalStr;
            detailsMc.premCreditsLbl.htmlText = xdata.creditsPremTotalStr;
        }

        // helpers

        private function createTextField(position:String, line:Number):TextField
        {
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = detailsMc.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = detailsMc.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = detailsMc.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.height = detailsMc.xpTitleLbl.height;
            newTf.alpha = 1;

            newTf.styleSheet = WGUtils.createTextStyleSheet(CSS_FIELD_CLASS, detailsMc.xpTitleLbl.defaultTextFormat);
            newTf.selectable = false;

            var y_space:Number = detailsMc.xpTitleLbl.height;
            var y_pos:Number = detailsMc.resTitleLbl && detailsMc.resTitleLbl.visible ? detailsMc.resTitleLbl.y : detailsMc.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            detailsMc.addChild(newTf);

            return newTf;
        }

        private function createTotalItem(params:Object = null):EfficiencyIconRenderer
        {
            var icon:EfficiencyIconRenderer = App.utils.classFactory.getComponent("EfficiencyIconRendererGUI", EfficiencyIconRenderer, params);
            icon.addEventListener(MouseEvent.ROLL_OVER, onRollHandler);
            icon.addEventListener(MouseEvent.ROLL_OUT, onRollHandler);
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
                var tooltip:* = tooltips[kind];
                if (tooltip == null)
                    return;
                var data:Object = merge(tooltip, {
                    isGarage: _data.common.isGarage,
                    type:kind,
                    disabled:icon == null ? false : icon.value <= 0
                });
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM, null, kind, data);
            }
            else
            {
                App.toolTipMgr.hide();
            }
        }

        private function merge(obj1:Object, obj2:Object):Object
        {
            var result:Object = new Object();
            for (var param:String in obj1)
                result[param] = obj1[param];
            for (param in obj2)
                result[param] = obj2[param];
            return result;
        }
    }
}
