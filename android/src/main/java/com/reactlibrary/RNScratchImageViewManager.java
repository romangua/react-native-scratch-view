package com.reactlibrary;

import android.graphics.Color;
import com.cooltechworks.views.ScratchImageView;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;


public class RNScratchImageViewManager extends SimpleViewManager<ScratchImageView> {

    public static final String REACT_CLASS = "RNScratchImageView";

    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    public ScratchImageView createViewInstance(ThemedReactContext context) {
        ScratchImageView scratchImageView = new ScratchImageView(context);
        scratchImageView.setBackgroundColor(Color.WHITE);
        scratchImageView.setImageResource(R.drawable.homer);

        scratchImageView.setRevealListener(new ScratchImageView.IRevealListener() {
            @Override
            public void onRevealed(ScratchImageView tv) {
                // on reveal
            }

            @Override
            public void onRevealPercentChangedListener(ScratchImageView siv, float percent) {
                // on image percent reveal
            }
        });

        return scratchImageView;
    }
}
