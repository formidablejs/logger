import { LogRecord } from '@livy/contracts';
import { AbstractFormattingProcessingHandler } from '@livy/util/lib/handlers/abstract-formatting-processing-handler'
import { DiscordRecord } from '../Records/DiscordRecord';

export class DiscordWebhookHandler extends AbstractFormattingProcessingHandler {
    /**
     * Discord webhook url
     */
    private get _webhookUrl(): string

    /**
     * Instance of DiscordRecord class preparing data for Discord API
     */
    private get _discordRecord(): string

    constructor(webhookUrl: string, options: any)

    /**
     * Get the disocrd record associated with the handler
     */
    get discordRecord(): DiscordRecord

    /**
     * Get the handler's webhook URL
     */
    get webhookUrl(): string

    /**
     * Write the record down to the log of the implementing handler
     */
    write(record: LogRecord): Promise<void>
}
