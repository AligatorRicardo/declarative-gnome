{ pkgs, ...}:
{
wayland.windowManager.hyprland = { 
enable = true;
settings = {
    "$mod"="SUPER";
    "$fileManager"= "dolphin";
    "$menu"="rofi -show drun -show-icons";
    "$terminal"="kitty";
     animations = {
       "bezier"="myBezier, 0.05, 0.9, 0.1, 1.05";
       animation = [ 
       "windows, 1, 7, myBezier"
       "windowsOut, 1, 7, default, popin 80%"
       "border, 1, 10, default"
       "borderangle, 1, 8, default"
       "fade, 1, 7, default"
       "workspaces, 1, 6, default"
      ];
      enabled=true;
    };
    decoration = {
       blur = {
        enabled=true;
        passes=1;
        size=3;
        vibrancy="0.1696";
       };
       active_opacity="1.0";
       "col.shadow"="rgba(1a1a1aee)";
       drop_shadow=true;
       inactive_opacity="1.0";
       rounding=10;
       shadow_range=4;
       shadow_render_power=3;
    };

    dwindle = {
      preserve_split=true;
      pseudotile=true;
    };

    # unscale XWayland
    xwayland = {
      force_zero_scaling = true;
    };

   general = {
    allow_tearing=false;
    border_size=2;
    "col.active_border"="rgb(8B8B1C) 45deg";
    "col.inactive_border"="rgb(3C3836)"; 
    gaps_in=5;
    gaps_out=20;
    layout="dwindle";
    resize_on_border=false;
   };

    gestures = {
     workspace_swipe=false;
    };

    input = {
      touchpad = {
       natural_scroll=false;
      };
     follow_mouse=1;
     kb_layout="br";
     sensitivity=0;
    };

    master = {
     new_status="master";
    };

   misc = {
    disable_hyprland_logo=true;
   };

env = [
"XCURSOR_SIZE,24"
"HYPRCURSOR_SIZE,24"
];
monitor=",preferred,auto,1.25";

windowrulev2="suppressevent maximize, class:.*";

bind=[
"$mod, RETURN, exec, $terminal"
"$mod, Q, killactive,"
"$mod, M, exit,"
"$mod, E, exec, $fileManager"
"$mod, V, togglefloating,"
"$mod, D, exec, $menu"
"$mod, P, pseudo, # dwindle"
"$mod, J, togglesplit, # dwindle"
"$mod, left, movefocus, l"
"$mod, right, movefocus, r"
"$mod, up, movefocus, u"
"$mod, down, movefocus, d"
"$mod, 1, workspace, 1"
"$mod, 2, workspace, 2"
"$mod, 3, workspace, 3"
"$mod, 4, workspace, 4"
"$mod, 5, workspace, 5"
"$mod, 6, workspace, 6"
"$mod, 7, workspace, 7"
"$mod, 8, workspace, 8"
"$mod, 9, workspace, 9"
"$mod, 0, workspace, 10"
"$mod SHIFT, 1, movetoworkspace, 1"
"$mod SHIFT, 2, movetoworkspace, 2"
"$mod SHIFT, 3, movetoworkspace, 3"
"$mod SHIFT, 4, movetoworkspace, 4"
"$mod SHIFT, 5, movetoworkspace, 5"
"$mod SHIFT, 6, movetoworkspace, 6"
"$mod SHIFT, 7, movetoworkspace, 7"
"$mod SHIFT, 8, movetoworkspace, 8"
"$mod SHIFT, 9, movetoworkspace, 9"
"$mod SHIFT, 0, movetoworkspace, 10"
"$mod, S, togglespecialworkspace, magic"
"$mod SHIFT, S, movetoworkspace, special:magic"
"$mod, mouse_down, workspace, e+1"
"$mod, mouse_up, workspace, e-1"
", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
];

bindm=[
"$mod, mouse:272, movewindow"
"$mod, mouse:273, resizewindow"
];

binde=[
", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
];

exec-once=[
"hyprpanel"
"hyprctl setcursor 'Capitaine Cursors (Gruvbox)' 24"
];

};
};


}

