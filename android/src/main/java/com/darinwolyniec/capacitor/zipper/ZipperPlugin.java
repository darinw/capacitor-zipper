package com.darinwolyniec.capacitor.zipper;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Zipper")
public class ZipperPlugin extends Plugin {

    private Zipper implementation = new Zipper();

    @PluginMethod
    public void zip(PluginCall call) {
        implementation.zip(call);
    }

    @PluginMethod
    public void unZip(PluginCall call) {
        implementation.unZip(call);
    }
}
