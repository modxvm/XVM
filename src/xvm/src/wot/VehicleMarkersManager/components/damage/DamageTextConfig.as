import wot.utils.Logger;

class wot.VehicleMarkersManager.components.damage.DamageTextConfig
{
    private var primaryAttributes:Object;
    private var secondaryAttributes:Object;
    private var dmgReceiverCfg:Object;
    
    public function DamageTextConfig(dmgReceiverCfg:Object, dmgSourceCfg:Object, flag:Number, damageType:String)
    {
        /**
         * Two vars below setup value priority.
         * In normal case damage section at root level of config is primary source of data
         * and multiple damageText sections at markers section are secondary.
         * 
         * getAttributesBySourceAndType - damageText section at root level
         * dmgReceiverCfg - damageText sections at markers section
         */
        Logger.add(" ");
        Logger.add("DamageTextConfig");
        dmgSourceCfg = getAttributesBySourceAndType(dmgSourceCfg, flag, damageType);
        primaryAttributes   = dmgReceiverCfg;
        secondaryAttributes = dmgSourceCfg;
        
        this.dmgReceiverCfg = dmgReceiverCfg;
    }
    
    public function get visible():Boolean
    {
        return dmgReceiverCfg.visible;
    }
    
    public function get shadow():Object
    {
        return dmgReceiverCfg.shadow;
    }
    
    public function get blowupMessage():String
    {
        return dmgReceiverCfg.blowupMessage;
    }
    
    public function get damageMessage():String
    {
        return String(merge(primaryAttributes.damageMessage, secondaryAttributes.damageMessage));
    }
    
    public function get textColor():Number
    {
        return Number(merge(primaryAttributes.color, secondaryAttributes.color));
    }
    
    public function get speed():Number
    {
        return Number(merge(primaryAttributes.speed, secondaryAttributes.speed));
    }
    
    public function get maxRange():Number
    {
        return Number(merge(primaryAttributes.maxRange, secondaryAttributes.maxRange));
    }
    
    public function get shadowColor():Number
    { 
        return Number(merge(primaryAttributes.shadow.color, secondaryAttributes.shadow.color));
    }
    
    public function get font():Object
    {
        var font = new Object;
        font.name   = fontName;
        font.size   = fontSize;
        font.align  = "center";
        font.bold   = fontBold;
        font.italic = fontItalic;
        return font;
    }
    
    // PRIVATE METHODS
    
    private function merge(primVal:Object, secVal:Object):Object
    {
        Logger.add("");
        Logger.add("  merge prim: " + primVal + " sec: " + secVal);
        if (primVal == "" || primVal == null)
        {
            Logger.add("  ret sec: " + secVal);
            return secVal;
        }
        else
        {
            Logger.add("  ret prim: " + primVal);
            return primVal;
        }
    }
    
    // font section start
    
    private function get fontName():String
    {
        return String(merge(primaryAttributes.font.name, secondaryAttributes.font.name));
    }
    
    private function get fontSize():Number
    {
        return Number(merge(primaryAttributes.font.size, secondaryAttributes.font.size));
    }
  
    private function get fontBold():Boolean
    {
        return Boolean(merge(primaryAttributes.font.bold, secondaryAttributes.font.bold));
    }
        
    private function get fontItalic():Boolean
    {
        return Boolean(merge(primaryAttributes.font.italic, secondaryAttributes.font.italic));
    }
    
    // font section end
    
    private function getAttributesBySourceAndType(dmgSourceCfg:Object, flag:Number, damageType:String):Object
    {
        /**
         *  Comment is actual for 0.8.0.
         *  Other possible damage types passed by WoT client to XVM.as:updateHealth() are:
         *  "drowning"   - Unused. "attack" type is used when subject drowned.
         *  "death_zone" - Unused. No idea what type this is.
         *  "explosion"  - Unused. This is neither ammunition explosion nor artillery splash.
         */
        var damageTypeNodeContent:Object;
        switch (damageType)
        {
            case "attack":
            {
                damageTypeNodeContent = dmgSourceCfg.attack;
                break;
            }
            case "fire":
            {
                damageTypeNodeContent = dmgSourceCfg.fire;
                break;
            }
            case "ramming":
            {
                damageTypeNodeContent = dmgSourceCfg.ramming;
                break;
            }
            case "world_collision":
            {
                damageTypeNodeContent = dmgSourceCfg.world_collision;
                break;
            }
            default:
            {
                // generalize all other types
                flag = 0; // only one line at "other" type
                damageTypeNodeContent = dmgSourceCfg.other;
            }
        }
        return damageTypeNodeContent[flag];
    }
}