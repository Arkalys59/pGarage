ESX = nil 
local isMenuOpen = false
local recherche = false
local playerPed = GetPlayerPed(-1)

local PlayerData = {}


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end


function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end
 
function SpawnVehicle(vehicle, plate)
    x,y,z = table.unpack(GetEntityCoords(playerPed,true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = 408.35119628906,
		y = -1638.78515625,
		z = 29.291955947876 
	}, 227.12664794921875, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		SetVehicleBodyHealth(callback_vehicle, 1000)
		TaskWarpPedIntoVehicle(playerPed, callback_vehicle, -1)
	end)
    TriggerServerEvent("pawal:breakveh", plate, false)
end



local menu_fouriere = RageUI.CreateMenu("Fourrière", "Action")

menu_fouriere.Closed = function()
    isMenuOpen = false
end
pound = {
    fourrierelist = {},
    fourrierelistjob = {}
}

local function menufourriere()
    if not isMenuOpen then
        isMenuOpen = true
        RageUI.Visible(menu_fouriere, true)
        CreateThread(function()
            while isMenuOpen do
                RageUI.IsVisible(menu_fouriere, function()
                    
                if Config.Option.NomFourriere == true then
                   RageUI.Separator('Fourrière : ~g~'..fourriereid.name)
                    RageUI.line(255,255,255)
                end
                    if Config.Option.FourriereJob == true then
                        if ESX.PlayerData ~= nil and ESX.PlayerData.job.name == Config.Option.FourriereSetJob then
                            if #pound.fourrierelistjob == 0 then
                                RageUI.Separator('~r~Aucun véhicule disponible')
                                RageUI.line(255,255,255)
                            else
                    RageUI.Button("Rechercher une plaque", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local plaquerecherchee = KeyboardInput("Plaque rechercher", "", 100)
                            if plaquerecherchee ~= "" and plaquerecherchee ~= nil then
                                plaquerecherche = plaquerecherchee
                                recherche = true
                            else
                                    ESX.ShowNotification('~r~Rercherche invalide !')
                            end
                        end
                    })

                    if recherche == true then
                        RageUI.Button("Supprimer votre recherche", nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                recherche = false
                            end
                        })

                     RageUI.Separator('Plaque rechercher : ~g~'..plaquerecherche)
                    end
                    RageUI.line(255,255,255,255)

               if ESX.PlayerData ~= nil and ESX.PlayerData.job.name == Config.Option.FourriereSetJob then
                    for i = 1, #pound.fourrierelistjob, 1 do
                        local hash = pound.fourrierelistjob[i].vehicle.model
                        local model = pound.fourrierelistjob[i].vehicle
                        local nomveh = GetDisplayNameFromVehicleModel(hash)
                        local nomvehtexte = GetLabelText(nomveh)
                        local plaque = pound.fourrierelistjob[i].plate
                        local fuel = pound.fourrierelistjob[i].fuel

                 if recherche == true then
                    if starts(plaque:lower(), plaquerecherche:lower()) then
                        RageUI.Button(nomvehtexte.." | ~o~"..plaque, nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                SpawnVehicleFourriere(model, plaque, fuel)
                                        RageUI.CloseAll()
                                        isMenuOpen = false
                            end
                        })
                    end
                      else
                        RageUI.Button(nomvehtexte.." | ~o~"..plaque, nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                if Config.Option.FourriereJob == true then
                                SpawnVehicleFourriere(model, plaque, fuel)
                                RageUI.CloseAll()
                                isMenuOpen = false
                                else
                                    SpawnVehicleFourriere(model, plaque, fuel)
                                    RageUI.CloseAll()
                                    isMenuOpen = false
                                end
                            end
                        })
                    end
                 end
                end
            end
        end
                else
                    if #pound.fourrierelist == 0  then
                        RageUI.Separator('~r~Aucun véhicule disponible')
                        RageUI.line(255,255,255)
                    else
                    for i = 1, #pound.fourrierelist, 1 do
                        local hash = pound.fourrierelist[i].vehicle.model
                        local model = pound.fourrierelist[i].vehicle
                        local nomveh = GetDisplayNameFromVehicleModel(hash)
                        local nomvehtexte = GetLabelText(nomveh)
                        local plaque = pound.fourrierelist[i].plate
                        local fuel = pound.fourrierelist[i].fuel

                        RageUI.Button(nomvehtexte.." | ~o~"..plaque, nil, {RightLabel = "→→"}, true, {
                            onSelected = function()
                                TriggerServerEvent("pawal:payementfourriere", nomvehtexte)
                                  SpawnVehicleFourriere(model, plaque, fuel)
                                        RageUI.CloseAll()
                                        isMenuOpen = false
                            end
                        })
                    end
                 end
                end
                end)
            Wait(0)      
            end
        end)
    end
end

-- Spawn du véhicule 

function SpawnVehicleFourriere(vehicle, plate, fuel)
    x,y,z = table.unpack(GetEntityCoords(playerPed,true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = fourriereid.PointSpawn.Position.x,
		y = fourriereid.PointSpawn.Position.y,
		z = fourriereid.PointSpawn.Position.z
	}, fourriereid.PointSpawn.Angle, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleBodyHealth(callback_vehicle, 1000)
		TaskWarpPedIntoVehicle(playerPed, callback_vehicle, -1)
        SetVehicleFuelLevel(callback_vehicle, fuel + 0.0)
		DecorSetFloat(callback_vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(callback_vehicle))
	end)
    TriggerServerEvent('pawal:changementetat', '0', plate)
end


CreateThread(function()
    if Config.Option.NomFourriere == true then
        NomFourriere = true 
     else
         NomFourriere = false 
     end
    for k, v in pairs(Config.Fourriere) do
        if v.blip == true then
        local blip = AddBlipForCoord(v.Position.x, v.Position.y, v.Position.z)

        SetBlipSprite(blip, Config.Blips.BlipSpriteFourriere)
        SetBlipScale (blip, Config.Blips.BlipScaleFourriere)
        SetBlipColour(blip, Config.Blips.BlipColorFourriere)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Blips.BlipNameFourriere)
        EndTextCommandSetBlipName(blip)
    end
  end
    while true do
        local wait = 750
        ESX.PlayerData = ESX.GetPlayerData()
        ESX.GetPlayerData()
        local plyCoords = GetEntityCoords(playerPed, false)
        for k, v in pairs(Config.Fourriere) do

            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Position.x, v.Position.y, v.Position.z)

            if Config.Option.FourriereJob == true and ESX.PlayerData.job and ESX.PlayerData.job.name == Config.Option.FourriereSetJob or Config.Option.FourriereJob == false then
            if dist <= Config.MarkerDistance then
                wait = 0
                DrawMarker(Config.MarkerType, v.Position.x, v.Position.y, v.Position.z, 0.0, 0.0, 0.0, Config.RotationX, Config.RotationY, Config.RotationZ, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end

            if dist <= 2 then
                fourriereid = v
                wait = 0
                if NomFourriere then 
                ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour accédez à la fourrière\nNom : ~g~'..fourriereid.name)
                else
                    ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour accédez à la fourrière')
                end
                if IsControlJustPressed(1, 51) then
                    if Config.Option.FourriereJob == false then
                       ESX.TriggerServerCallback("pawal:listevehiculefourrierejoueur", function(fourrierevehicle)
                           pound.fourrierelist = fourrierevehicle
                       end)
                    else
                        ESX.TriggerServerCallback("pawal:listevehiculefourrierejob", function(fourrierevehiclejob)
                            pound.fourrierelistjob = fourrierevehiclejob
                        end)
                    end
                    menufourriere()
                end
              end
             end
        end
        Citizen.Wait(wait)
    end
end)
