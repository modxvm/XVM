/**
 * Loader for JSONx format (JSON with references)
 * @author sirmax2
 */
import com.xvm.JSONx;
import com.xvm.Logger;

class com.xvm.JSONxLoader
{
    private var rootPath:Object;
    private var rootFileName:Object;
    private var target:Object;
    private var callback:Function;
    
    private var file_cache = { };
    private var obj_cache = { };
    private var pendingFiles:Array = [ ];
    
    private var rootObj:Object;
    
    public static function LoadAndParse(filename:String, target:Object, callback:Function)
    {
        var jl:JSONxLoader = new JSONxLoader(filename, target, callback);
        jl.LoadFiles();
    }

    public function JSONxLoader(rootFileName:String, target:Object, callback:Function)
    {
        var a:Array = rootFileName.split("\\").join("/").split("/");
        this.rootFileName = a.pop();
        this.rootPath = a.length > 0 ? a.join("/") + "/" : "";
        this.target = target;
        this.callback = callback;
        this.pendingFiles = [ this.rootFileName ];
        this.rootObj = {$ref: { file: this.rootFileName, path: "." }};
    }

    private var loadingCount:Number;
    private function LoadFiles():Void
    {
        Logger.add("LoadFiles: ['" + pendingFiles.join("', '") + "']");
        loadingCount = pendingFiles.length;
        for (var i:Number = 0; i < loadingCount; ++i)
            LoadFile(pendingFiles[i]);
        pendingFiles = [ ];
    }

    private function LoadFile(filename:String)
    {
        var me:JSONxLoader = this;
        var lv:LoadVars = new LoadVars();
        lv.onData = function(str:String) {
            //Logger.add("onData: " + filename);
            me.file_cache[filename] = str;
            if (!--me.loadingCount)
                me.LoadFileCallback.call(me);
        }
        //Logger.add("lv.load: " + rootPath + filename);
        lv.load(rootPath + filename);
    }
    
    private function LoadFileCallback()
    {
        //Logger.add("LoadFileCallback");
        try
        {
            //Logger.addObject(rootObj, "rootObj", 2);
            //Logger.addObject(rootObj.markers.ally.alive.normal, "marker", 10);
            rootObj = Deref(rootObj);
            //Logger.addObject(pendingFiles, "pendingFiles", 2);
            if (pendingFiles.length > 0)
                LoadFiles();
            else
            {
                //Logger.addObject(rootObj, "config", 10);
                //Logger.addObject(rootObj.markers.ally.alive.normal, "marker", 10);
                callback.call(target, { data:rootObj, filename:rootFileName } );
            }
        }
        catch (ex)
        {
            callback.call(target, ex);
        }
    }

    private function Deref(data:Object, level:Number, file:String)
    {
        //Logger.addObject(data, "Deref", 2);
        if (level == null)
            level = 0;

        // limit of recursion
        if (level > 50)
            return data;

        if (data == null)
            return null;

        // scalar
        if (typeof data.toString == 'undefined')
            return data;

        // array
        if (data instanceof Array) // array
        {
            var len = data.length;
            for (var i = 0; i < len; ++i)
                data[i] = Deref(data[i], level + 1, file);
            return data;
        }

        // object
        if (data.$ref == null)
        {
            for (var i in data)
            {
                data[i] = Deref(data[i], level + 1, file);
                //Logger.addObject(data[i], i, 2);
            }
            return data;
        }

        // reference
        //   "$ref": { "file": "...", "line": "..." }

        //Logger.addObject(file, "file", 2);
        //Logger.addObject(data, "Deref[" + level + "]", 2);

        var fn = data.$ref.abs_path;
        if (!fn)
        {
            var d = splitDir(file || "");
            fn = (d.d + (data.$ref.file || d.f));
        }

        //Logger.add("fn: " + fn);

        if (!file_cache.hasOwnProperty(fn))
        {
            //Logger.add("fn: " + fn + " (pending)");
            data.$ref.abs_path = fn;
            var found:Boolean = false;
            var len = pendingFiles.length;
            for (var j = 0; j < len; ++j)
            {
                if (pendingFiles[j] == fn)
                {
                    found = true;
                    break;
                }
            }
            if (!found)
                pendingFiles.push(fn);
        }
        else
        {
            //Logger.add("fn: " + fn + " (loaded)");
            try
            {
                if (!obj_cache.hasOwnProperty(fn))
                    obj_cache[fn] = JSONx.parse(file_cache[fn]);
                if (obj_cache[fn] == null)
                    throw { type: fn == rootFileName ? "NO_FILE" : "NO_REF_FILE", message: "file is missing: " + fn };
                var value = getValue(obj_cache[fn], data.$ref.path);
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
                data = Deref(value, level + 1, fn);
                //Logger.addObject(data);
            }
            catch (ex)
            {
                throw ex.error ? ex : { error: ex, filename: fn };
            }
        }

        return data;
    }

    private function getValue(obj:Object, path: String)
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
    
    private function clone(obj:Object):Object
    {
        return JSONx.parse(JSONx.stringify(obj, "", true));
    }

    private function splitDir(path:String):Object
    {
        var fileArray:Array = path.split("\\").join("/").split("/");
        return
        {
            f: fileArray.pop(),
            d: fileArray.length > 0 ? fileArray.join("/") + "/" : ""
        }
    }
}
