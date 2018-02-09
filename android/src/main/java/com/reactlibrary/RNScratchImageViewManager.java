package com.reactlibrary;

import android.content.Context;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import java.util.Map;

public class RNScratchImageViewManager extends SimpleViewManager<RNScrathViewMain> {

    public static final String REACT_CLASS = "RNScratchImageView";
    public static final String ON_REVEAL_PERCENT_CHANGED = "ON_REVEAL_PERCENT_CHANGED";
    public static final String ON_REVEALED = "ON_REVEALED";
    private Context _context;

    @Override
    public String getName() {
        return REACT_CLASS;
    }

   @Override
    public RNScrathViewMain createViewInstance(ThemedReactContext context) {
        this._context = context;

       return new RNScrathViewMain(_context);
    }

    @ReactProp(name = "revealPercent")
    public void setRevealPercent(final RNScrathViewMain view, float value) {
        if (view != null) {
            view.setRevealPercent(value);
        }
    }

    @ReactProp(name = "strokeWidth")
    public void setStrokeWidth(final RNScrathViewMain view, int value) {
        if (view != null) {
            view.setRevealSize(value * 4);
        }
    }

    @ReactProp(name = "imageScratched")
    public void setImageScratched(final RNScrathViewMain view, final ReadableMap value) {
        if (view != null) {
            view.setImageScratched(value.getString("uri"));
        }
    }

    @ReactProp(name = "imagePattern")
    public void setImagePattern(final RNScrathViewMain view, final ReadableMap value) {
        if (view != null) {
            view.setImagePattern(value.getString(("uri")));
        }
    }

   public Map getExportedCustomBubblingEventTypeConstants() {
        return MapBuilder.builder()
                .put(ON_REVEAL_PERCENT_CHANGED, MapBuilder.of("phasedRegistrationNames", MapBuilder.of("bubbled", "onRevealPercentChanged")))
                .put(ON_REVEALED, MapBuilder.of("phasedRegistrationNames", MapBuilder.of("bubbled", "onRevealed")))
                .build();
    }
}
