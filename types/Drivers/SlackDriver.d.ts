import { Driver } from '../Driver'
import { SlackWebhookHandler } from '@livy/slack-webhook-handler'

export class SlackDriver extends Driver {
    handler(): SlackWebhookHandler
}
