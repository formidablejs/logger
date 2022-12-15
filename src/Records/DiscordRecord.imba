import { FormattableHandlerMixin } from '@livy/util/lib/handlers/formattable-handler-mixin'
import { LogLevel } from '@livy/contracts/lib/log-level'
import { LogRecord } from '@livy/contracts/lib/log-record'
import { LineFormatter } from '@livy/line-formatter'
import { capitalizeFirstLetter, isEmpty } from '@livy/util/lib/helpers'
import { AnyObject } from '@livy/util/lib/types'

const COLOR_DANGER = 16711697
const COLOR_WARNING = 16771898
const COLOR_GOOD = 2135795
const COLOR_DEFAULT = null

const SeverityMap = {
	debug: 7
	info: 6
	notice: 5
	warning: 4
	error: 3
	critical: 2
	alert: 1
	emergency: 0
}

export class DiscordRecord < FormattableHandlerMixin(class Mixin)

	# Name of the bot
	prop username\string = null

	# Profile picture of the bot
	prop avatarUrl\string = null

	# Whether the message should be added to Discord as embed (plain text otherwise)
	prop useEmbed\boolean

	#  Whether the attachment should include context and extra data
	prop includeContextAndExtra\boolean

	# Dot separated list of fields to exclude from slack message. E.g. ['context.field1', 'extra.field2']
	prop excludedFields\string[] = []

	def constructor options = { }
		super()

		self.username = options.username
		self.useEmbed = options.useEmbed !== false ? true : options.useEmbed
		self.avatarUrl = options.avatarUrl
		self.includeContextAndExtra = (options.includeContextAndExtra !== undefined || options.includeContextAndExtra !== null) ? options.includeContextAndExtra : false
		self.excludedFields = options.excludedFields || []
		self.explicitFormatter = options.formatter

	# Get required data in format that Discord is expecting
	def getDiscordData record\LogRecord
		const data\AnyObject = {}
		const clearedRecord = self.removeExcludedFields(record)

		data.content = null

		const message\string = self.useEmbed ? clearedRecord.message : self.formatter.format(clearedRecord)

		if self.username
			data.username = self.username

		if self.useEmbed
			const embed\AnyObject = {
				title: "Message"
				description: message
				color: self.getEmbedColor(clearedRecord.level)
				fields: [
					{
						name: "Level"
						value: clearedRecord.level
					}
				]
			}

			if self.includeContextAndExtra
				for key in ['context', 'extra']
					if isEmpty(clearedRecord[key])
						continue

					embed.fields.push(...self.generateEmbedFields(clearedRecord[key]))

			data.embeds = [embed]

		else
			data.content = message

		if self.avatarUrl
			data.avatar_url = self.avatarUrl

		data

	# Get a Discord message embed color associated with the provided level
	def getEmbedColor\number level\LogLevel
		const severity = SeverityMap[level]

		switch true
			when severity <= SeverityMap.error
				return COLOR_DANGER

			when severity <= SeverityMap.warning
				return COLOR_WARNING

			when severity <= SeverityMap.info
				return COLOR_GOOD

			else
				return COLOR_DEFAULT

	# Stringify an array of key/value pairs to be used in embed fields
	def stringify fields\AnyObject|any[]
		const isObject = !Array.isArray(fields)
		const hasNestedData = !Array.isArray(fields) || field.some do(field) typeof field === 'object' && field !== null

		isObject || hasNestedData ? JSON.stringify(fields, null, 2) : JSON.stringify(fields)

	# @inheritdoc
	def getDefaultFormatter
		new LineFormatter {
			include: {
				context: self.includeContextAndExtra
				extra: self.includeContextAndExtra
			}
		}

	# Generate an attachment field
	def generateEmbedField title\string, value\string|number|AnyObject|any
		const stringifiedValue = typeof value === 'string' || typeof value === 'number' ? String(value) : '```json\n' + self.stringify(value) + '\n```'

		{
			name: capitalizeFirstLetter(title)
			value: stringifiedValue
		}

	# Generate a collection of embed fields
	def generateEmbedFields data\Partial<LogRecord>
		Object.entries(data).map do([key, value])
			self.generateEmbedField(key, value)

	# Get a copy of record with fields excluded according to `self.excludedFields`
	def removeExcludedFields record\LogRecord
		const copy = { ...record }

		for field in self.excludedFields
			const keys = field.split('.')
			let node = copy
			const lastKey = keys[keys.length - 1]

			for key in keys
				if !(key in node)
					break

				if lastKey === key
					delete node[key]
					break

				node = node[key]

		copy
