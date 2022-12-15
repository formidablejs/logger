import { FormatterInterface, LogLevel, LogRecord } from '@livy/contracts'
import { AnyObject } from '@livy/util/lib/types'
import { FormattableHandlerMixin } from '@livy/util/lib/handlers/formattable-handler-mixin'
import { LineFormatter } from '@livy/line-formatter'

export interface EmbedField {
    name: string
    value: string
}

export interface DiscordRecordOptions {
    username: string
    useEmbed: boolean
    avatarUrl: string
    includeContextAndExtra: boolean
    excludedFields: string[]
    formatter: FormatterInterface | undefined
}

export class DiscordRecord extends FormattableHandlerMixin(class {}) {
    constructor(options: DiscordRecordOptions)

    /**
     * Name of the bot
     */
    get username(): string | null

    /**
     * Profile picture of the bot
     */
    get avatarUrl(): string | null

    /**
     * Whether the message should be added to Discord as embed (plain text otherwise)
     */
    get useEmbed(): boolean

    /**
     * Dot separated list of fields to exclude from slack message. E.g. ['context.field1', 'extra.field2']
     */
    get excludedFields(): string[]

    /**
     * Get required data in format that Discord is expecting
     */
    getDiscordData(record: LogRecord): AnyObject

    /**
     * Get a Discord message embed color associated with the provided level
     */
    getEmbedColor(level: LogLevel): number

    /**
     * Stringify an array of key/value pairs to be used in embed fields
     */
    stringify(fields: AnyObject | any[]): string

    /**
     * Get the default formatter
     *
     * This exists to be overridden, because getters/setters of mixins can not be properly overridden due to TS2611
     *
     * @protected This should also not be public, but is forced to be due to microsoft/typescript#17744
     */
    getDefaultFormatter(): LineFormatter

    /**
     * Generate an attachment field
     */
    generateEmbedField(title: string, value: string | number | AnyObject | any): EmbedField

    /**
     * Generate a collection of embed fields
     */
    generateEmbedFields(data: Partial<LogRecord>): any

    /**
     * Get a copy of record with fields excluded according to `self.excludedFields`
     */
    removeExcludedFields(record: LogRecord): any
}
