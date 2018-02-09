package com.reactlibrary.lib;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;

public interface IScratchImageView {

    /**
     * Whether the view receive user on touch motion
     *
     * @return true if scratchable
     */
    public boolean isScratchable();

    /**
     * If true, set the view allow receive on touch to reveal the view
     * By default, scratchable is true
     *
     * @param flag - flag for enable/disable scratch
     */
    public void setScratchable(boolean flag);

    /**
     * Set the color of overlay
     *
     * @param ResId - resources identifier for color in INT type
     */
    public void setOverlayColor(int ResId);

    /**
     * Set the radius size of the circle to be revealed
     *
     * @param size - radius size of circle in pixel unit
     */
    public void setRevealSize(int size);

    /**
     * Set turn on/off effect of anti alias of circle revealed
     * By default, anti alias is turn off
     *
     * @param flag - set true to turn on anti alias
     */
    public void setAntiAlias(boolean flag);

    /**
     * Reset the scratch view
     */
    public void resetView();

    /**
     * Set drawable for scratch view
     *
     * @param drawable - Set drawable for scratch view
     */
    public void setScratchDrawable(Drawable drawable);

    public void setScratchBitmap(Bitmap b);

    public float getScratchedRatio();

    public float getScratchedRatio(int speed);

    public void setOnScratchCallback(ScrathImageView.OnScratchCallback callback);

    public void setScratchAll(boolean scratchAll);

    public void setBackgroundClickable(boolean clickable);
}