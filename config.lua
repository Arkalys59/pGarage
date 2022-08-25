Config = {
  MarkerType = 6, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
  MarkerSizeLargeur = 0.7, -- Largeur du marker
  MarkerSizeEpaisseur = 0.7, -- Épaisseur du marker
  MarkerSizeHauteur = 0.7, -- Hauteur du marker
  RotationX = -90.0,
  RotationY = 0.0,
  RotationZ = 0.0,
  MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
  MarkerColorR = 255, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
  MarkerColorG = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
  MarkerColorB = 0, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
  MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
  MarkerSaute = false, -- Si le marker saute (true = oui, false = non)
  MarkerTourne = false, -- Si le marker tourne (true = oui, false = non)
}

Config.Option = {
    VipSysteme = true, -- Si vous voulez la catégorie "VIP"
    Statistique = true, -- Si vous voulez le panel Statistique

    FourriereJob = false, -- Pour que la fourrière soit gérer par une entreprise
    FourriereSetJob = "mechanic", -- Mettre le setjob de l'entreprise qui gère la fourrière (si le FourriereJob = true)
    FourrierePrix = 500, -- Prix pour sortir de la fourrière un véhicule (uniquement si FourriereJob = false)

    SaveEssence = true, -- Si vous voulez la save de l'essence ou non
    EssenceSpawn = 50, -- Le nombre de litre d'essence dans le reservoir lors du spawn (Uniquement si SaveEssence = false)

    NomParking = true, -- Si vous voulez que dans le ShowHelpNotification ainsi que dans le menu le nom du garage s'affiche (Nom à définir dans le config des garages)
    NomFourriere = true, -- Si vous voulez que dans le ShowHelpNotification ainsi que dans le menu le nom de la fourrières s'affiche (Nom à définir dans le config des fourrières)

    RenameCar = true, -- Si vous voulez donnez la possibilité de pouvoir renommer la voiture dans le garage

    SaveDegatsMoteur = true, -- Si vous voulez les sauvegardes dégats moteur 
    EtatMoteurSpawn = 1000, -- L'état du moteur lors du spawn (uniquement si SaveDegatsMoteur = false)

    RangerReboot = true -- Si vous voulez qu'a chaque reboot du script toute les voitures des joueurs retournes dans le garage et aucun véhicule dans la fourrière
}

Config.Blips = {
    BlipSpriteGarage = 50,
    BlipScaleGarage = 0.6,
    BlipColorGarage = 2,
    BlipNameGarage = "Garage Public",

    BlipSpriteFourriere = 67,
    BlipScaleFourriere = 0.6,
    BlipColorFourriere = 17,
    BlipNameFourriere = "Fourriere"
}


Config.Garage = {
     parkingcentral  = {
        name = "Parking Central",	
        blip = true,
		Position = {x = 216.06230163574, y = -810.05609130859, z = 29.72417640686},
		PointSpawn = {
			Position = {x = 231.18742370605, y = -794.66223144531, z = 30.589582443237}, -- Position spawn voiture
			Angle = 158.5987091064453,
		},
		PointDelet = {
			Position = {x = 224.14657592773, y = -762.23449707031, z = 29.822662353516},
		},
	},

    aeroport  = {	
        name = "Aéroport",
        blip = true,
		Position = {x = -993.60083007813, y = -2705.9152832031, z = 13.000998497009},
		PointSpawn = {
			Position = {x = -989.38818359375, y = -2706.7236328125, z = 12.830688476563}, -- Position spawn voiture
			Angle = 334.3816223144531,
		},
		PointDelet = {
			Position = {x = -986.40325927734, y = -2708.2814941406, z = 12.830688476563},
		},
	},

    sandy1  = {	
        name = "Sandy Shores - #1",
        blip = true,
		Position = {x = 1529.8543701172, y = 3778.4208984375, z = 33.511505126953},
		PointSpawn = {
			Position = {x = 1536.3248291016, y = 3769.9050292969, z = 34.05004119873}, -- Position spawn voiture
			Angle = 303.0149841308594,
		},
		PointDelet = {
			Position = {x = 1543.0080566406, y = 3780.3173828125, z = 33.050048828125},
		},
	},

    sandy2  = {	
        name = "Sandy Shores - #2",
        blip = true,
		Position = {x = 1792.5815429688, y = 4591.4404296875, z = 36.682926177979},
		PointSpawn = {
			Position = {x = 1793.5913085938, y = 4584.9130859375, z = 36.186489105225}, -- Position spawn voiture
			Angle = 184.5916748046875,
		},
		PointDelet = {
			Position = {x = 121.80478668213, y = 6615.1049804688, z = 30.842998504639},
		},
	},

    paleto  = {	
        name = "Paleto Bay",
        blip = true,
		Position = {x = 105.15587615967, y = 6613.5883789063, z = 31.397514343262},
		PointSpawn = {
			Position = {x = 118.56407165527, y = 6599.208984375, z = 32.01782989502}, -- Position spawn voiture
			Angle = 271.1077880859375,
		},
		PointDelet = {
			Position = {x = 1789.4548339844, y = 4585.1450195313, z = 36.393390655518},
		},
	},

    plage  = {	
        name = "Plage",
        blip = true,
		Position = {x = -1699.7137451172, y = -942.40112304688, z = 6.6764097213745},
		PointSpawn = {
			Position = {x = -1694.1437988281, y = -944.49407958984, z = 7.6764092445374}, -- Position spawn voiture
			Angle = 341.692626953125,
		},
		PointDelet = {
			Position = {x = -1703.0310058594, y = -936.29846191406, z = 6.6764130592346},
		},
	},

    indu  = {	
        name = "Zone Industriel",
        blip = true,
		Position = {x = 996.54711914063, y = -2551.1330566406, z = 27.462518692017},
		PointSpawn = {
			Position = {x = 993.25805664063, y = -2549.0954589844, z = 28.301998138428}, -- Position spawn voiture
			Angle = 354.2957763671875,
		},
		PointDelet = {
			Position = {x = 987.76574707031, y = -2548.3686523438, z = 27.301998138428},
		},
	},

    port  = {	
        name = "Port",
        blip = true,
		Position = {x = 549.44586181641, y = -3056.1789550781, z = 5.1692891120911},
		PointSpawn = {
			Position = {x = 546.55590820313, y = -3054.1418457031, z = 6.0696330070496}, -- Position spawn voiture
			Angle = 359.1296081542969,
		},
		PointDelet = {
			Position = {x = 543.14611816406, y = -3053.6027832031, z = 5.0696330070496},
		},
	},
}

Config.Fourriere = {
    fourriere1  = {
       name = "Fourrière - Central",	
       blip = true,
       Position = {x = 409.62002563477, y = -1623.1538085938, z = 28.29195022583},
       PointSpawn = {
           Position = {x = 416.80682373047, y = -1628.025390625, z = 29.291931152344}, -- Position spawn voiture
           Angle = 138.2492828369141,
       },
   },

   fourriere2  = {
       name = "Fourrière - Sandy Shores",	
       blip = true,
       Position = {x = 1663.4152832031, y = 3825.16796875, z = 33.891532897949},
       PointSpawn = {
           Position = {x = 1668.318359375, y = 3834.9353027344, z = 34.898857116699}, -- Position spawn voiture
           Angle = 221.62156677246097,
      },
   },

   fourriere3  = {
    name = "Fourrière - Paleto Bay",	
    blip = true,
    Position = {x = -196.16941833496, y = 6265.28125, z = 30.489320755005},
    PointSpawn = {
        Position = {x = -195.45419311523, y = 6269.5903320313, z = 31.489303588867}, -- Position spawn voiture
        Angle = 40.46950531005859,
   },
},


}