package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.reactlibrary.views.ScratchImageView;

/**
 * Created by dev3 on 1/2/18.
 */

public class RNScratchViewManager extends SimpleViewManager<ScratchImageView> {

    private RNScratchViewContextModule mContextModule;

    public RNScratchViewManager(ReactApplicationContext reactContext) {
        mContextModule = new RNScratchViewContextModule(reactContext);
    }

    @Override
    public String getName() {
        return "RNScratchImageView";
    }

    @Override
    public ScratchImageView createViewInstance(ThemedReactContext context) {
        //return new ScratchImageView(context, mContextModule.getActivity());
        return new ScratchImageView(context);
    }
}
