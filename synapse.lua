local response = syn.request({Url = "http://52.255.55.167:1337/lloader/"..getgenv().LH_Key, Method = "GET"}).Body
    getgenv().LH_Excutor = 'Synapse X'
    if string.find(response, 'https://raw.githubusercontent.com') then
        loadstring(game:HttpGet(response))()
        LoadChangeLog()
    end