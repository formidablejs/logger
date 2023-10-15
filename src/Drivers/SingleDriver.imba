import { existsSync, mkdirSync } from 'fs'
import { dirname, join } from 'path'
import { FileHandler } from '@livy/file-handler'
import { LineFormatter } from '@livy/line-formatter'
import { Driver } from '../Driver'

export class SingleDriver < Driver

	get path
		let path\string = self.options.path ?? join(process.cwd!, 'storage', 'logs', 'formidable.log')

		if (process.platform !== 'win32' && path.slice(0, 1) !== '/') || (process.platform === 'win32' && path.slice(1, 2) !== ':')
			path = join(process.cwd!, path)

		if !existsSync dirname(path)
			try mkdirSync dirname(path), { recursive: true }

		path

	def handler
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
