package com.reactlibrary;

import android.graphics.Color;
import android.support.annotation.Nullable;
import android.util.Log;

import com.cooltechworks.views.ScratchImageView;
import com.facebook.infer.annotation.Assertions;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.UIManagerModule;
import com.facebook.react.uimanager.events.EventDispatcher;
import com.facebook.react.uimanager.events.RCTEventEmitter;

import java.util.Map;

import static java.security.AccessController.getContext;


public class RNScratchImageViewManager extends SimpleViewManager<ScratchImageView> {

    public static final String REACT_CLASS = "RNScratchImageView";
    public static final int ON_REVEAL = 1;

    @Override
    public String getName() {
        return REACT_CLASS;
    }

   @Override
    public ScratchImageView createViewInstance(ThemedReactContext context) {
        ScratchImageView scratchImageView = new ScratchImageView(context);
        scratchImageView.setBackgroundColor(Color.WHITE);
        scratchImageView.setImageResource(R.drawable.homer);

        return scratchImageView;
    }

    @Override
    protected void addEventEmitters(final ThemedReactContext reactContext, final ScratchImageView view) {

        view.setRevealListener(new ScratchImageView.IRevealListener() {
            @Override
            public void onRevealed(com.cooltechworks.views.ScratchImageView scratchImageView) {
                Log.d("llog", "OnReveal fired ");
            }

            @Override
            public void onRevealPercentChangedListener(com.cooltechworks.views.ScratchImageView scratchImageView, float value) {
                // Value between 0-1
                Log.d("llog", "onRevealPercentChanged fired: " + value*100 + "%");
                if(reactContext!=null){
                    Log.d("llog", "entrooo fired: " + value*100 + "%");
                    WritableMap event = Arguments.createMap();

                    event.putDouble("percent", value*100);
                    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                            view.getId(),
                            "onRevealPercentChanged",
                            event);
                }
            }
        });
    }

  /*  @Override
    public Map<String,Integer> getCommandsMap() {
        Log.d("React"," View manager getCommandsMap:");
        return MapBuilder.of(
                "onRevealPercentChanged",
                ON_REVEAL);
    }

    @Override
    public void receiveCommand(ScratchImageView view, int commandType, @Nullable ReadableArray args) {
        Assertions.assertNotNull(view);
        Assertions.assertNotNull(args);
        switch (commandType) {
            case ON_REVEAL: {
                Log.d("onReveal", "AWSD");
                return;
            }

            default:
                throw new IllegalArgumentException(String.format(
                        "Unsupported command %d received by %s.",
                        commandType,
                        getClass().getSimpleName()));
        }
    }*/
}
