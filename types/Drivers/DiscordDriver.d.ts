import { Driver } from '../Driver'
import { DiscordWebhookHandler } from '../Handlers/DiscordWebhookHandler'

export class DiscordDriver extends Driver {
    handler(): DiscordWebhookHandler
}
