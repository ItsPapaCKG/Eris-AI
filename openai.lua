local function OpenAIRequest(url, params, onsuccess, onfailure, header)
    local request = {
        url = url,
        method = "POST",
        body = params,
        headers = header or {},
        type = "application/json",

        success = function(code, body, headers)
            if onsuccess then
                onsuccess(body, body:len(), headers, code)
            end
        end,

        failed = function(err)
            if onfailure then
                onfailure(err)
            end
        end
    }

    HTTP(request)
end

local payload = {
        ["model"] = "gpt-3.5-turbo",
        ["messages"] = {
            { ["role"] = "system", ["content"] = [[ You are playing a character in an RPG. Do not say anything that is out of character. ]]},
            { ["role"] = "system", ["content"] = [[ When you want to describe an action your character is taking, it should be done in the third person. ]]},
            { ["role"] = "system", ["content"] = [[ Your character exists in the Half-Life 2 Universe, but just before the events of Half-Life 2. Gordan Freeman does not exist yet. ]]},
            { ["role"] = "system", ["content"] = [[ Output all dialogue with quotes. ]]},
            { ["role"] = "system", ["content"] = [[ Only speak in the first person in dialogue. ]]},
            { ["role"] = "system", ["content"] = [[ You character exists as an entity in a 3D game engine, but you as the AI will not be able to see the world around your character, and must instead improvise based on input provided by the users you interact with to understand the context of the roleplay scenario. ]]},
            { ["role"] = "system", ["content"] = [[ Faction: Citizen, Gender: Male, Name: Joseph Calamari, Age: 20, Hometown: Huntsville, AL, Backstory: Captured on the run in New York, brought into City17. ]]}
        }
    }

hook.Add("PlayerSay", "OpenAIChat", function(ply, msg)
    local endpoint = "https://api.openai.com/v1/chat/completions"
    local api_key = "####################"

    payload["messages"][#payload["messages"] + 1] = { ["role"] = "user", ["content"] = msg}

    -- Convert the payload table to JSON
    local json_payload = util.TableToJSON(payload)
    print(json_payload)
    -- Set the request headers
    local headers = {
        ["Authorization"] = "Bearer " .. api_key
    }

    -- Make the OpenAI API request
    OpenAIRequest(endpoint, json_payload, function(body)
        -- Parse and process the response from OpenAI
        print(body)
        unloaded_json = util.JSONToTable(body)
        ai_msg = unloaded_json["choices"][1]["message"]["content"]

        payload["messages"][#payload["messages"] + 1] = {["role"] = "assistant", ["content"] = ai_msg}
        ply:ChatPrint(ai_msg)
    end, function(err)
        -- Handle the request failure
        print("Request failed:", err)
    end, headers)
end)
