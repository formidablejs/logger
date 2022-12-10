import { ConsoleHandler } from '@livy/console-handler'
import { ConsoleFormatter } from '@livy/console-formatter'
import { Driver } from '../Driver'

export class ConsoleDriver < Driver

	def handler
		new ConsoleHandler({
			formatter: new ConsoleFormatter({
				include: {
					datetime: true,
					channel: false,
					level: true,
					severity: false,
					message: true,
					context: true,
					extra: true
				},
				ignoreEmptyContext: true,
				ignoreEmptyExtra: true
			})
			...self.options
		})
