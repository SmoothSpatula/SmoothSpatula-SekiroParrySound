-- Sekiro Parry Sound v1.0.0
-- SmoothSpatula

log.info("Successfully loaded ".._ENV["!guid"]..".")

-- ========== Audio ==========

local parry_sfx = {}

-- Load parry sound
for i = 1, 9 do
    parry_sfx[i] = gm.audio_create_stream(_ENV["!plugins_mod_folder_path"].."/Sekiro"..i..".ogg")
    if parry_sfx[i] ~= -1 then log.info("Loaded parry "..i.." sfx.")
    else log.info("Failed to load parry "..i.." sfx.") end
end


-- ========== ImGui ==========

local sekiro_parry_sound_enabled = true
gui.add_to_menu_bar(function()
    local new_value, clicked = ImGui.Checkbox("Enable Sekiro Parry Sound", sekiro_parry_sound_enabled)
    if clicked then
        sekiro_parry_sound_enabled = new_value
    end
end)

-- ========== Main ==========

-- Replace the original sound with a random parry sound from Sekiro
gm.pre_script_hook(gm.constants.sound_play, function(self, other, result, args)
    if sekiro_parry_sound_enabled and args[1].value == gm.constants.wMercenary_Parry_Deflection then 
        args[1].value = parry_sfx[math.random(9)]
    end
end)