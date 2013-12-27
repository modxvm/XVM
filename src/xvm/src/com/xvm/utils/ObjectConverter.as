/**
 * Generic Object to Class Instance Converter
 * url http://sinnus.blogspot.com/2012/01/how-to-create-typed-as3-objects-from.html
 * source https://gist.github.com/sinnus/1556693
 * enhanced and ported to Scaleform 29.08.2013 by Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.utils
{
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;
    import com.xvm.Logger;

    public class ObjectConverter
    {
        private static var _simpleTypes: Array = [Boolean, Number, String];

        private static function populateArray(data: Array, clazz: Class): Array
        {
            var result: Array = new Array(data.length);
            for (var i: int =0; i< data.length; i++) {
                result[i] = createData(data[i], clazz);
            }
            return result;
        }


        private static function createData(rawData:Object, clazz:Class):*
        {
            if (clazz == Object)
                return rawData;

            if (rawData == null)
            {
                if (typeof(clazz) == typeof(Number))
                    return NaN;
                return null;
            }

            if (rawData is clazz)
                return rawData;

            if (_simpleTypes.indexOf(clazz) > -1)
                return rawData;

            var result:Object = new clazz();
            var describeTypeXML:XML = describeType(clazz);
            var isDynamic:Boolean = describeTypeXML..type.@isDynamic;
            var variables:XMLList = describeTypeXML..variable;
            var accessors:XMLList = describeTypeXML..accessor;
            for (var nm:String in rawData)
            {
                var a:XML = null;
                for each (var accessor:XML in accessors)
                {
                    if (accessor.@name == nm)
                    {
                        v = accessor;
                        break;
                    }
                }
                var v:XML = null;
                for each (var variable:XML in variables)
                {
                    if (variable.@name == nm)
                    {
                        v = variable;
                        break;
                    }
                }
                if (a != null && a.@access != "readwrite")
                    continue;

                if (a == null && v == null)
                {
                    if (isDynamic)
                    {
                        result[nm] = rawData[nm];
                    }
                }
                else
                {
                    processVar(a || v, rawData, result);
                }
            }
            return result;
        }

        private static function processVar(variable:XML, rawData:Object, result:Object):void
        {
            if (variable.@type == "Array") {
                var array: Array = rawData[variable.@name];
                if (array) {
                    var metaType: Class = Object;
                    for each (var metadata: XML in variable..metadata) {
                        if (metadata.@name == "ArrayElementType") {
                            metaType = getDefinitionByName(metadata..arg.@value) as Class;
                            break;
                        }
                    }
                    result[variable.@name] = populateArray(array, metaType);
                }
            } else {
                result[variable.@name] = createData(rawData[variable.@name], getDefinitionByName(variable.@type) as Class)
            }
        }

        public static function convertData(rawData: Object, clazz: Class): *
        {
            if (rawData === null) {
                return null;
            }
            if (describeType(rawData).@name == "Array") {
                return populateArray(rawData as Array, clazz);
            } else {
                return createData(rawData, clazz);
            }
        }

        /*public static function toRawData(object: *): Object {
            if (object === null) {
                return null;
            }
            for each (var clazz : Class in _simpleTypes) {
                if (object is clazz) {
                    return object;
                }
            }
            if (object is Array) {
                var arrayResult: Array = [];
                for each (var item: Object in object) {
                    arrayResult.push(toRawData(item));
                }
                return arrayResult;
            }
            var result: Object = {};
            var classInfo: Object = ObjectUtil.getClassInfo(object);
            for each (var p: String in classInfo.properties) {
                result[p] = toRawData(object[p]);
            }
            return result;
        }*/
    }
}
