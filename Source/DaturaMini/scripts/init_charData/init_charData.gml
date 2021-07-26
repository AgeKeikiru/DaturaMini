enum en_charID{
    
    IMO,
    ARI,
    BREIA,
    TEAR,
    WITCHY,
    ALTAI,
    
    LENGTH
    
}

enum en_exCharID{
    
    VELD,
    
    LENGTH
    
}

function lwo_charData() constructor{
    
    name = "";
    unlockDesc = "TBA";
    
    hintDesc = [
        
        "ATK\n\n",
        "UP-ATK\n\n",
        "DOWN-ATK\n\n",
        "DEFEND\n\n"
        
    ];
    
    introTxt = array_create(en_charID.LENGTH, "...");
    
    s_icon = [spr_ari_idle, spr_ari_move];
    s_port = spr_ari_port;
    
}

function lwo_imoData() : lwo_charData() constructor{
    
    name = "Imo'lei";
    
    hintDesc[0] += "Basic slash,\nclose range";
    hintDesc[1] += "Rising slash,\ncreates wave\non the ground";
    hintDesc[2] += "Down-slash,\npulls enemies\nin";
    hintDesc[3] += "Block,\nmove to dodge";
    
    introTxt[en_charID.IMO] =       "\"" +
                                    "Try not to get in the way too\n" +
                                    "much." +
                                    "\"";
    
    introTxt[en_charID.ARI] =       "\"" +
                                    "Ugh, how did I get stuck with\n" +
                                    "you?" +
                                    "\"";
                                    
    introTxt[en_charID.BREIA] =     "\"" +
                                    "Fat chance if I have to\n" +
                                    "babysit you." +
                                    "\"";
    
    s_icon = [spr_imo_idle, spr_imo_move];
    s_port = spr_imo_port;
    
}

function lwo_ariData() : lwo_charData() constructor{
    
    name = "Ari";
    
    hintDesc[0] += "Rapid shot,\nsafe,\ndoesn't stun";
    hintDesc[1] += "Missile volley,\nlimited homing";
    hintDesc[2] += "Down-crash,\nmore height\nimproves AoE";
    hintDesc[3] += "Sliding dodge,\nstuns enemies";
    
    introTxt[en_charID.IMO] =       "\"" +
                                    "Ha! Just try to keep up then!" +
                                    "\"";
    
    introTxt[en_charID.ARI] =       "\"" +
                                    "Alright, we got this in the\n" +
                                    "bag!" +
                                    "\"";
                                    
    introTxt[en_charID.BREIA] =     "\"" +
                                    "Quick eh? Why don't we have\n" +
                                    "a race then!" +
                                    "\"";
    
    s_icon = [spr_ari_idle, spr_ari_move];
    s_port = spr_ari_port;
    
}

function lwo_breiaData() : lwo_charData() constructor{
    
    name = "Breia";
    unlockDesc = "Clear Stage 1";
    
    hintDesc[0] += "Slug round,\nextra dmg vs\nfrozen enemies";
    hintDesc[1] += "Ice grenade,\nhit midair\nfor bigger AoE";
    hintDesc[2] += "Freeze shot,\nhit the ground\nfor AoE";
    hintDesc[3] += "8-way dodge,\ncancels into\nself";
    
    introTxt[en_charID.IMO] =       "\"" +
                                    "That's my line, if you get\n" +
                                    "hit it's your own fault." +
                                    "\"";
    
    introTxt[en_charID.ARI] =       "\"" +
                                    "I'm not dragging your corpse\n" +
                                    "back home, y'know." +
                                    "\"";
                                    
    introTxt[en_charID.BREIA] =     "\"" +
                                    "Let's get this done quick,\n" +
                                    "yea?" +
                                    "\"";
    
    s_icon = [spr_bre_idle, spr_bre_move];
    s_port = spr_bre_port;
    
}

function lwo_tearData() : lwo_charData() constructor{
    
    name = "Tear";
    //unlockDesc = "Clear Stage 2\nwith no\ncontinues";
    //s_icon = [spr_imo_idle, spr_imo_move];
    //s_port = spr_imo_port;
    
}

function lwo_witchyData() : lwo_charData() constructor{
    
    name = "Witchy";
    //unlockDesc = "Clear the game";
    //s_icon = [spr_imo_idle, spr_imo_move];
    //s_port = spr_imo_port;
    
}

function lwo_altaiData() : lwo_charData() constructor{
    
    name = "Altai";
    //unlockDesc = "Clear any stage\non EXH with no\ncontinues";
    //s_icon = [spr_imo_idle, spr_imo_move];
    //s_port = spr_imo_port;
    
}

//arrange mode chars

function lwo_veldData() : lwo_charData() constructor{
    
    name = "Veld";
    //unlockDesc = "Clear the game";
    //s_icon = [spr_imo_idle, spr_imo_move];
    //s_port = spr_imo_port;
    
}

//harzer
//clear the game with no continues

//jack
//clear the game with a certain score

global.arr_chars = [
    
    new lwo_imoData(),
    new lwo_ariData(),
    new lwo_breiaData(),
    new lwo_tearData(),
    new lwo_witchyData(),
    new lwo_altaiData()
    
];

global.arr_exChars = [
    
    new lwo_veldData()
    
];