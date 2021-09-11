
    Citizen.CreateThread(function() 
                    local BanList = {}
                    local BanListLoad = false
                    CreateThread(
                        function()
                            while true do
                                Wait(1000)
                                if BanListLoad == false then
                                    LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                                    if BanList ~= {} then
                                        BanListLoad = true
                                    else
                                    end
                                end
                            end
                        end
                    )

                    CreateThread(
                        function()
                            while true do
                                Wait(600000)
                                if BanListLoad == true then
                                    LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                                end
                            end
                        end
                    )

                    local counter = {}

                    RegisterServerEvent("aopkfgebjzhfpazf77")
                    AddEventHandler(
                        "aopkfgebjzhfpazf77",
                        function(reason, servertarget)
                            local license, identifier, liveid, xblid, discord, playerip, target
                            local duree = 0
                            local reason = reason

                            if not reason then
                                reason = "Cheating"
                            end

                            if tostring(source) == "" then
                                target = tonumber(servertarget)
                            else
                                target = source
                            end

                            if target and target > 0 then
                                local ping = GetPlayerPing(target)

                                if ping and ping > 0 then
                                    if duree and duree < 365 then
                                        local sourceplayername = "Aspect"
                                        local targetplayername = GetPlayerName(target)
                                        for k, v in ipairs(GetPlayerIdentifiers(target)) do
                                            if string.sub(v, 1, string.len("license:")) == "license:" then
                                                license = v
                                            elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                                                identifier = v
                                            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                                liveid = v
                                            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                                xblid = v
                                            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                                discord = v
                                            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                                playerip = v
                                            end
                                        end

                                        if duree > 0 then
                                            ban(
                                                target,
                                                license,
                                                identifier,
                                                liveid,
                                                xblid,
                                                discord,
                                                playerip,
                                                targetplayername,
                                                sourceplayername,
                                                duree,
                                                reason,
                                                0
                                            )
                                            DropPlayer(target, "" .. reason)
                                        else
                                            ban(
                                                target,
                                                license,
                                                identifier,
                                                liveid,
                                                xblid,
                                                discord,
                                                playerip,
                                                targetplayername,
                                                sourceplayername,
                                                duree,
                                                reason,
                                                1
                                            )
                                            DropPlayer(target, "" .. reason)
                                        end
                                    else
                                    end
                                else
                                end
                            else
                            end
                        end
                    )
                    
                    function ban(src, reason) 
                        local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                        local cfg = json.decode(config)
                        local ids = ExtractIdentifiers(src);
                        local playerip = ids.ip;
                        local playerSteam = ids.steam;
                        local playerLicense = ids.license;
                        local playerXbl = ids.xbl;
                        local playerLive = ids.live;
                        local playerDisc = ids.discord;
                        local banData = {};
                        banData['ID'] = tonumber(getNewBanID());
                        banData['playerip'] = "NONE SUPPLIED";
                        banData['reason'] = reason;
                        banData['license'] = "NONE SUPPLIED";
                        banData['steam'] = "NONE SUPPLIED";
                        banData['xbl'] = "NONE SUPPLIED";
                        banData['live'] = "NONE SUPPLIED";
                        banData['discord'] = "NONE SUPPLIED";
                        if ip ~= nil and ip ~= "nil" and ip ~= "" then 
                            banData['ip'] = tostring(ip);
                        end
                        if playerLicense ~= nil and playerLicense ~= "nil" and playerLicense ~= "" then 
                            banData['license'] = tostring(playerLicense);
                        end
                        if playerSteam ~= nil and playerSteam ~= "nil" and playerSteam ~= "" then 
                            banData['steam'] = tostring(playerSteam);
                        end
                        if playerXbl ~= nil and playerXbl ~= "nil" and playerXbl ~= "" then 
                            banData['xbl'] = tostring(playerXbl);
                        end
                        if playerLive ~= nil and playerLive ~= "nil" and playerLive ~= "" then 
                            banData['live'] = tostring(playerXbl);
                        end
                        if playerDisc ~= nil and playerDisc ~= "nil" and playerDisc ~= "" then 
                            banData['discord'] = tostring(playerDisc);
                        end
                        cfg[tostring(GetPlayerName(src))] = banData;
                        SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
                    end
                    function getNewBanID()
                        local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                        local cfg = json.decode(config)
                        local banID = 0;
                        for k, v in pairs(cfg) do 
                            banID = banID + 1;
                        end
                        return (banID + 1);
                    end
                    
                    RegisterNetEvent('VAC:CheckStaff')
                    AddEventHandler('VAC:CheckStaff', function()
                        local src = source;
                        if IsPlayerAceAllowed(src, 'Aspect.Bypass') then 
                            TriggerClientEvent('VAC:CheckStaffReturn', src, true);
                        else 
                            TriggerClientEvent('VAC:CheckStaffReturn', src, false);
                        end
                    end)
                    
                    RegisterCommand('ac-unban', function(source, args, rawCommand)
                        local src = source;
                        if (src <= 0) then
                            -- Console unban
                            if #args == 0 then 
                                -- Not enough arguments
                                print('^3[^3Aspect^3] ^1Not enough arguments...');
                                return; 
                            end
                            local banID = args[1];
                            if tonumber(banID) ~= nil then
                                local playerName = UnbanPlayer(banID);
                                if playerName then
                                    print('^3[^3Aspect^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2CONSOLE');
                                    TriggerClientEvent('chatMessage', -1, '^3[^3 Aspect^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2CONSOLE'); 
                                else 
                                    -- Not a valid ban ID
                                    print('^3[^3Aspect^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
                                end
                            end
                            return;
                        end 
                        if IsPlayerAceAllowed(src, "Aspect.Bypass") then 
                            if #args == 0 then 
                                -- Not enough arguments
                                TriggerClientEvent('chatMessage', src, '^3[^3 Aspect^3] ^1Not enough arguments...');
                                return; 
                            end
                            local banID = args[1];
                            if tonumber(banID) ~= nil then 
                                -- Is a valid ban ID 
                                local playerName = UnbanPlayer(banID);
                                if playerName then
                                    TriggerClientEvent('chatMessage', -1, '^3[^3 Aspect^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2' .. GetPlayerName(src)); 
                                else 
                                    -- Not a valid ban ID
                                    TriggerClientEvent('chatMessage', src, '^3[^3 Aspect^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
                                end
                            else 
                                -- Not a valid number
                                TriggerClientEvent('chatMessage', src, '^3[^3 Aspect^3] ^1That is not a valid number...'); 
                            end
                        end
                    end)
                    function UnbanPlayer(banID)
                        local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                        local cfg = json.decode(config)
                        for k, v in pairs(cfg) do 
                            local id = tonumber(v['ID']);
                            if id == tonumber(banID) then 
                                local name = k;
                                cfg[k] = nil;
                                SaveResourceFile(GetCurrentResourceName(), "banlist.json", json.encode(cfg, { indent = true }), -1)
                                return name;
                            end
                        end
                        return false;
                    end 
                    function isBanned(src)
                        local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                        local cfg = json.decode(config)
                        local ids = ExtractIdentifiers(src);
                        local playerIP = ids.ip;
                        local playerSteam = ids.steam;
                        local playerLicense = ids.license;
                        local playerXbl = ids.xbl;
                        local playerLive = ids.live;
                        local playerDisc = ids.discord;
                        for k, v in pairs(cfg) do 
                            local reason = v['reason']
                            local id = v['ID']
                            local ip = v['ip']
                            local license = v['license']
                            local steam = v['steam']
                            local xbl = v['xbl']
                            local live = v['live']
                            local discord = v['discord']
                            if tostring(ip) == tostring(playerIP) then return { ['banID'] = id, ['reason'] = reason } end;
                            if tostring(license) == tostring(playerLicense) then return { ['banID'] = id, ['reason'] = reason } end;
                            if tostring(steam) == tostring(playerSteam) then return { ['banID'] = id, ['reason'] = reason } end;
                            if tostring(xbl) == tostring(playerXbl) then return { ['banID'] = id, ['reason'] = reason } end;
                            if tostring(live) == tostring(playerLive) then return { ['banID'] = id, ['reason'] = reason } end;
                            if tostring(discord) == tostring(playerDisc) then return { ['banID'] = id, ['reason'] = reason } end;
                        end
                        return false;
                    end
                    function GetBans()
                        local config = LoadResourceFile(GetCurrentResourceName(), "banlist.json")
                        local cfg = json.decode(config)
                        return cfg;
                    end
                    local playTracker = {}
                    Citizen.CreateThread(function()
                        while true do 
                            Wait(0);
                            for _, id in pairs(GetPlayers()) do 
                                local ip = ExtractIdentifiers(id).ip;
                                if playTracker[ip] ~= nil then 
                                    playTracker[ip] = playTracker[ip] + 1;
                                else 
                                    playTracker[ip] = 1;
                                end
                            end
                            Wait((1000 * 60)); -- Every minute 
                        end
                    end)
                    function GetLatest(count)
                        local latest = {};
                        local lowest = 9999999;
                        local lowestUser = nil;
                        local ourCount = 0;
                        local ourArr = {};
                        for ip, playtime in pairs(playTracker) do 
                            ourArr[ip] = playtime;
                        end
                        local retArr = {};
                        while ourCount < count do 
                            lowest = nil;
                            local lowestIP = nil;
                            lowestUser = nil;
                            for ip, playtime in pairs(ourArr) do 
                                for _, pid in pairs(GetPlayers()) do 
                                    local playerIP = ExtractIdentifiers(pid).ip;
                                    if tostring(ip) == tostring(playerIP) then 
                                        if lowest == nil or lowest >= playtime then 
                                            lowestIP = ip;
                                            lowest = playtime 
                                            lowestUser = pid;
                                        end
                                    end 
                                end 
                            end
                            if lowest ~= nil then 
                                ourArr[lowestIP] = nil;
                                table.insert(retArr, {lowestUser, lowest});
                            end 
                            ourCount = ourCount + 1;
                        end
                        return retArr;
                    end

                    function OnPlayerConnecting(name, setKickReason, deferrals)
                        deferrals.defer();
                        print("[Aspect-AC] Checking their Ban Data");
                        local src = source;
                        local banned = false;
                        local ban = isBanned(src);
                        Citizen.Wait(100);
                        if ban then 
                            -- They are banned 
                            local reason = ban['reason'];
                            local printMessage = nil;
                            if string.find(reason, "[Aspect-AC]") then 
                                printMessage = "" 
                            else 
                                printMessage = "[Aspect-AC] " 
                            end 
                            print("[BANNED PLAYER] Player " .. GetPlayerName(src) .. " tried to join, but was banned for: " .. reason);
                            deferrals.done(printMessage .. "(BAN ID: " .. ban['banID'] .. ") " .. reason);
                            banned = true;
                            CancelEvent();
                            return;
                        end
                        if not banned then 
                            deferrals.done();
                        end
                    end
                    RegisterCommand("acban", function(source, args, raw)
                        -- /acban <id> <reason> 
                        local src = source;
                        if IsPlayerAceAllowed(src, "Aspect.Bypass") then 
                            -- They can ban players this way
                            if #args < 2 then 
                                -- Not valid enough num of arguments 
                                TriggerClientEvent('chatMessage', source, "^5[^1Aspect^5] ^1ERROR: You have supplied invalid amount of arguments... " ..
                                    "^2Proper Usage: /acban <id> <reason>");
                                return;
                            end
                            local id = args[1]
                            if ExtractIdentifiers(args[1]) ~= nil then 
                                -- Valid player supplied 
                                local ids = ExtractIdentifiers(id);
                                local steam = ids.steam;
                                local gameLicense = ids.license;
                                local discord = ids.discord;
                                local reason = table.concat(args, ' '):gsub(args[1] .. " ", "");
                                BanPlayer(args[1], reason);
                                sendToDisc("[BANNED] Banned by " .. GetPlayerName(src) .. ": _[" .. tostring(id) .. "] " .. GetPlayerName(id) .. "_", 
                                    'Reason: **' .. reason .. '**\n' ..
                                    'Steam: **' .. steam .. '**\n' ..
                                    'GameLicense: **' .. gameLicense .. '**\n' ..
                                    'Discord Tag: <@' .. discord:gsub('discord:', '') .. '>**\n' ..
                                    'Discord UID: **' .. discord:gsub('discord:', '') .. '**\n');
                                DropPlayer(id, "[Aspect-AC]: Banned by player " .. GetPlayerName(src) .. " for reason: " .. reason);
                            else 
                                -- Not a valid player supplied 
                                TriggerClientEvent('chatMessage', source, "^5[^1Aspect^5] ^1ERROR: There is no valid player with that ID online... " ..
                                    "^2Proper Usage: /acban <id> <reason>");
                            end
                        end
                    end)
                    AddEventHandler("playerConnecting", OnPlayerConnecting)

                    function ExtractIdentifiers(src)
                        local identifiers = {
                            steam = "",
                            ip = "",
                            discord = "",
                            license = "",
                            xbl = "",
                            live = ""
                        }
                    
                        --Loop over all identifiers
                        for i = 0, GetNumPlayerIdentifiers(src) - 1 do
                            local id = GetPlayerIdentifier(src, i)
                    
                            --Convert it to a nice table.
                            if string.find(id, "steam") then
                                identifiers.steam = id
                            elseif string.find(id, "ip") then
                                identifiers.ip = id
                            elseif string.find(id, "discord") then
                                identifiers.discord = id
                            elseif string.find(id, "license") then
                                identifiers.license = id
                            elseif string.find(id, "xbl") then
                                identifiers.xbl = id
                            elseif string.find(id, "live") then
                                identifiers.live = id
                            end
                        end
                    
                        return identifiers
                    end
                    

                
                    local newestversion = "v1.1.0"
                    local versionac = Aspect.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("Aspect:getIsAllowed")
                    AddEventHandler(
                        "Aspect:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "Aspect.Bypass") then
                                TriggerServerEvent("Aspect:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("Aspect:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== STARTUP ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            Wait(2000)
                            SetConvarServerInfo("Aspect-AC", "https://discord.gg/g8jDUaUPBG") -- Please do not remove this as this anticheat is public and free so I want some kind of credits idc if you use anything from this anticheat just plz leave credits.
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^3 [Aspect-AC] ^0 Loading Aspect's Servers...")
                            Wait(6000)
                         --   print("^3 [Aspect-AC]^2 You are permitted to use Aspect-AC, welcome back^0.")
                            print(
                                "^3 [Aspect-AC]^0 Aspect-AC is currently identified as ^2" .. resourceName .. "^0!"
                            )
                            if resourceName == "aspect-ac" then
                                print(
                                    "^3 [Aspect-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_boombox^0?"
                                )
                            elseif resourceName == "Aspect-Anticheat" then
                                print(
                                    "^3 [Aspect-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_boombox^0?"
                                )
                            elseif resourceName == "Anticheat" then
                                print(
                                    "^3 [Aspect-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_boombox^0?"
                                )
                            elseif resourceName == "AC" then
                                print(
                                    "^3 [Aspect-AC]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_boombox^0?"
                                )
                            end
                           
                          --  ACStarted()
--                            ACStartLog()
-- [Removed both of these LOL]
                        end
                    )

             

                    function logo()
                        print(
                            [[
                    
                                ____    ____  __    __   __        ______     ___      .__   __. 
                                \   \  /   / |  |  |  | |  |      /      |   /   \     |  \ |  | 
                                 \   \/   /  |  |  |  | |  |     |  ,----'  /  ^  \    |   \|  | 
                                  \      /   |  |  |  | |  |     |  |      /  /_\  \   |  . `  | 
                                   \    /    |  `--'  | |  `----.|  `----./  _____  \  |  |\   | 
                                    \__/      \______/  |_______| \______/__/     \__\ |__| \__| 
                                                                                                                                                                                     
                                    ^3              Anti-Cheat Initialised
            ]]
                        )
                    end

                

                    --=====================================================--
                    --=====================================================--

                    function LogBanToDiscord(playerId, reason, typee)
                        playerId = tonumber(playerId)
                        local name = GetPlayerName(playerId)
                        if playerId == 0 then
                            local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
                            local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
                        else
                        end
                        local steamid = "Unknown"
                        local license = "Unknown"
                        local discord = "Unknown"
                        local xbl = "Unknown"
                        local liveid = "Unknown"
                        local ip = "Unknown"

                        if name == nil then
                            name = "Unknown"
                        end

                        for k, v in pairs(GetPlayerIdentifiers(playerId)) do
                            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                                steamid = v
                            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                                license = v
                            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                xbl = v
                            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                ip = string.sub(v, 4)
                            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                discordid = string.sub(v, 9)
                                discord = "<@" .. discordid .. ">"
                            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                liveid = v
                            end
                        end

                        local discordInfo = {
                            ["author"] = {
                                ["name"] = "Aspect-AC",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/885198956957663271/885632331543633920/New_Project_1background.png",
                            },
                            ["color"] = "16744576",
                            ["type"] = "rich",
                            ["title"] = "Aspect-AC | Player Banned",
                            ["description"] = 
                            
                            "**Name: **" .. 
                                        name ..  
                            "\n **Server ID: **" .. 
                                             playerId ..
                                             "\n **Reason: **" ..
                                                     reason ..
                                                    "\n **Steam Hex: **" ..
                                                        steamid ..
                                                            "\n **License: **" ..
                                                                license .. "\n **Discord: **" .. discord,

                            ["footer"] = {
                                ["text"] = " Aspect-AC | https://Aspectac.xyz | " .. os.date("%x %X %p")
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    Aspect.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode(
                                        {
                                            username = "Aspect-AC",
                                            avatar_url = "https://cdn.discordapp.com/attachments/885198956957663271/885632331543633920/New_Project_1background.png",
                                            embeds = {discordInfo}
                                        }
                                    ),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "model" then
                                PerformHttpRequest(
                                    Aspect.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Aspect-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "unban" then
                                PerformHttpRequest(
                                    Aspect.Logs.Unbans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Aspect-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "explosion" then
                                PerformHttpRequest(
                                    Aspect.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Aspect-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            end
                        end
                    end

                  


                 

                        ACFailed = function()
                        end

                        --=====================================================--
                        --=====================================================--


                        local banMessage = nil
                        --banMessage = "\n\nDetected by Aspect Systems.\nReason: Cheating\nAppeal at: ".. Aspect.Discord .. "\n\nhttps://Aspect"
                      --  if Aspect.UseCustomBanMessage then
                        --    banMessage = "" .. Aspect.CustomBanMessage .. ""
                        --else
                            banMessage =
                                "\n\nDetected by Aspect Systems.\nReason: Cheating\nDate Detected: " ..
                                os.date("%x at %X %p") .. "\nAppeal at: " .. Aspect.Discord .. "\n\nhttps://Aspect"
                        end

                        local banmessages = {
                            noclip = "Player Attemped To No-Clip",
                            godmode = "Player Attemped To Enable Godmode",
                            AntiClearPedTasks = "Player Tried To Clear Ped Task's",
                            spectate = "Player Attemped To Specate Another Player",
                            pedspeed = "Player Enabled Ped Speed Modifier"
                        }
                        
                        
                        RegisterServerEvent("fuhjizofzf4z5fza")
                        AddEventHandler(
                            "fuhjizofzf4z5fza",
                            function(type, item)
                                local _type = type or "default"
                                local _item = item or "none"
                                _type = string.lower(_type)

                                if IsPlayerAceAllowed(source, "Aspect.Bypass") then
                                    if (_type == "default") then
                                                                                print("^3 [Aspect-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR !")
                                        LogBanToDiscord(source, "Unknown Readon", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", "Banned", source)
                                    elseif (_type == "basic") then
                                                                                print("^3 [Aspect-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                        LogBanToDiscord(source, "Tried to put in godmode", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestart") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                        )
                                        LogBanToDiscord(source, "Attempted To Noclip " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "noclip") then
                                        print(
                                        "^3 [Aspect-AC]" ..
                                        GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                                                                        )
                                        LogBanToDiscord(source, "Tried to start the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestop") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!"
                                        )
                                        LogBanToDiscord(source, "Tried to stop the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "esx") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "vrp") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "asd") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "spectate") then
                                                                                print(
                                            "^3 [Aspect-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !"
                                        )
                                        LogBanToDiscord(source, "Tried to spectate a player", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcecounter") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR DIFFERENT RESOURCE COUNT!"
                                        )
                                        LogBanToDiscord(source, "has a different resource number count", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "antiblips") then
                                                                                print("^3 [Aspect-AC]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                        LogBanToDiscord(source, "tried to enable players blips", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "blacklisted_weapon") then
                                        print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                        )
                                        LogBanToDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                        if Aspect.BanBlacklistedWeapon then
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                                end
                                    elseif (_type == "hash") then
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                        )
                                        LogBanToDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                    elseif (_type == "explosion") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR SPAWNED EXPLOSION !"
                                        )
                                        LogBanToDiscord(source, "Tried to spawn an explosion : " .. item, "basic")
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "event") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR BLACKLISTED EVENT : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to trigger a blacklisted event : " .. item,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "menu") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried inject a menu in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "functionn") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to inject a function in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "damagemodifier") then
                                                                                print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to change his Weapon Damage : " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "malformedresource") then
                                        print(
                                            "^3 [Aspect-AC]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(
                                            source,
                                            "Tried to inject a malformed resource : " .. item,
                                            "basic"
                                        )
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                        end
                                end
                            end
                        )

                        Citizen.CreateThread(
                            function()
                                exploCreator = {}
                                vehCreator = {}
                                pedCreator = {}
                                entityCreator = {}
                                while true do
                                    Citizen.Wait(2500)
                                    exploCreator = {}
                                    vehCreator = {}
                                    pedCreator = {}
                                    entityCreator = {}
                                end
                            end
                        )

                        local gasPumps = {
                            vector3(-72.0343, -1765.106, 28.52847)
                        }

                        if Aspect.BlacklistedExplosions then
                            AddEventHandler(
                                "explosionEvent",
                                function(sender, ev)
                                    if ev.damageScale ~= 0.0 then
                                        local BlacklistedExplosionsArray = {}

                                        for kkk, vvv in pairs(Aspect.BlockedExplosions) do
                                            table.insert(BlacklistedExplosionsArray, vvv)
                                        end

                                        if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                                                                                        CancelEvent()
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn a blacklisted explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            LogBanToDiscord(sender, "Made a Explosion", "basic")
                                        else
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                        end

                                        if ev.explosionType ~= 9 then
                                            exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                            if exploCreator[sender] > 3 then
                                                LogBanToDiscord(
                                                    sender,
                                                    "Tried to spawn mass explosions - type : " .. ev.explosionType,
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                                 CancelEvent()
                                            end
                                        else
                                            exploCreator[sender] = (exploCreator[sender] or 0) + 1
                                            if exploCreator[sender] > 3 then
                                                LogBanToDiscord(
                                                    sender,
                                                    "Tried to spawn mass explosions ( gas pump )",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                                 CancelEvent()
                                            end
                                        end

                                        if ev.isAudible == false then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn silent explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                 end

                                        if ev.isInvisible == true then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn invisible explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                 end

                                        if ev.damageScale > 1.0 then
                                            LogBanToDiscord(
                                                sender,
                                                "Tried to spawn oneshot explosion - type : " .. ev.explosionType,
                                                "basic"
                                            )
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                 end
                                        CancelEvent()
                                    end
                                end
                            )
                        end

                        if Aspect.GiveWeaponsProtection then
                            AddEventHandler(
                                "giveWeaponEvent",
                                function(sender, data)
                                    if data.givenAsPickup == false then
                                        LogBanToDiscord(sender, "Tried to give weapon to a player", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                                 CancelEvent()
                                    end
                                end
                            )

                            AddEventHandler(
                                "RemoveWeaponEvent",
                                function(sender, data)
                                    CancelEvent()
                                    LogBanToDiscord(sender, "Tried to remove weapon to a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                    end
                            )

                            AddEventHandler(
                                "RemoveAllWeaponsEvent",
                                function(sender, data)
                                    CancelEvent()
                                    LogBanToDiscord(sender, "Tried to remove all weapons to a player", "basic")
                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, sender)
                                                                    end
                            )
                        end


                         if Aspect.TriggersProtection
                         then
                            for k, events in pairs(Aspect.ProtectedTriggers) do
                                RegisterServerEvent(events)
                                AddEventHandler(
                                    events,
                                    function()
                                        LogBanToDiscord(source, "Triggered Protected Event: " .. events, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                                CancelEvent()
                                    end
                                )
                            end
                        end

                        AddEventHandler(
                            "entityCreating",
                            function(entity)
                                if DoesEntityExist(entity) then
                                    local src = NetworkGetEntityOwner(entity)
                                    local model = GetEntityModel(entity)
                                    local blacklistedPropsArray = {}
                                    local WhitelistedPropsArray = {}
                                    local eType = GetEntityPopulationType(entity)

                                    if src == nil then
                                        CancelEvent()
                                    end

                                    for bl_k, bl_v in pairs(Aspect.BlacklistedModels) do
                                        table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                    end

                                    for wl_k, wl_v in pairs(Aspect.WhitelistedProps) do
                                        table.insert(WhitelistedPropsArray, GetHashKey(wl_v))
                                    end

                                    if eType == 0 then
                                        CancelEvent()
                                    end

                                    if GetEntityType(entity) == 3 then
                                        if eType == 6 or eType == 7 then
                                            if inTable(WhitelistedPropsArray, model) == false then
                                                if model ~= 0 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn a blacklisted prop : " .. model,
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                        CancelEvent()

                                                    entityCreator[src] = (entityCreator[src] or 0) + 1
                                                    if entityCreator[src] > 30 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn " .. entityCreator[src] .. " entities",
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                          end
                                                end
                                            end
                                        end
                                    else
                                        if GetEntityType(entity) == 2 then
                                            if eType == 6 or eType == 7 then
                                                if inTable(blacklistedPropsArray, model) ~= false then
                                                    if model ~= 0 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn a blacklisted vehicle : " .. model,
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                                 CancelEvent()
                                                    end
                                                end
                                                vehCreator[src] = (vehCreator[src] or 0) + 1
                                                if vehCreator[src] > 20 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                 end
                                            end
                                        elseif GetEntityType(entity) == 1 then
                                            if eType == 6 or eType == 7 then
                                                if inTable(blacklistedPropsArray, model) ~= false then
                                                    if model ~= 0 or model ~= 225514697 then
                                                        LogBanToDiscord(
                                                            src,
                                                            "Tried to spawn a blacklisted ped : " .. model,
                                                            "basic"
                                                        )
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                                 CancelEvent()
                                                    end
                                                end
                                                pedCreator[src] = (pedCreator[src] or 0) + 1
                                                if pedCreator[src] > 20 then
                                                    LogBanToDiscord(
                                                        src,
                                                        "Tried to spawn " .. pedCreator[src] .. " peds",
                                                        "basic"
                                                    )
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                 end
                                            end
                                        else
                                            if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                                                if model ~= 0 or model ~= 225514697 then
                                                    LogBanToDiscord(src, "Tried to spawn a model : " .. model, "basic")
                                                    TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                         CancelEvent()
                                                end
                                            end
                                        end
                                    end

                                    if GetEntityType(entity) == 1 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            pedCreator[src] = (pedCreator[src] or 0) + 1
                                            if pedCreator[src] > 20 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. pedCreator[src] .. " peds",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                 CancelEvent()
                                            end
                                        end
                                    elseif GetEntityType(entity) == 2 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            vehCreator[src] = (vehCreator[src] or 0) + 1
                                            if vehCreator[src] > 20 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. vehCreator[src] .. " vehs",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                 CancelEvent()
                                            end
                                        end
                                    elseif GetEntityType(entity) == 3 then
                                        if eType == 6 or eType == 7 or eType == 0 then
                                            entityCreator[src] = (entityCreator[src] or 0) + 1
                                            if entityCreator[src] > 99 then
                                                LogBanToDiscord(
                                                    src,
                                                    "Tried to spawn " .. entityCreator[src] .. " entities",
                                                    "basic"
                                                )
                                                TriggerEvent("aopkfgebjzhfpazf77", banMessage, src)
                                                                                                 CancelEvent()
                                            end
                                        end
                                    end
                                end
                            end
                        )

                        if Aspect.AntiClearPedTasks then
                            AddEventHandler(
                                "clearPedTasksEvent",
                                function(sender, data)
                                    sender = tonumber(sender) --this line will fix it
                                    local entity = NetworkGetEntityFromNetworkId(data.pedId)
                                    if DoesEntityExist(entity) then
                                        local owner = NetworkGetEntityOwner(entity)
                                        if owner ~= sender then
                                            print(sender)
                                            CancelEvent()
                                            LogBanToDiscord(owner, "Tried to clear ped tasks")
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                                                                 end
                                    end
                                end
                            )
                        end

                        if Aspect.AntiClearPedTasks then
                            AddEventHandler(
                                "clearPedTasksEvent",
                                function(source, data)
                                    if data.immediately then
                                        LogBanToDiscord(source, "Tried to clear ped tasks", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banmessages.AntiClearPedTasks, source)
                                                                         end
                                end
                            )
                        end

                        function webhooklog(a, b, d, e, f)
                            if Aspect.VPNBlocker.Enabled then
                                if Aspect.VPNBlocker.Logs.Webhook ~= "" or Aspect.VPNBlocker.Logs.Webhook ~= nil then
                                    PerformHttpRequest(
                                        Aspect.VPNBlocker.Logs.Webhook,
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                embeds = {
                                                    {
                                                        author = {
                                                            name = "Aspect-AC | AntiVPN",
                                                            icon_url = "https://cdn.discordapp.com/attachments/864647682949251123/882071604950085642/image0.gif"
                                                        },
                                                        title = "Connection " .. a,
                                                        description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                                                        color = f
                                                    }
                                                }
                                            }
                                        ),
                                        {["Content-Type"] = "application/json"}
                                    )
                                else
                                    print(
                                        "^3 AntiVPN^0: ^1Discord Webhook link missing, You're not going to get any log.^0"
                                    )
                                end
                            end
                        end

                        if Aspect.VPNBlocker.Enabled then
                            local function OnPlayerConnecting(name, setKickReason, deferrals)
                                local ip = tostring(GetPlayerEndpoint(source))
                                deferrals.defer()
                                Wait(0)
                                deferrals.update("^[Aspect-AC]: Checking VPN...")
                                PerformHttpRequest(
                                    "https://blackbox.ipinfo.app/lookup/" .. ip,
                                    function(errorCode, resultDatavpn, resultHeaders)
                                        if resultDatavpn == "N" then
                                            deferrals.done()
                                        else
                                            print(
                                                "^3 [Aspect-AC]^0 ^1Player ^0" ..
                                                    name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                            )
                                            if Aspect.VPNBlocker.Logs.Enabled then
                                                webhooklog("Unauthorized", name, ip, "VPN Detected...", 16711680)
                                            end
                                            deferrals.done("[Aspect-AC]: Please disable your VPN connection.")
                                        end
                                    end
                                )
                            end

                            AddEventHandler("playerConnecting", OnPlayerConnecting)
                        end

                        RegisterServerEvent("VAC:NoClip")
                        AddEventHandler("VAC:NoClip", function(reason)
                            if Aspect.Noclip.Enabled and not IsPlayerAceAllowed(source, "Aspect.Bypass") then
                                local name = GetPlayerName(source)
                                local id = source;
                                local ids = ExtractIdentifiers(id);
                                local steam = ids.steam:gsub("steam:", "");
                                local steamDec = tostring(tonumber(steam,16));
                                if counter[ids.steam] ~= nil then 
                                    counter[ids.steam] = counter[ids.steam] + 1;
                                else 
                                    counter[ids.steam] = 1;
                                end
                                if counter[ids.steam] ~= nil and counter[ids.steam] >= Aspect.Noclip.TriggerCount then 
                                    steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                    local gameLicense = ids.license;
                                    local discord = ids.discord;
                                        LogBanToDiscord(source, "Player Attempted To No-Clip", "basic")
                                        ban(id, reason);
                                    end
                                    DropPlayer(id, reason)
                                end
                                    end)
                        

RegisterNetEvent("VAC:SpectateTrigger")
AddEventHandler("VAC:SpectateTrigger", function(reason)
    
    if Aspect.Spectate.Enabled and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.Spectate.Enabled then 
                LogBanToDiscord(source, "Atempted To Spectate Another Player", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)


          
                    local FRAMEWORK =
                    Aspect.Framework
                        FRAMEWORK = nil
                        TriggerEvent(
                            "" .. Aspect.SharedObject .. "",
                            function(obj)
                                FRAMEWORK = obj
                            end
                        )
                        local allowedJobs = Aspect.Tazers.ESX.WhitelistedJobs

                        AddEventHandler(
                            "weaponDamageEvent",
                            function(sender, data)
                                if Aspect.Tazers.Enabled then
                                    local allowed = false
                                    if sender ~= nil then
                                        if data.damageType ~= 0 then
                                            if data.weaponDamage == 1 then
                                                local xPlayer = FRAMEWORK.GetPlayerFromId(sender)
                                                if xPlayer ~= nil then
                                                    for k, v in pairs(allowedJobs) do
                                                        if xPlayer.job ~= nil and xPlayer.job.name == v then
                                                            allowed = true
                                                            break
                                                        end
                                                    end
                                                    if not allowed then
                                                        CancelEvent()
                                                        LogBanToDiscord(owner, "Tried to taze a player", "basic")
                                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, owner)
                                                                                                          end
                                                end
                                            end
                                        end
                                    end
                                end

                                local Charset = {}
                                for i = 65, 90 do
                                    table.insert(Charset, string.char(i))
                                end
                                for i = 97, 122 do
                                    table.insert(Charset, string.char(i))
                                end

                                function RandomLetter(length)
                                    if length > 0 then
                                        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
                                    end

                                    return ""
                                end
                            end
                        )
                    end
            ) 

       
    

-- [Weapon Server Event]
            RegisterNetEvent("VAC:WeaponFlag")
            AddEventHandler("VAC:WeaponFlag", function(reason)
                if Aspect.AntiWeapons and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                    local id = source;
                    local ids = ExtractIdentifiers(id);
                    local steam = ids.steam:gsub("steam:", "");
                    local steamDec = tostring(tonumber(steam,16));
                    steam = "https://steamcommunity.com/profiles/" .. steamDec;
                    local gameLicense = ids.license;
                    local discord = ids.discord;
                    if Aspect.AntiWeapons then 
                        LogBanToDiscord(source, "Player Had A Blacklisted Weapon", "basic")
                        ban(id, reason);
                    end
                    DropPlayer(id, reason)
                end
            end)
-- Damage Multipier
RegisterNetEvent("VAC:Teleport")
AddEventHandler("VAC:Teleport", function(reason)
    if Aspect.AntiTeleport and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.AntiTeleport then 
                LogBanToDiscord(source, "Attempted To Teleport", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

-- end of damage multiplier



-- end of Infinite Ammo Event

-- Super Jump Event
RegisterNetEvent("VAC:Superjump")
AddEventHandler("VAC:Superjump", function(reason)
    if Aspect.AntiSuperJump and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.AntiSuperJump then 
                LogBanToDiscord(source, "Player Enabled Super Jump", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

-- end of Super Jump Event

RegisterNetEvent("VAC:AntiGodMode")
AddEventHandler("VAC:AntiGodMode", function(reason)
    if Aspect.AntiGodmode and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.AntiGodmode then 
                LogBanToDiscord(source, "Player Enabled Godmode", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

-- Speed Modifer Event
RegisterNetEvent("VAC:Speed")
AddEventHandler("VAC:Speed", function(reason)
    if Aspect.AntiSpeedHack and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.AntiSpeedHack then 
            LogBanToDiscord(source, "Player Enabled Ped Speed Modifier", "basic")
            ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)
RegisterNetEvent("VAC:ThermalVision")
AddEventHandler("VAC:ThermalVision", function(reason)
    if Aspect.AntiThermalVision and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
    local id = source;
    local ids = ExtractIdentifiers(id);
    local steam = ids.steam:gsub("steam:", "");
    local steamDec = tostring(tonumber(steam,16));
    steam = "https://steamcommunity.com/profiles/" .. steamDec;
    local gameLicense = ids.license;
    local discord = ids.discord;
    if Aspect.AntiThermalVision then 
            LogBanToDiscord(source, "Player Enabled Thermal Vision", "basic")
            ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

RegisterNetEvent("VAC:AntiTeleport")
AddEventHandler("VAC:AntiTeleport", function(reason)
    if Aspect.AntiTeleport and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Aspect.AntiTeleport then 
                LogBanToDiscord(source, "Player Attempted To Teleport", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

            RegisterNetEvent("VAC:AntiInvisble")
            AddEventHandler("VAC:AntiInvisble", function(reason)
                if Aspect.AntiInvisble and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                    local id = source;
                    local ids = ExtractIdentifiers(id);
                    local steam = ids.steam:gsub("steam:", "");
                    local steamDec = tostring(tonumber(steam,16));
                    steam = "https://steamcommunity.com/profiles/" .. steamDec;
                    local gameLicense = ids.license;
                    local discord = ids.discord;
                    if Aspect.AntiInvisble then 
                            LogBanToDiscord(source, "Player Enabled Invisibility", "basic")
                            ban(id, reason);
                        end
                        DropPlayer(id, reason)
                    end
                        end)
                        RegisterNetEvent("VAC:AntiNightVision")
                        AddEventHandler("VAC:AntiNightVision", function(reason)
                            if Aspect.AntiNightVision and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                local id = source;
                                local ids = ExtractIdentifiers(id);
                                local steam = ids.steam:gsub("steam:", "");
                                local steamDec = tostring(tonumber(steam,16));
                                steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                local gameLicense = ids.license;
                                local discord = ids.discord;
                                if Aspect.AntiNightVision then 
                                        LogBanToDiscord(source, "Player Enabled Night Vision", "basic")
                                        ban(id, reason);
                                    end
                                    DropPlayer(id, reason)
                                end
                                    end)      
                                    RegisterNetEvent("VAC:AntiPlayerBlips")
                                    AddEventHandler("VAC:AntiPlayerBlips", function(reason)
                                        if Aspect.AntiBlips and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                            local id = source;
                                            local ids = ExtractIdentifiers(id);
                                            local steam = ids.steam:gsub("steam:", "");
                                            local steamDec = tostring(tonumber(steam,16));
                                            steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                            local gameLicense = ids.license;
                                            local discord = ids.discord;
                                            if Aspect.AntiBlips then 
                                                    LogBanToDiscord(source, "Player Enabled Player Blips", "basic")
                                                    ban(id, reason);
                                                end
                                                DropPlayer(id, reason)
                                            end
                                                end)         
                                                RegisterNetEvent("VAC:BlacklistedKeys")
                                                AddEventHandler("VAC:BlacklistedKeys", function(reason)
                                                    if Aspect.AntiKey and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                                        local id = source;
                                                        local ids = ExtractIdentifiers(id);
                                                        local steam = ids.steam:gsub("steam:", "");
                                                        local steamDec = tostring(tonumber(steam,16));
                                                        steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                        local gameLicense = ids.license;
                                                        local discord = ids.discord;
                                                        if Aspect.AntiKey then 
                                                                LogBanToDiscord(source, "Player Used A Blacklisted Key", "basic")
                                                                ban(id, reason);
                                                            end
                                                            DropPlayer(id, reason)
                                                        end
                                                            end)                                                    
                                                                        RegisterNetEvent("VAC:VehicleModifier")
                                                                        AddEventHandler("VAC:VehicleModifier", function(reason)
                                                                            if Aspect.AntiVehicleModifiers and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                                                                local id = source;
                                                                                local ids = ExtractIdentifiers(id);
                                                                                local steam = ids.steam:gsub("steam:", "");
                                                                                local steamDec = tostring(tonumber(steam,16));
                                                                                steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                local gameLicense = ids.license;
                                                                                local discord = ids.discord;
                                                                                if Aspect.AntiVehicleModifiers then 
                                                                                        LogBanToDiscord(source, "Player Enabled Vehicle Power Modifer", "basic")
                                                                                        ban(id, reason);
                                                                                    end
                                                                                    DropPlayer(id, reason)
                                                                                end
                                                                                    end)           
                                                                                    RegisterNetEvent("VAC:AntiGiveArmour")
                                                                                    AddEventHandler("VAC:AntiGiveArmour", function(reason)
                                                                                        if Aspect.AntiGiveArmour and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                                                                            local id = source;
                                                                                            local ids = ExtractIdentifiers(id);
                                                                                            local steam = ids.steam:gsub("steam:", "");
                                                                                            local steamDec = tostring(tonumber(steam,16));
                                                                                            steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                            local gameLicense = ids.license;
                                                                                            local discord = ids.discord;
                                                                                            if Aspect.AntiGiveArmour then 
                                                                                                    LogBanToDiscord(source, "Player Tried Giving Themselves Armour", "basic")
                                                                                                    ban(id, reason);
                                                                                                end
                                                                                                DropPlayer(id, reason)
                                                                                            end
                                                                                                end)  
                                                                                                RegisterNetEvent("VAC:resourcestopandstart")
                                                                                                AddEventHandler("VAC:resourcestopandstart", function(reason)
                                                                                                    if Aspect.AntiResourceStartandStop and not IsPlayerAceAllowed(source, "Aspect.Bypass") then 
                                                                                                        local id = source;
                                                                                                        local ids = ExtractIdentifiers(id);
                                                                                                        local steam = ids.steam:gsub("steam:", "");
                                                                                                        local steamDec = tostring(tonumber(steam,16));
                                                                                                        steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                                        local gameLicense = ids.license;
                                                                                                        local discord = ids.discord;
                                                                                                        if Aspect.AntiResourceStartandStop then 
                                                                                                                LogBanToDiscord(source, "Player Tried To Stop/Start A Resource", "basic")
                                                                                                                ban(id, reason);
                                                                                                            end
                                                                                                            DropPlayer(id, reason)
                                                                                                        end
                                                                                                            end)  

                                                                                                            if Aspect.WordsProtection then
                                                                                                                AddEventHandler(
                                                                                                                    "chatMessage",
                                                                                                                    function(source, n, message)
                                                                                                                        for k, n in pairs(Aspect.BlacklistedWords) do
                                                                                                                            if string.match(message:lower(), n:lower()) then
                                                                                                                                LogBanToDiscord(source, "Tried to say : " .. n,"basic")
                                                                                                                                TriggerEvent("aopkfgebjzhfpazf77", " [Aspect-AC] : Blacklisted Word", source)
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                )
