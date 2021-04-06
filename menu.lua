ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


function KeyboardInput(textEntry, inputText, maxLength)
    AddTextEntry('FMMC_KEY_TIP1', textEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", inputText, "", "", "", maxLength)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(1.0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end



local hPlainte
    RMenu.Add('hPlainte', 'main', RageUI.CreateMenu(nil, "", 10,222,"police2", "interaction_bgd"))
    RMenu:Get('hPlainte', 'main'):SetSubtitle("~b~Veuillez remplir le formulaire")
    RMenu:Get('hPlainte', 'main').EnableMouse = false
    RMenu:Get('hPlainte', 'main').Closed = function()
        hPlainte = false
end


function IsDateCorrect(date)
    if (string.match(date, "^%d+%p%d+%p%d%d%d%d$")) then
        local d, m, y = string.match(date, "(%d+)%p(%d+)%p(%d+)")
        d, m, y = tonumber(d), tonumber(m), tonumber(y)
        local dm2 = d*m*m
        if  d>31 or m>12 or dm2==0 or dm2==116 or dm2==120 or dm2==124 or dm2==496 or dm2==1116 or dm2==2511 or dm2==3751 then
            if dm2==116 and (y%400 == 0 or (y%100 ~= 0 and y%4 == 0)) then
                return true
            else
                return false
            end
        else
            return true
        end
    else
        return false
    end
end




function openPlainte()
	if not hPlainte then
        hPlainte = true
        local telephone = nil 
        local contre = nil
        local nprenom = nil
        local date = nil
        local texte = nil
        RageUI.Visible(RMenu:Get('hPlainte', 'main'), true)
        
	Citizen.CreateThread(function()
        while hPlainte do
            
			Citizen.Wait(1)
                RageUI.IsVisible(RMenu:Get('hPlainte', 'main'), true, true, true, function()
                    RageUI.ButtonWithStyle("Numéro de téléphone :", nil ,{RightLabel = telephone}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local phone = KeyboardInput('Exemple : 555-9453', "", 8)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            telephone = GetOnscreenKeyboardResult()
                            if telephone == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un numéro de téléphone.')
                            end
                        end 
                    end 
                end)
                    RageUI.ButtonWithStyle("Prénom et nom :", nil ,{RightLabel = nprenom}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local name = KeyboardInput('Exemple : Jordan Isotrope', "", 20)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            nprenom = GetOnscreenKeyboardResult()
                            if nprenom == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un prénom et un nom.')
                            end
                        end 
                    end 
                end)
                RageUI.ButtonWithStyle("Contre :", nil ,{RightLabel = contre}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                local acontre = KeyboardInput('Exemple : Pablo Escobar', "", 20)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0);
                                Citizen.Wait(1)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                contre = GetOnscreenKeyboardResult()
                                if contre == nil then
                                ESX.ShowNotification('~r~Vous devez entrer une personne contre qui vous voulez porter plainte.')
                            end
                        end 
                    end 
                end)
                    RageUI.ButtonWithStyle("Date des faits :", nil ,{RightLabel = date}, true, function(Hovered, Active, Selected) 
                            if (Selected) then 
                            local adate = KeyboardInput('Exemple : 01/01/2021', "", 20)
                            while (UpdateOnscreenKeyboard() == 0) do
                                DisableAllControlActions(0);
                               Citizen.Wait(1)
                            end
                            if (GetOnscreenKeyboardResult()) then
                                date = GetOnscreenKeyboardResult()
                                if date == nil then
                                   ESX.ShowNotification('~r~Vous devez entrer une date')
                                end
                            end 
						end 
                    end)
                    RageUI.ButtonWithStyle("Faits :", nil ,{RightLabel = ''}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        local desc = KeyboardInput("Expliquez les faits", "", 400)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0);
                           Citizen.Wait(1)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            texte = GetOnscreenKeyboardResult()
                            if texte == nil then
                               ESX.ShowNotification('~r~Vous devez entrer un texte')
                            end
                        end 
                    end 
                end)
                    numeroplainte = math.random(0, 999999)
                    RageUI.ButtonWithStyle("Enregistrer", nil ,{RightLabel = '', Color = { BackgroundColor = RageUI.ItemsColour.Green }}, true, function(Hovered, Active, Selected)
                        if (Selected) then 
                            local troll = GetPlayerName(PlayerId())
                                if (telephone == nil or telephone == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir votre numéro de téléphone.')
                                elseif (nprenom == nil or nprenom == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir vôtre ~r~nom et prénom~s~.')
                                elseif (contre == nil or contre == '~b~') then
                                ESX.ShowNotification('~r~Vous avez oublié une case.')
                                elseif (date == nil or date == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir la date.')
                                elseif (texte == nil or texte == '~b~') then
                                ESX.ShowNotification('~r~Veuillez remplir une description.')
                                else
                                TriggerServerEvent('plaintelspd', 'Numéro de téléphone : ' ..telephone.. '\n\nPrénom et nom : ' ..nprenom.. '\n\nÀ l\'encontre de : ' ..contre.. '\n\nDate des faîts : ' ..date.. '\n\nDescription : ' ..texte.. '\n\nNuméro de plainte : ' ..numeroplainte.. '\n\n\n(En cas de troll) Pseudo Steam : ' ..troll)
                                RageUI.CloseAll()
                                hPlainte = false
                                ESX.ShowNotification('~s~Votre ~b~plainte ~s~a bien été enrengister. \nUn ~b~agent ~s~vous contactera.')
                            end
						end 
					end)
				end)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(439.87, -981.12, 30.68)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 5 then
            interval = 200
        else
            interval = 1
            DrawMarker(21, 439.87, -981.12, 30.68, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 170, 170, 1, 1, 2, 0, nil, nil, 0)
            if distance < 1 then  
                AddTextEntry("HELP", "Appuyez sur ~INPUT_CONTEXT~ ~s~pour porter plainte.")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    openPlainte()
                end
            end
        end
        Citizen.Wait(interval)
    end
end)
