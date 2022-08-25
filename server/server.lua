ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------------------------------------------------
-- Partie : Ranger les véhicules lors d'un reboot 
-------------------------------------------------------
if Config.Option.RangerReboot == true then
AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored ",{
		['@stored'] = "1",
	})
  end)
end
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------



-------------------------------------------------------
-- Partie : Trigger + ServerCallback pour la partie Garage
-------------------------------------------------------
ESX.RegisterServerCallback("pawal:vehiclelist", function(source, cb)
    local ownedCars =  {}
    local xPlayer = ESX.GetPlayerFromId(source)
	  if Config.Option.VipSysteme == true then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = @stored AND vip = @vip', {
            ['@owner'] = xPlayer.identifier,
            ['@stored'] = '1',
			['@vip'] = '0'
        }, function(data)
            for k, v in pairs(data) do
                local vehicle = json.decode(v.vehicle)
                table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, fuel = v.fuel, rename = v.renamecar, etatmoteur = v.etatmoteur})
            end
            cb(ownedCars)
        end)
	else
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = @stored ', {
            ['@owner'] = xPlayer.identifier,
            ['@stored'] = '1',
        }, function(data)
            for k, v in pairs(data) do
                local vehicle = json.decode(v.vehicle)
                table.insert(ownedCars, {vehicle = vehicle, stored = v.stored, plate = v.plate, fuel = v.fuel, rename = v.renamecar, etatmoteur = v.etatmoteur})
            end
            cb(ownedCars)
        end)
	end
end)

ESX.RegisterServerCallback("pawal:vehiclelistvip", function(source, cb)
    local ownedCarsVip =  {}
    local xPlayer = ESX.GetPlayerFromId(source)
	if Config.Option.VipSysteme == true then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND stored = @stored AND vip = @vip', {
            ['@owner'] = xPlayer.identifier,
            ['@stored'] = '1',
			['@vip'] = '1',
        }, function(data)
            for k, v in pairs(data) do
                local vehicle = json.decode(v.vehicle)
                table.insert(ownedCarsVip, {vehicle = vehicle, stored = v.stored, plate = v.plate, fuel = v.fuel, rename = v.renamecar, etatmoteur = v.etatmoteur})
            end
            cb(ownedCarsVip)
        end)
	end
end)

RegisterServerEvent('pawal:changementetat')
AddEventHandler('pawal:changementetat', function(state, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	MySQL.Async.execute("UPDATE owned_vehicles SET `stored` = @stored WHERE owner = @owner AND @plate = plate",{
		['@owner'] = xPlayer.identifier,
		['@stored'] = state,
		['@plate'] = plate
	})
end)

RegisterServerEvent('pawal:setrename')
AddEventHandler('pawal:setrename', function(nouveaunom, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	MySQL.Async.execute("UPDATE owned_vehicles SET `renamecar` = @renamecar WHERE owner = @owner AND @plate = plate",{
		['@owner'] = xPlayer.identifier,
		['@renamecar'] = nouveaunom,
		['@plate'] = plate
	})
end)

RegisterServerEvent('pawal:setrenamedefault')
AddEventHandler('pawal:setrenamedefault', function(nouveaunom, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	MySQL.Async.execute("UPDATE owned_vehicles SET `renamecar` = @renamecar WHERE owner = @owner AND @plate = plate",{
		['@owner'] = xPlayer.identifier,
		['@renamecar'] = nouveaunom,
		['@plate'] = plate
	})
end)


RegisterServerEvent('pawal:savemoteur')
AddEventHandler('pawal:savemoteur', function(etatmoteur, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	MySQL.Async.execute("UPDATE owned_vehicles SET `etatmoteur` = @etatmoteur WHERE owner = @owner AND @plate = plate",{
		['@owner'] = xPlayer.identifier,
		['@etatmoteur'] = etatmoteur,
		['@plate'] = plate
	})
end)


RegisterServerEvent('pawal:savefuel')
AddEventHandler('pawal:savefuel', function(fuel, plate)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

	MySQL.Async.execute("UPDATE owned_vehicles SET `fuel` = @fuel WHERE owner = @owner AND @plate = plate",{
		['@owner'] = xPlayer.identifier,
		['@fuel'] = fuel,
		['@plate'] = plate
	})
end)

ESX.RegisterServerCallback('pawal:rangervehicle', function (source, cb, Propsvehicle, fuel)
	local ownedCars = {}
	local vehplate = Propsvehicle.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = Propsvehicle.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = Propsvehicle.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then

				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(Propsvehicle),
					['@plate'] = Propsvehicle.plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
						print(('pGarage : ~r~tente de ranger un véhicule non à lui '):format(xPlayer.identifier))
					end
					cb(true)
				end)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------


-------------------------------------------------------
-- Partie : Trigger + ServerCallback pour la partie Fourrière
-------------------------------------------------------

ESX.RegisterServerCallback("pawal:listevehiculefourrierejoueur", function(source, cb)
	local fourrierevehicle = {}
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @owner AND `stored` = @stored", {
		["@owner"] = xPlayer.identifier,
		["@stored"] = "0"
	}, function(data)
		for k, v in pairs(data) do
			local veh = json.decode(v.vehicle)
			table.insert(fourrierevehicle, {vehicle = veh, stored = v.stored, plate = v.plate, fuel = v.fuel})
		end
		cb(fourrierevehicle)
	end)
end)

ESX.RegisterServerCallback("pawal:listevehiculefourrierejob", function(source, cb)
	local fourrierevehiclejob = {}
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE `stored` = @stored", {
		["@stored"] = "0"
	}, function(data)
		for k, v in pairs(data) do
			local veh = json.decode(v.vehicle)
			table.insert(fourrierevehiclejob, {vehicle = veh, stored = v.stored, plate = v.plate, fuel = v.fuel})
		end
		cb(fourrierevehiclejob)
	end)
end)

RegisterServerEvent('pawal:payementfourriere')
AddEventHandler('pawal:payementfourriere', function(carname)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	
	if xPlayer.getMoney() >= Config.Option.FourrierePrix then
		xPlayer.removeMoney(Config.Option.FourrierePrix)
		TriggerClientEvent('esx:showNotification', _src, "Vous venez de payer ~b~"..Config.Option.FourrierePrix.."$~s~ pour récuperer votre ~b~"..carname)
		cb(true)
	else 
		TriggerClientEvent('esx:showNotification', _src, "~r~Vous n'avez pas suffisament d'argent ~s~!")
		cb(false)
	end
end)
-------------------------------------------------------
-------------------------------------------------------
-------------------------------------------------------
