import { ConsoleDriver } from './Drivers/ConsoleDriver'
import { DailyDriver } from './Drivers/DailyDriver'
import { get } from './Logger'
import { HandlerInterface } from '@livy/contracts'
import { Log } from './Logger'
import { register } from './Logger'
import { ServiceResolver } from '@formidablejs/framework'
import { SingleDriver } from './Drivers/SingleDriver'

export class LoggerServiceResolver < ServiceResolver

	get channel\object
		const name = self.app.config.get('logging.default')

		self.app.config.get("logging.channels.{name}")

	get handler\HandlerInterface
		const driver = get(channel.driver)

		(new driver(channel)).handler!

	def boot
		register('single', SingleDriver)
		register('daily', DailyDriver)
		register('console', ConsoleDriver)

		Log.handlers.add(self.handler)
