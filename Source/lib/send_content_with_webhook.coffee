send_content_with_webhook = (body) ->
    WEBHOOK_ID = process.env.WEBHOOK_ID
    WEBHOOK_TOKEN = process.env.WEBHOOK_TOKEN
    WEBHOOK_URL = 'https://discord.com/api'

    if not typeof body is 'object' then body = { content: body }
    response = await fetch "#{WEBHOOK_URL}/webhooks/#{WEBHOOK_ID}/#{WEBHOOK_TOKEN}", 
          method: 'POST'
          headers: 
              'Content-Type': 'application/json'
          body: JSON.stringify body
export { send_content_with_webhook }