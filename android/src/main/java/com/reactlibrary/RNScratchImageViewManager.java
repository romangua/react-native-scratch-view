package com.reactlibrary;

import android.graphics.Color;
import android.support.annotation.Nullable;
import android.util.Log;
import com.cooltechworks.views.ScratchImageView;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;

import java.util.Map;


public class RNScratchImageViewManager extends SimpleViewManager<ScratchImageView> {

    public static final String REACT_CLASS = "RNScratchImageView";
    private static final String ON_REVEAL_PERCENT_CHANGED = "ON_REVEAL_PERCENT_CHANGED";
    private static final String ON_REVEALED = "ON_REVEALED";

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

    @ReactProp(name = "strokeWidth")
    public void setStrokeWidth(ScratchImageView view, int value) {
        view.setStrokeWidth(value);
    }

    @ReactProp(name = "src")
    public void setHeight(ScratchImageView view, int value) {
        view.setMinimumHeight(value);
        view.setMaxHeight(value);
    }

   public Map getExportedCustomBubblingEventTypeConstants() {
        return MapBuilder.builder()
                .put(ON_REVEAL_PERCENT_CHANGED, MapBuilder.of("phasedRegistrationNames", MapBuilder.of("bubbled", "onRevealPercentChanged")))
                .put(ON_REVEALED, MapBuilder.of("phasedRegistrationNames", MapBuilder.of("bubbled", "onRevealed")))
                .build();
    }

    @Override
    protected void addEventEmitters(final ThemedReactContext reactContext, final ScratchImageView view) {

        view.setRevealListener(new ScratchImageView.IRevealListener() {
            @Override
            public void onRevealed(com.cooltechworks.views.ScratchImageView scratchImageView) {
                Log.d("llog", "OnReveald fired ");
            }

            @Override
            public void onRevealPercentChangedListener(com.cooltechworks.views.ScratchImageView scratchImageView, float value) {
                // Value between 0-1
                Log.d("llog", "onRevealPercentChanged fired: " + value * 100 + "%");
                if (reactContext != null) {
                    if (value * 100 >= 95f) {
                        WritableMap event = Arguments.createMap();
                        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                                view.getId(),
                                ON_REVEALED,
                                event);
                    } else {

                        WritableMap event = Arguments.createMap();
                        event.putDouble("value", value * 100);
                        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                                view.getId(),
                                ON_REVEAL_PERCENT_CHANGED,
                                event);
                    }
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
