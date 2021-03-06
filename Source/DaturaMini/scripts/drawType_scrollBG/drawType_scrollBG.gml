function drawType_scrollBG(){
    
    draw_set_color(CC_HYPINK);
    
    draw_rectangle(x, y, x + camW, y + camH, false);
    
    wrapStripe(50, 100, 10, 85, 1000, CC_UI_ACCENT, 0.2);
    wrapStripe(80, 100, 2, 110, 720, CC_UI_ACCENT, 0.2);
    wrapStripe(120, 100, 4, 170, 1200, CC_UI_ACCENT, 0.3);
    wrapStripe(42, 190, 5, 76, 1020, CC_UI_ACCENT, 0.2);
    wrapStripe(100, 150, 5, 100, 900, CC_UI_ACCENT, 0.2);
    wrapStripe(25, 130, 5, 72, 800, CC_UI_ACCENT, 0.2);
    wrapStripe(93, 60, 3, 100, 2900, c_white, 0.3);
    wrapStripe(33, 40, 3, 203, 2100, c_white, 0.2);
    wrapStripe(60, 200, 3, 188, 708, c_white, 0.3);
    wrapStripe(128, 110, 3, 100, 3100, c_white, 0.3);
    wrapStripe(71, 38, 3, 203, 2100, c_white, 0.2);
    wrapStripe(133, 220, 3, 188, 1822, c_white, 0.2);
    
    draw_set_color(c_white);
    
}