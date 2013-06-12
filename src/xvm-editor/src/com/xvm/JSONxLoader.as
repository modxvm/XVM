/**
 * Loader for JSONx format (JSON with references)
 * @author sirmax2
 */

package com.xvm
{

import com.xvm.JSONx;

public class JSONxLoader
{
    public static function Deref(data:Object, level:int, file:Object, cache:Object)
    {
        //Logger.addObject(data, "Deref", 2);

        // limit of recursion
        if (level > 50)
            return data;

        if (data == null)
            return null;

        // scalar
        if (typeof data.toString == 'undefined')
            return data;

		if (typeof data == 'string')
			return data;
		
        // array
        if (data instanceof Array) // array
        {
            var len = data.length;
            for (var i = 0; i < len; ++i)
                data[i] = Deref(data[i], level + 1, file, cache);
            return data;
        }

        // object
        if (data.$ref == null)
        {
            for (var i in data)
            {
                data[i] = Deref(data[i], level + 1, file, cache);
                //Logger.addObject(data[i], i, 2);
            }
            return data;
        }

        // reference
        //   "$ref": { "file": "...", "line": "..." }

        //Logger.addObject(data, "Deref[" + level + "]", 2);

        var dirName = file.d || "";
        var fileName = file.f || "";
        var fn = dirName + (data.$ref.file || fileName);
        var fileArray:Array = fn.split("\\").join("/").split("/");
        fileName = fileArray.pop();
        dirName = fileArray.length > 0 ? fileArray.join("/") + "/" : "";

        //Logger.add("fn: " + fn);

		try
		{
            if (cache[fn] == null)
                throw { type: "NO_FILE", message: "file is missing: " + fn };
            var value = getValue(cache[fn], data.$ref.path);
            //Logger.add(data.$ref.path + ": " + String(value));
            if (value === undefined)
                throw { type: "BAD_REF", message: "bad reference:\n    ${\"" + data.$ref.file + "\":\"" + data.$ref.path + "\"}" };

            // override referenced values
            //   "damageText": {
            //     "$ref": { "path":"def.damageText" },
            //     "damageMessage": "all {{dmg}}"
            //    }

            for (var i in data)
            {
                if (i != "$ref")
                    value[i] = data[i];
            }

            // deref result
            data = Deref(value, level + 1, { d:dirName, f:fileName }, cache );
            //Logger.addObject(data);
        }
        catch (ex)
        {
            throw ex.error ? ex : { error: ex, filename: fn };
        }

        return data;
    }

    private static function getValue(obj:Object, path: String)
    {
        //Logger.add("getValue: " + path);

        if (obj === undefined)
            return undefined;

        if (path == "." || path == "")
            return obj;

        var p: Array = path.split("."); // "path.to.value"
        var o = obj;
        var p_len:Number = p.length;
        for (var i:Number = 0; i < p_len; ++i)
        {
            if (!o.hasOwnProperty(p[i]))
                return undefined;
            o = o[p[i]];
        }
        return o == null ? null : clone(o);
    }

    private static function clone(obj:Object):Object
    {
        return JSONx.parse(JSONx.stringify(obj, "", true));
    }
}

}
