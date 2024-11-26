Config = {}

Config.VoteCooldown = 1800
Config.VoteDuration = 60
Config.AllowKeepCurrentAoP = true
Config.DataSendInterval = 5
Config.DefaultAoP = 'SouthLS'
Config.RegCooldown = 60
Config.ChangeBucket = true
Config.BucketNumber = 9
Config.mdtcars = {"police", "police2", "police3"}


Config.AoPs = {
    SouthLS = {
        Addresses = {
            {playerPos = vector4(219.8107, -1688.1177, 29.3074, 308.5343), carPos = vector4(224.9119, -1707.4291, 28.8923, 205.5703), name = "903 Brouge Ave.", socialgroups = {"AfricanAmerican"}, isBusy = false},
            {playerPos = vector4(287.4194, -1774.1803, 28.0576, 146.8016), carPos = vector4(296.8440, -1791.3463, 27.5274, 229.4117), name = "1473 Roy Lowenstein Blvd.", socialgroups = {"AfricanAmerican", "Hispanic"}, isBusy = false},
            {playerPos = vector4(176.4422, -1855.7943, 24.0780, 155.4938), carPos = vector4(163.0915, -1868.2733, 23.6489, 151.1518), name = "1387 Covenant Ave.", socialgroups = {"AfricanAmerican", "Hispanic"}, isBusy = false},
            {playerPos = vector4(430.5233, -1558.6478, 32.7922, 234.8037), carPos = vector4(467.4366, -1579.5315, 28.7293, 230.7573), name = "1070 Roy Lowenstein Blvd.", socialgroups = {"Hispanic"}, isBusy = false}
        },
        Units = {
            {playerPos = vector4(373.0541, -1610.2061, 29.2919, 230.3073), carPos = vector4(392.6191, -1608.0861, 28.8981, 229.5580), name = "1A-01", divisions = {"LSPD_Davis_Patrol"}, isBusy = false},
            {playerPos = vector4(373.0541, -1610.2061, 29.2919, 230.3073), carPos = vector4(390.4275, -1610.1361, 28.8980, 231.1839), name = "1A-02", divisions = {"LSPD_Davis_Patrol"}, isBusy = false}
        }
    },
    DowntownLS = {
        Addresses = {
            {playerPos = vector4(-268.1380, -959.4002, 31.2231, 208.1281), carPos = vector4(-297.6705, -990.2004, 30.6720, 340.4367), name = "3 Alta St.", socialgroups = {"Business"}, isBusy = false},
            {playerPos = vector4(-34.6885, -615.8406, 35.0803, 132.4802), carPos = vector4(-37.7320, -620.5906, 34.6442, 250.2875), name = "4 Integrity Way", socialgroups = {"Business"}, isBusy = false},
        },
        Units = {
            {playerPos = vector4(441.0550, -1000.2581, 30.7221, 177.0973), carPos = vector4(446.1300, -1025.1733, 28.2043, 3.8679), name = "2A-01", divisions = {"LSPD_MissionRow_Patrol"}, isBusy = false},
            {playerPos = vector4(441.0550, -1000.2581, 30.7221, 177.0973), carPos = vector4(442.0990, -1026.7491, 28.2998, 3.0498), name = "2A-02", divisions = {"LSPD_MissionRow_Patrol"}, isBusy = false}
        }
    },
    Vespucci = {
        Addresses = {
            {playerPos = vector4(-268.1380, -959.4002, 31.2231, 208.1281), carPos = vector4(-297.6705, -990.2004, 30.6720, 340.4367), name = "3 Alta St.", socialgroups = {"Business"}, isBusy = false},
            {playerPos = vector4(-34.6885, -615.8406, 35.0803, 132.4802), carPos = vector4(-37.7320, -620.5906, 34.6442, 250.2875), name = "4 Integrity Way", socialgroups = {"Business"}, isBusy = false},
        },
        Units = {
            {playerPos = vector4(441.0550, -1000.2581, 30.7221, 177.0973), carPos = vector4(446.1300, -1025.1733, 28.2043, 3.8679), name = "2A-01", divisions = {"LSPD_MissionRow_Patrol"}, isBusy = false},
            {playerPos = vector4(441.0550, -1000.2581, 30.7221, 177.0973), carPos = vector4(442.0990, -1026.7491, 28.2998, 3.0498), name = "2A-02", divisions = {"LSPD_MissionRow_Patrol"}, isBusy = false}
        }
    },
}

Config.SocialGroups = {
    Hispanic = {
        firstNames = {'Carlos', 'Juan', 'Miguel', 'Alejandro', 'Diego', 'Luis', 'José', 'Hector', 'Rafael', 'Javier'},
        lastNames = {'Hernandez', 'Garcia', 'Martinez', 'Lopez', 'Rivera', 'Rodriguez', 'Sanchez', 'Ramirez', 'Torres', 'Gonzalez'},
        pedModels = {"a_m_m_socenlat_01", "a_m_m_eastsa_01", "a_m_m_eastsa_02", "a_m_y_stlat_01", "a_m_m_stlat_02"},
        vehicles = {'blista', 'prairie', 'asea', 'minivan', 'primo', 'asterope', 'fugitive', 'intruder', 'stanier', 'premier', 'stratum', 'habanero', 'seminole', 'vigero', 'stalion'},
    },
    AfricanAmerican = {
        firstNames = {'Jamal', 'DeAndre', 'Tyrone', 'Malik', 'Darius', 'Marquis', 'Isaiah', 'Deshawn', 'Lamar', 'Jalen'},
        lastNames = {'Johnson', 'Williams', 'Brown', 'Davis', 'Harris', 'Jackson', 'Lewis', 'Thompson', 'White', 'Robinson'},
        pedModels = {"a_m_m_soucent_01", "a_m_m_soucent_02", "a_m_m_soucent_03", "a_m_m_soucent_04", 'a_m_y_soucent_01', 'a_m_y_soucent_02', 'a_m_y_soucent_03', 'a_m_y_soucent_04'},
        vehicles = {'blista', 'prairie', 'asea', 'minivan', 'primo', 'asterope', 'fugitive', 'intruder', 'stanier', 'premier', 'stratum', 'habanero', 'seminole', 'vigero', 'stalion'},
    },
    Business = {
        firstNames = {'Alexander', 'Nathaniel', 'Charles', 'Sebastian', 'Julian', 'Theodore', 'Vincent', 'Maximilian', 'Harrison', 'Oliver'},
        lastNames = {'Sterling', 'Fairfax', 'Remington', 'Ashford', 'Wentworth', 'Kensington', 'Langston', 'Hawthorne', 'Beaumont', 'Kingsley'},        
        pedModels = {"a_m_m_business_01", "a_m_y_business_01", "a_m_y_business_02", "a_m_y_business_02"},
        vehicles = {'felon', 'schafter2', 'dubsta', 'oracle2', 'zion', 'baller2', 'cavalcade2', 'huntley', 'superd', 'rapidgt'},
    },
}

Config.Divisions = {
    LSPD_Davis_Patrol = {
        firstNames = {'James', 'Marcus', 'Daniel', 'Jonathan', 'Anthony', 'Raymond', 'Michael', 'Samuel', 'Luis', 'Eric'},
        lastNames = {'Martinez', 'Williams', 'Johnson', 'Garcia', 'Hernandez', 'Brown', 'Davis', 'Lopez', 'Jackson', 'Wilson'},        
        pedModels = {'s_m_y_cop_01'},
        vehicles = {'police', 'police2'},
        loadout = 'Patrol'
    },
    LSPD_MissionRow_Patrol = {
        firstNames = {'James', 'Marcus', 'Daniel', 'Jonathan', 'Anthony', 'Raymond', 'Michael', 'Samuel', 'Luis', 'Eric'},
        lastNames = {'Martinez', 'Williams', 'Johnson', 'Garcia', 'Hernandez', 'Brown', 'Davis', 'Lopez', 'Jackson', 'Wilson'},        
        pedModels = {'s_m_y_cop_01'},
        vehicles = {'police', 'police2'},
        loadout = 'Patrol'
    },
}

Config.Loadouts = {
    Patrol = {
        weapons = {
            {weapon = "WEAPON_PUMPSHOTGUN", ammo = 8},
            {weapon = "WEAPON_NIGHTSTICK", ammo = 0},
            {weapon = "WEAPON_PISTOL", ammo = 36}
        }
    }
}