ESX = nil 
local playerPed = GetPlayerPed(-1)
isMenuOpen = false

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

local garage_menu = RageUI.CreateMenu(nil, "Garage")
local option_menu = RageUI.CreateSubMenu(garage_menu, nil, "Option")
garage_menu.Closed = function ()
    isMenuOpen = false
end

local Listing = {
    "Standard~s~",
    "VIP~s~",
}
local ListingIndex = 1

Garage = {
    vehiclelist = {},
    vehiclelistvip = {}
}

function menugarage()
    if not isMenuOpen then
        isMenuOpen = true
        RageUI.Visible(garage_menu, true)
        CreateThread(function()
            while isMenuOpen do
                RageUI.IsVisible(garage_menu, function()
                if Config.Option.NomParking == true then
                    RageUI.Separator('Garage : ~g~'..garageid.name)
                    RageUI.line(255,255,255,255)
                end
                  if Config.Option.VipSysteme == true then
                    RageUI.List("Filtre", Listing, ListingIndex, nil, {}, true, {
                        onActive = function()
                            activee = false
                        end,
                        onListChange = function(i, Items)
                            if ListingIndex ~= i then
                                ListingIndex = i;
                            end
                        end
                    })  
                end

                if Config.Option.Statistique == true then
                    RageUI.Checkbox("Activer les statistiques", false, checkbox, {}, {
                        onActive = function()
                            activee = false
                        end,
						onChecked = function()
							checkbox = true
							performance = true
						end,
						onUnChecked = function()
							checkbox = false
							performance = false
						end
					})             
                end

                if Config.Option.Statistique == true or Config.Option.VipSysteme == true then
                    RageUI.line(255,255,255,255)
                end

                    
                    if ListingIndex == 1 and Config.Option.VipSysteme == true or Config.Option.VipSysteme == false then
                    for i = 1, #Garage.vehiclelist, 1 do
                        local hash = Garage.vehiclelist[i].vehicle.model
                        local model = Garage.vehiclelist[i].vehicle
                        local nomvehicle = GetDisplayNameFromVehicleModel(hash)
                        local text = GetLabelText(nomvehicle)
                        local place = GetVehicleModelNumberOfSeats(Garage.vehiclelist[i].vehicle.model)
                        local plaque = Garage.vehiclelist[i].plate 
                        local fuel = Garage.vehiclelist[i].fuel
                        local renamecar = Garage.vehiclelist[i].rename
                        local degatmoteur = Garage.vehiclelist[i].etatmoteur

                        if Config.Option.RenameCar == true then
                            if renamecar == nil or renamecar == "Null" or renamecar == "null" or renamecar == "NULL" then
                                textcar = text
                            else
                                textcar = renamecar
                            end
                        else
                            textcar = text
                        end

                        RageUI.Button(textcar.." | ~b~"..plaque, nil,{RightLabel = "→→"}, true, {
                            onActive = function()
                                if Config.Option.Statistique == true and activee ~= true then
                                MaxSpeed = GetVehicleModelMaxSpeed(Garage.vehiclelist[i].vehicle.model)*3.6
                                Acceleration = GetVehicleModelAcceleration(Garage.vehiclelist[i].vehicle.model)*3.6/220
                                Braking = GetVehicleModelMaxBraking(Garage.vehiclelist[i].vehicle.model)/2
                                hashstatistique = Garage.vehiclelist[i].vehicle.model
                                nomvehiclestatistique = GetDisplayNameFromVehicleModel(hashstatistique)
                                textstatistique = GetLabelText(nomvehiclestatistique)
                                placestatistique = GetVehicleModelNumberOfSeats(Garage.vehiclelist[i].vehicle.model)
                                plaquestatistique = Garage.vehiclelist[i].plate 
                                fuelstatistique = Garage.vehiclelist[i].fuel
                                degatmoteurstatistique = Garage.vehiclelist[i].etatmoteur
                                end
                                activee = true
                            end,
                            onSelected = function()
                                modelselection = model
                                plaqueselection = plaque
                                fuelselection = fuel
                                textvoiture = text
                                etatmoteurselection = degatmoteur
                                if renamecar == nil or renamecar == "Null" or renamecar == "null" or renamecar == "NULL" then
                                    renamecarselection = "~r~Aucun"
                                else
                                    renamecarselection = renamecar
                                end
                                WaitInfos = true
                            end
                        }, option_menu)
                    end
                    if activee == true and performance == true and Config.Option.Statistique == true then
                        RageUI.StatisticPanel(MaxSpeed/220, "Vitesse maximum", PanelIndex)
                        RageUI.StatisticPanel(Acceleration*100, "Accélération", PanelIndex)
                        RageUI.StatisticPanel(Braking, "Freinage", PanelIndex)
                        RageUI.BoutonPanel("Plaque", "~r~"..plaquestatistique, PanelIndex)
                        RageUI.BoutonPanel("Modèle", "~g~"..textstatistique, PanelIndex)
                        RageUI.BoutonPanel("Nombre de place", "~y~"..placestatistique, PanelIndex)
                        if Config.Option.SaveDegatsMoteur == true then
                        RageUI.BoutonPanel("Etat Moteur", "~o~"..degatmoteurstatistique.."/1000", PanelIndex)
                        end
                        if Config.Option.SaveEssence == true then
                        RageUI.BoutonPanel("Essence", "~b~"..fuelstatistique.."L", PanelIndex)
                        end
                    end
                    if #Garage.vehiclelist == 0 then
                        RageUI.Separator('~r~Aucun véhicule disponible')
                        RageUI.line(255,255,255,255)
                    end
                 end
                 if ListingIndex == 2 and Config.Option.VipSysteme == true then
                    for i = 1, #Garage.vehiclelistvip, 1 do
                        local hash = Garage.vehiclelistvip[i].vehicle.model
                        local model = Garage.vehiclelistvip[i].vehicle
                        local nomvehicle = GetDisplayNameFromVehicleModel(hash)
                        local text = GetLabelText(nomvehicle)
                        local place = GetVehicleModelNumberOfSeats(Garage.vehiclelistvip[i].vehicle.model)
                        local plaque = Garage.vehiclelistvip[i].plate 
                        local fuel = Garage.vehiclelistvip[i].fuel
                        local renamecar = Garage.vehiclelistvip[i].rename
                        local degatmoteur = Garage.vehiclelistvip[i].etatmoteur

                    if Config.Option.RenameCar == true then
                        if renamecar == nil or renamecar == "Null" or renamecar == "null" or renamecar == "NULL" then
                            textcar = text
                        else
                            textcar = renamecar
                        end
                    else
                        textcar = text
                    end

                        RageUI.Button("[~y~VIP~s~] "..textcar.." | ~b~"..plaque, nil, {RightLabel = "→→"}, true, {
                            onActive = function()
                                if Config.Option.Statistique == true and activee ~= true then
                                MaxSpeed = GetVehicleModelMaxSpeed(Garage.vehiclelistvip[i].vehicle.model)*3.6
                                Acceleration = GetVehicleModelAcceleration(Garage.vehiclelistvip[i].vehicle.model)*3.6/220
                                Braking = GetVehicleModelMaxBraking(Garage.vehiclelistvip[i].vehicle.model)/2
                                hashstatistique = Garage.vehiclelistvip[i].vehicle.model
                                nomvehiclestatistique = GetDisplayNameFromVehicleModel(hashstatistique)
                                textstatistique = GetLabelText(nomvehiclestatistique)
                                placestatistique = GetVehicleModelNumberOfSeats(Garage.vehiclelistvip[i].vehicle.model)
                                plaquestatistique = Garage.vehiclelistvip[i].plate 
                                fuelstatistique = Garage.vehiclelistvip[i].fuel
                                degatmoteurstatistique = Garage.vehiclelistvip[i].etatmoteur
                                activee = true
                                end
                            end,
                            onSelected = function()
                                modelselection = model
                                plaqueselection = plaque
                                etatmoteurselection = degatmoteur
                                fuelselection = fuel
                                textvoiture = text
                                if renamecar == nil or renamecar == "Null" or renamecar == "null" or renamecar == "NULL" then
                                    renamecarselection = "~r~Aucun"
                                else
                                    renamecarselection = renamecar
                                end
                                WaitInfos = true
                            end
                        }, option_menu)
                    end
                    if activee == true and performance == true and Config.Option.Statistique == true then
                        RageUI.StatisticPanel(MaxSpeed/220, "Vitesse maximum", PanelIndex)
                        RageUI.StatisticPanel(Acceleration*100, "Accélération", PanelIndex)
                        RageUI.StatisticPanel(Braking, "Freinage", PanelIndex)
                        RageUI.BoutonPanel("Plaque", "~r~"..plaquestatistique, PanelIndex)
                        RageUI.BoutonPanel("Modèle", "~g~"..textstatistique, PanelIndex)
                        RageUI.BoutonPanel("Nombre de place", "~y~"..placestatistique, PanelIndex)
                        if Config.Option.SaveDegatsMoteur == true then
                        RageUI.BoutonPanel("Etat Moteur", "~o~"..degatmoteurstatistique.."/1000", PanelIndex)
                        end
                        if Config.Option.SaveEssence == true then
                        RageUI.BoutonPanel("Essence", "~b~"..fuelstatistique.."L", PanelIndex)
                        end
                    end
                    if #Garage.vehiclelistvip == 0 then
                        RageUI.Separator('~r~Aucun véhicule disponible')
                        RageUI.line(255,255,255,255)
                    end
                 end
                end)

                RageUI.IsVisible(option_menu, function()
                    if WaitInfos == true then
                    RageUI.Separator('Véhicule : ~g~'..textvoiture)
                    if Config.Option.RenameCar == true then
                    RageUI.Separator('Nom custom : ~o~'..renamecarselection)
                    end
                    RageUI.line(255,255,255,255)
                    RageUI.Button("Sortir le véhicule", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            SpawnVehicle(modelselection, plaqueselection, fuelselection, etatmoteurselection)
                            ESX.ShowNotification('Vous venez de sortir votre ~b~'..textvoiture)
                            RageUI.CloseAll()
                            isMenuOpen = false
                        end
                    })
                    if Config.Option.RenameCar == true then
                    RageUI.Button("Renommer le véhicule", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            local nouveaurename = KeyboardInput("Saisir le nouveau nom", "", 20)
                            if nouveaurename ~= "" and nouveaurename ~= nil and nouveaurename ~= "Null" and nouveaurename ~= "NULL" and nouveaurename ~= "null" then
                                recherche = true
                                TriggerServerEvent('pawal:setrename', nouveaurename, plaqueselection)
                                RageUI.CloseAll()
                                open = false 
                                Wait(50)
                                ESX.TriggerServerCallback("pawal:vehiclelistvip", function(ownedCarsVip)
                                    Garage.vehiclelistvip = ownedCarsVip
                                end)
                                ESX.TriggerServerCallback("pawal:vehiclelist", function(ownedCars)
                                    Garage.vehiclelist = ownedCars
                                end)
                                ESX.ShowNotification('Véhicule ~b~mise à jour\n~s~Nom : ~b~'..nouveaurename)
                                RageUI.Visible(garage_menu, true)
                            else
                                ESX.ShowNotification('~r~Rename invalide !')
                            end
                        end
                    })
               
                    if renamecarselection ~= "~r~Aucun" then                   
                     RageUI.Button("~r~Supprimer le nom custom (Rename)", nil, {RightLabel = "→→"}, true, {
                        onSelected = function()
                            if renamecarselection ~= "~r~Aucun" then
                                recherche = true
                                TriggerServerEvent('pawal:setrenamedefault', "Null", plaqueselection)
                                RageUI.CloseAll()
                                open = false 
                                Wait(50)
                                ESX.TriggerServerCallback("pawal:vehiclelistvip", function(ownedCarsVip)
                                    Garage.vehiclelistvip = ownedCarsVip
                                end)
                                ESX.TriggerServerCallback("pawal:vehiclelist", function(ownedCars)
                                    Garage.vehiclelist = ownedCars
                                end)
                                ESX.ShowNotification('~g~Le Rename à bien était retirer')
                                RageUI.Visible(garage_menu, true)
                            else
                                ESX.ShowNotification('~r~Votre véhicule ne possède pas de Rename !')
                            end
                        end
                    })
                else 
                    RageUI.Button("~r~Supprimer le nom custom (Rename)", "Votre véhicule ne possède pas de rename", {RightLabel = "→→"}, false, {
                    })  
                end
            end
                    end
                end)
                Citizen.Wait(0)
            end
        end)
    end
end

CreateThread(function()
    if Config.Option.NomParking == true then
       NomParking = true 
    else
        NomParking = false 
    end
    for k, v in pairs(Config.Garage) do
        if v.blip == true then
        local blip = AddBlipForCoord(v.Position.x, v.Position.y, v.Position.z)

        SetBlipSprite(blip, Config.Blips.BlipSpriteGarage)
        SetBlipScale (blip, Config.Blips.BlipScaleGarage)
        SetBlipColour(blip, Config.Blips.BlipColorGarage)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(Config.Blips.BlipNameGarage)
        EndTextCommandSetBlipName(blip)
    end
  end
    while true do
        local wait = 750
        for k, v in pairs(Config.Garage) do

            local plyCoords = GetEntityCoords(playerPed, false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.Position.x, v.Position.y, v.Position.z)

            if dist <= Config.MarkerDistance then
                wait = 0
                DrawMarker(Config.MarkerType, v.Position.x, v.Position.y, v.Position.z, 0.0, 0.0, 0.0, Config.RotationX, Config.RotationY, Config.RotationZ, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end

            if dist <= 2 then
                garageid = v
                wait = 0
                if NomParking then
                  ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour accédez au garage\nNom : ~g~'..garageid.name)
                else
                  ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour accédez au garage')
                end
                if IsControlJustPressed(1, 51) then
                    ESX.TriggerServerCallback("pawal:vehiclelist", function(ownedCars)
                        Garage.vehiclelist = ownedCars
                    end)

                    ESX.TriggerServerCallback("pawal:vehiclelistvip", function(ownedCarsVip)
                        Garage.vehiclelistvip = ownedCarsVip
                    end)
                    menugarage()
                end
            end

            local dist2 = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.PointDelet.Position.x, v.PointDelet.Position.y, v.PointDelet.Position.z)
         if IsPedInAnyVehicle(playerPed, false) then
            if dist2 <= Config.MarkerDistance then
                wait = 0
                DrawMarker(Config.MarkerType, v.PointDelet.Position.x, v.PointDelet.Position.y, v.PointDelet.Position.z, 0.0, 0.0, 0.0, Config.RotationX, Config.RotationY, Config.RotationZ, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end

            if dist2 <= 2 then
                wait = 0
                ESX.ShowHelpNotification('~INPUT_CONTEXT~ pour ranger votre véhicule')
                if IsControlJustPressed(1, 51) then
                         ReturnVeh()
                end
            end
          end
        end
    Citizen.Wait(wait)
    end
end)


function SpawnVehicle(vehicle, plate, fuel, etatmoteur)
    x,y,z = table.unpack(GetEntityCoords(playerPed,true))

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = garageid.PointSpawn.Position.x,
		y = garageid.PointSpawn.Position.y,
		z = garageid.PointSpawn.Position.z
	}, garageid.PointSpawn.Angle, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
        if Config.Option.SaveDegatsMoteur == true then
            SetVehicleEngineHealth(callback_vehicle, etatmoteur + 0.0)
        else
		    SetVehicleEngineHealth(callback_vehicle, Config.Option.EtatMoteurSpawn + 0.0)
        end
		TaskWarpPedIntoVehicle(playerPed, callback_vehicle, -1)
        if Config.Option.SaveEssence == true then
        SetVehicleFuelLevel(callback_vehicle, fuel + 0.0)
		DecorSetFloat(callback_vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(callback_vehicle))
        else
            SetVehicleFuelLevel(callback_vehicle, Config.Option.EssenceSpawn + 0.0)
            DecorSetFloat(callback_vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(callback_vehicle))
        end
	end)
    TriggerServerEvent('pawal:changementetat', '0', plate)
end


function ReturnVeh()
    if IsPedInAnyVehicle(playerPed, false) then 
        local pos = GetEntityCoords(playerPed)
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local Propsvehicle = ESX.Game.GetVehicleProperties(vehicle)
        local fuel = GetVehicleFuelLevel(vehicle)
        local current = GetPlayersLastVehicle(playerPed, true)
        local engineH = GetVehicleEngineHealth(current)
        local hash = GetEntityModel(vehicle)
        local nomvehicle = GetDisplayNameFromVehicleModel(hash)
        local text = GetLabelText(nomvehicle)
        local plate = Propsvehicle.plate

        ESX.TriggerServerCallback("pawal:rangervehicle", function(valid)
            if valid then 
                BreakReturnVehicle(vehicle, Propsvehicle, text)
                TriggerServerEvent('pawal:savefuel',tostring(math.ceil(fuel)) , plate)
                TriggerServerEvent('pawal:savemoteur', tostring(math.ceil(engineH)), plate)
            else
                ESX.ShowNotification("~r~Tu ne peut pas garer ce véhicule")
            end
        end, Propsvehicle)
    else 
        ESX.ShowNotification("~r~Ce véhicule ne vous appartient pas !")
    end
end

function BreakReturnVehicle(vehicle, Propsvehicle, text)
    local getvehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, getvehicle, 0)	
    Citizen.Wait(2000)
    ESX.Game.DeleteVehicle(vehicle)
    TriggerServerEvent('pawal:changementetat', '1', Propsvehicle.plate)
	ESX.ShowNotification("Vous venez de ranger votre ~b~"..text)
end