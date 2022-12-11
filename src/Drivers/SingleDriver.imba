import { FileHandler } from '@livy/file-handler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class SingleDriver < Driver

	def handler
		new FileHandler(self.options.path ?? 'storage/logs/formidable.log', {
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
			...self.options
		})
