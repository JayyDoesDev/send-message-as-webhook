import { base } from "./api.js"

send_content_with_webhook = (body) ->
    WEBHOOK_ID = process.env.WEBHOOK_ID
    WEBHOOK_TOKEN = process.env.WEBHOOK_TOKEN

    if not typeof body is 'object' then body = { content: body }
    url = base "/webhooks/#{WEBHOOK_ID}/#{WEBHOOK_TOKEN}"
    response = await fetch url, 
          method: 'POST'
          headers: 
              'Content-Type': 'application/json'
          body: JSON.stringify body
export { send_content_with_webhook }