import { DiscordWebhookHandler } from '../Handlers/DiscordWebhookHandler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class DiscordDriver < Driver

	def handler
		new DiscordWebhookHandler(self.options.url, {
			formatter: new LineFormatter({
				include: {
					datetime: true,
					channel: true,
					level: true,
					severity: false,
					message: true,
					context: true,
					extra: true
				},
				ignoreEmptyContext: true
				ignoreEmptyExtra: true
			}),
			includeContextAndExtra: true
			...self.options
		})
