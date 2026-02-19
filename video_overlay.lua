-- Credit to Yahiamice for this shit or else what I wanted to do would NOT have been possible. God bless you, Yahiamice! Modified Slightly by FamousmewYT-JP, but core functionality remains the same.

function create_UIBox_one_one_video(name,buttonname)
local file_path=SMODS.Mods["noirlatro"].path.."/assets/video/"..name
local file=NFS.read(file_path)
love.filesystem.write("temp.ogv",file)
local video_file=love.graphics.newVideo('temp.ogv')
local vid_sprite=Sprite(0,0,11*16/9,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)],{x=0,y=0})
video_file:getSource():setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*10))
vid_sprite.video=video_file
video_file:play()
local t=create_UIBox_generic_options({back_delay=2,back_label=buttonname,colour=G.C.BLACK,padding=0,contents={{n=G.UIT.O,config={object=vid_sprite}}}})
return t
end

-- Will probably have to change this maybe IDK

OneOneVideoModal = OneOneVideoModal or {
active = false,
finished = false,
vid = nil,
vid_sprite = nil,
ui = nil,
started_this_loss = false,
triggered_game_over = false,
}

function OneOneVideoModal:start(filename)
if self.active then return end
if not (love and love.graphics and love.graphics.newVideo) then
print("[OneOneVideoModal] love.graphics.newVideo not available") -- So this way it (shouldn't') cause a Stack Traceback in case it can't find the video, and will print in console. Makes it easier for debugging.
return
end

local file_path = SMODS.Mods["noirlatro"].path.."/assets/video/"..filename
local file = NFS.read(file_path)
if not file then
print("[OneOneVideoModal] Failed to read file: " .. file_path)  
return
end

love.filesystem.write("temp_1-1.ogv", file)
local success, video_file = pcall(love.graphics.newVideo, 'temp_1-1.ogv')
if not success then
print("[OneOneVideoModal] Failed to load video!")
print("[OneOneVideoModal] Error: " .. tostring(video_file))
return
end

-- This is the goodie video parts and the proper UI popout.

self.vid_sprite = Sprite(0,0,11*16/9,11,G.ASSET_ATLAS["ui_"..(G.SETTINGS.colourblind_option and 2 or 1)], {x=0, y=0})
self.vid_sprite.video = video_file
video_file:getSource():setVolume(G.SETTINGS.SOUND.volume*G.SETTINGS.SOUND.game_sounds_volume/(100*10))
video_file:play()

self.vid = video_file
self.active = true
self.finished = false
self.started_this_loss = true
self.triggered_game_over = false

self:open_ui()
end

function OneOneVideoModal:open_ui()
self.ui = create_UIBox_generic_options({
back_func = "one_one_close_video",
back_label = "Close",
colour = G.C.BLACK,
padding = 0,
contents = {
{n=G.UIT.O, config={object = self.vid_sprite}}
}
})
G.FUNCS.overlay_menu({ definition = self.ui.definition })
end

G.FUNCS.one_one_close_video = function(e)
if OneOneVideoModal.active and not OneOneVideoModal.finished then
return
end
OneOneVideoModal:stop()
if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
end

function OneOneVideoModal:stop()
if self.vid then
self.vid:pause()
self.vid = nil
end
self.vid_sprite = nil
self.active = false
self.finished = false
self.started_this_loss = false
if not self.triggered_game_over then
self.triggered_game_over = true
G.GAME.chips = 0
G.GAME.current_round.hands_left = 0
G.GAME.current_round.discards_left = 0
end
end

function OneOneVideoModal:update()
if not (self.active and self.vid) then return end
if not self.vid:isPlaying() and not self.finished then
self.finished = true
end
end
