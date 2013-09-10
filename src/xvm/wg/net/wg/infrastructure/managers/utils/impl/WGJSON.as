package net.wg.infrastructure.managers.utils.impl 
{
    import com.adobe.serialization.json.*;
    import net.wg.infrastructure.interfaces.entity.*;
    
    public class WGJSON extends Object implements net.wg.infrastructure.interfaces.entity.ISerializable
    {
        public function WGJSON()
        {
            super();
            return;
        }

        public function encode(arg1:*):String
        {
            return new com.adobe.serialization.json.JSONEncoder(arg1).getString();
        }

        public function decode(arg1:String):Object
        {
            return new com.adobe.serialization.json.JSONDecoder(arg1, true).getValue();
        }
    }
}
