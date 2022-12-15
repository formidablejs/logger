import { got } from '../Utils/got'
import { DiscordRecord } from '../Records/DiscordRecord'
import { FormatterInterface } from '@livy/contracts/lib/formatter-interface'
import { AbstractFormattingProcessingHandler } from '@livy/util/lib/handlers/abstract-formatting-processing-handler'

export class DiscordWebhookHandler < AbstractFormattingProcessingHandler

	# Discord webhook url
	prop _webhookUrl\string

	# Instance of DiscordRecord class preparing data for Discord API
	prop _discordRecord\DiscordRecord

	def constructor webhookUrl\string, options = { }
		super({ level: options.level, bubble: options.bubble })

		self._webhookUrl = webhookUrl
		self.explicitFormatter = options.formatter

		self._discordRecord = new DiscordRecord({
			username: options.username
			useEmbed: options.useEmbed
			avatarUrl: options.avatarUrl
			includeContextAndExtra: options.includeContextAndExtra
			excludedFields: options.excludedFields
			formatter: self.explicitFormatter
		})

	# Get the disocrd record associated with the handler
	get discordRecord\DiscordRecord
		self._discordRecord

	# Get the handler's webhook URL
	get webhookUrl\string
		self._webhookUrl

	# @inheritdoc
	def write\Promise<void> record\LogRecord
		const postData = this._discordRecord.getDiscordData(record)
		const postString = JSON.stringify(postData)

		await got(self._webhookUrl, {
			method: 'POST'
			body: postString
			headers: {
				'Content-Type': 'application/json'
			}
		})

		null

	# @inheritdoc
	def getDefaultFormatter
		self._discordRecord.defaultFormatter

	# @inheritdoc
	def setFormatter formatter\FormatterInterface
		self._discordRecord.formatter = formatter

	# @inheritdoc
	def getFormatter
		self._discordRecord.formatter
