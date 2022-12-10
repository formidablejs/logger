import { FileHandler } from '@livy/file-handler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class DailyDriver < Driver

	get path\string
		let path\string = this.options.path ?? 'storage/logs/formidable.log'

		if path.includes('.')
			let args\string[] = path.split('.')

			const fileName = args.at(-2)

			args[args.length - 2] = `${fileName}-%date%`

			path = args.join('.')
		else
			path = `${path}-%date%`

		path

	def handler
		new FileHandler(self.path ?? 'storage/logs/formidable.log', {
			formatter: new LineFormatter({
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
			}),
			...self.options
		})
