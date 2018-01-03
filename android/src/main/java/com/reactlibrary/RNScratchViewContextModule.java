package com.reactlibrary;

import android.app.Activity;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;

public class RNScratchViewContextModule extends ReactContextBaseJavaModule {

    public RNScratchViewContextModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "RNScratchViewContextModule";
    }

    public Activity getActivity() {
        return this.getCurrentActivity();
    }
}
