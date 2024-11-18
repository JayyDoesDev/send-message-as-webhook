import { InteractionResponseType } from "discord-api-types/v10"

handle_message_components = (req, res) ->
    { data } = req.body

    switch data.custom_id
        when 'button1'
            res.send 
                type: InteractionResponseType.ChannelMessageWithSource
                data: content: "Button 1 was clicked"
        when 'button2'
            res.send 
                type: InteractionResponseType.ChannelMessageWithSource
                data: content: "Button 2 was clicked"

export { handle_message_components }