/**
 * Loader for JSONx format (JSON with references)
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.io
{
    import com.xvm.*;
    import com.xvm.io.*;
    import flash.utils.*;

    public class JSONxLoader
    {
        public static function Load(filename:String):Object
        {
            try
            {
                //Logger.add("LoadAndParse: " + filename);
                return (new JSONxLoader(filename))._Load();
            }
            catch (ex:Error)
            {
                return ex;
            }
            return null;
        }

        // PRIVATE

        private var rootFileName:String;
        private var file_cache:Dictionary;
        private var obj_cache:Dictionary;

        public function JSONxLoader(rootFileName:String)
        {
            this.rootFileName = rootFileName;
            this.file_cache = new Dictionary();
            this.obj_cache = new Dictionary();
        }

        //private var rootFileName:Object;
        private var pendingFiles:Vector.<String>;

        private function _Load():*
        {
            var rootObj:Object = {$ref: { file: rootFileName, path: "." }};
            pendingFiles = Vector.<String>([ rootFileName ]);

            while (pendingFiles.length > 0)
            {
                //Logger.addObject(pendingFiles);
                pendingFiles.forEach(function(filename:String):void
                {
                    Logger.add("LoadFile: " + filename.replace(Defines.XVM_DIR_NAME, ''));
                    var data:String = Xvm.cmd(Defines.XPM_COMMAND_LOADFILE, filename);
                    if (data == null)
                        throw new JSONxError(filename == rootFileName ? "NO_FILE" : "NO_REF_FILE", "file is missing: " + filename);
                    file_cache[filename] = data;
                });
                pendingFiles = new Vector.<String>();
                rootObj = Deref(rootObj);
            }

            return rootObj;
        }

        private function Deref(data:Object, level:int = 0, file:String = null, obj_path:String = null):Object
        {
            // limit of recursion
            if (level > 32)
                return data;

            if (data == null)
                return null;

            // scalar
            if (data is String || data is Number || data is Boolean)
                return data;

            if (!obj_path)
                obj_path = "";

            // array
            if (data is Array) // array
            {
                var len:int = data.length;
                for (var i:int = 0; i < len; ++i)
                    data[i] = Deref(data[i], level + 1, file, obj_path + "[" + i + "]");
                return data;
            }

            // object
            if (data.$ref === undefined)
            {
                for (var n:String in data)
                    data[n] = Deref(data[n], level + 1, file, (obj_path == "" ? "" : obj_path + ".") + n);
                return data;
            }

            // reference
            //   "$ref": { "file": "...", "line": "..." }

            if (data.$ref.$ref != null)
                throw new JSONxError("BAD_REF", "endless reference recursion in " + file + ", " + obj_path);

            var fn:String = data.$ref.abs_path;
            if (!fn)
            {
                var d:Object = splitDir(file || "");
                fn = (d.d + (data.$ref.file || d.f));
            }

            if (file_cache[fn] === undefined)
            {
                data.$ref.abs_path = fn;
                var found:Boolean = false;
                var len2:int = pendingFiles.length;
                for (var j:int = 0; j < len2; ++j)
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
                try
                {
                    if (obj_cache[fn] === undefined)
                        obj_cache[fn] = JSONx.parse(file_cache[fn]);
                    if (obj_cache[fn] == null)
                        throw new JSONxError("PARSE_ERROR", "error parsing file: " + fn);
                    var value:* = getValue(obj_cache[fn], data.$ref.path);
                    if (value === undefined)
                        throw new JSONxError("BAD_REF", "bad reference:\n    ${\"" + data.$ref.file + "\":\"" + data.$ref.path + "\"}");

                    // override referenced values
                    //   "damageText": {
                    //     "$ref": { "path":"def.damageText" },
                    //     "damageMessage": "all {{dmg}}"
                    //    }

                    for (var n2:String in data)
                    {
                        if (n2 != "$ref")
                            value[n2] = data[n2];
                    }

                    // deref result
                    data = Deref(value, level + 1, fn, obj_path);
                }
                catch (ex:JSONxError)
                {
                    ex.filename = fn;
                    throw ex;
                }
            }

            return data;
        }

        private function getValue(obj:*, path: String):*
        {
            if (obj === undefined)
                return undefined;

            if (path == "." || path == "")
                return obj;

            var p: Array = path.split("."); // "path.to.value"
            var o:* = obj;
            var p_len:Number = p.length;
            for (var i:Number = 0; i < p_len; ++i)
            {
                var opi:* = o[p[i]];
                if (opi === undefined)
                    return undefined;
                o = opi;
            }
            return o == null ? null : clone(o);
        }

        private function clone(obj:Object):Object
        {
            return JSONx.parse(JSONx.stringify(obj, "", true));
        }

        private function splitDir(path:String):Object
        {
            var fileArray:Vector.<String> = Vector.<String> (path.split("\\").join("/").split("/"));
            return {
                f: fileArray.pop(),
                d: fileArray.length > 0 ? fileArray.join("/") + "/" : ""
            };
        }
    }
}
