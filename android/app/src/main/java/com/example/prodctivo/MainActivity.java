package com.example.prodctivo;

import android.util.Log;

import androidx.annotation.NonNull;

import com.gg.reader.api.dal.GClient;
import com.gg.reader.api.dal.HandlerTagEpcLog;
import com.gg.reader.api.dal.HandlerTagEpcOver;
import com.gg.reader.api.protocol.gx.EnumG;
import com.gg.reader.api.protocol.gx.LogBaseEpcInfo;
import com.gg.reader.api.protocol.gx.LogBaseEpcOver;
import com.gg.reader.api.protocol.gx.MsgBaseInventoryEpc;
import com.gg.reader.api.protocol.gx.MsgBaseStop;
import com.gg.reader.api.protocol.gx.ParamEpcReadTid;
import com.gg.reader.api.utils.HksPower;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.tagteka.Prodctivo/bluebirdSled";
    GClient client = new GClient();//可自行写成全局单例复用
    boolean isRead = false;
    private List<String> inventory = new ArrayList<>();

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
                            } else if (call.method.equals("scanTags")) {
                                int toRet = scan();
                                result.success(inventory);
//                                else result.error("UNAVAILABLE", "Issue", null);
//                            } else if (call.method.equals("stopScan")) {
//                                int toRet = stopScan();
//                                result.success(toRet);
//                            } else if (call.method.equals("fetchList")) {
//                                result.success(inventory);
//                            } else if (call.method.equals("getConnectionStatus")) {
//                                result.success(getConnectionStatus());
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
    public String disconnectSled() {
        return "";
    }

    private void readEvent() {
        MsgBaseInventoryEpc msg = new MsgBaseInventoryEpc();
        msg.setAntennaEnable(EnumG.AntennaNo_1);
        msg.setInventoryMode(EnumG.InventoryMode_Inventory);

        //匹配某张标签TID读 E280110520007993A8F708A8  可选参数
//        ParamEpcFilter filter = new ParamEpcFilter();
//        String tid = "E280110520007993A8F708A8";
//        filter.setArea(EnumG.ParamFilterArea_TID);//匹配epc -> EnumG.ParamFilterArea_EPC
//        filter.setBitStart(0);//匹配epc -> 32
//        filter.setHexData(tid);
//        filter.setBitLength(tid.length() * 4);
//        msg.setFilter(filter);

//        读TID 默认只读EPC 可选参数
        ParamEpcReadTid readTid = new ParamEpcReadTid();
        readTid.setMode(EnumG.ParamTidMode_Auto);
        readTid.setLen(6);//word

        msg.setReadTid(readTid);

        //读UserData 默认只读EPC 可选参数
//        ParamEpcReadUserdata readUserdata = new ParamEpcReadUserdata();
//        readUserdata.setStart(0);
//        readUserdata.setLen(1);//word
//        msg.setReadUserdata(readUserdata);

        //读保留区 可选参数
//        ParamEpcReadReserved readReserved = new ParamEpcReadReserved();
//        readReserved.setStart(0);
//        readReserved.setLen(4);//word
//        msg.setReadReserved(readReserved);

        client.sendSynMsg(msg);
        if (msg.getRtCode() == 0) {
            isRead = true;
            Log.e("MsgBaseInventoryEpc", msg.getRtMsg());
        }
        stopEvent();
    }

    // TODO: 停止读卡
    private void stopEvent() {
        MsgBaseStop msg = new MsgBaseStop();
        client.sendSynMsg(msg);
        if (msg.getRtCode() == 0) {
            isRead = false;
            Log.e("MsgBaseStop", msg.getRtMsg());
        }
    }

    public int scan(){
        if (isRead){
            stopEvent();
            isRead = false;
            return 0;
        }
        else{
            readEvent();
            isRead = true;
            return 1;
        }
    }

    public String connectSled(){
        HksPower.uhf_power(1);
        if (client.openCusAndroidSerial("/dev/ttysWK0:115200", 64, 100)) {
            Log.e("client", "Serial port initialized successfully.");
            subscriberHandler();//订阅上报回调
            return "Successfully Connected.";
        } else {
            Log.e("client", "Serial port initialization was unsuccessful.");
            return "Error.";
        }
    }

    private void subscriberHandler() {
        client.onTagEpcLog = new HandlerTagEpcLog() {
            @Override
            public void log(String s, LogBaseEpcInfo logBaseEpcInfo) {
                // 回调内部如有阻塞，会影响 API 正常使用
                // 标签回调数量较多，请将标签数据先缓存起来再作业务处理
                if (logBaseEpcInfo.getResult() == 0) {
                    Log.e("标签-->", logBaseEpcInfo.getEpc());
                    inventory.add(logBaseEpcInfo.getEpc());
                }
            }
        };
        client.onTagEpcOver = new HandlerTagEpcOver() {
            @Override
            public void log(String s, LogBaseEpcOver logBaseEpcOver) {
                Log.e("HandlerTagEpcOver", "HandlerTagEpcOver");
            }
        };
    }
}
