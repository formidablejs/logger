import { existsSync, mkdirSync } from 'fs'
import { dirname, join } from 'path'
import { FileHandler } from '@livy/file-handler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class SingleDriver < Driver

	def handler
		let path = self.options.path ?? 'storage/logs/formidable.log'

		if path.slice(0, 1) !== '/'
			path = join(process.cwd(), path)

		if !existsSync dirname(path)
			try mkdirSync dirname(path), { recursive: true }

		new FileHandler(path, {
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
