package com.example.prodctivo;

import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.view.View.OnClickListener;

import androidx.annotation.NonNull;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import co.kr.bluebird.sled.Reader;
import co.kr.bluebird.sled.SDConsts;



public class MainActivity extends FlutterActivity {

    private Reader mReader;
    private Context mContext;
    private final ConnectivityHandler mConnectivityHandler = new ConnectivityHandler(this);
    private final InventoryHandler mInventoryHandler = new InventoryHandler(this);
    private static final String CHANNEL = "com.tagteka.Prodctivo/bluebirdSled";
    private TagListAdapter mAdapter;
    private boolean mInventory = false;
    private List<String> inventory = new ArrayList<>();
    String debugMessage = "Reached1";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("connectSled")) {
                                String toRet = connectSled();
                                if (toRet.equals("Successfully connected.")) result.success(toRet);
                                else result.error("UNAVAILABLE", toRet, null);
                            } else if (call.method.equals("disconnectSled")) {
                                String toRet = disconnectSled();
                                if (toRet.equals("Successfully disconnected."))
                                    result.success(toRet);
                                else result.error("UNAVAILABLE", toRet, null);
                            }else if (call.method.equals("scanTags")){
                                int toRet = scan();
                                result.success(inventory);
//                                else result.error("UNAVAILABLE", "Issue", null);
                            }else if (call.method.equals("stopScan")){
                                int toRet = stopScan();
                                result.success(toRet);
                            }else if (call.method.equals("fetchList")){
                                result.success(inventory);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private String connectSled() {
        int ret = -100;
        mContext = this.getContext();
        boolean openResult = false;
        String retString = "";
        mReader = Reader.getReader(mContext, mConnectivityHandler);
        if (mReader != null) {
            openResult = mReader.SD_Open();
        }
        if (mReader != null && openResult == SDConsts.SD_OPEN_SUCCESS) {
            ret = mReader.SD_Wakeup();
        }
        if (ret == SDConsts.SDResult.SUCCESS) {
            mReader.SD_Connect();
            retString = "Successfully connected.";
        } else {
            retString = "No connection.";
        }

        return retString;
    }

    private String disconnectSled() {
        mContext = this.getContext();
        mReader = Reader.getReader(mContext, mConnectivityHandler);
        String retString = "";
        int ret = -100;
        boolean closeResult = false;
        if (mReader != null) {
            ret = mReader.SD_Disconnect();
            closeResult = mReader.SD_Close();
            retString = closeResult ? "Successfully disconnected." : "Error.";
        } else {
            retString += "No connection.";
        }
        return retString;
    }

    private int scan(){
        mContext = this.getContext();
        mReader = Reader.getReader(mContext, mInventoryHandler);
        mReader.RF_PerformInventory(true, false, false);
        Thread t = new Thread() {
            @Override
            public void run() {
                try {
                    this.sleep(5000);
                    mReader.RF_StopInventory();
                } catch (InterruptedException ex) {
                    ex.printStackTrace();
                }
            }
        };
        t.start();
        // int ret = mReader.RF_PerformInventory(true, false, false);
//        mReader.RF_StopInventory();
        return 0;
    }

    private int stopScan(){
        mContext = this.getContext();
        mReader = Reader.getReader(mContext, mInventoryHandler);
        mReader.RF_StopInventory();
        return 0;
    }

    private List<String> fetchList(){
        return inventory;
    }

    private void clearList(){
        inventory.clear();
    }

    private static class ConnectivityHandler extends Handler {
        private final WeakReference<MainActivity> mExecutor;

        public ConnectivityHandler(MainActivity f) {
            mExecutor = new WeakReference<>(f);
        }

        @Override
        public void handleMessage(Message msg) {
            MainActivity executor = mExecutor.get();
            if (executor != null) {
                executor.handleMessage(msg);
            }
        }
    }

    private static class InventoryHandler extends Handler {
        private final WeakReference<MainActivity> mExecutor;

        public InventoryHandler(MainActivity m) {
            mExecutor = new WeakReference<>(m);
        }

        @Override
        public void handleMessage(Message msg) {
            MainActivity executor = mExecutor.get();
            if (executor != null) {
                executor.handleMessage(msg);
            }
        }
    }


    public void handleMessage(Message m) {
        debugMessage = "id: " + m.what + " arg1: " + m.arg1 + " arg2: " + m.arg2 + " obj " + (String) m.obj;
        switch (m.what) {
            case SDConsts.Msg.SDMsg:
                if (m.arg1 == SDConsts.SDCmdMsg.SLED_WAKEUP) {
                    int ret = mReader.SD_Connect();
                }
                break;
            case SDConsts.Msg.RFMsg:
                switch (m.arg1){
                    case SDConsts.RFCmdMsg.INVENTORY:
                        debugMessage = "reached2";
                        if (m.arg2 == SDConsts.RFResult.SUCCESS) {
                            if (m.obj != null && m.obj instanceof String){
                                String data  = (String) m.obj;
                                if (data != null)
                                    processReadData(data);
                            }
                        }
                }
                break;
        }
    }

    private void processReadData(String data) {
        StringBuilder tagSb = new StringBuilder();
        tagSb.setLength(0);
        String info = "";
        String originalData = data;
        debugMessage = data;
        if (data.contains(";")) {
            //full tag example(with optional value)
            //1) RF_PerformInventory => "3000123456783333444455556666;rssi:-54.8"
            //2) RF_PerformInventoryWithLocating => "3000123456783333444455556666;loc:64"
            int infoTagPoint = data.indexOf(';');
            info = data.substring(infoTagPoint, data.length());
            int infoPoint = info.indexOf(':') + 1;
            info = info.substring(infoPoint, info.length());
            data = data.substring(0, infoTagPoint);
        }
        String ret = "info:" + info + " data: " + data;
        if (inventory.size() == 10){
            inventory.remove(0);
        }
        if (inventory.contains(data))
            return;
        inventory.add(data);
    }
}
