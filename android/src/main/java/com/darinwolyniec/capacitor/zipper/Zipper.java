package com.darinwolyniec.capacitor.zipper;

import com.getcapacitor.JSObject;
import com.getcapacitor.PluginCall;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.ZipParameters;
import net.lingala.zip4j.progress.ProgressMonitor;
import net.lingala.zip4j.model.FileHeader;

import java.io.File;
import java.util.List;

public class Zipper {

    public void zip(PluginCall call) {
        String source = sanitizePath(call.getString("source", ""));
        String destination = sanitizePath(call.getString("destination", ""));
        String password = call.getString("password", "");
        boolean overwrite = call.getBoolean("overwrite", true);

        try {
            File srcDir = new File(source);
            File destZip = new File(destination);
            if (!srcDir.exists()) {
                call.reject("Source folder does not exist: " + source);
                return;
            }

            if (overwrite && destZip.exists()) {
                destZip.delete();
            }

            ZipFile zipFile = new ZipFile(destZip);
            ZipParameters parameters = new ZipParameters();
            if (!password.isEmpty()) {
                zipFile.setPassword(password.toCharArray());
            }

            zipFile.addFolder(srcDir, parameters);

            JSObject result = new JSObject();
            result.put("completed", true);
            result.put("path", destination);
            call.resolve(result);

        } catch (ZipException e) {
            call.reject("Zip error: " + e.getMessage(), e);
        }
    }

    public void unZip(PluginCall call) {
        String source = sanitizePath(call.getString("source", ""));
        String destination = sanitizePath(call.getString("destination", ""));
        String password = call.getString("password", "");
        boolean overwrite = call.getBoolean("overwrite", true);

        try {
            ZipFile zipFile = new ZipFile(source);
            if (zipFile.isEncrypted()) {
                zipFile.setPassword(password.toCharArray());
            }

            zipFile.extractAll(destination);

            JSObject result = new JSObject();
            result.put("completed", true);
            result.put("path", destination);
            call.resolve(result);

        } catch (ZipException e) {
            call.reject("Unzip error: " + e.getMessage(), e);
        }
    }

    private String sanitizePath(String path) {
        if (path.contains("_capacitor_")) {
            path = path.replace("_capacitor_", "");
        }
        return path.replace("file://", "");
    }
}
