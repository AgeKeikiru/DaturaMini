==Datura Mini v0.1.1, 9/25/2021 Prototype Build==

By @A.Kei.KI, in GameMaker Studio 2

Thank you for playing! I hope you come back for the next release <3


==Additional Credits==

@Lewmothmusic       Music
Sidearm Studios     SFX
@ChequeredInk       Fonts


==Default Controls==

Make sure your controller is plugged in prior to launching the game

Enter       [A/Start]   Confirm
Arrow Keys  [DPad]      Menu navigation/Movement
Space       [A]         Jump
Z           [X]         Attack (character 1)
X           [Y]         Attack (character 2)
C                       Defend (current character)
Shift       [B]         Hyper mode
D                       Attack (current character)
A           [LB]        Defend (character 1)
S           [RB]        Defend (character 2)
F                       Switch characters

=Debug Controls=
F1                      Debug mode toggle (during a stage)
Home                    Restart game
PgUp                    Heal current character
PgDn                    KO current character
End                     Game Over shortcut
Del                     Fill hyper gauge
Numpad 1-2              Jump to specific stage


==Patch Notes==

=v0.1.1=
- The missing wall in Stage 2 has been fixed
- Projectiles have been recolored to improve visibility
- New character added

=v0.0.5=
- Stage 2 added
- Enemy projectile colors have been standardized to improve recognition
- Removed vertical camera control during fixed camera sections
- Afterimages no longer prematurely disappear
- Projectiles no longer disappear when too close to the bottom of the screen

=v0.0.4=
- Grounded Imo Up-Atk now requires the attack button to be held to get the rising uppercut, tapping the button will now only create the ground wave
- The afterimage used when sprinting no longer has a hitbox
- Replaced placeholder audio
- Added audio feedback when attacks successfully connect
- Removed unintentional hitbox on the sprint afterimage

=v0.0.3=
- New character added, clear stage 1 to unlock
- Controller input now automatically detects the lowest controller slot (xinput only)
- Added Options and Keybinds menu functionality (Controls rebinding not yet implemented, but key assignments can be viewed)
- Stage clear screen no longer hangs if [Max Hyper] count is 0
- Added hitsparks to attacks
- Ari Up-Atk now creates an explosion, the damage has been split between initial contact and the explosion
- Adjusted knockback values for the following attacks:
    - Imo Up-Atk (slight increase to lift on midair hit, significant increase to lift on grounded hit)

=v0.0.2=
- Attacks and defensive actions (including jumping) can now cancel into each-other
- Moving uninterrupted for a short period of time will now increase movement speed
- Holding Up or Down while stationary will now pan the camera
- Added rudimentary xinput support (only reads slot 0)
- Added placeholder audio
- Added additional controls to allow alternate methods of controlling the party
- Increased maximum jump height
- Imo Neutral-Atk now attacks twice (individual damage has been halved to remain consistent). The second attack has a higher hitbox to assist in attacking enemies while going up mild slopes
- Ari Up-Atk no longer fails to spawn missiles if her back is against a wall
- Fixed inconsistent collision between Ari Atk and slopes
- Player projectiles now despawn upon exiting screen boundaries
- Imo now properly loses her blocking property if she is KO'd while blocking
- Attacks will no longer reverse the movement of moving platforms
- Stage clear screen now properly reflects the player's performance

=v0.0.1=
- Initial release
- 2 available characters
- 1 available stage