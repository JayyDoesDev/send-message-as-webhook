base = (route) ->
    "https://discord.com/api#{route}"

v9 = (route) ->
    base "/v9#{route}"

v10 = (route) ->
    base "/v10#{route}"

export { base, v9, v10 }