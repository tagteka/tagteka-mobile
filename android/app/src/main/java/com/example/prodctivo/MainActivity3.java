//package com.example.prodctivo;
//
//import android.annotation.SuppressLint;
//import android.app.AlertDialog;
//import android.content.BroadcastReceiver;
//import android.content.Context;
//import android.content.DialogInterface;
//import android.content.Intent;
//import android.content.IntentFilter;
//import android.media.AudioManager;
//import android.media.SoundPool;
//import android.os.Bundle;
//import android.os.Environment;
//import android.os.Handler;
//import android.os.Message;
//import android.os.SystemClock;
//import android.util.Log;
//import android.view.KeyEvent;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.widget.AdapterView;
//import android.widget.Button;
//import android.widget.ImageView;
//import android.widget.LinearLayout;
//import android.widget.ListView;
//import android.widget.TextView;
//import android.widget.Toast;
//import android.widget.ToggleButton;
//
//import androidx.annotation.NonNull;
//import androidx.annotation.Nullable;
//
//import com.speedata.libuhf.IUHFService;
//import com.speedata.libuhf.UHFManager;
//import com.speedata.libuhf.bean.SpdInventoryData;
//import com.speedata.libuhf.interfaces.OnSpdInventoryListener;
//import com.speedata.libuhf.utils.CommonUtils;
//import com.speedata.libuhf.utils.ErrorStatus;
//import com.speedata.libuhf.utils.SharedXmlUtil;
////import com.speedata.uhf.adapter.UhfCardAdapter;
////import com.speedata.uhf.adapter.UhfCardBean;
////import com.speedata.uhf.dialog.DefaultSettingDialog;
////import com.speedata.uhf.excel.EPCBean;
////import com.speedata.uhf.floatball.FloatWarnManager;
////import com.speedata.uhf.libutils.ToastUtil;
////import com.speedata.uhf.libutils.excel.ExcelUtils;
////import com.yhao.floatwindow.FloatWindow;
//
//import java.io.BufferedWriter;
//import java.io.File;
//import java.io.FileWriter;
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.Locale;
//import java.util.Objects;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.MethodChannel;
//import io.flutter.plugins.GeneratedPluginRegistrant;
//import jxl.write.Colour;
//
///**
// * 主界面
// * The home page
// *
// * @author zzc
// */
//
//public class MainActivity3 extends FlutterActivity {
//
//    private List<String> data = new ArrayList<>();
//    private static final String CHANNEL = "com.tagteka.Prodctivo/bluebirdSled";
//    private IUHFService iuhfService;
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//        GeneratedPluginRegistrant.registerWith(flutterEngine);
//        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
//                .setMethodCallHandler(
//                        (call, result) -> {
//                            if (call.method.equals("connectSled")) {
//                                String toRet = connectSled();
//                                if (toRet.equals("Successfully connected.")) result.success(toRet);
//                                else result.error("UNAVAILABLE", toRet, null);
////                            } else if (call.method.equals("disconnectSled")) {
////                                String toRet = disconnectSled();
////                                if (toRet.equals("Successfully disconnected."))
////                                    result.success(toRet);
////                                else result.error("UNAVAILABLE", toRet, null);
//                            }else if (call.method.equals("scanTags")){
//                                String toRet = scanTags();
//                                result.success(data);
////                                else result.error("UNAVAILABLE", "Issue", null);
//                            }else if (call.method.equals("stopScan")){
////                                int toRet = stopScan();
////                                result.success(toRet);
////                            }else if (call.method.equals("fetchList")){
////                                result.success(inventory);
////                            }
////                            else if (call.method.equals("getConnectionStatus")){
////                                result.success(getConnectionStatus());
////                            }
//                            }
//                            else{
//                                result.notImplemented();
//                            }
//                        }
//                );
//    }
//
//    public String connectSled(){
//        int x = initUhf();
////        int y = initReceive();
//        return x == 0 ? "Successfully connected." : "Error";
//    }
//
////    private boolean spdEquality(SpdInventoryData var1, SpdInventoryData var2){
////        if (var1.getEpc() == var2.getEpc() && var1.getTid() == var2.getTid()) return true;
////        return false;
////    }
//
//    private boolean scanning = false;
//
//    public String scanTags(){
//        this.iuhfService.setOnInventoryListener(new OnSpdInventoryListener() {
//            @Override
//            public void getInventoryData(SpdInventoryData var1) {
//                String epcCard = var1.getEpc();
//                boolean match = false;
//                for (String s : data){
//                   if(s.equals(epcCard)) match = true;
//                }
//                if (!match) data.add(epcCard);
//            }
//            @Override
//            public void onInventoryStatus(int i) {
//                System.out.println(i);
//            }});
//        if (!scanning){
//            iuhfService.inventoryStart();
//            scanning = true;
//        }
//        else {
//            iuhfService.inventoryStop();
//            scanning = false;
//        }
//        return "Success.";
//    }
//
//    private TextView mEtSearch;
//    private AlertDialog alertDialog1;
//    private Button mFindBtn;
//    private LinearLayout mLlFind, mLlListBg, mLlPause;
//    private ListView mListViewCard;
//    private TextView mTvListMsg;
//    private ToggleButton mTbtnSound;
//    private TextView tagNumTv;
//    private TextView speedTv;
//    private TextView totalTime;
//    private TextView mVersionTv;
//    private Button btnExport;
//    private Button mBtSearch;
//    private ImageView mIvSet;
//    private ImageView mIvMenu;
//
//    private UhfCardAdapter uhfCardAdapter;
//    private List<UhfCardBean> uhfCardBeanList = new ArrayList<UhfCardBean>();
//
//    private boolean inSearch = false;
//    private SoundPool soundPool;
//    private int soundId;
//    private String model;
//    private long mkeyTime = 0;
//    private long scant = 0;
//    private long startCheckingTime;
//    private static final String CHARGING_PATH = "/sys/class/misc/bq25601/regdump/";
//    private File file;
//    private BufferedWriter writer;
//    private int jishu = 0;
//
//    public static final String START_SCAN = "com.spd.action.start_uhf";
//    public static final String STOP_SCAN = "com.spd.action.stop_uhf";
////    private BroadcastReceiver receiver = new BroadcastReceiver() {
////        @Override
////        public void onReceive(Context context, Intent intent) {
////
////            if (!MyApp.isOpenServer) {
////                String action = intent.getAction();
////                switch (Objects.requireNonNull(action)) {
////                    case START_SCAN:
////                        //启动超高频扫描 Start uhf scan
////                        if (inSearch) {
////                            return;
////                        }
////                        startUhf();
////                        break;
////                    case STOP_SCAN:
////                        if (inSearch) {
////                            stopUhf();
////                        }
////                        break;
////                    default:
////                        break;
////                }
////            }
////        }
////    };
//
//    public int initUhf(){
//        this.iuhfService = UHFManager.getUHFService(this);
//        return iuhfService.openDev();
//    }
//
//    /**
//     * 注册广播
//     * Registered broadcasting
//     */
////    private void initReceive() {
////        IntentFilter filter = new IntentFilter();
////        filter.addAction(START_SCAN);
////        filter.addAction(STOP_SCAN);
////        registerReceiver(receiver, filter);
////    }
////}
//}