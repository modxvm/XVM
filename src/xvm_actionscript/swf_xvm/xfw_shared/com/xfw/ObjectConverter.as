/**
 * Generic Object to Class Instance Converter
 * url http://sinnus.blogspot.com/2012/01/how-to-create-typed-as3-objects-from.html
 * source https://gist.github.com/sinnus/1556693
 * enhanced and ported to Scaleform 29.08.2013 by Maxim Schedriviy "max(at)modxvm.com"
 */
package com.xfw
{
    import com.xfw.*;
    import flash.utils.*;

    public class ObjectConverter
    {

        /**
         * Convert on object to an instance of the specified class
         * @param rawData source data
         * @param clazz target class
         * @return instance of the target class
         */
        public static function convertData(rawData: Object, clazz: Class): *
        {
            if (rawData === null)
            {
                return null;
            }

            if (describeType(rawData).@name == "Array")
            {
                return populateArray(rawData as Array, clazz);
            }

            return createData(rawData, clazz);
        }

        /**
         * Convert class instance to the raw object
         * @param object class instance
         * @return raw object
         */
        public static function toRawData(object: *): Object
        {
            if (object === null)
            {
                return null;
            }

            if (getQualifiedClassName(object) == "Object")
            {
                return object;
            }

            for each (var clazz:Class in SIMPLE_TYPES)
            {
                if (object is clazz)
                {
                    return object;
                }
            }

            if (object is Array)
            {
                var arrayResult:Array = [];
                for each (var item:Object in object)
                {
                    arrayResult.push(toRawData(item));
                }
                return arrayResult;
            }

            var result:Object = {};
            var describeTypeXML:XML = describeType(object);
            for each (var accessor:XML in describeTypeXML..accessor)
            {
                if (accessor.@access == "readwrite" || accessor.@access == "read")
                {
                    result[accessor.@name] = toRawData(object[accessor.@name])
                }
            }
            for each (var variable:XML in describeTypeXML..variable)
            {
                result[variable.@name] = toRawData(object[variable.@name])
            }
            return result;
        }

        // PRIVATE

        private static const SIMPLE_TYPES: Array = [Boolean, Number, String];

        private static function populateArray(data: Array, clazz: Class): Array
        {
            var result:Array = new Array(data.length);
            var len:int = data.length;
            for (var i:int = 0; i < len; i++) {
                result[i] = createData(data[i], clazz);
            }
            return result;
        }

        //private static function populateVector(data: Array, itemClassName: String): Array
        //{
            //var itemClass:Class = getDefinitionByName(itemClassName) as Class;
            //var vectorClass:Class = getDefinitionByName("__AS3__.vec::Vector.<" + itemClassName + ">") as Class;
            //var result:* = new vectorClass(data.length);
            //for (var i: int = 0; i < data.length; i++) {
                //result[i] = createData(data[i], itemClass);
            //}
            //return result;
        //}

        private static function createData(rawData: Object, clazz: Class): *
        {
            if (clazz == Object)
                return rawData;

            if (rawData == null)
            {
                if (clazz == Number)
                    return NaN;
                return null;
            }

            if (rawData is clazz)
                return rawData;

            if (SIMPLE_TYPES.indexOf(clazz) > -1)
                return rawData;

            var result:Object = new clazz();
            var describeTypeXML:XML = describeType(result);
            var isDynamic:Boolean = describeTypeXML.@isDynamic == "true";
            var variables:XMLList = describeTypeXML.variable;
            var accessors:XMLList = describeTypeXML.accessor;
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
                if (a != null) {
                    if (a.@access != "readwrite")
                        continue;
                }

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

        private static function processVar(variable: XML, rawData: Object, result: Object): void
        {
            if (variable.@type == "Array")
            {
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
            }
            //else if (variable.@type.toString().indexOf("__AS3__.vec::Vector$") == 0)
            //{
                //var array2: Array = rawData[variable.@name];
                //if (array2) {
                    //var itemClassName:String = variable.@type.toString().substr("__AS3__.vec::Vector$".length);
                    //Logger.add(itemClassName);
                    //result[variable.@name] = populateVector(array2, itemClassName);
                    //Logger.addObject(result[variable.@name]);
                //}
            //}
            else if (variable.@type == "Class") // untyped variable: var x:*
            {
                result[variable.@name] = rawData[variable.@name];
            }
            else
            {
                result[variable.@name] = createData(rawData[variable.@name], getDefinitionByName(variable.@type) as Class);
            }
        }
    }
}
