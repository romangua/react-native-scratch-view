package com.reactlibrary;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.Nullable;
import android.util.Log;
import com.cooltechworks.views.ScratchImageView;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.squareup.picasso.Picasso;

import java.util.Map;


public class RNScratchImageViewManager extends SimpleViewManager<ScratchImageView> {

    public static final String REACT_CLASS = "RNScratchImageView";
    private static final String ON_REVEAL_PERCENT_CHANGED = "ON_REVEAL_PERCENT_CHANGED";
    private static final String ON_REVEALED = "ON_REVEALED";
    private Context _context;

    @Override
    public String getName() {
        return REACT_CLASS;
    }

   @Override
    public ScratchImageView createViewInstance(ThemedReactContext context) {
        this._context = context;
        ScratchImageView scratchImageView = new ScratchImageView(_context);
        scratchImageView.setBackgroundColor(Color.WHITE);
        scratchImageView.setImageResource(R.drawable.homer);

        return scratchImageView;
    }

    @ReactProp(name = "strokeWidth")
    public void setStrokeWidth(ScratchImageView view, int value) {
        view.setStrokeWidth(value);
    }

    @ReactProp(name = "imageScratched")
    public void setImageScratched(ScratchImageView view, ReadableMap value) {

        Picasso.with(_context)
                .load("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1GzFEIXWOydx7khmtlP2_L-geboBoduazwhqO0h2eL856Pdd9")
               // .resize(50, 50)
                .centerCrop()
                .into(view);
    }

    @ReactProp(name = "imagePattern")
    public void setImagePattern(ScratchImageView view, ReadableMap value) {
        // view.setMinimumHeight(value);
        // view.setMaxHeight(value);
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
}
