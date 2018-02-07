package com.reactlibrary;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.util.Log;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.reactlibrary.lib.ScratchImageView;
import com.squareup.picasso.Picasso;
import com.squareup.picasso.Target;
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

        return scratchImageView;
    }

    @ReactProp(name = "strokeWidth")
    public void setStrokeWidth(final ScratchImageView view, int value) {
        view.setStrokeWidth(value/2);
    }

    @ReactProp(name = "imageScratched")
    public void setImageScratched(final ScratchImageView view, final ReadableMap value) {
        Log.d("entro", "setImageScratched: " +value.getString("uri"));
        Picasso.with(_context)
                .load(value.getString("uri"))
                .fit()
                .into(view);
    }

    @ReactProp(name = "imagePattern")
    public void setImagePattern(final ScratchImageView view, final ReadableMap value) {
        Picasso.with(_context)
                .load(value.getString("uri"))
                .into(new Target() {
                    @Override
                    public void onBitmapLoaded (Bitmap bitmap, Picasso.LoadedFrom from){
                        Log.d("entro", "onBitmapLoaded: " + value.getString("uri"));
                        if(view != null && bitmap != null) {
                            Log.d("entro","no es null");
                            view.setScratchPattern(bitmap);
                        }
                    }

                    @Override
                    public void onBitmapFailed(Drawable errorDrawable) {
                        Log.d("entro", "onBitmapFailed");
                    }

                    @Override
                    public void onPrepareLoad(Drawable placeHolderDrawable) {
                        Log.d("entro", "onPrepareLoad");
                    }
                });
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
            public void onRevealed(ScratchImageView scratchImageView) {
                Log.d("llog", "OnReveald fired ");
            }

            @Override
            public void onRevealPercentChangedListener(ScratchImageView scratchImageView, float value) {
                if (reactContext != null) {
                    if (value * 100 >= 95f) {
                        WritableMap event = Arguments.createMap();
                        reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
                                view.getId(),
                                ON_REVEALED,
                                event);
                    } else {
                        Log.d("llog", "onRevealPercentChanged fired: " + value * 100 + "%");

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
