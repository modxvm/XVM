package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.battleResults.*;
    import xvm.hangar.UI.battleResults.*;

    /**
     * @author Pavel Máca
     */
    public class CommonView
    {
        private const FIELD_POS_TITLE:String = "fieldPosTitle";
        private const FIELD_POS_NON_PREM:String = "fieldPosNonPrem";
        private const FIELD_POS_PREM:String = "fieldPosPrem";
        private const CSS_FIELD_CLASS:String = "xvm_bsField";

        private var view:CommonStats;

        private var shotsTitle:TextField;
        private var shotsCount:TextField;
        private var shotsPercent:TextField;
        private var damageAssistedTitle:TextField;
        private var damageAssistedValue:TextField;
        private var damageValue:TextField;

        private var tooltips:Object;

        public static function init(view:CommonStats):void
        {
            var instance:CommonView = new CommonView();
            instance.view = view;

            instance.compactQuests();

            if (Config.config.battleResults.showExtendedInfo)
            {
                instance.hideDetailBtn();
                instance.hideQuestLabel();
                instance.initTextFields();
                instance.setData(view.detailsMc.data);
            }

            if (Config.config.battleResults.showTotals)
                instance.setTotals(view.detailsMc.data);

            if (Config.config.battleResults.showNetIncome)
                instance.showNetIncome(view.detailsMc.data);
        }

        public function CommonView()
        {
            tooltips = { };
        }

        private function compactQuests():void
        {
            view.questList.linkage = getQualifiedClassName(UI_BR_SubtaskComponent);

            // hide shadows
            view.upperShadow.visible = false;
            view.lowerShadow.visible = false;
        }

        private function hideDetailBtn():void
        {
            view.detailsMc.detailedReportBtn.visible = false;
        }

        private function hideQuestLabel():void
        {
            view.detailsMc.progressTF.visible = false;
        }

        private function showNetIncome(data:Object):void
        {
            view.detailsMc.creditsLbl.htmlText = data.creditsNoPremTotalStr;
            view.detailsMc.premCreditsLbl.htmlText = data.creditsPremTotalStr;
        }

        private function initTextFields():void
        {
            shotsTitle = this.createTextField(FIELD_POS_TITLE, 1);

            shotsCount = this.createTextField(FIELD_POS_NON_PREM, 1);

            shotsPercent = this.createTextField(FIELD_POS_PREM, 1);

            damageAssistedTitle = this.createTextField(FIELD_POS_TITLE, 2);

            damageAssistedValue = this.createTextField(FIELD_POS_NON_PREM, 2);
            damageAssistedValue.name = EfficiencyIconRenderer.ASSIST;
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OVER, onOver);
            damageAssistedValue.addEventListener(MouseEvent.ROLL_OUT, onOut);

            damageValue = this.createTextField(FIELD_POS_PREM, 2);
            damageValue.name = EfficiencyIconRenderer.DAMAGE;
            damageValue.addEventListener(MouseEvent.ROLL_OVER, onOver);
            damageValue.addEventListener(MouseEvent.ROLL_OUT, onOut);
        }

        private function createTextField(position:String, line:Number):TextField
        {
            var newTf:TextField = new TextField();
            var orig:TextField;
            switch (position)
            {
                case FIELD_POS_TITLE:
                    orig = view.detailsMc.xpTitleLbl;
                    newTf.autoSize = TextFieldAutoSize.LEFT;
                    break;
                case FIELD_POS_NON_PREM:
                    orig = view.detailsMc.xpLbl;
                    break;
                case FIELD_POS_PREM:
                    orig = view.detailsMc.premXpLbl;
                    break;
                default:
                    return null;
            }
            newTf.x = orig.x;
            newTf.height = view.detailsMc.xpTitleLbl.height;
            newTf.alpha = 1;

            newTf.styleSheet = Utils.createTextStyleSheet(CSS_FIELD_CLASS, view.detailsMc.xpTitleLbl.defaultTextFormat);
            newTf.selectable = false;

            var y_space:Number = view.detailsMc.xpTitleLbl.height;
            var y_pos:Number = view.detailsMc.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            view.detailsMc.addChild(newTf);

            return newTf;
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function setData(data:Object):void
        {
            //Logger.addObject(data);
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(data.directHits + "/" + data.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitPercent:Number = (data.shots <= 0) ? 0 : (data.directHits / data.shots) * 100;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitPercent) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(App.utils.locale.integer(data.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(App.utils.locale.integer(data.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function setTotals(data:Object):void
        {
            try
            {
                //Logger.addObject(data, 3);
                var x:int = view.effencyTitle.x + 294;
                var y:int = view.effencyTitle.y;
                var w:Number = 32;

                // spotted
                //view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.SPOTTED, x: x, y: y1, width: w, height:h,
                //    htmlText: getTotalSpottedStr(data) } ));
                view.addChild(createTotalItem( { x: x, y: y, kind: EfficiencyIconRenderer.SPOTTED,
                    value: getTotalSpotted(data),
                    tooltip: { } } ));

                // damage assisted (radio/tracks)
                view.addChild(createTotalItem( { x: x + w * 1, y: y, kind: EfficiencyIconRenderer.ASSIST,
                    value: getTotalAssistCount(data),
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        value: data.damageAssisted,
                        values: data.damageAssistedRadio + "<br/>" + data.damageAssistedTrack,
                        discript: data.details[0].damageAssistedNames // WG programmer is asshole!
                    } } ));

                // crits
                view.addChild(createTotalItem( { x: x + w * 2, y: y, kind: EfficiencyIconRenderer.CRITS,
                    value: getTotalCritsCount(data),
                    tooltip: { value: getTotalCritsCount(data) } } ));

                // piercings
                view.addChild(createTotalItem( { x: x + w * 3 - 1, y: y, kind: EfficiencyIconRenderer.DAMAGE,
                    value: data.piercings,
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        values: data.damageDealt + "<br/>" + data.piercings,
                        discript: data.details[0].damageDealtNames
                    } } ));

                // kills
                view.addChild(createTotalItem( { x: x + w * 4 - 2, y: y, kind: EfficiencyIconRenderer.KILL,
                    value: data.kills,
                    tooltip: { value: -1 } } ));
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function calcDetails(data:Object, field:String):Number
        {
            var n:int = 0;
            for each (var obj:Object in data.details)
            {
                var v:* = obj[field];
                if (v is String)
                    n += int(parseInt(v));
                else if (v is Boolean)
                    n += v == true ? 1 : 0
                else
                    n += int(v);
            }
            return n;
        }

        private function getTotalSpotted(data:Object):Number
        {
            return calcDetails(data, "spotted");
        }

        private function getTotalAssistCount(data:Object):Number
        {
            var n:int = 0;
            for each (var obj:Object in data.details)
            {
                if (obj["damageAssistedRadio"] != 0 || obj["damageAssistedTrack"] != 0)
                    n++;
            }
            return n;
        }

        private function getTotalCritsCount(data:Object = null):Number
        {
            return calcDetails(data, "critsCount");
        }

        private function createTotalItem(params:Object = null):EfficiencyIconRenderer
        {
            if (params != null)
            {
                if (params.hasOwnProperty("tooltip"))
                {
                    tooltips[params.kind] = params.tooltip;
                    delete params.tooltip;
                }
            }

            var icon:EfficiencyIconRenderer = App.utils.classFactory.getComponent("EfficiencyIconRendererGUI", EfficiencyIconRenderer, params);
            icon.enabled = params.value > 0;
            icon.addEventListener(MouseEvent.ROLL_OVER, onOver);
            icon.addEventListener(MouseEvent.ROLL_OUT, onOut);

            return icon;
        }

        private function onOver(e:MouseEvent):void
        {
            var icon:EfficiencyIconRenderer = e.currentTarget as EfficiencyIconRenderer;
            var kind:String = icon != null ? icon.kind : e.currentTarget.name;
            var tooltip:* = tooltips[kind];
            if (tooltip == null)
                return;
            var data:Object = merge(tooltip, {
                "type":kind,
                "disabled":icon == null ? false : icon.value <= 0
            });
            App.toolTipMgr.showSpecial(Tooltips.EFFICIENCY_PARAM, null, kind, data);
        }

        private function onOut(m:MouseEvent):void
        {
            App.toolTipMgr.hide();
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
