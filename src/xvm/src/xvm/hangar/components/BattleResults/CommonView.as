package xvm.hangar.components.BattleResults
{
    import com.xvm.*;
    import com.xvm.l10n.*;
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
                instance.setTotals(view.detailsMc.data);
            }

            if (Config.config.battleResults.showNetIncome)
                instance.showNetIncome(view.detailsMc.data);
        }

        public function CommonView()
        {
            tooltips = { };
        }

        private function compactQuests():void
        {
            view.questList.linkage = getQualifiedClassName(UI_BR_SubtaskComponent_UI);

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
            damageValue = this.createTextField(FIELD_POS_PREM, 2);
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
            newTf.alpha = 1;

            newTf.styleSheet = Utils.createTextStyleSheet(CSS_FIELD_CLASS, view.detailsMc.xpTitleLbl.defaultTextFormat);
            newTf.selectable = false;

            var y_space:Number = view.detailsMc.xpTitleLbl.height;
            var y_pos:Number = view.detailsMc.xpTitleLbl.y;

            newTf.y = y_pos + line * y_space;

            view.detailsMc.addChild(newTf);

            return newTf;
        }

        private function formatThousand(val:Number):String
        {
            return App.utils.locale.integer(val);
        }

        private function formatText(text:String, color:String, align:String = TextFormatAlign.LEFT):String
        {
            return "<p class='" + CSS_FIELD_CLASS + "' align='" + align + "'><font color='" + color + "'>" + text + "</font></p>";
        }

        private function setData(data:Object):void
        {
            shotsTitle.htmlText = formatText(Locale.get("Hit percent"), "#C9C9B6");
            shotsCount.htmlText = formatText(data.hits + "/" + data.shots, "#C9C9B6", TextFormatAlign.RIGHT);

            var hitPercent:Number;
            if (data.shots > 0)
                hitPercent = (data.hits / data.shots) * 100;
            else
                hitPercent = 0;
            shotsPercent.htmlText = formatText(App.utils.locale.float(hitPercent) + "%", "#C9C9B6", TextFormatAlign.RIGHT);

            damageAssistedTitle.htmlText = formatText(Locale.get("Damage (assisted / own)"), "#C9C9B6");
            damageAssistedValue.htmlText = formatText(formatThousand(data.damageAssisted), "#408CCF", TextFormatAlign.RIGHT);
            damageValue.htmlText = formatText(formatThousand(data.damageDealt), "#FFC133", TextFormatAlign.RIGHT);
        }

        private function setTotals(data:Object):void
        {
            try
            {
                //Logger.addObject(data, 3);
                var x:int = view.effencyTitle.x + 288;
                var y1:int = view.effencyTitle.y + 4;
                var y2:int = view.effencyTitle.y - 3;
                var w:int = 33;
                var h:int = 32;

                // spotted
                view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.SPOTTED, x: x, y: y1, width: w, height:h,
                    htmlText: getTotalSpottedStr(data) } ));

                // damage assisted (radio/tracks)
                view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.ASSIST, x: x + w * 1 - 1, y: y1, width: w, height:h,
                    htmlText: getTotalAssistCountStr(data),
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        value: data.damageAssisted,
                        values: data.damageAssistedRadio + "<br/>" + data.damageAssistedTrack,
                        discript: data.details[0].damageAssistedNames // WG programmer is asshole!
                    } } ));

                // crits
                view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.CRITS, x: x + w * 2 - 2, y: y1, width: w, height:h,
                    htmlText: getTotalCritsCountStr(data),
                    tooltip: { value: getTotalCritsCount(data) } } ));

                // hits/damage
                view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.DAMAGE, x: x + w * 3 - 3, y: y2, width: w, height:h,
                    htmlText: getTotalDamageStr(data) + "<br/>" + getTotalHitsStr(data) + "/" + getTotalPiercedStr(data),
                    tooltip: (data.details == null || data.details.length == 0) ? null : {
                        values: data.damageDealt + "<br/>" + data.pierced,
                        discript: data.details[0].damageDealtNames
                    } } ));

                // kills
                view.addChild(createTotalsTextField( { name: EfficiencyIconRenderer.KILL, x: x + w * 4 - 4, y: y1, width: w, height:h,
                    htmlText: getTotalKillsStr(data),
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

        private function getTotalSpottedStr(data:Object):String
        {
            return "<font color='#408CCF'>" + getTotalSpotted(data).toString() + "</font>"
        }

        private function getTotalAssistCountStr(data:Object):String
        {
            var n:int = 0;
            for each (var obj:Object in data.details)
            {
                if (obj["damageAssistedRadio"] != 0 || obj["damageAssistedTrack"] != 0)
                    n++;
            }
            return "<font color='#97EA14'>" + n.toString() + "</font>"
        }

        private function getTotalCritsCount(data:Object):Number
        {
            return calcDetails(data, "critsCount")
        }

        private function getTotalCritsCountStr(data:Object):String
        {
            return "<font color='#FF0000'>" + getTotalCritsCount(data).toString() + "</font>"
        }

        private function getTotalHitsStr(data:Object):String
        {
            return "<font color='#D85600'>" + data.hits + "</font>"
        }

        private function getTotalPiercedStr(data:Object):String
        {
            return "<font color='#D85600'>" + data.pierced + "</font>"
        }

        private function getTotalDamageStr(data:Object):String
        {
            return "<font color='#D85600'>" + data.damageDealt + "</font>"
        }

        private function getTotalKillsStr(data:Object):String
        {
            return "<font color='#FF0000'>" + data.kills + "</font>"
        }

        private function createTotalsTextField(params:Object = null):TextField
        {
            var tf:TextField = new TextField();
            //tf.border = true; tf.borderColor = 0xFFFFFF;
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.selectable = false;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.styleSheet = Utils.createTextStyleSheet("txt", new TextFormat("$FieldFont", 12, Defines.UICOLOR_LABEL));
            if (params != null)
            {
                for (var name:* in params)
                {
                    if (name == "htmlText")
                        tf[name] = "<textformat leading='-3'><p class='txt' align='center'>" + params[name] + "</p></textformat>";
                    else if (name == "tooltip")
                        tooltips[params["name"] || tf.name] = params[name];
                    else
                        tf[name] = params[name];
                }
            }
            tf.addEventListener(MouseEvent.ROLL_OVER, onOver);
            tf.addEventListener(MouseEvent.ROLL_OUT, onOut);
            return tf;
        }

        private function onOver(e:MouseEvent):void
        {
            var data:Object = {
                "type":e.currentTarget.name,
                "disabled":false
            }
            var tooltip:* = tooltips[e.currentTarget.name];
            if (tooltip != null && !(tooltip is String))
                data = merge(data, tooltip);
            App.toolTipMgr.showSpecial(Tooltips.EFFICIENCY_PARAM,null,e.currentTarget.name,data);
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
