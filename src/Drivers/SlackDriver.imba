import { SlackWebhookHandler } from '@livy/slack-webhook-handler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class SlackDriver < Driver

	def handler
		new SlackWebhookHandler(self.options.url, {
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
				ignoreEmptyContext: true,
				ignoreEmptyExtra: true
			}),
			includeContextAndExtra: true
			...self.options
		})
