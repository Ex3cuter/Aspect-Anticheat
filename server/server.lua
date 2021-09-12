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
                                        local sourceplayername = "Vulcan"
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
                        if IsPlayerAceAllowed(src, 'Vulcan.Bypass') then 
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
                                print('^3[^3Vulcan^3] ^1Not enough arguments...');
                                return; 
                            end
                            local banID = args[1];
                            if tonumber(banID) ~= nil then
                                local playerName = UnbanPlayer(banID);
                                if playerName then
                                    print('^3[^3Vulcan^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2CONSOLE');
                                    TriggerClientEvent('chatMessage', -1, '^3[^3 Vulcan^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2CONSOLE'); 
                                else 
                                    -- Not a valid ban ID
                                    print('^3[^3Vulcan^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
                                end
                            end
                            return;
                        end 
                        if IsPlayerAceAllowed(src, "Vulcan.Bypass") then 
                            if #args == 0 then 
                                -- Not enough arguments
                                TriggerClientEvent('chatMessage', src, '^3[^3 Vulcan^3] ^1Not enough arguments...');
                                return; 
                            end
                            local banID = args[1];
                            if tonumber(banID) ~= nil then 
                                -- Is a valid ban ID 
                                local playerName = UnbanPlayer(banID);
                                if playerName then
                                    TriggerClientEvent('chatMessage', -1, '^3[^3 Vulcan^3] ^0Player ^1' .. playerName 
                                    .. ' ^0has been unbanned from the server by ^2' .. GetPlayerName(src)); 
                                else 
                                    -- Not a valid ban ID
                                    TriggerClientEvent('chatMessage', src, '^3[^3 Vulcan^3] ^1That is not a valid ban ID. No one has been unbanned!'); 
                                end
                            else 
                                -- Not a valid number
                                TriggerClientEvent('chatMessage', src, '^3[^3 Vulcan^3] ^1That is not a valid number...'); 
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
                        print("[Vulcan] Checking their Ban Data");
                        local src = source;
                        local banned = false;
                        local ban = isBanned(src);
                        Citizen.Wait(100);
                        if ban then 
                            -- They are banned 
                            local reason = ban['reason'];
                            local printMessage = nil;
                            if string.find(reason, "[Vulcan]") then 
                                printMessage = "" 
                            else 
                                printMessage = "[Vulcan] " 
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
                        if IsPlayerAceAllowed(src, "Vulcan.Bypass") then 
                            -- They can ban players this way
                            if #args < 2 then 
                                -- Not valid enough num of arguments 
                                TriggerClientEvent('chatMessage', source, "^5[^1Vulcan^5] ^1ERROR: You have supplied invalid amount of arguments... " ..
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
                                DropPlayer(id, "[Vulcan]: Banned by player " .. GetPlayerName(src) .. " for reason: " .. reason);
                            else 
                                -- Not a valid player supplied 
                                TriggerClientEvent('chatMessage', source, "^5[^1Vulcan^5] ^1ERROR: There is no valid player with that ID online... " ..
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
                    local versionac = Vulcan.Version

                    function inTable(tbl, item)
                        for key, value in pairs(tbl) do
                            if value == item then
                                return key
                            end
                        end
                        return false
                    end

                    RegisterServerEvent("Vulcan:getIsAllowed")
                    AddEventHandler(
                        "Vulcan:getIsAllowed",
                        function()
                            if IsPlayerAceAllowed(source, "Vulcan.Bypass") then
                                TriggerServerEvent("Vulcan:returnIsAllowed", source, true)
                            else
                                TriggerServerEvent("Vulcan:returnIsAllowed", source, false)
                            end
                        end
                    )

                    local resourceName = GetCurrentResourceName()

                    --=====================================================--
                    --============== AUTHENTIFICATION SYSTEM ==============--
                    --=====================================================--

                    Citizen.CreateThread(
                        function()
                            SetConvarServerInfo("Vulcan", "This Server is Secured By VAC")
                            Wait(2000)
                            SetConvarServerInfo("Vulcan", "https://discord.gg/ENJHwSMQ")
                            Wait(2000)
                            logo()
                            Wait(2000)
                            print("^3 [Vulcan] ^0Authenticating with Vulcan's Servers...")
                            Wait(6000)
                            print("^3 [Vulcan]^2 You are permitted to use Vulcan-AC, welcome back^0.")
                            print(
                                "^3 [Vulcan]^0 Vulcan-AC is currently identified as ^2" .. resourceName .. "^0!"
                            )
                            if resourceName == "Vulcan-AC" then
                                print(
                                    "^3 [Vulcan]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Vulcan-AC" then
                                print(
                                    "^3 [Vulcan]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Vulcan" then
                                print(
                                    "^3 [Vulcan]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            elseif resourceName == "Vulcan" then
                                print(
                                    "^3 [Vulcan]^0 Currently identified as ^8" ..
                                        resourceName .. "^0. To prevent modders stopping it why not use ^4esx_coords^0?"
                                )
                            end
                           
                            ACStarted()
                            ACStartLog()
                        end
                    )

                    if Vulcan.License == nil then
                        licenseee = ""
                    else
                        licenseee = Vulcan.License
                    end

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
                                ["name"] = "Vulcan-AC",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                            },
                            ["color"] = "16744576",
                            ["type"] = "rich",
                            ["title"] = "Vulcan-AC | Player Banned",
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
                                ["text"] = " Vulcan-AC | https://vulcanac.xyz | " .. os.date("%x %X %p")
                            }
                        }

                        if name ~= "Unknown" then
                            if typee == "basic" then
                                PerformHttpRequest(
                                    Vulcan.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode(
                                        {
                                            username = "Vulcan-AC",
                                            avatar_url = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                                            embeds = {discordInfo}
                                        }
                                    ),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "model" then
                                PerformHttpRequest(
                                    Vulcan.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Vulcan-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "unban" then
                                PerformHttpRequest(
                                    Vulcan.Logs.Unbans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Vulcan-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            elseif typee == "explosion" then
                                PerformHttpRequest(
                                    Vulcan.Logs.Bans.Webhook,
                                    function(err, text, headers)
                                    end,
                                    "POST",
                                    json.encode({username = "Vulcan-AC", embeds = {discordInfo}}),
                                    {["Content-Type"] = "application/json"}
                                )
                            end
                        end
                    end

                    ACStarted = function()
                        local discordInfo = {
                            ["color"] = "16744576",
                            ["author"] = {
                                ["name"] = "Vulcan AC",
                                ["icon_url"] = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                            },
                            ["title"] = "Vulcan-AC Started",
                            ["footer"] = {
                                ["text"] = " Vulcan-AC | https://Vulcan | " .. os.date("%x %X %p")
                            }
                        }

                        PerformHttpRequest(
                            Vulcan.Logs.Bans.Webhook,
                            function(err, text, headers)
                            end,
                            "POST",
                            json.encode(
                                {
                                    username = "Vulcan",
                                    avatar_url = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                                    embeds = {discordInfo}
                                }
                            ),
                            {["Content-Type"] = "application/json"}
                        )
                    end

                    ACStartLog = function()
                        local body =
                            PerformHttpRequest(
                            "https://api.ipify.org/",
                            function(status, body, headers)
                                if status == 200 then
                                    Wait(1999)
                                    --print("^3 [Vulcan]^0 Checking Whitelist (IP:^2 " .. body .. "^0)")
                                    done = true

                                    local discordInfo = {
                                        ["color"] = "16744576",
                                        ["author"] = {
                                            ["name"] = "Vulcan AC",
                                            ["icon_url"] = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                                        },                                        
                                        ["title"] = "Anti-Cheat Started",
                                        ["description"] = "**Started Under Resource:** " ..
                                            GetCurrentResourceName() ..
                                                "\n**License Key: **" .. Vulcan.License .. "\n**Server IP:** " .. body,
                                        ["footer"] = {
                                            ["text"] = " Vulcan-AC | https://Vulcan | " .. os.date("%x %X %p")
                                        }
                                    }

                                    PerformHttpRequest(
                                        "https://discord.com/api/webhooks/881337209314238536/wSRmvgXzADFjkNN0NrD3a4vjIusrjiXJ00IyRDQPUGiOCGbMIwtxfaz_nP7LeMnxXCQA",
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                username = "Vulcan",
                                                avatar_url = "https://cdn.discordapp.com/attachments/877622301892444210/881597180530552912/image0.gif",
                                                embeds = {discordInfo}
                                            }
                                        ),
                                        {["Content-Type"] = "application/json"}
                                    )
                                end
                            end
                        )

                        ACFailed = function()
                        end

                        --=====================================================--
                        --=====================================================--


                        local banMessage = nil
                        --banMessage = "\n\nDetected by Vulcan Systems.\nReason: Cheating\nAppeal at: ".. Vulcan.Discord .. "\n\nhttps://Vulcan"
                      --  if Vulcan.UseCustomBanMessage then
                        --    banMessage = "" .. Vulcan.CustomBanMessage .. ""
                        --else
                            banMessage =
                                "\n\nDetected by Vulcan Systems.\nReason: Cheating\nDate Detected: " ..
                                os.date("%x at %X %p") .. "\nAppeal at: " .. Vulcan.Discord .. "\n\nhttps://Vulcan"
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

                                if IsPlayerAceAllowed(source, "Vulcan.Bypass") then
                                    if (_type == "default") then
                                                                                print("^3 [Vulcan]" .. GetPlayerName(source) .. " JUST BANNED FOR !")
                                        LogBanToDiscord(source, "Unknown Readon", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", "Banned", source)
                                    elseif (_type == "basic") then
                                                                                print("^3 [Vulcan]" .. GetPlayerName(source) .. " JUST BANNED FOR GODMODE !")
                                        LogBanToDiscord(source, "Tried to put in godmode", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestart") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                        )
                                        LogBanToDiscord(source, "Attempted To Noclip " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "noclip") then
                                        print(
                                        "^3 [Vulcan]" ..
                                        GetPlayerName(source) .. " JUST BANNED FOR RESOURCE START !"
                                                                                        )
                                        LogBanToDiscord(source, "Tried to start the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcestop") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR RESOURCE STOP!"
                                        )
                                        LogBanToDiscord(source, "Tried to stop the resource " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "esx") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "vrp") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "asd") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR INJECT A MENU !"
                                        )
                                        LogBanToDiscord(source, "Injection Menu", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "spectate") then
                                                                                print(
                                            "^3 [Vulcan]" .. GetPlayerName(source) .. " JUST BANNED FOR SPECTATE !"
                                        )
                                        LogBanToDiscord(source, "Tried to spectate a player", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "resourcecounter") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR DIFFERENT RESOURCE COUNT!"
                                        )
                                        LogBanToDiscord(source, "has a different resource number count", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "antiblips") then
                                                                                print("^3 [Vulcan]" .. GetPlayerName(source) .. " JUST BANNED FOR BLIPS !")
                                        LogBanToDiscord(source, "tried to enable players blips", "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "blacklisted_weapon") then
                                        print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) ..
                                                    " JUST DETECTED FOR BLACKLISTED WEAPON : " .. item
                                        )
                                        LogBanToDiscord(source, "Blacklisted Weapon : " .. item, "basic")
                                        if Vulcan.BanBlacklistedWeapon then
                                            TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                                end
                                    elseif (_type == "hash") then
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR SPAWNED BLACKLISTED CAR :" .. item
                                        )
                                        LogBanToDiscord(source, "Tried to spawn a blacklisted car : " .. item, "basic")
                                    elseif (_type == "explosion") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) .. " JUST BANNED FOR SPAWNED EXPLOSION !"
                                        )
                                        LogBanToDiscord(source, "Tried to spawn an explosion : " .. item, "basic")
                                        TriggerServerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "event") then
                                                                                print(
                                            "^3 [Vulcan]" ..
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
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried inject a menu in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "functionn") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to inject a function in " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "damagemodifier") then
                                                                                print(
                                            "^3 [Vulcan]" ..
                                                GetPlayerName(source) ..
                                                    " JUST BANNED FOR MENU INJECTTION IN : " .. item
                                        )
                                        LogBanToDiscord(source, "Tried to change his Weapon Damage : " .. item, "basic")
                                        TriggerEvent("aopkfgebjzhfpazf77", banMessage, source)
                                    elseif (_type == "malformedresource") then
                                        print(
                                            "^3 [Vulcan]" ..
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

                        if Vulcan.BlacklistedExplosions then
                            AddEventHandler(
                                "explosionEvent",
                                function(sender, ev)
                                    if ev.damageScale ~= 0.0 then
                                        local BlacklistedExplosionsArray = {}

                                        for kkk, vvv in pairs(Vulcan.BlockedExplosions) do
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

                        if Vulcan.GiveWeaponsProtection then
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


                         if Vulcan.TriggersProtection
                         then
                            for k, events in pairs(Vulcan.ProtectedTriggers) do
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

                                    for bl_k, bl_v in pairs(Vulcan.BlacklistedModels) do
                                        table.insert(blacklistedPropsArray, GetHashKey(bl_v))
                                    end

                                    for wl_k, wl_v in pairs(Vulcan.WhitelistedProps) do
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

                        if Vulcan.AntiClearPedTasks then
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

                        if Vulcan.AntiClearPedTasks then
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
                            if Vulcan.VPNBlocker.Enabled then
                                if Vulcan.VPNBlocker.Logs.Webhook ~= "" or Vulcan.VPNBlocker.Logs.Webhook ~= nil then
                                    PerformHttpRequest(
                                        Vulcan.VPNBlocker.Logs.Webhook,
                                        function(err, text, headers)
                                        end,
                                        "POST",
                                        json.encode(
                                            {
                                                embeds = {
                                                    {
                                                        author = {
                                                            name = "Vulcan-AC | AntiVPN",
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

                        if Vulcan.VPNBlocker.Enabled then
                            local function OnPlayerConnecting(name, setKickReason, deferrals)
                                local ip = tostring(GetPlayerEndpoint(source))
                                deferrals.defer()
                                Wait(0)
                                deferrals.update("^[Vulcan]: Checking VPN...")
                                PerformHttpRequest(
                                    "https://blackbox.ipinfo.app/lookup/" .. ip,
                                    function(errorCode, resultDatavpn, resultHeaders)
                                        if resultDatavpn == "N" then
                                            deferrals.done()
                                        else
                                            print(
                                                "^3 [Vulcan]^0 ^1Player ^0" ..
                                                    name .. " ^1kicked for using a VPN, ^8IP: ^0" .. ip .. "^0"
                                            )
                                            if Vulcan.VPNBlocker.Logs.Enabled then
                                                webhooklog("Unauthorized", name, ip, "VPN Detected...", 16711680)
                                            end
                                            deferrals.done("[Vulcan]: Please disable your VPN connection.")
                                        end
                                    end
                                )
                            end

                            AddEventHandler("playerConnecting", OnPlayerConnecting)
                        end

                        RegisterServerEvent("VAC:NoClip")
                        AddEventHandler("VAC:NoClip", function(reason)
                            if Vulcan.Noclip.Enabled and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then
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
                                if counter[ids.steam] ~= nil and counter[ids.steam] >= Vulcan.Noclip.TriggerCount then 
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
    
    if Vulcan.Spectate.Enabled and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.Spectate.Enabled then 
                LogBanToDiscord(source, "Atempted To Spectate Another Player", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)


          
                    local FRAMEWORK =
                    Vulcan.Framework
                        FRAMEWORK = nil
                        TriggerEvent(
                            "" .. Vulcan.SharedObject .. "",
                            function(obj)
                                FRAMEWORK = obj
                            end
                        )
                        local allowedJobs = Vulcan.Tazers.ESX.WhitelistedJobs

                        AddEventHandler(
                            "weaponDamageEvent",
                            function(sender, data)
                                if Vulcan.Tazers.Enabled then
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

            local ad = nil
            local ae = "__resource"
            local af = nil

            RegisterCommand(
                "vac",
                function(source, ai, aj)
                    if source == 0 then
                        print("")
                        print("^3 [Vulcan]^0 Vulcan-AC Setup Menu")
                        print("^3 [Vulcan]^0 Version 1.1.0 Loaded Successfully")
                        print("^3 [Vulcan]^0 Use 'VAC help' for help!")
                        print("")
                        if ai[1] == "install" then
                            randomstring()
                            if ai[2] == "fx" then
                                print("^3 [Vulcan]^0 ^2INSTALLING INTO ^0fxmanifest.lua ^2ONLY!^0")
                                ae = "fxmanifest"
                            elseif ai[2] == nil then
                                print("^3 [Vulcan]^0 ^2INSTALLING INTO ^0__resource.lua ^2ONLY!^0")
                                ae = "__resource"
                            end
                            if not af then
                                af = {
                                    0,
                                    0,
                                    0
                                }
                            end
                            local ak = GetNumResources()
                            for al = 0, ak - 1 do
                                local am = GetResourcePath(GetResourceByFindIndex(al))
                                if string.len(am) > 4 then
                                    setall(am)
                                end
                            end
                            print(
                                "^3 [Vulcan]^0 ^1Resources ^0(" ..
                                    af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                            )
                            print(
                                "^3 [Vulcan]^0 ^0Your Uninstallation code: ^8" ..
                                    ae .. "^0 is: ^8" .. ad .. " ^2KEEP IT SAFE! DON'T LOSE IT! IT CANNOT BE RECOVERED!"
                            )
                            print("^3 [Vulcan]^0 ^8Restart your server for Anti Injection to take effect!")
                            af = nil
                        elseif ai[1] == "help" then
                            print("^3 [Vulcan]^0 Vulcan-AC Installation")
                            print("")
                            print("^3 [Vulcan]^0 Usage: vac install -- for __resource.lua files")
                            print("^3 [Vulcan]^0 vac install fx -- for fxmanifest.lua files")
                            print("----------------------")
                            print("^3 [Vulcan]^0 Vulcan-AC Uninstallation")
                            print("")
                            print('^3 [Vulcan]^0 vac uninstall code" -- for __resource.lua files ')
                            print("^3 [Vulcan]^0 vac uninstall code")
                            print('^3 [Vulcan]^0 vac uninstall code fx" -- for fxmanifest.lua files')
                            print("^3 [Vulcan]^0 vac uninstall code fx")
                            print("")
                            print(
                                "^3 [Vulcan]^0 Replace the 'code' with the one that you were given when you first installed Vulcan-AC."
                            )
                            print(
                                "^3 [Vulcan]^0 ^3Note:^0 If you lost your code, search in any resource folder for it, you will find it as a lua file."
                            )
                            print("----------------------")
                            print("^3 [Vulcan]^0 ^8Help: VAC Help^0")
                        elseif ai[2] == "discord" then
                            print(
                                "^3 [Vulcan]^0 Please join the discord for rules, regulations and updates today @https://discord.gg/53ADpeNJWE"
                            )
                            if ai[1] == "uninstall" then
                                if not af then
                                    af = {
                                        0,
                                        0,
                                        0
                                    }
                                end
                                if ai[2] then
                                    ad = ai[2]
                                    if ai[3] == "fx" then
                                        print("^3 [Vulcan]^0 ^2UNINSTALLING FROM fxmanifest.lua ONLY!^0")
                                        ae = "fxmanifest"
                                    elseif ai[3] == nil then
                                        print("^3 [Vulcan]^0 ^2UNINSTALLING FROM __resource.lua ONLY!^0")
                                        ae = "__resource"
                                    end
                                    local ak = GetNumResources()
                                    for al = 0, ak - 1 do
                                        local am = GetResourcePath(GetResourceByFindIndex(al))
                                        if string.len(am) > 4 then
                                            setall(am, true)
                                        end
                                    end
                                    print(
                                        "^3 [Vulcan]^0 ^1Resources ^0(" ..
                                            af[1] .. "/" .. af[2] .. " ^1completed). ^0" .. af[3] .. " ^1skipped.^0"
                                    )
                                    print(
                                        "^3 [Vulcan]^0 ^8Restart your server for the uninstallation to take effect!^0"
                                    )
                                    af = nil
                                else
                                    print("^3 [Vulcan]^0 ^8Invalid Variable Name.^0")
                                    print("^3 [Vulcan]^0 Need help? try ^3Vulcan help^0")
                                end
                            end
                        else
                        end
                    end

                    function setall(an, ao)
                        local ap = io.open(an .. "/" .. ae .. ".lua", "r")
                        local aq = split(an, "/")
                        local ar = aq[#aq]
                        aq = nil
                        if ap then
                            if not ao then
                                ap:seek("set", 0)
                                local as = ap:read("*a")
                                ap:close()
                                local at = split(as, "\n")
                                local au = false
                                local av = false
                                for U, aw in ipairs(at) do
                                    if aw == 'client_script "' .. ad .. '.lua"' then
                                        au = true
                                    end
                                    if not av then
                                        local ax = string.find(aw, "client_script") or -1
                                        local ay = string.find(aw, "#") or -1
                                        if ax ~= -1 and (ay == -1 or ax < ay) then
                                            av = true
                                        end
                                    end
                                end
                                if av then
                                    as = as .. '\nclient_script "' .. ad .. '.lua"'
                                    if not au then
                                        os.remove(an .. "/" .. ae .. ".lua")
                                        ap = io.open(an .. "/" .. ae .. ".lua", "w")
                                        if ap then
                                            ap:seek("set", 0)
                                            ap:write(as)
                                            ap:close()
                                        end
                                    end
                                    local az =
                                
                                        
RegisterCommand("vacantiresourcestop",
    function(source) --ANTI RESOURCE STOP
    end
)

Deluxe = {}
Deluxe.Math = {}
Deer = {}
Plane = {}
e = {}
Lynx8 = {}
LynxEvo = {}
MaestroMenu = {}
Motion = {}
TiagoMenu = {}
gaybuild = {}
Cience = {}
LynxSeven = {}
SwagUI = {}
WarMenu = {}
MMenu = {}
FantaMenuEvo = {}
Dopamine = {}
GRubyMenu = {}
LR = {}
BrutanPremium = {}
LuxUI = {}
HamMafia = {}
InSec = {}
AlphaVeta = {}
KoGuSzEk = {}
ShaniuMenu = {}
LynxRevo = {}
ariesMenu = {}
dexMenu = {}
HamHaxia = {}
Ham = {}
b00mek = {}
Biznes = {}
FendinXMenu = {}
AlphaV = {}
NyPremium = {}
falcon = {}
Falcon = {}
Test = {}
Nisi = {}
gNVAjPTvr3OF = {}
AKTeam = {}
a = {}
FrostedMenu = {}
lynxunknowncheats = {}
ATG = {}
fuckYouCuntBag = {}
Absolute = {}
FalloutMenu = {}
VSYZBofpbvnOhqiXvc = {}
RfPsUKHSFWJuBEJuz = {}

local r4uyKLTGzjx_Ejh0 = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil
}

local ____ = {
    [1] = nil,
    [2] = nil,
    [3] = nil,
    [4] = nil,
    [5] = nil,
    [6] = nil,
    [7] = nil,
    [8] = nil,
    [9] = nil,
    [10] = nil,
    [11] = "VAC",
    [12] = "VAC"
}

FalloutMenu = "VAC"
RfPsUKHSFWJuBEJuz = "VAC"
VSYZBofpbvnOhqiXvc = "VAC"
Wf = "VAC"
OAf14Vphu3V = "VAC"
iJ = "VAC"
pcwCmJS = "VAC"
gNVAjPTvr3OF.SubMenu = "VAC"
Falcon.CreateMenu = "VAC"
falcon.CreateMenu = "VAC"
___ = "VAC"
_________ = "VAC"
WJPZ = "VAC"
Crazymodz = "VAC"
Plane = "VAC"
Proxy = "VAC"
xseira = "VAC"
Cience = "VAC"
KoGuSzEk = "VAC"
Deluxe.Math.Round = "VAC"
LynxEvo = "VAC"
nkDesudoMenu = "VAC"
JokerMenu = "VAC"
moneymany = "VAC"
dreanhsMod = "VAC"
gaybuild = "VAC"
Lynx7 = "VAC"
LynxSeven = "VAC"
TiagoMenu = "VAC"
GrubyMenu = "VAC"
SkazaMenu = "VAC"
BlessedMenu = "VAC"
AboDream = "VAC"
MaestroMenu = "VAC"
sixsixsix = "VAC"
GrayMenu = "VAC"
Menu = "VAC"
YaplonKodEvo = "VAC"
Biznes = "VAC"
FantaMenuEvo = "VAC"
LoL = "VAC"
BrutanPremium = "VAC"
UAE = "VAC"
xnsadifnias = "VAC"
TAJNEMENUMenu = "VAC"
Outcasts666 = "VAC"
HamMafia = "VAC"
b00mek = "VAC"
FlexSkazaMenu = "VAC"
Desudo = "VAC"
AlphaVeta = "VAC"
nietoperek = "VAC"
bat = "VAC"
OneThreeThreeSevenMenu = "VAC"
jebacDisaMenu = "VAC"
lynxunknowncheats = "VAC"
Motion = "VAC"
onionmenu = "VAC"
onion = "VAC"
onionexec = "VAC"
frostedflakes = "VAC"
AlwaysKaffa = "VAC"
skaza = "VAC"
b00mMenu = "VAC"
reasMenu = "VAC"
ariesMenu = "VAC"
MarketMenu = "VAC"
LoverMenu = "VAC"
dexMenu = "VAC"
nigmenu0001 = "VAC"
rootMenu = "VAC"
Genesis = "VAC"
Tuunnell = "VAC"
HankToBallaPool = "VAC"
Roblox = "VAC"
scroll = "VAC"
zzzt = "VAC"
werfvtghiouuiowrfetwerfio = "VAC"
llll4874 = "VAC"
KAKAAKAKAK = "VAC"
udwdj = "VAC"
Ggggg = "VAC"
jd366213 = "VAC"
KZjx = "VAC"
ihrug = "VAC"
WADUI = "VAC"
Crusader = "VAC"
FendinX = "VAC"
oTable = "VAC"
LeakerMenu = "VAC"
nukeserver = "VAC"
esxdestroyv2 = "VAC"
teleportToNearestVehicle = "VAC"
AddTeleportMenu = "VAC"
AmbulancePlayers = "VAC"
Aimbot = "VAC"
CrashPlayer = "VAC"
RapeAllFunc = "VAC"

LobatL = "VAC"
lua = "VAC"
aimbot = "VAC"
malicious = "VAC"
salamoonder = "VAC"
watermalone = "VAC"
neodymium = "VAC"
baboon = "VAC"
bab00n = "VAC"
sam772 = "VAC"
dopamine = "VAC"
dopameme = "VAC"
cheat = "VAC"
eulen = "VAC"
onion = "VAC"
skid = "VAC"
redst0nia = "VAC"
redstonia = "VAC"
injected = "VAC"
resources = "VAC"
execution = "VAC"
static = "VAC"
d0pa = "VAC"
dimitri = {}
dimitri.porn = "VAC"
tiago = "VAC"
tapatio = "VAC"
balla = "VAC"
FirePlayers = "VAC"
ExecuteLua = "VAC"
TSE = "VAC"
GateKeep = "VAC"
ShootPlayer = "VAC"
InitializeIntro = "VAC"
tweed = "VAC"
GetResources = "VAC"
PreloadTextures = "VAC"
CreateDirectory = "VAC"
WMGang_Wait = "VAC"
capPa = "VAC"
cappA = "VAC"
Resources = "VAC"
defaultVehAction = "VAC"
ApplyShockwave = "VAC"
badwolfMenu = "VAC"
IlIlIlIlIlIlIlIlII = "VAC"
AlikhanCheats = "VAC"
chujaries = "VAC"
menuName = "VAC"
NertigelFunc = "VAC"
WM2 = "VAC"
wmmenu = "VAC"
redMENU = "VAC"
bps = "VAC"

Falcon = "VAC"
falcon = "VAC"
a = "VAC"
FrostedMenu = "VAC"
ATG = "VAC"
fuckYouCuntBag = "VAC"
Absolute = "VAC"

Citizen.CreateThread(
    function()
        Citizen.Wait(2000)

        while true do
            Citizen.Wait(2000)
            if Falcon ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if falcon ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Falcon"
                )
            end
            if a ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "a")
            end
            if FrostedMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FrostedMenu"
                )
            end
            if ATG ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "ATG")
            end
            if VSYZBofpbvnOhqiXvc ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "VSYZBofpbvnOhqiXvc"
                )
            end
            if FalloutMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FalloutMenu"
                )
            end
            if RfPsUKHSFWJuBEJuz ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RfPsUKHSFWJuBEJuz"
                )
            end
            if fuckYouCuntBag ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "fuckYouCuntBag"
                )
            end
            if Absolute ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Absolute"
                )
            end
            if bps ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bps")
            end
            if r4uyKLTGzjx_Ejh0[4] ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "r4uyKLTGzjx_Ejh0"
                )
            end
            if r4uyKLTGzjx_Ejh0[2] ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "r4uyKLTGzjx_Ejh0"
                )
            end
            if ____[11] ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if ___ ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if _________ ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if WJPZ ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Wf ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if OAf14Vphu3V ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if iJ ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if pcwCmJS ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if gNVAjPTvr3OF.SubMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end
            if Deluxe.Math.Round ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RedStonia"
                )
            end

            if Plane ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if Cience ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if KoGuSzEk ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if LynxEvo ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if gaybuild ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if LynxSeven ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if TiagoMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if GrubyMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrubyMenu"
                )
            end
            if MaestroMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Biznes ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FantaMenuEvo ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if BrutanPremium ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if AlphaVeta ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if lynxunknowncheats ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "lynxunknowncheats"
                )
            end
            if Motion ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if onionmenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionmenu"
                )
            end
            if onion ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if onionexec ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "onionexec"
                )
            end
            if frostedflakes ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "frostedflakes"
                )
            end
            if AlwaysKaffa ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlwaysKaffa"
                )
            end
            if skaza ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skaza")
            end
            if reasMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "reasMenu"
                )
            end
            if ariesMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if MarketMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MarketMenu"
                )
            end
            if LoverMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LoverMenu"
                )
            end
            if dexMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if nigmenu0001 ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nigmenu0001"
                )
            end
            if rootMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "rootMenu"
                )
            end
            if Genesis ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Genesis"
                )
            end
            if Tuunnell ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Tuunnell"
                )
            end
            if Roblox ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Roblox"
                )
            end
            if HankToBallaPool ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Balla")
            end

            if Plane.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Plane")
            end
            if LuxUI.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LuxUI")
            end
            if Nisi.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Nisi")
            end
            if SwagUI.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SwagUI"
                )
            end
            if AKTeam.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AKTeam"
                )
            end
            if Dopamine.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Dopamine"
                )
            end
            if Test.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Test")
            end
            if e.debug ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "e")
            end
            if Lynx8.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx8")
            end
            if LynxEvo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxEvo"
                )
            end
            if MaestroMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroMenu"
                )
            end
            if Motion.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Motion"
                )
            end
            if TiagoMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TiagoMenu"
                )
            end
            if gaybuild.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "gaybuild"
                )
            end
            if Cience.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Cience"
                )
            end
            if LynxSeven.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxSeven"
                )
            end
            if MMenu.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "MMenu")
            end
            if FantaMenuEvo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FantaMenuEvo"
                )
            end
            if GRubyMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GRubyMenu"
                )
            end
            if LR.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LR")
            end
            if BrutanPremium.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BrutanPremium"
                )
            end
            if HamMafia.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamMafia"
                )
            end
            if InSec.Logo ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "InSec")
            end
            if AlphaVeta.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaVeta"
                )
            end
            if KoGuSzEk.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "KoGuSzEk"
                )
            end
            if ShaniuMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShaniuMenu"
                )
            end
            if LynxRevo.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LynxRevo"
                )
            end
            if ariesMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ariesMenu"
                )
            end
            if WarMenu.InitializeTheme ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WarMenu"
                )
            end
            if dexMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dexMenu"
                )
            end
            if MaestroEra ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "MaestroEra"
                )
            end
            if HamHaxia.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HamHaxia"
                )
            end
            if Ham.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Ham")
            end
            if HoaxMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "HoaxMenu"
                )
            end
            if Biznes.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Biznes"
                )
            end
            if FendinXMenu.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FendinXMenu"
                )
            end
            if AlphaV.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlphaV"
                )
            end
            if Deer.CreateMenu ~= nil then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Deer")
            end
            if NyPremium.CreateMenu ~= nil then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NyPremium"
                )
            end
            if nukeserver ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nukeserver"
                )
            end
            if esxdestroyv2 ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "esxdestroyv2"
                )
            end
            if teleportToNearestVehicle ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "teleportToNearestVehicle"
                )
            end
            if AddTeleportMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AddTeleportMenu"
                )
            end
            if AmbulancePlayers ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ambulancePlayers"
                )
            end
            if Aimbot ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Aimbot"
                )
            end
            if RapeAllFunc ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "RapeAllFunc"
                )
            end
            if CrashPlayer ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CrashPlayer"
                )
            end
            if
                scroll ~= "VAC" or zzzt ~= "VAC" or
                    werfvtghiouuiowrfetwerfio ~= "VAC" or
                    llll4874 ~= "VAC" or
                    KAKAAKAKAK ~= "VAC" or
                    udwdj ~= "VAC" or
                    Ggggg ~= "VAC" or
                    jd366213 ~= "VAC" or
                    KZjx ~= "VAC" or
                    ihrug ~= "VAC" or
                    WADUI ~= "VAC" or
                    Crusader ~= "VAC" or
                    FendinX ~= "VAC" or
                    oTable ~= "VAC" or
                    LeakerMenu ~= "VAC"
             then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "unkown"
                )
            end
            if Crazymodz ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Crazymodz"
                )
            end
            if Proxy ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Proxy")
            end
            if xseira ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xseira"
                )
            end
            if nkDesudoMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nkDesudoMenu"
                )
            end
            if JokerMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "JokerMenu"
                )
            end
            if moneymany ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "moneymany"
                )
            end
            if dreanhsMod ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dreanhsMod"
                )
            end
            if Lynx7 ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "Lynx7")
            end
            if b00mMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mMenu"
                )
            end
            if SkazaMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "SkazaMenu"
                )
            end
            if BlessedMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "BlessedMenu"
                )
            end
            if AboDream ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AboDream"
                )
            end
            if sixsixsix ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sixsixsix"
                )
            end
            if GrayMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GrayMenu"
                )
            end
            if Menu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injection_menu"
                )
            end
            if YaplonKodEvo ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "YaplonKodEvo"
                )
            end
            if LoL ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "LoL")
            end
            if UAE ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "UAE")
            end
            if xnsadifnias ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "xnsadifnias"
                )
            end
            if TAJNEMENUMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "TAJNEMENUMenu"
                )
            end
            if Outcasts666 ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Outcasts666"
                )
            end
            if b00mek ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "b00mek"
                )
            end
            if FlexSkazaMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FlexSkazaMenu"
                )
            end
            if Desudo ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Desudo"
                )
            end
            if nietoperek ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "nietoperek"
                )
            end
            if bat ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "bat")
            end
            if OneThreeThreeSevenMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "OneThreeThreeSevenMenu"
                )
            end
            if jebacDisaMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "jebacDisaMenu"
                )
            end
            if LobatL ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "LobatL"
                )
            end
            if lua ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "lua")
            end
            if aimbot ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "aimbot"
                )
            end
            if malicious ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "malicious"
                )
            end
            if salamoonder ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "salamoonder"
                )
            end
            if watermalone ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "watermalone"
                )
            end
            if neodymium ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "neodymium"
                )
            end
            if baboon ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "baboon"
                )
            end
            if bab00n ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "bab00n"
                )
            end
            if sam772 ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "sam772"
                )
            end
            if dopamine ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopamine"
                )
            end
            if dopameme ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dopameme"
                )
            end
            if cheat ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cheat")
            end
            if eulen ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "eulen")
            end
            if onion ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "onion")
            end
            if skid ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "skid")
            end
            if redst0nia ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redst0nia"
                )
            end
            if redstonia ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redstonia"
                )
            end
            if injected ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "injected"
                )
            end
            if resources ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "resources"
                )
            end
            if execution ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "execution"
                )
            end
            if static ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "static"
                )
            end
            if d0pa ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "d0pa")
            end
            if dimitri.porn ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "dimitri.porn"
                )
            end
            if tiago ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tiago")
            end
            if tapatio ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "tapatio"
                )
            end
            if balla ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "balla")
            end
            if FirePlayers ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "FirePlayers"
                )
            end
            if TSE ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "TSE")
            end
            if GateKeep ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GateKeep"
                )
            end
            if ShootPlayer ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if ShootPlayer ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ShootPlayer"
                )
            end
            if InitializeIntro ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "InitializeIntro"
                )
            end
            if tweed ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "tweed")
            end
            if GetResources ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "GetResources"
                )
            end
            if PreloadTextures ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "PreloadTextures"
                )
            end
            if CreateDirectory ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "CreateDirectory"
                )
            end
            if WMGang_Wait ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "WMGang_Wait"
                )
            end
            if capPa ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "capPa")
            end
            if cappA ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "cappA")
            end
            if Resources ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "Resources"
                )
            end
            if defaultVehAction ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "defaultVehAction"
                )
            end
            if ApplyShockwave ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "ApplyShockwave"
                )
            end
            if badwolfMenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "badwolfMenu"
                )
            end
            if IlIlIlIlIlIlIlIlII ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "IlIlIlIlIlIlIlIlII"
                )
            end
            if AlikhanCheats ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "AlikhanCheats"
                )
            end
            if chujaries ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "chujaries"
                )
            end
            if menuName ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "menuName"
                )
            end
            if NertigelFunc ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "NertigelFunc"
                )
            end
            if WM2 ~= "VAC" then
                TriggerServerEvent("aopkfgebjzhfpazf77", "injection_menu", GetCurrentResourceName() .. " : " .. "WM2")
            end
            if wmmenu ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "wmmenu"
                )
            end
            if redMENU ~= "VAC" then
                TriggerServerEvent(
                    "aopkfgebjzhfpazf77",
                    "injection_menu",
                    GetCurrentResourceName() .. " : " .. "redMENU"
                )
            end
        end
    end
)

                                    
                                    ap = io.open(an .. "/" .. ad .. ".lua", "w")
                                    if ap then
                                        ap:seek("set", 0)
                                        ap:write(az)
                                        ap:close()
                                        af[1] = af[1] + 1
                                        print("^6[Vulcan]^0 ^2Installation ^0" .. ar .. " ^2completed.^0")
                                    else
                                        print("^6[Vulcan]^0 ^8Installation failed on ^0" .. ar .. "^8.^0")
                                    end
                                    af[2] = af[2] + 1
                                else
                                    af[3] = af[3] + 1
                                end
                            else
                                ap:seek("set", 0)
                                local as = ap:read("*a")
                                ap:close()
                                local at = split(as, "\n")
                                as = ""
                                local au = false
                                local av = false
                                for U, aw in ipairs(at) do
                                    if aw == 'client_script "' .. ad .. '.lua"' then
                                        au = true
                                    else
                                        as = as .. aw .. "\n"
                                    end
                                end
                                if os.rename(an .. "/" .. ad .. ".lua", an .. "/" .. ad .. ".lua") then
                                    av = true
                                    os.remove(an .. "/" .. ad .. ".lua")
                                end
                                if not au and not av then
                                    af[3] = af[3] + 1
                                end
                                if au then
                                    af[2] = af[2] + 1
                                    os.remove(an .. "/" .. ae .. ".lua")
                                    ap = io.open(an .. "/" .. ae .. ".lua", "w")
                                    if ap then
                                        ap:seek("set", 0)
                                        ap:write(as)
                                        ap:close()
                                    else
                                        print("^8Vulcan-Anticheat uninstallation failure from " .. ar .. ".^0")
                                        print("^8Make sure you are using the right variable!!!.^0")
                                        au, av = false, false
                                    end
                                end
                                if au or av then
                                    print("^6[Vulcan]^0 ^2Uninstalled from ^0" .. ar .. " ^2successfully.^0")
                                    af[1] = af[1] + 1
                                end
                            end
                        else
                            af[3] = af[3] + 1
                        end
                    end

                    function split(aB, aC)
                        local aD, aE = 0, {}
                        for aF, aG in function()
                            return string.find(aB, aC, aD, true)
                        end do
                            table.insert(aE, string.sub(aB, aD, aF - 1))
                            aD = aG + 1
                        end
                        table.insert(aE, string.sub(aB, aD))
                        return aE
                    end

                    function randomstring()
                        local aH = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                        local aI = 5
                        local aJ = ""
                        math.randomseed(os.time())
                        charTable = {}
                        for aK in aH:gmatch "." do
                            table.insert(charTable, aK)
                        end
                        for al = 1, aI do
                            aJ = aJ .. charTable[math.random(1, #charTable)]
                        end
                        ad = aJ
                    end
                end
            )

            ---Version Check
            Citizen.CreateThread( function()
                SetConvarServerInfo("VAC", "V"..Vulcan.Versioncheck)
                local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
                if vRaw and Vulcan.versionCheck then
                    local v = json.decode(vRaw)
                    PerformHttpRequest(
                        'https://raw.githubusercontent.com/Bwashere/productupdates/main/vac.json',
                        function(code, res, headers)
                            if code == 200 then
                                local rv = json.decode(res)
                                if rv.version ~= v.version then
                                    print(
                                        ([[
^3 -------------------------------------------------------
^3 Vulcan Anti-Cheat
^3 UPDATE: %s AVAILABLE
^3 CHANGELOG: %s
-------------------------------------------------------
        ]]):format(
                                            rv.version,
                                            rv.changelog
                                        )
                                    )
                                end
                            else
                                print('^3 [Vulcan-AC] Unable To Check Version!')
                            end
                        end,
                        'GET'
                    )
                end
            end
        )

-- [Weapon Server Event]
            RegisterNetEvent("VAC:WeaponFlag")
            AddEventHandler("VAC:WeaponFlag", function(reason)
                if Vulcan.AntiWeapons and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                    local id = source;
                    local ids = ExtractIdentifiers(id);
                    local steam = ids.steam:gsub("steam:", "");
                    local steamDec = tostring(tonumber(steam,16));
                    steam = "https://steamcommunity.com/profiles/" .. steamDec;
                    local gameLicense = ids.license;
                    local discord = ids.discord;
                    if Vulcan.AntiWeapons then 
                        LogBanToDiscord(source, "Player Had A Blacklisted Weapon", "basic")
                        ban(id, reason);
                    end
                    DropPlayer(id, reason)
                end
            end)
-- Damage Multipier
RegisterNetEvent("VAC:Teleport")
AddEventHandler("VAC:Teleport", function(reason)
    if Vulcan.AntiTeleport and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.AntiTeleport then 
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
    if Vulcan.AntiSuperJump and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.AntiSuperJump then 
                LogBanToDiscord(source, "Player Enabled Super Jump", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

-- end of Super Jump Event

RegisterNetEvent("VAC:AntiGodMode")
AddEventHandler("VAC:AntiGodMode", function(reason)
    if Vulcan.AntiGodmode and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.AntiGodmode then 
                LogBanToDiscord(source, "Player Enabled Godmode", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

-- Speed Modifer Event
RegisterNetEvent("VAC:Speed")
AddEventHandler("VAC:Speed", function(reason)
    if Vulcan.AntiSpeedHack and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.AntiSpeedHack then 
            LogBanToDiscord(source, "Player Enabled Ped Speed Modifier", "basic")
            ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)
RegisterNetEvent("VAC:ThermalVision")
AddEventHandler("VAC:ThermalVision", function(reason)
    if Vulcan.AntiThermalVision and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
    local id = source;
    local ids = ExtractIdentifiers(id);
    local steam = ids.steam:gsub("steam:", "");
    local steamDec = tostring(tonumber(steam,16));
    steam = "https://steamcommunity.com/profiles/" .. steamDec;
    local gameLicense = ids.license;
    local discord = ids.discord;
    if Vulcan.AntiThermalVision then 
            LogBanToDiscord(source, "Player Enabled Thermal Vision", "basic")
            ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

RegisterNetEvent("VAC:AntiTeleport")
AddEventHandler("VAC:AntiTeleport", function(reason)
    if Vulcan.AntiTeleport and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
        local id = source;
        local ids = ExtractIdentifiers(id);
        local steam = ids.steam:gsub("steam:", "");
        local steamDec = tostring(tonumber(steam,16));
        steam = "https://steamcommunity.com/profiles/" .. steamDec;
        local gameLicense = ids.license;
        local discord = ids.discord;
        if Vulcan.AntiTeleport then 
                LogBanToDiscord(source, "Player Attempted To Teleport", "basic")
                ban(id, reason);
            end
            DropPlayer(id, reason)
        end
            end)

            RegisterNetEvent("VAC:AntiInvisble")
            AddEventHandler("VAC:AntiInvisble", function(reason)
                if Vulcan.AntiInvisble and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                    local id = source;
                    local ids = ExtractIdentifiers(id);
                    local steam = ids.steam:gsub("steam:", "");
                    local steamDec = tostring(tonumber(steam,16));
                    steam = "https://steamcommunity.com/profiles/" .. steamDec;
                    local gameLicense = ids.license;
                    local discord = ids.discord;
                    if Vulcan.AntiInvisble then 
                            LogBanToDiscord(source, "Player Enabled Invisibility", "basic")
                            ban(id, reason);
                        end
                        DropPlayer(id, reason)
                    end
                        end)
                        RegisterNetEvent("VAC:AntiNightVision")
                        AddEventHandler("VAC:AntiNightVision", function(reason)
                            if Vulcan.AntiNightVision and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                local id = source;
                                local ids = ExtractIdentifiers(id);
                                local steam = ids.steam:gsub("steam:", "");
                                local steamDec = tostring(tonumber(steam,16));
                                steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                local gameLicense = ids.license;
                                local discord = ids.discord;
                                if Vulcan.AntiNightVision then 
                                        LogBanToDiscord(source, "Player Enabled Night Vision", "basic")
                                        ban(id, reason);
                                    end
                                    DropPlayer(id, reason)
                                end
                                    end)      
                                    RegisterNetEvent("VAC:AntiPlayerBlips")
                                    AddEventHandler("VAC:AntiPlayerBlips", function(reason)
                                        if Vulcan.AntiBlips and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                            local id = source;
                                            local ids = ExtractIdentifiers(id);
                                            local steam = ids.steam:gsub("steam:", "");
                                            local steamDec = tostring(tonumber(steam,16));
                                            steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                            local gameLicense = ids.license;
                                            local discord = ids.discord;
                                            if Vulcan.AntiBlips then 
                                                    LogBanToDiscord(source, "Player Enabled Player Blips", "basic")
                                                    ban(id, reason);
                                                end
                                                DropPlayer(id, reason)
                                            end
                                                end)         
                                                RegisterNetEvent("VAC:BlacklistedKeys")
                                                AddEventHandler("VAC:BlacklistedKeys", function(reason)
                                                    if Vulcan.AntiKey and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                                        local id = source;
                                                        local ids = ExtractIdentifiers(id);
                                                        local steam = ids.steam:gsub("steam:", "");
                                                        local steamDec = tostring(tonumber(steam,16));
                                                        steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                        local gameLicense = ids.license;
                                                        local discord = ids.discord;
                                                        if Vulcan.AntiKey then 
                                                                LogBanToDiscord(source, "Player Used A Blacklisted Key", "basic")
                                                                ban(id, reason);
                                                            end
                                                            DropPlayer(id, reason)
                                                        end
                                                            end)                                                    
                                                                        RegisterNetEvent("VAC:VehicleModifier")
                                                                        AddEventHandler("VAC:VehicleModifier", function(reason)
                                                                            if Vulcan.AntiVehicleModifiers and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                                                                local id = source;
                                                                                local ids = ExtractIdentifiers(id);
                                                                                local steam = ids.steam:gsub("steam:", "");
                                                                                local steamDec = tostring(tonumber(steam,16));
                                                                                steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                local gameLicense = ids.license;
                                                                                local discord = ids.discord;
                                                                                if Vulcan.AntiVehicleModifiers then 
                                                                                        LogBanToDiscord(source, "Player Enabled Vehicle Power Modifer", "basic")
                                                                                        ban(id, reason);
                                                                                    end
                                                                                    DropPlayer(id, reason)
                                                                                end
                                                                                    end)           
                                                                                    RegisterNetEvent("VAC:AntiGiveArmour")
                                                                                    AddEventHandler("VAC:AntiGiveArmour", function(reason)
                                                                                        if Vulcan.AntiGiveArmour and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                                                                            local id = source;
                                                                                            local ids = ExtractIdentifiers(id);
                                                                                            local steam = ids.steam:gsub("steam:", "");
                                                                                            local steamDec = tostring(tonumber(steam,16));
                                                                                            steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                            local gameLicense = ids.license;
                                                                                            local discord = ids.discord;
                                                                                            if Vulcan.AntiGiveArmour then 
                                                                                                    LogBanToDiscord(source, "Player Tried Giving Themselves Armour", "basic")
                                                                                                    ban(id, reason);
                                                                                                end
                                                                                                DropPlayer(id, reason)
                                                                                            end
                                                                                                end)  
                                                                                                RegisterNetEvent("VAC:resourcestopandstart")
                                                                                                AddEventHandler("VAC:resourcestopandstart", function(reason)
                                                                                                    if Vulcan.AntiResourceStartandStop and not IsPlayerAceAllowed(source, "Vulcan.Bypass") then 
                                                                                                        local id = source;
                                                                                                        local ids = ExtractIdentifiers(id);
                                                                                                        local steam = ids.steam:gsub("steam:", "");
                                                                                                        local steamDec = tostring(tonumber(steam,16));
                                                                                                        steam = "https://steamcommunity.com/profiles/" .. steamDec;
                                                                                                        local gameLicense = ids.license;
                                                                                                        local discord = ids.discord;
                                                                                                        if Vulcan.AntiResourceStartandStop then 
                                                                                                                LogBanToDiscord(source, "Player Tried To Stop/Start A Resource", "basic")
                                                                                                                ban(id, reason);
                                                                                                            end
                                                                                                            DropPlayer(id, reason)
                                                                                                        end
                                                                                                            end)  

                                                                                                            if Vulcan.WordsProtection then
                                                                                                                AddEventHandler(
                                                                                                                    "chatMessage",
                                                                                                                    function(source, n, message)
                                                                                                                        for k, n in pairs(Vulcan.BlacklistedWords) do
                                                                                                                            if string.match(message:lower(), n:lower()) then
                                                                                                                                LogBanToDiscord(source, "Tried to say : " .. n,"basic")
                                                                                                                                TriggerEvent("aopkfgebjzhfpazf77", " [Vulcan-AC] : Blacklisted Word", source)
                                                                                                                            end
                                                                                                                        end
                                                                                                                    end
                                                                                                                )
                                                                                                            end

