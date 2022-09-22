/*
 * Copyright (C) 2015 - 2017 Bluebird Inc, All rights reserved.
 *
 * http://www.bluebirdcorp.com/
 *
 * Author : Bogon Jun
 *
 * Date : 2016.01.18
 */

package com.example.prodctivo;

import android.app.LauncherActivity;
import android.content.Context;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import java.util.concurrent.CopyOnWriteArrayList;
import android.app.LauncherActivity.ListItem;

public class TagListAdapter extends BaseAdapter {

    private static final String TAG = TagListAdapter.class.getSimpleName();

    private static final boolean D = false;

    private static final int MAX_LIST_COUNT = 50000;

    private int mListCycleCount = 0;

    private CopyOnWriteArrayList<ListItem> mItemList;

    private CopyOnWriteArrayList<String> mTagList;

    private Context mContext;

    private class ItemHolder {

        public ImageView mImage;

        public TextView mUpText;

        public TextView mDownText;

        public TextView mDupText;
    }

    public TagListAdapter(Context ctx) {
        super();
        if (D) Log.d(TAG, "TagListAdapter");
        mContext = ctx;
        mItemList = new CopyOnWriteArrayList<>();
        mTagList = new CopyOnWriteArrayList<>();
    }

    @Override
    public int getCount() {
        // TODO Auto-generated method stub
        if (D) Log.d(TAG, "getCount");
        return mItemList.size();
    }

    @Override
    public Object getItem(int arg0) {
        // TODO Auto-generated method stub
        if (D) Log.d(TAG, "getItem");
        return mItemList.get(arg0);
    }

    @Override
    public long getItemId(int arg0) {
        // TODO Auto-generated method stub
        if (D) Log.d(TAG, "getItemId");
        return arg0;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        return null;
    }

    public void removeAllItem() {
        if (D) Log.d(TAG, "removeAllItem");
        mItemList.clear();
        mTagList.clear();
        mListCycleCount = 0;
        notifyDataSetChanged();
    }

    public int getTotalCount() {
        if (D) Log.d(TAG, "getTotalCount");
        return (mListCycleCount * MAX_LIST_COUNT) + mItemList.size();
    }
}