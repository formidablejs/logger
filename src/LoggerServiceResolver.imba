import { ServiceResolver } from '@formidablejs/framework'
import { createLogger } from '@livy/logger'
import { Driver } from './Driver'
import { ConsoleDriver } from './Drivers/ConsoleDriver'
import { DailyDriver } from './Drivers/DailyDriver'
import { SingleDriver } from './Drivers/SingleDriver'
import { SlackDriver } from './Drivers/SlackDriver'
import { StackDriver } from './Drivers/StackDriver'
import { DiscordDriver } from './Drivers/DiscordDriver'
import { ConfigMissingException } from './Exceptions/ConfigMissingException'
import { get } from './Logger'
import { Log } from './Logger'
import { register } from './Logger'
import { getInstance } from './Logger'
import { registerInstance } from './Logger'
import type { HandlerInterface } from '@livy/contracts'

export class LoggerServiceResolver < ServiceResolver

	get channel\any
		const name = self.app.config.get('logging.default')

		self.app.config.get("logging.channels.{name}")

	get handler\HandlerInterface
		if !self.channel
			throw new ConfigMissingException "Logging config is missing"

		const driver = get(self.channel.driver)

		(new driver(channel)).handler!

	def boot
		Driver.setConfig(self.app.config)

		register('stack', StackDriver)
		register('single', SingleDriver)
		register('daily', DailyDriver)
		register('console', ConsoleDriver)
		register('slack', SlackDriver)
		register('discord', DiscordDriver)

		self.registerChannel!

		Log.handlers.add(self.handler)

	def registerChannel
		const environment = self.app.config.get('app.env', 'local')
		const loggingMode = self.app.config.get('logging.mode', 'sync')

		# Switch to a different logger
		Log.channel = do(name\string, options = {})
			const instance = getInstance[name]

			if instance then return instance

			const channel = self.app.config.get("logging.channels.{name}")

			if !channel
				throw new ConfigMissingException "Logging config is missing"

			const driver = get(channel.driver)

			const handler = (new driver(channel)).handler!

			const logger = new createLogger(environment, {
				mode: options.mode ?? loggingMode
			})

			logger.handlers.add(handler)

			registerInstance(name, logger)

			logger
